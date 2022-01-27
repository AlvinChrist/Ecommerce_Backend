import ProductImage from "../models/galleryModel.js";
import Product from "../models/productModel.js";
import Wishlist from "../models/wishlistModel.js";
import ProductRating from "../models/ratingModel.js"
import Discount from "../models/discountModel.js";

export const getUserWishlist = async(req, res) => {
    try {
        await Wishlist.findAll({
            where: {
                userId: req.params.id
            },
            include: [
                {
                    model: Product,
                },
            ],
        }).then(items=> {
            if (items.length == 0){
                res.json({wishlist: []})
            }
            items.forEach(function(item,idx,array){
                ProductImage.findOne({
                    where: {
                        productId: item.productId,
                        used: 'True'
                    }
                }).then(image=>{
                    const img = {imagePath: image.imagePath}
                    item.product.setDataValue('product_galleries', [img])
                })
                ProductRating.findAll({
                    where: {
                        productId: item.productId
                    }
                }).then(ratings=>{
                    const reducer = (prev, cur) => prev + cur.dataValues.productRating
                    const acc = ratings.reduce(reducer,0) / ratings.length
                    item.product.setDataValue('finalRating', acc) 
                })
                Discount.findOne({
                    where: {
                        discountId: item.product.discountId
                    }
                }).then(disc => {
                    if(item.product.discountId){
                        item.product.setDataValue('product_discount', disc)
                        item.product.setDataValue("beforeDiscount", item.product.productPrice)
                        item.product.productPrice = (100 - disc.discountPercent) / 100 * item.product.productPrice    
                    }
                }).catch((err) => {
                    console.log(err)
                })
                .then(()=>{
                    if(idx === array.length -1){
                        res.json({wishlist: items})
                    }
                })
            })
        })
        
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
                    userId: req.params.userId,
                    productId: req.params.productId
                }
            })
            res.json({message: "Item Removed!"})
        } catch (error) {
            res.json({message: "Something Went Wrong!", error: error.message})
        }
}