import firebase from "firebase/compat/app";
import "firebase/compat/auth";
import "firebase/compat/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyDcp8M0rMmKjfYtJiJjS_6MYxzXPNFu0t8",
  authDomain: "ctsereactnativetodo.firebaseapp.com",
  projectId: "ctsereactnativetodo",
  storageBucket: "ctsereactnativetodo.appspot.com",
  messagingSenderId: "296822540",
  appId: "1:296822540:web:7697a18e8dd70c2e9b4b29",
  measurementId: "G-0ZBN7CHXRY",
};

if (!firebase.apps.length) {
  firebase.initializeApp(firebaseConfig);
}

export { firebase }; // export firebase as a module
