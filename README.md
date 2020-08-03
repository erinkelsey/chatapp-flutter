## About

A simple chat app using Flutter and Dart for iOS, Android and web. The app uses Firebase Authentication and Database, and File Storage for the backend.

Hosted web example here:

## Functionality

-

## Install and Setup

You will need Flutter installed, along with a number of dependencies for building and running iOS and Android apps on simulators. You can find the install instructions here: https://flutter.dev/docs/get-started/install

To run with web, follow the instructions here: https://flutter.dev/docs/get-started/web

## Setup

This implementation uses Firebase Authentication and Database. You will need to do set these up, in order for the app to work for you.

- Set up a new project in Firebase:

  - Make sure to enable Google Analytics

  - Set up the iOS Platform in Firebase project:

    - Select iOS as an option
    - Register the app with your iOS bundle ID
    - Download config file
    - Put config file in the ios/Runner folder (where Info.plist is)

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

* Get the the Web API Key from Settings (YOUR_FIREBASE_WEB_API_KEY)

* Set up the Database:

  - Go to Develop -> Database
  - Add a database
  - Copy the DB URL (YOUR_FIREBASE_DB_URL)
    - Example: https://my-app-e7a11.firebaseio.com/
  - Set up the Rules:
    {
    "rules": {
    ".read": "auth != null",
    ".write": "auth != null",
    "products": {
    ".indexOn": ["creatorId"]
    }
    }
    }

* Authentication
  - Go to Develop -> Authentication
  - In Sign-in method tab, and enable Email/Password Provider

## Run

Run on a device (once it is connected):

    $ flutter run --dart-define=FIREBASE_API_KEY=[YOUR_FIREBASE_WEB_API_KEY] --dart-define=FIREBASE_DB_URL=[YOUR_FIREBASE_DB_URL]

Run on a web browser (if you have installed support for running on web):

    $ flutter run -d chrome --dart-define=FIREBASE_API_KEY=[YOUR_FIREBASE_WEB_API_KEY] --dart-define=FIREBASE_DB_URL=[YOUR_FIREBASE_DB_URL]

## TODO

- Test cases
