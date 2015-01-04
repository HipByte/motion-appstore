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
