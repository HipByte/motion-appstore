# motion-appstore

This is RubyMotion plugin which provides `validate` and `upload` commands for iTunes Connect.

## Install

```
$ gem install motion-appstore
```

If you like to install manually,

```
$ git clone https://github.com/Watson1978/motion-appstore.git
$ cd motion-appstore
$ rake install
```

## Usage

```
$ rake archive:distribution
$ motion validate APPLE-ID
$ motion upload APPLE-ID
```

### validate

This command validates your app whether it is possible to upload to iTunes Connect.

Example)

If app configuration has some errors:
```
$ motion validate watson1978@gmail.com
Validate: ./build/iPhoneOS-8.1-Release/HelloActions.ipa
✗ Redundant Binary Upload. There already exists a binary upload with build '1.0' for version '1.10'
```

The app is good to submit to iTunes Connect:

```
$ motion validate watson1978@gmail.com
Validate: ./build/iPhoneOS-8.1-Release/HelloActions.ipa
✓ No errors validating archive at ./build/iPhoneOS-8.1-Release/HelloActions.ipa
```

### upload

This command uploads your app to iTunes Connect.

Example)

```
$ motion upload watson1978@gmail.com
Upload: ./build/iPhoneOS-8.1-Release/HelloActions.ipa
✓ No errors uploading ./build/iPhoneOS-8.1-Release/HelloActions.ipa
```

## Password management

motion-appstore attempts to retrieve your password from the keychain automatically. However, in certain circumstances, this may not work, like for example if you have not used Apple's AppLoader application before or if you are using iCloud's keychain. If motion-appstore keeps asking you for your password repeatedly, type the following command:

```
$ security add-internet-password -a <your-email-address> -j default -r htps -s idmsa.apple.com -w <your-password> -T /usr/bin/security
```

Your password will then be safely stored in the keychain and accessible by motion-appstore.
