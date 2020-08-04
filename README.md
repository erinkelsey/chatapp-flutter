## About

A simple chat app using Flutter and Dart for iOS, Android and web. The app uses Firebase Authentication and Database, and File Storage for the backend.

Hosted web example here:

## Functionality

-

## Install and Setup

You will need Flutter installed, along with a number of dependencies for building and running iOS and Android apps on simulators. You can find the install instructions here: https://flutter.dev/docs/get-started/install

To run with web, follow the instructions here: https://flutter.dev/docs/get-started/web

## Setup

This implementation uses Firebase Authentication, Database, and Storage. You will need to do set these up, in order for the app to work for you:

- Project:

  - Make sure to enable Google Analytics

  - Set up the iOS Platform in Firebase project:

    - Select iOS as an option
    - Register the app with your iOS bundle ID
    - Download config file
    - Put config file in the ios/Runner folder (where Info.plist is), in XCode. Do not drag and drop the file into the folder!

  - Set up the Web Platform in Firebase project:

    - Add the JS scripts to the web/index.html file before initializing the service worker
    - You may have to change the Firebase version to 7.5.0 for all, if you get errors

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

## Run

Run on a device (once it is connected):

    $ flutter run

Run on a web browser (if you have installed support for running on web):

    $ flutter run -d chrome

## TODO

- Test cases
