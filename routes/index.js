import express from "express";
import { verifyToken } from "../middleware/verifyToken.js";
import uploadFile from "../middleware/upload.js"
import uploadAvatar from "../middleware/uploadAvatar.js";
import { 
    getAllProducts,
    getProduct,
    createProduct,
    updateProduct,
    destroyProduct
} from "../controllers/products.js";

import {
    getGallery,
    createImage,
    destroyImage,
    updateUsedImage
} from "../controllers/gallery.js";

import { 
    getAllComment,
    postComment,
    editComment,
    destroyComment 
} from "../controllers/comment.js";

import {
    ratingProduct,
    getRating,
    getRatingUser,
} from "../controllers/rating.js"

import {
    getAllDiscount,
    setDiscount
} from "../controllers/discount.js"

import {
    addToWishlist,
    getUserWishlist
} from "../controllers/wishlist.js"

import {
    addToCart,
    getUserCart,
    removefromCart,
} from "../controllers/cart.js"

import {
    addTransaction,
    getAllTransaction,
    getUserTransaction,
    getTransactionDetail
} from "../controllers/transaction.js"

import {
    getAllUser,
    getUserById,
    register,
    login,
    logout
} from "../controllers/user.js";

import { refreshToken } from "../controllers/refreshToken.js"

const router = express.Router();

//Main Routing
router.get('/users', verifyToken, getAllUser);
router.get('/user/:id', verifyToken, getUserById);
router.get('/token', refreshToken);
router.post('/user', uploadAvatar.single("file"),register);
router.post('/login', login);
router.delete('/logout', logout);

//Product Routing
router.get('/products', getAllProducts);

router.get('/products/:id', getProduct);

router.post('/products', verifyToken, uploadFile.single("file"), createProduct);

router.put('/products/:id', verifyToken, uploadFile.single("file"), updateProduct);

router.delete('/products/:id', verifyToken, destroyProduct);


//Gallery Routing
router.get('/gallery/product/:id', getGallery);
router.post('/gallery', verifyToken, uploadFile.single("file"), createImage);
router.put('/product/:id/image', updateUsedImage)
router.delete('/gallery/:id', verifyToken, destroyImage);


//Comment Routing
router.get('/product/:id/comments', getAllComment)
router.post('/comments', verifyToken, postComment)
router.put('/comment/:id', verifyToken, editComment)
router.delete('/comment/:id', verifyToken, destroyComment)

//Rating Routing
router.post('/rate', verifyToken, ratingProduct)
router.get('/product/:id/rating',getRating)
router.get('/product/:productId/rating/user/:userId',getRatingUser)

//Discount Routing
router.get('/discounts', getAllDiscount)
router.put('/product/:id/discount', setDiscount)

//Wishlist Routing
router.post('/wishlist', addToWishlist)
router.get('/user/:id/wishlist', getUserWishlist)

//Cart Routing
router.post('/cart', addToCart)
router.get('/user/:id/cart', getUserCart)

//Transaction Routing
router.post('/transaction', addTransaction)
router.get('/transaction', getAllTransaction),
router.get('/user/:id/transaction', getUserTransaction)
router.get('/transaction/:id', getTransactionDetail)
export default router;