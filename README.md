# Flame Animation test

![screenshot](docs/images/screenshot.gif)

Uses Flutter stack to use Flutter widgets inside a Flame game.

Audio stopped working as of June 21, 2021.  

[video tutorial](https://youtu.be/v_Yb95vdMEM)

## Notes

Trying to debug audio problem.
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