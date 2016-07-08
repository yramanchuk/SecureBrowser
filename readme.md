Steps to build:

1. Build VeraCryptoLib project for all needed architectures (sim + devices)
2. Create universal lib:
	2.1  open Terminal go Products path
	2.2 run lipo -create Debug-iphoneos/libVeraCryptoLib.a Debug-iphonesimulator/libVeraCryptoLib.a -output libVeraCryptoLib.a
	2.3 update lib headers if they were changed by you
3. Build and run SecureBrowser


Remarks:
We use XOR crypto, so file can be en/de-crypted with the same key - you can try to encrypt it several times;



Possible improvements:
1. Use models for data flow (not NSURLs)
2. encryption/decryption and file save in background
3. Notification mechanism about encrypt data should be changed (don't like used one, but it's fastest)
4. Folder structer and refactoring of file operations
5. refactoring of supported file types enum
6. add ability to add/remove images
7. implemet unit tests

Used resources:
1. compile static lib:
http://stackoverflow.com/questions/18811072/how-to-build-and-use-a-c-static-library-for-ios-application
2. xor encryption
http://stackoverflow.com/questions/20365005/c-xor-encryption
3. cutom protocol
http://oyster.engineering/post/74290088019/getting-creative-with-uiwebview-and-nsurlprotocol
https://www.raywenderlich.com/59982/nsurlprotocol-tutorial


Custom build scripts
I prefer wrap into framework (e g lib + headers)
https://gist.github.com/cromandini/1a9c4aeab27ca84f5d79

Later we can create build scripts so library will be updated during release phase.