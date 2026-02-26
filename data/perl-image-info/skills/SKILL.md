---
name: perl-image-info
description: This tool extracts technical metadata and identifies file formats for a wide variety of image types using the Image::Info Perl module. Use when user asks to retrieve image dimensions, identify file types, extract metadata from images, or detect file corruption.
homepage: https://metacpan.org/pod/Image::Info
---


# perl-image-info

## Overview
The `perl-image-info` skill leverages the `Image::Info` Perl module to parse and retrieve technical details from image files. It supports a broad spectrum of formats, including common types like JPEG, PNG, and GIF, as well as specialized formats like BMP, XBM, and XPM. This skill is particularly effective for identifying image properties (width, height, color type) and detecting file format mismatches or corruption through error reporting.

## Usage Patterns and Best Practices

### Quick Metadata Extraction (CLI One-liners)
Since `perl-image-info` is primarily a Perl library, the most efficient way to use it from the command line is via Perl one-liners.

**Extract all metadata as a Data Dumper string:**
```bash
perl -MImage::Info=image_info -MData::Dumper -e 'print Dumper(image_info("image.jpg"))'
```

**Print image dimensions (Width x Height):**
```bash
perl -MImage::Info=image_info,dim -e '$info = image_info("image.png"); print join("x", dim($info)), "\n"'
```

**Identify the actual file type (independent of extension):**
```bash
perl -MImage::Info=image_type -e 'print image_type("file.dat")->{file_type}'
```

### Handling Multi-Image Files
Some formats (like GIF or TIFF) may contain multiple images. `image_info` returns a list of hashes in list context.

**Get info for all frames in an animated GIF:**
```bash
perl -MImage::Info=image_info -e '@info = image_info("animation.gif"); print scalar(@info) . " frames found\n"'
```

### Error Handling
Always check for the `error` key in the returned hash to ensure the file was parsed correctly.

```bash
perl -MImage::Info=image_info -e '
    $info = image_info("corrupt.jpg");
    if ($info->{error}) {
        print "Error: " . $info->{error} . "\n";
    } else {
        print "Format: " . $info->{file_media_type} . "\n";
    }
'
```

### Common Metadata Keys
When accessing the info hash, these keys are frequently available across most formats:
- `width`: Image width in pixels.
- `height`: Image height in pixels.
- `color_type`: Description of the color space (e.g., "RGB", "Gray", "Indexed").
- `file_media_type`: The MIME type (e.g., "image/jpeg").
- `resolution`: DPI or physical resolution if available.

## Expert Tips
- **Memory Efficiency**: If you only need to check the file type without parsing the entire metadata tree, use `image_type()` instead of `image_info()`.
- **In-Memory Processing**: You can pass a scalar reference containing image data to `image_info(\$data)` if the image is already loaded in memory, avoiding unnecessary disk I/O.
- **Format Specifics**: For formats like BMP or XPM, the module provides specific sub-modules (`Image::Info::BMP`, etc.) which are automatically loaded by the main `Image::Info` interface.

## Reference documentation
- [Image::Info - Extract meta information from image files](./references/metacpan_org_pod_Image__Info.md)
- [Image::Info::BMP](./references/metacpan_org_pod_Image__Info__BMP.md)
- [Image::Info::XPM](./references/metacpan_org_pod_Image__Info__XPM.md)