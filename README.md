# Chat Demo
### Requirements:
- [Xcode 8]
- [Swift 3.0]
- [Carthage]: A simple, decentralized dependency manager for Cocoa

### Installation guides:
- `cd` to project folder / `Carthage`
- `run` command `carthage update --platform iOS --no-use-binaries`
- Check out `build` folder and copy frameworks to project
- Do not forget to add frameworks to `embbed binaries`
- If `ChatDemoTests` sheme can not run, please copy `XCTest` framework to `Frameworks` folder

### Getting started:
This project is a demo of chat application uses:
- [MVVM]: a software architectural pattern
- Reactive programming with [RxSwift]
- [Auto layout]

### Testing & Code coverage
- [Code coverage] using Xcode: 
- [Unit Test]
- [UI Test]

> Thanks for reading,
> Duong Tran

[Carthage]: <https://github.com/Carthage/Carthage>
[RxSwift]: <https://github.com/ReactiveX/RxSwift>
[Swift 3.0]: <https://swift.org/>
[Xcode 8]: <https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_8/Xcode_8.xip>
[MVVM]: <https://www.objc.io/issues/13-architecture/mvvm/>
[Auto layout]: <https://developer.apple.com/library/prerelease/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html>
[Code coverage]: <https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/07-code_coverage.html>
[Unit Test]: <https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/07-code_coverage.html>
[UI Test]: <https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/09-ui_testing.html>
