# src/abimetadata

Theme:

🌗 Match OS
🌑 Dark
🌕 Light

* [Index](theindex.html)

Search:

Group by:
Section
Type

* [Imports](#6)
* [Types](#7)
  + [Config](#Config "Config = object
      inputFile*: string         ## Path to the input ABIF file
      outputFile*: string        ## Path to the output file (when editing)
      tag*: string               ## Tag name to view or edit
      value*: string             ## New value for tag (when editing)
      listTags*: bool            ## Whether to list all tags (default behavior)
      debug*: bool               ## Whether to show debug information
      limit*: int                ## Maximum number of tags to display (0 = no limit)
      showVersion*: bool         ## Whether to show version information")
* [Procs](#12)

  canDisplayTag- [canDisplayTag(tagName: string; entry: DirectoryEntry): bool](#canDisplayTag%2Cstring%2CDirectoryEntry "canDisplayTag(tagName: string; entry: DirectoryEntry): bool")
  displaySingleTag- [displaySingleTag(trace: ABIFTrace; tagName: string; debug: bool)](#displaySingleTag%2CABIFTrace%2Cstring%2Cbool "displaySingleTag(trace: ABIFTrace; tagName: string; debug: bool)")
  formatTagValue- [formatTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string](#formatTagValue%2Cstring%2CDirectoryEntry%2CABIFTrace "formatTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string")
  getFullTagValue- [getFullTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string](#getFullTagValue%2Cstring%2CDirectoryEntry%2CABIFTrace "getFullTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string")
  isHumanReadableType- [isHumanReadableType(tagType: ElementType): bool](#isHumanReadableType%2CElementType "isHumanReadableType(tagType: ElementType): bool")
  listMetadata- [listMetadata(trace: ABIFTrace; debug: bool; limit: int = 0)](#listMetadata%2CABIFTrace%2Cbool%2Cint "listMetadata(trace: ABIFTrace; debug: bool; limit: int = 0)")
  main- [main()](#main "main()")
  modifyTag- [modifyTag(trace: ABIFTrace; tagName: string; newValue: string;
    outputFile: string): bool](#modifyTag%2CABIFTrace%2Cstring%2Cstring%2Cstring "modifyTag(trace: ABIFTrace; tagName: string; newValue: string;
              outputFile: string): bool")
  parseCommandLine- [parseCommandLine(): Config](#parseCommandLine "parseCommandLine(): Config")
  printHelp- [printHelp()](#printHelp "printHelp()")
  verifyTagUpdate- [verifyTagUpdate(inputFile, outputFile, tagName: string): bool](#verifyTagUpdate%2Cstring%2Cstring%2Cstring "verifyTagUpdate(inputFile, outputFile, tagName: string): bool")
  verifyTagUpdateBasic- [verifyTagUpdateBasic(inputFile, outputFile, tagName: string; newValue: string;
    offset: int): bool](#verifyTagUpdateBasic%2Cstring%2Cstring%2Cstring%2Cstring%2Cint "verifyTagUpdateBasic(inputFile, outputFile, tagName: string; newValue: string;
                         offset: int): bool")
* [Exports](#19)

[Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L1)
[Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L1)

This module provides a command-line tool for displaying and modifying metadata in ABIF files.

The abimetadata tool allows users to:

1. List all human-readable metadata fields in an ABIF file
2. View the full content of a specific tag
3. Edit the value of a tag (currently limited to string-type tags)

Command-line usage:

```
abimetadata <input.ab1> [options]
```

Options:

-h, --help

Show help message

-l, --list

List all metadata fields (default)

-t, --tag=STRING

Tag name to view or edit

-v, --value=STRING

New value for tag when editing

-o, --output=STRING

Output file for modified ABI file

--limit=INT

Limit number of tags displayed

--version

Show version information

--debug

Show additional debug information

Examples:

```
# List all tags
abimetadata input.ab1

# View a specific tag's full content
abimetadata input.ab1 -t SMPL1

# Edit a tag
abimetadata input.ab1 -t SMPL1 -v "New Sample Name" -o modified.ab1
```

# [Imports](#6)

[abif](abif.html)

# [Types](#7)

``` Config = object inputFile*: string ## Path to the input ABIF file outputFile*: string ## Path to the output file (when editing) tag*: string ## Tag name to view or edit value*: string ## New value for tag (when editing) listTags*: bool ## Whether to list all tags (default behavior) debug*: bool ## Whether to show debug information limit*: int ## Maximum number of tags to display (0 = no limit) showVersion*: bool ## Whether to show version information ```
:   Configuration for the abimetadata tool. Contains command-line options and settings.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L40)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L40)

# [Procs](#12)

``` proc canDisplayTag(tagName: string; entry: DirectoryEntry): bool {....raises: [], tags: [], forbids: [].} ```
:   Determines if a tag can be displayed based on its name and properties.

    Parameters: tagName: The name of the tag entry: The DirectoryEntry for the tag

    Returns: true if the tag can be displayed, false otherwise

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L266)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L266)

``` proc displaySingleTag(trace: ABIFTrace; tagName: string; debug: bool) {. ...raises: [KeyError], tags: [ReadIOEffect], forbids: [].} ```
:   Displays the full content of a single tag.

    Parameters: trace: The ABIFTrace containing the tag tagName: The name of the tag to display debug: Whether to show debug information

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L428)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L428)

``` proc formatTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string {. ...raises: [], tags: [ReadIOEffect], forbids: [].} ```
:   Formats a tag's value for display, with possible truncation for long values.

    Parameters: tagName: The name of the tag entry: The DirectoryEntry for the tag trace: The ABIFTrace containing the tag

    Returns: The tag's value as a string, possibly truncated for display

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L338)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L338)

``` proc getFullTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string {. ...raises: [], tags: [ReadIOEffect], forbids: [].} ```
:   Gets the full, untruncated value of a tag.

    Parameters: tagName: The name of the tag entry: The DirectoryEntry for the tag trace: The ABIFTrace containing the tag

    Returns: The tag's value as a string, formatted according to its data type

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L285)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L285)

``` proc isHumanReadableType(tagType: ElementType): bool {....raises: [], tags: [], forbids: [].} ```
:   Determines if a tag type can be displayed in a human-readable format.

    Parameters: tagType: The ElementType to check

    Returns: true if the type is human-readable, false otherwise

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L246)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L246)

``` proc listMetadata(trace: ABIFTrace; debug: bool; limit: int = 0) {. ...raises: [IOError, KeyError], tags: [WriteIOEffect, ReadIOEffect], forbids: [].} ```
:   Lists all human-readable metadata fields in the ABIF file.

    Parameters: trace: The ABIFTrace to list metadata from debug: Whether to show debug information limit: Maximum number of tags to display (0 = no limit)

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L461)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L461)

``` proc main() {....raises: [ValueError, OSError], tags: [ReadIOEffect, ReadDirEffect, WriteIOEffect, ExecIOEffect], forbids: [].} ```
:   Main entry point for the abimetadata program.

    Handles command-line parsing and executes the appropriate action based on the provided options (list, view, or edit tags).

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L927)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L927)

