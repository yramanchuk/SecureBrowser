Steps to build:

1. Build VeraCryptoLib project for all needed architectures (sim + devices)
2. Create universal lib:<br>
2.1.  open Terminal go Products path <br>
2.2. run lipo -create Debug-iphoneos/libVeraCryptoLib.a Debug-iphonesimulator/libVeraCryptoLib.a -output libVeraCryptoLib.a<br>
2.3. update lib headers if they were changed by you<br>
2.4. update libVeraCryptoLib.a<br>
3. Build and run SecureBrowser


Remarks:
We use XOR crypto, so file can be en/de-crypted with the same key; you can try to encrypt it several times.



Possible improvements:

1. Use models for data flow (not NSURLs)
2. encryption/decryption and file save operation must be implemented in background
3. Notification mechanism about encryption of data should be improved (I don't like NSNotificationCenter, but it's just faster to implement in POC)
4. Folder structure / refactoring of file operations
5. refactoring of supported file types enum
6. add ability to add/remove images
7. implement unit tests

Used resources:

1. compile static lib:
http://stackoverflow.com/questions/18811072/how-to-build-and-use-a-c-static-library-for-ios-application
2. xor encryption
http://stackoverflow.com/questions/20365005/c-xor-encryption
3. custom protocol
http://oyster.engineering/post/74290088019/getting-creative-with-uiwebview-and-nsurlprotocol
https://www.raywenderlich.com/59982/nsurlprotocol-tutorial


Custom build scripts.
I prefer to wrap static lib into framework (e g lib + headers)
https://gist.github.com/cromandini/1a9c4aeab27ca84f5d79

Later we can create build scripts so library will be updated during release phase.
