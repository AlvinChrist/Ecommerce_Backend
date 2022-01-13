import Sequelize from "sequelize";
import db from "../config/database.js";
import Product from "./productModel.js";
import User from "./userModel.js"

const { DataTypes } = Sequelize;

const Wishlist = db.define('wishlist',{
    userId:{
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    productId:{
        type: DataTypes.INTEGER,
        allowNull: false
    },
    productQty:{
        type: DataTypes.INTEGER,
        allowNull: false
    }
},{
    freezeTableName: true
})

Wishlist.removeAttribute('id');

User.belongsToMany(Product, { 
    through: Wishlist,
    foreignKey: 'userId'
});

Product.belongsToMany(User, { 
    through: Wishlist,
    foreignKey: 'productId'
});

Wishlist.belongsTo(User, { 
    foreignKey: 'userId' 
})
Wishlist.belongsTo(Product,{
    foreignKey: 'productId'
})
Product.hasMany(Wishlist, {
    foreignKey: 'productId',
    onDelete: 'cascade',
    onUpdate: 'cascade'
})

User.hasMany(Wishlist, {
    foreignKey: 'userId',
    onDelete: 'cascade',
    onUpdate: 'cascade'
})

export default Wishlist;