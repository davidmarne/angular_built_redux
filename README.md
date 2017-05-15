[![Pub](https://img.shields.io/pub/v/angular_built_redux.svg)](https://pub.dartlang.org/packages/angular_built_redux)

### angular_built_redux

Provides a class for your components to extend that will subscribe to a built redux store and only perform change detection when the store triggers and values your component cares about change.

### Caution
This is library is still in discovery. If you are using built redux in your angular2 app it may be best to instantiate the store in your top-level component and pass values down from the top. Then you can use OnPush change detection for the children components.
