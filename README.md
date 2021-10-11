## What this for
Simple Demo iOS app for Marvel Comics Info, which will utilize the Marvel Developer API to get some comics data and show the info.

## Requirement
- Xcode 12 or above

## Initial setup
install dependencies by using CocoaPods (https://cocoapods.org/) <br />
`pod install`

**Dependencies** <br />
- SDWebImage: https://github.com/SDWebImage/SDWebImage

## Setup Developer Keys
- Please visit https://developer.marvel.com/ to get a pair of public and private keys. <br />
- In _MarvelComicsInfo -> Info.plist -> MarvelConfig_, put public key as **apiKey**, private key as **secret**
