## About

A simple group chat app using Flutter and Dart for iOS and Android. This app uses Firebase Authentication, Database, and File Storage for the backend, also push notifications with Firebase Cloud Messaging.

## Functionality

- Basic authentication -> signup, login, logout
- Signup with image
- Send chat messages to all other users
- Receive push notifications when a user sends a chat

## Install and Setup

You will need Flutter installed, along with a number of dependencies for building and running iOS and Android apps on simulators. You can find the install instructions here: https://flutter.dev/docs/get-started/install

## Setup

This implementation uses Firebase Authentication, Database, and Storage. You will need to do set these up, in order for the app to work for you:

- Project:

  - Make sure to enable Google Analytics

  - Set up the iOS Platform in Firebase project:

    - Select iOS as an option
    - Register the app with your iOS bundle ID
    - Download config file
    - Put config file in the ios/Runner folder (where Info.plist is), in XCode. Do not drag and drop the file into the folder!

  - Set up the Android Platform in Firebase project:

    - Register the app with your Android package name
    - Download the config file
    - Put config file in the android/app folder
    - Project-level build.gradle:

          buildscript {
            repositories {
              // Check that you have the following line (if not, add it):
              google() // Google's Maven repository
            }
            dependencies {
              ...
              // Add this line
              classpath 'com.google.gms:google-services:4.3.3'
            }
          }

          allprojects {
            ...
            repositories {
              // Check that you have the following line (if not, add it):
              google() // Google's Maven repository
              ...
            }
          }

    - App-level build.gradle:

          apply plugin: 'com.android.application'
          // Add this line
          apply plugin: 'com.google.gms.google-services'

          dependencies {
            // add the Firebase SDK for Google Analytics
            implementation 'com.google.firebase:firebase-analytics:17.2.2'
            // add SDKs for any other desired Firebase products
            // https://firebase.google.com/docs/android/setup#available-libraries
          }

- Database

  - Go to Develop -> Database
  - Create a Cloud Firestore Database
  - Add a Collection and call it: chats
  - Go to Rules tab and set up rules:

        rules_version = '2';
        service cloud.firestore {
          match /databases/{database}/documents {

            match /users/{uid}{
              allow write: if request.auth != null && request.auth.uid == uid;
            }

            match /users/{uid}{
              allow read: if request.auth != null;
            }

            match /chats/{document=**} {
              allow read, create: if request.auth != null;
            }
          }
        }

- Storage

  - Create a default bucket
  - Go to Rules tab and set up rules:

        rules_version = '2';
        service firebase.storage {
          match /b/{bucket}/o {
            match /{allPaths=**} {
              allow read, create: if request.auth != null;
            }
          }
        }

* Authentication

  - Go to Develop -> Authentication
  - In Sign-in method tab, and enable Email/Password Provider

* Push Notifications

  - Android/iOS:

    - Follow the directions here: https://pub.dev/packages/firebase_messaging

  - iOS:

    - Open up project in XCode, and make sure that the entitlements file is on Debug/Profile/Release for the Code Signing Entitlements setting in Build Settings for both the Project Runner and Targets Runner

- Functions

  Run the following:

      $ firebase login
      $ firebase deploy

## Run

Run on a device (once it is connected):

    $ flutter run

## TODO

- Test cases
