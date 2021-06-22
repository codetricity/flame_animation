# Flame Animation test

![screenshot](docs/images/screenshot.gif)

Uses Flutter stack to use Flutter widgets inside a Flame game.

Audio only tested on Android and Google Chrome as of June 21, 2021.  

[video tutorial](https://youtu.be/v_Yb95vdMEM)

## Notes

If you encounter build errors on Android, it may be because of gradle cache.
I had to through the steps below.  I have audio working on web and Android now.

https://github.com/flutter/flutter/issues/83834

https://github.com/luanpotter/audioplayers/issues/923

Incompatible version of Kotlin.

In `build.gradle` under android

```
buildscript {
    ext.kotlin_version = '1.5.10'
    repositories {
        google()
```