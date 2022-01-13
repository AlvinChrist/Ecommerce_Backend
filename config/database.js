import Sequelize from "sequelize";

const db = new Sequelize('ecommerce', 'root', '', {
    host: "localhost",
    dialect: "mysql"
});

export default db; 