# Python IDE Mobile - IDE for Python 3
<!-- [![Codemagic build status](https://api.codemagic.io/apps/5f755f0647fecf7a4f25751a/5f75609747fecf958ea171b0/status_badge.svg)](https://codemagic.io/apps/5f755f0647fecf7a4f25751a/5f75609747fecf958ea171b0/latest_build) -->

Python IDE Mobile is a simple yet fully-featured Python 3 IDE that doesn't require a PC setup for your projects.

[<img src="https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png" 
      alt="Download from Google Play" 
      height="80">](https://play.google.com/store/apps/details?id=in.canews.pythonide)

## Installation

### From Google PlayStore:
#### Android (arm, arm64, x86)
 - the minimum supported Android version is 4.3 (JellyBean).
 - Google Play Store Link: https://play.google.com/store/apps/details?id=in.canews.pythonide

#### Compiling Source: 

You need Flutter Framework to compile this App from Source.

#### Installing Flutter: https://flutter.dev/docs/get-started/install

```
git clone https://github.com/canewsin/pythonide.git
cd pythonide
flutter packages get
```

After that create a file named `key.properties` in the `android` directory and fill in the below details, which are in capital letters, with your details.

```
storeFile=ANDROID_KEY_STORE_FILE_PATH
storePassword=KEY_STORE_PASSWORD
keyAlias=KEY_ALIAS
keyPassword=KEY_PASSWORD
```

In the root folder:

- to build an APK

```
flutter build apk --no-shrink
```

- to build an appbundle

```
flutter build appbundle --no-shrink
```

- to run the app on an Android Device / Emulator

```
flutter run
```

## Donate
BTC (Preferred): 

`1ZeroNetyV5mKY9JF1gsm82TuBXHpfdLX`

ETH: 

`0xa81a32dcce8e5bcb9792daa19ae7f964699ee536`

UPI (Indian Users): 

`pramukesh@upi`

Liberapay: 

`https://liberapay.com/canews.in/donate`

## Contribute
Your support in the form of contributions or financial assistance is appreciated in the development of this project. For those inclined to offer technical assistance, kindly direct your efforts towards our GitHub repository for code and translation contributions. For those interested in providing financial aid, donations in the form of Bitcoin or other supported cryptocurrencies can be sent to the specified addresses or by purchasing in-app purchases.
