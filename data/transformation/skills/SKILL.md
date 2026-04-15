---
name: transformation
description: This tool applies complex visual effects and transformations to images in Android projects. Use when user asks to blur an image, crop an image, apply rounded corners, convert an image to grayscale, apply a color filter, mask an image, or use GPU-based artistic effects.
homepage: https://github.com/wasabeef/glide-transformations
metadata:
  docker_image: "biocontainers/transformation:phenomenal-v2.2.2_cv1.2.8"
---

# transformation

## Overview
The transformation skill enables the integration of the `glide-transformations` library into Android projects. While Glide provides basic image loading, this skill extends those capabilities to include complex visual effects like Gaussian blurs, rounded corners, grayscale filters, and various GPU-based artistic effects. It is particularly useful for creating polished UI components like circular profile pictures or blurred background headers.

## Implementation Guide

### 1. Dependency Configuration
To use these transformations, ensure the library is included in your `build.gradle` file. If using GPU-accelerated filters, the `gpuimage` dependency is also required.

```gradle
repositories {
    mavenCentral()
}

dependencies {
    implementation 'jp.wasabeef:glide-transformations:4.3.0'
    // Required only for GPU Filters
    implementation 'jp.co.cyberagent.android:gpuimage:2.1.0'
}
```

### 2. Applying Basic Transformations
Transformations are applied using `RequestOptions.bitmapTransform()`.

**Blurring an Image:**
```kotlin
Glide.with(context)
    .load(url)
    .apply(RequestOptions.bitmapTransform(BlurTransformation(25, 3)))
    .into(imageView)
```

**Circular Crop:**
```kotlin
Glide.with(context)
    .load(url)
    .apply(RequestOptions.bitmapTransform(CropCircleTransformation()))
    .into(imageView)
```

### 3. Combining Multiple Transformations
When applying more than one effect, use `MultiTransformation` to chain them. The order of transformations in the list determines the order of execution.

```kotlin
val multi = MultiTransformation<Bitmap>(
    BlurTransformation(25),
    RoundedCornersTransformation(128, 0, RoundedCornersTransformation.CornerType.BOTTOM)
)

Glide.with(context)
    .load(url)
    .apply(RequestOptions.bitmapTransform(multi))
    .into(imageView)
```

### 4. Available Transformation Categories
- **Crop**: `CropTransformation`, `CropCircleTransformation`, `CropSquareTransformation`, `RoundedCornersTransformation`.
- **Color**: `ColorFilterTransformation`, `GrayscaleTransformation`.
- **Blur**: `BlurTransformation`.
- **Mask**: `MaskTransformation` (uses a local drawable as a mask).
- **GPU Filters**: `ToonFilterTransformation`, `SepiaFilterTransformation`, `ContrastFilterTransformation`, `InvertFilterTransformation`, `PixelationFilterTransformation`, `SketchFilterTransformation`, `SwirlFilterTransformation`, `BrightnessFilterTransformation`, `KuwaharaFilterTransformation`, `VignetteFilterTransformation`.

## Expert Tips & Best Practices
- **Performance**: GPU filters are generally more performant for complex mathematical operations but require the additional `gpuimage` dependency. Use standard transformations for simple tasks like cropping to keep the APK size smaller.
- **Transformation Order**: When using `MultiTransformation`, always place cropping or resizing transformations before heavy filters (like Blur) to reduce the number of pixels the filter needs to process.
- **Corner Types**: `RoundedCornersTransformation` allows for specific corner masking (e.g., `TOP`, `BOTTOM`, `LEFT`, `RIGHT`). This is ideal for card layouts where only the top corners should be rounded.
- **Blur Radius**: The `BlurTransformation` takes two parameters: `radius` and `sampling`. Increasing `sampling` (e.g., to 3 or 4) reduces the image size before blurring, which significantly improves performance for large images while maintaining the blur effect.

## Reference documentation
- [Glide Transformations README](./references/github_com_wasabeef_glide-transformations.md)