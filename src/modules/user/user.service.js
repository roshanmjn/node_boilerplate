const httpStatus = require("http-status");
const { HttpException } = require("../../middlewares/errors.js");
const { dbConnection, sequelize } = require("../../config/connection.js");
const { decrypt, encrypt, jwtRefreshSign, jwtDecode } = require("../../utils/encrypter.js");
const { v4: uuidv4 } = require("uuid");
require("dotenv").config();
const { sendVerificationEmail } = require("../../utils/contact.js");

const createUser = async (userBody) => {
    // console.log(userBody);
    try {
        const { first_name, last_name, email, google_id, facebook_id, password, confirm_password, image, is_admin = false } = userBody;

        const check_email = btoa(encodeURIComponent(email));

        const conn = await dbConnection;
        let query = "SELECT * FROM users WHERE email = ?";
        const [findUser] = await conn.query(query, [check_email]);
        console.log(findUser);

        if (findUser && findUser.length > 0) {
            throw new HttpException(httpStatus.BAD_REQUEST, "User account aleady exists !");
        }
        if (password !== confirm_password) {
            throw new HttpException(httpStatus.BAD_REQUEST, "Passwords do not match !");
        }

        //create token using email  and uuid without jwt
        const verificationToken = uuidv4();
        console.log(verificationToken);

        const encoded_first_name = btoa(encodeURIComponent(first_name));
        const encoded_last_name = btoa(encodeURIComponent(last_name));
        const encoded_email = btoa(encodeURIComponent(email));
        const encoded_google_id =  google_id ? btoa(encodeURIComponent(google_id)) : null;
        const encoded_facebook_id = facebook_id ? btoa(encodeURIComponent(facebook_id)) : null;
        const hashed_password = await encrypt(password);
        const image_path = image ? btoa(encodeURIComponent(image)) : null;
        const encoded_token = btoa(encodeURIComponent(verificationToken));


        console.log(encoded_token);

        query = `INSERT INTO users
            (first_name,last_name,email,
            google_id,facebook_id,password,
            image,token,created_at)
            VALUES
            (?,?,?,?,?,?,?,?,NOW())`;

        const [user] = await conn.query(query, [
            encoded_first_name,
            encoded_last_name,
            encoded_email,
            encoded_google_id,
            encoded_facebook_id,
            hashed_password,
            image_path,
            encoded_token,
            is_admin,
        ]);

        await sendVerificationEmail(email, process.env.BASE_URL + `/auth/verify-email?token=${verificationToken}`);

        return { message: "User created successfully and verification link has been send to you mail !" };
    } catch (error) {
        throw new HttpException(httpStatus.BAD_REQUEST, error.message);
    }
};

module.exports = { createUser };
