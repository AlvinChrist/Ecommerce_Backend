import Cart from "../models/cartModel.js";
import Product from "../models/productModel.js";
import User from "../models/userModel.js";

export const getUserCart = async(req, res) => {
    
    try {
        let cart = await Cart.findAll({
            where: {
                userId: req.params.id
            },
            include: [
                {
                    model: Product,
                }
            ]
        })
        
        for (const item of cart){
            if (item.productQty > item.product.productStock){
                console.log(item.product.productStock)
                console.log(item.productQty)
                await Cart.update({
                    productQty: item.product.productStock
                }, {
                    where: {
                        userId: item.userId,
                        productId: item.productId,
                        transactionId: null
                    }
                })
            }
        }

        cart = await Cart.findAll({
            where: {
                userId: req.params.id
            },
            include: [
                {
                    model: Product,
                }
            ]
        })

        res.json({cart: cart})
    } catch (error) {
        res.json({message: "Something Went Wrong", error: error.message})
    }

}

export const addToCart = async(req, res) => {
    try {
        const product = await Product.findOne({
            where: {
                productId: req.body.productId
            },
            attributes: ['productStock']
        })
        if (req.body.productQty > product.productStock){
            res.json({message: "Insufficient Stock"})
        } else {
            const count = await Cart.count({
                where:{
                    userId: req.body.userId,
                    productId: req.body.productId
                }
            });
            if (count != 0){
                await Cart.update({
                    productQty: req.body.productQty
                }, {
                    where: {
                        userId: req.body.userId,
                        productId: req.body.productId
                    }
                });
                res.json({message: "Cart Updated!"})
            } else {
                await Cart.create({
                    userId: req.body.userId,
                    productId: req.body.productId,
                    productQty: req.body.productQty
                });
                res.json({message: "Added to Cart!"})
            }
    
        }
    } catch (error) {
        res.json({message: "Something Went Wrong", error: error.message})
    }
}

export const removefromCart = async(req, res) => {
    try {
        await Cart.destroy({
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
