const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Send a push notification to all users when a new
// message is created
exports.myFunction = functions.firestore
  .document("chats/{message}")
  .onCreate((snapshot, context) => {
    return admin.messaging().sendToTopic("chats", {
      notification: {
        title: snapshot.data().username,
        body: snapshot.data().text,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });
