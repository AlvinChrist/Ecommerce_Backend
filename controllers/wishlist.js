import Wishlist from "../models/wishlistModel.js";
import Product from "../models/productModel.js";
import User from "../models/userModel.js";

export const getUserWishlist = async(req, res) => {
    try {
        const wishlist = await Wishlist.findAll({
            where: {
                userId: req.params.id
            },
            include: [
                {
                    model: Product,
                }
            ]
        })
        res.json({wishlist: wishlist})
    } catch (error) {
        res.json({message: "Something Went Wrong!", error: error.message})
    }
}

export const addToWishlist = async(req, res) => {
    try {
        
            const count = await Wishlist.count({
                where:{
                    userId: req.body.userId,
                    productId: req.body.productId
                }
            });
            if (count != 0){
                await Wishlist.update({
                    productQty: req.body.productQty
                }, {
                    where: {
                        userId: req.body.userId,
                        productId: req.body.productId
                    }
                });
                res.json({message: "Wishlist Updated!"})
            } else {
                await Wishlist.create({
                    userId: req.body.userId,
                    productId: req.body.productId,
                    productQty: req.body.productQty
                });
                res.json({message: "Added to Wishlist!"})
            }
    
        
    } catch (error) {
        res.json({message: "Something Went Wrong", error: error.message})
    }
}

export const removefromWishlist = async(req, res) => {
        try {
            await Wishlist.destroy({
                where:{
                    userId: req.body.userId,
                    productId: req.body.productId
                }
            })
            res.json({message: "This Item Removed From Your Wishlist"})
        } catch (error) {
            res.json({message: "Something Wnet Wrong!", error: error.message})
        }
}