``` proc modifyTag(trace: ABIFTrace; tagName: string; newValue: string; outputFile: string): bool {....raises: [KeyError], tags: [WriteIOEffect, ExecIOEffect, ReadDirEffect, ReadIOEffect], forbids: [].} ```
:   Modifies the value of a tag in an ABIF file.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L719)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L719)

``` proc parseCommandLine(): Config {....raises: [ValueError, OSError], tags: [ReadIOEffect], forbids: [].} ```
:   Parses command line arguments and returns a Config object.

    This procedure:

    * Initializes Config with default values
    * Processes command-line arguments
    * Handles special flags like --version and --help
    * Validates required parameters based on operating mode

    Returns: A Config object with settings based on command-line arguments

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L77)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L77)

``` proc printHelp() {....raises: [], tags: [], forbids: [].} ```
:   Displays the help message for the abimetadata tool. Exits the program after displaying the message.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L52)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L52)

``` proc verifyTagUpdate(inputFile, outputFile, tagName: string): bool {....raises: [], tags: [ReadIOEffect, WriteIOEffect], forbids: [].} ```
:   Verifies that a tag was properly updated by comparing original and modified files.

    Parameters: inputFile: Path to the original ABIF file outputFile: Path to the modified ABIF file tagName: The name of the tag that was modified

    Returns: true if the tag was successfully updated, false otherwise

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L622)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L622)

``` proc verifyTagUpdateBasic(inputFile, outputFile, tagName: string; newValue: string; offset: int): bool {.discardable, ...raises: [], tags: [ReadIOEffect], forbids: [].} ```
:   Verifies tag update by directly checking the binary content at the specified offset This simpler method just checks if we can find the expected value at the offset
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimetadata.nim#L561)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimetadata.nim#L561)

# [Exports](#19)

[exportFastq](abif.html#exportFastq,ABIFTrace,string), [newABIFTrace](abif.html#newABIFTrace,string,bool), [getQualityValues](abif.html#getQualityValues,ABIFTrace), [getData](abif.html#getData,ABIFTrace,string), [DirectoryEntry](abif.html#DirectoryEntry), [ElementType](abif.html#ElementType), [close](abif.html#close,ABIFTrace), [ABIFTrace](abif.html#ABIFTrace), [getTagNames](abif.html#getTagNames,ABIFTrace), [abifVersion](abif.html#abifVersion), [getSequence](abif.html#getSequence,ABIFTrace), [getSampleName](abif.html#getSampleName,ABIFTrace), [exportFasta](abif.html#exportFasta,ABIFTrace,string)

Made with Nim. Generated: 2025-07-23 15:08:18 UTC