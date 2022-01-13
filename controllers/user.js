import User from "../models/userModel.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

export const getAllUser = async(req, res)=>{
    try{
        const users = await User.findAll();
        res.json(users);
    }catch(error){
        console.log(error);
    }
}

export const getUserById = async(req, res) => {
    await User.findOne({ 
        where: {userId: req.params.userId },
        attributes: {exclude: ['password','refresh_token']}
    }).then((user) => {
        res.json(user)
    }).catch((err) => {
        console.log(err)
    })
}

export const register = async(req, res)=>{
    if (req.body.password !== req.body.confPassword) return res.status(400).json({message: "Confirmed Password Doesn't Match"});
    const salt = await bcrypt.genSalt();
    const hashPassword = await bcrypt.hash(req.body.password, salt);
    User.count({ where: {email: req.body.email}}).then((count) => {
        if(count == 0){
            User.create({
                name: req.body.name,
                email: req.body.email,
                phoneNo: req.body.phoneNo,
                address: req.body.address,
                userName: req.body.userName,
                password: hashPassword,
                userAvatar: req.body.userAvatar,
                role: req.body.role
            }).then((resp) => {
                console.log(resp)
                res.json({message: 'Registration success!'})
            }).catch((err) => {
                console.log(err)
            });
        }
        else{
            res.status(409).json({message: `User with email: '${req.body.email}' exists!`})
        }
    })
    
}

export const login = async(req, res)=>{
    try{
        const user = await User.findAll({
            where:{
                email: req.body.email
            }
        });
        const match = await bcrypt.compare(req.body.password, user[0].password);
        console.log(match)
        if(!match) return res.status(400).json({message: "Wrong Password!"})
        const userId = user[0].userId
        const userName = user[0].userName
        const email = user[0].email
        const role = user[0].role
        const accessToken = jwt.sign({userId, userName, email, role}, process.env.ACCESS_TOKEN_SECRET, {
            expiresIn: '20s'
        });

        const refreshToken = jwt.sign({userId, userName, email, role}, process.env.REFRESH_TOKEN_SECRET, {
            expiresIn: '1d'
        });

        await User.update({refresh_token: refreshToken}, {
            where:{
                userId: userId
            }
        });


        res.cookie('refreshToken', refreshToken, {
            httpOnly: true,
            maxAge: 24 * 60 * 60 * 1000
        });

        res.json({accessToken});
    }catch(error){
        res.status(404).json({message: "User Doesn't Exist!"})
    }
}

export const logout = async(req, res) => {
    const refreshToken = req.cookies.refreshToken;
    if(!refreshToken) return res.sendStatus(204);
    const user = await User.findAll({
        where: {
            refresh_token: refreshToken
        }
    });
    if(!user[0]) return res.sendStatus(204);
    const userId = user[0].userId;
    await User.update({refresh_token: null},{
        where:{
            userId: userId
        }
    });
    res.clearCookie('refreshToken');
    return res.sendStatus(200)
}