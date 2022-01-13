import ProductComment from "../models/commentModel.js"
import Product from "../models/productModel.js"
import User from "../models/userModel.js"
import Sequelize  from "sequelize"

export const getAllComment = async (req, res) => {
    try {
        const comments = await ProductComment.findAll({
            include: [
                {
                    model: Product,
                    where: {
                        productId: req.params.id
                    }
                }, 
                {
                    model: User
                }
            ]
        })
        res.json({comments: comments})
    } catch (error) {
        console.log(error)
    }
    
}


export const postComment = async(req, res) => {
    try {
        await ProductComment.create({
            userId: req.body.userId,
            productId: req.body.productId,
            commentText: req.body.commentText
        });
        res.json({message: "Comment Posted!"})
    } catch (error) {
        console.log(error)
    }
}

export const editComment = async (req, res) => {
    console.log("hello")
    try {
        
        await ProductComment.update({
            commentText: req.body.commentText
        }, {
            where: {
                commentId: req.params.id
            }
        })
        res.json({message: "Comment Updated"})
    } catch (error) {
        console.log(error)
    }
}

export const destroyComment = async (req, res) => {
   try {
        await ProductComment.destroy({
            where: {
                commentId: req.params.id
            }
        })
        res.json({message: "Comment Deleted"})
    } catch (error) {
        console.log(error)
    }
}