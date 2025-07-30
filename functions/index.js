const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();
const db = admin.firestore();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "alphyoj@gmail.com",
    pass: "nzeftxrflvyiuivm", 
  },
});

exports.sendOtp = functions.https.onCall(async (data, context) => {
  const { email } = data;
  const otp = Math.floor(100000 + Math.random() * 900000).toString();

  const mailOptions = {
    from: "Nike App <alphyoj@gmail.com>",
    to: email,
    subject: "Your Nike App OTP",
    text: `Your OTP code is: ${otp}`,
  };

  try {
    await transporter.sendMail(mailOptions);
    await db.collection("otp").doc(email).set({
      otp,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    return { success: true };
  } catch (error) {
    return { success: false, error: error.toString() };
  }
});
