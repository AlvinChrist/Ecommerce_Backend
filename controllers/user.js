import User from "../models/userModel.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import * as fs from 'fs'

export const getAllUser = async(req, res)=>{
    try{
        const users = await User.findAll();
        res.json(users);
    }catch(error){
        console.log(error);
    }
}

export const getUserById = async(req, res) => {
    try{
        const user = await User.findAll({
            where: {
                userId: req.params.id
            }
        });
        res.json({user: user})
    } catch (error){
        console.log(error)
    }
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
                userAvatar: 'avatars/'+req.file.filename,
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

export const updateUserProfile = async(req, res)=>{
    const user = await User.findOne({
        where: {
            userId: req.params.id
        }
    })
    const match = await bcrypt.compare(req.body.oldPassword, user.password);
    if (!match) {
        fs.unlink(__dirname + "/resources/static/assets/avatars/" + req.file.filename, (err => {
            if (err) console.log(err);
        }))
        return res.status(400).json({message: "Old Password is wrong!"});
    }
    const salt = await bcrypt.genSalt();
    const hashPassword = await bcrypt.hash(req.body.newPassword, salt);
    User.findAndCountAll({ where: {email: req.body.email}}).then((data) => {
        if(data.count == 0 || data.rows[0].userId == req.params.id){
            if (user.userAvatar != 'avatars/'+req.file.filename){
                fs.unlink(__dirname + "/resources/static/assets/" + user.userAvatar, (err => {
                    if (err) console.log(err);
                }))
            }

            User.update({
                name: req.body.name,
                email: req.body.email,
                phoneNo: req.body.phoneNo,
                address: req.body.address,
                userName: req.body.userName,
                password: hashPassword,
                userAvatar: 'avatars/'+req.file.filename,
                role: req.body.role
            }, {
                where: {
                    userId: req.params.id
                }
            }).then((resp) => {
                console.log(resp)
                res.json({message: 'Profile Updated!'})
            }).catch((err) => {
                res.json({message: "Something Went Wrong", error: err.message})
            });
        }
        else{
            if (data.rows[0].userId != req.params.id && user.userAvatar != 'avatars/'+req.file.filename){
                fs.unlink(__dirname + "/resources/static/assets/avatars/" + req.file.filename, (err => {
                    if (err) console.log(err);
                }))
            }
            res.status(409).json({message: `User with email: '${req.body.email}' exists!`})
        }
    })
    
}