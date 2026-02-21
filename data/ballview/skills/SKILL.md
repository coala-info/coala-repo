---
name: ballview
description: BallView is a custom Android UI component designed to visualize progress through a "water ball" effect.
homepage: https://github.com/LaxusJie/BallViewDemo
---

# ballview

## Overview
BallView is a custom Android UI component designed to visualize progress through a "water ball" effect. It provides a smooth ripple animation that fills a circular container based on a defined percentage. This skill helps developers integrate the component into their Android projects, configure its layout in XML, and control the animation and target values via Java.

## Integration and Setup
To use BallView in an Android project, you must manually include the source and assets:
1.  **Source Code**: Copy `BallView.java` into your project's package directory.
2.  **Assets**: Copy the required ripple/mask images from the `mipmap-xxhdpi` folder of the demo project into your own project's resource folders.

## XML Implementation
Define the BallView in your layout XML file. Ensure the width and height are equal to maintain a circular aspect ratio.

```xml
<com.app.ballviewdemo.BallView
    android:id="@+id/ballview"
    android:layout_width="250dp"
    android:layout_height="250dp"
    android:layout_centerHorizontal="true"/>
```

## Programmatic Usage
Control the progress and animation within your Activity or Fragment using the following methods:

1.  **Initialize**: Find the view by its ID.
2.  **Set Progress**: Use `setTarget(int)` to define the percentage (0-100).
3.  **Animate**: Call `start()` to begin the water ripple animation.

```java
BallView ballView = (BallView) findViewById(R.id.ballview);
ballView.setTarget(70); // Set progress to 70%
ballView.start();       // Begin animation
```

## Best Practices
- **Aspect Ratio**: Always use identical values for `android:layout_width` and `android:layout_height`. If the dimensions differ, the water ripple effect may appear distorted or clipped.
- **Performance**: Since the view uses custom drawing and animation, avoid placing a large number of BallViews on a single screen to prevent UI thread lag.
- **Target Values**: Ensure the integer passed to `setTarget()` is within the 0-100 range to avoid unexpected visual behavior.

## Reference documentation
- [BallView Main README](./references/github_com_LaxusJie_BallViewDemo.md)