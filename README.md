# Chat Demo
![ScreenShot](https://raw.github.com/duongifc/ChatDemo/master/Demo.gif)


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

### Project structure

|↝ `Application`: contains global variables, application management functions, prefix,..

|↝ `Configurations`: setup environment (development, production, staging), database, ...

|↝ `Models`: contains model objects

|↝ `Services`: contains services which analyze data, communicate with api, database, cache and other datasources

|↝ `UI` - `Presentation layer`

|-----|-----↝ `Custom controls`: contains custom controls which are not supported from cocoapods, carthage and written by yourself

|-----|-----↝ `Helpers`: contains libraries which are related to UI and can not build as framework

|-----|-----↝ `Common`: contains base element, controls, ...

|-----|-----↝ `Scenes`: seperated by screens

|-----|------------|-----↝ `Example screen`:  

|-----|------------|----------------|-----↝ `ViewControllers`:  bind data and event, do not implement business logic code

|-----|------------|----------------|-----↝ `ViewModels`:  implement business logic code

|-----|------------|----------------|-----↝ `Views`:  contains child views, cells, ...

|-----|------------|-----↝ `Storyboards`:  contains storyboards

|↝ `Resources`: contains images, assets, videos, audios, database, jsons, xmls and other local data files

|↝ `Utilities`:  help develop easier and faster and code more beautiful

|-----|-----↝ `Extensions`: contains extensions

|-----|-----↝ **and other**



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
