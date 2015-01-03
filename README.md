# motion-validate

This is RubyMotion plugin which provides validation command before submitting to AppStore.

## Usage

```
$ rake archive:distribution
$ motion validate APPLE-ID
```

Example)

If app configuration has some error:
```
$ motion validate watson1978@gmail.com
** Validate ./build/iPhoneOS-8.1-Release/HelloActions.ipa **
2015-01-04 06:03:53.172 altool[9688:97684] *** Error: (
    "Error Domain=ITunesConnectionOperationErrorDomain Code=1091 \"Redundant Binary Upload. There already exists a binary upload with build '1.0' for version '1.7'\" UserInfo=0x7f81205293d0 {NSLocalizedRecoverySuggestion=Redundant Binary Upload. There already exists a binary upload with build '1.0' for version '1.7', NSLocalizedDescription=Redundant Binary Upload. There already exists a binary upload with build '1.0' for version '1.7', NSLocalizedFailureReason=iTunes Store operation failed.}"
)
```

The app is good to submit to AppStore:

```
$ motion validate watson1978@gmail.com
** Validate ./build/iPhoneOS-8.1-Release/HelloActions.ipa **
2015-01-04 06:11:56.252 altool[10072:101867] No errors validating archive at ./build/iPhoneOS-8.1-Release/HelloActions.ipa
```
