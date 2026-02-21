---
name: perl-image-exiftool
description: The `exiftool` command-line application is a powerful, platform-independent utility for manipulating file metadata.
homepage: https://metacpan.org/pod/Image::ExifTool
---

# perl-image-exiftool

## Overview
The `exiftool` command-line application is a powerful, platform-independent utility for manipulating file metadata. It supports thousands of different tags and hundreds of file formats. This skill provides the essential patterns for querying specific metadata, performing batch updates, and automating file organization based on internal metadata properties.

## Common CLI Patterns

### Reading Metadata
- **Extract all metadata**: `exiftool image.jpg`
- **Extract specific tags**: `exiftool -DateTimeOriginal -GPSPosition image.jpg`
- **Extract common tags in tab-delimited format**: `exiftool -T -common dir > metadata.txt`
- **Identify duplicate tags and their groups**: `exiftool -a -u -g1 image.jpg`

### Writing and Editing
- **Update a specific tag**: `exiftool -Artist="Author Name" image.jpg`
- **Delete a specific tag**: `exiftool -GPSUpdate:all= image.jpg`
- **Delete all metadata**: `exiftool -all= image.jpg` (Note: This leaves some hardware-level information intact).
- **Shift dates/times**: `exiftool "-AllDates+=0:0:0 1:30:0" dir` (Adds 1 hour and 30 minutes to all date tags).

### File Organization and Renaming
- **Rename files by date**: `exiftool '-filename<CreateDate' -d %Y%m%d_%H%M%S%%-c.%%e dir`
- **Organize into folders by year/month**: `exiftool '-Directory<CreateDate' -d %Y/%m dir`

## Expert Tips
- **Preserve File Modification Date**: Use the `-P` option to prevent ExifTool from updating the filesystem's "File Modification Date/Time" when editing tags.
- **Batch Processing**: Use `-r` to recurse into subdirectories.
- **Conditional Processing**: Use the `-if` option to process only files meeting specific criteria, e.g., `exiftool -all= -if '$imagesize eq "640x480"' dir`.
- **Copying Tags**: Copy metadata from one file to another using `exiftool -tagsFromFile source.jpg "-all:all>all:all" target.jpg`.
- **Output Formats**: Use `-json` or `-xml` for structured data export that can be easily parsed by other scripts.

## Reference documentation
- [Image::ExifTool Documentation](./references/metacpan_org_pod_Image__ExifTool.md)