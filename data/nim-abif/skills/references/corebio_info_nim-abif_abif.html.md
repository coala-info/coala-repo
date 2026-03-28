# src/abif

Theme:

🌗 Match OS
🌑 Dark
🌕 Light

* [Index](theindex.html)

Search:

Group by:
Section
Type

* [Types](#7)
  + [ABIFTrace](#ABIFTrace "ABIFTrace = ref object
      stream*: FileStream        ## File stream
      fileName*: string          ## Path to the file
      version*: int              ## ABIF format version
      numElems*: int             ## Number of directory entries
      ## Offset to the directory
      tags*: TableRef[string, DirectoryEntry] ## Directory entries indexed by tag
      data*: TableRef[string, string] ## Extracted data values")
  + [DirectoryEntry](#DirectoryEntry "DirectoryEntry = object
      tagName*: string           ## Four-character tag name
      tagNum*: int               ## Tag number
      elemType*: ElementType     ## Type of data stored
      elemSize*: int             ## Size of one element in bytes
      elemNum*: int              ## Number of elements
      dataSize*: int             ## Total size of data in bytes
      dataOffset*: int           ## Offset to the data in the file
      dataHandle*: int           ## Data handle (reserved)")
  + [ElementType](#ElementType "ElementType = enum
      etByte = 1, etChar = 2, etWord = 3, etShort = 4, etLong = 5, etRational = 6,
      etFloat = 7, etDouble = 8, etDate = 10, etTime = 11, etThumb = 12,
      etBool = 13, etPoint = 14, etRect = 15, etVPoint = 16, etVRect = 17,
      etPString = 18, etCString = 19, etTag = 20")
* [Procs](#12)

  abifVersion- [abifVersion(): string](#abifVersion "abifVersion(): string")
  close- [close(trace: ABIFTrace)](#close%2CABIFTrace "close(trace: ABIFTrace)")
  exportFasta- [exportFasta(trace: ABIFTrace; outFile: string = "")](#exportFasta%2CABIFTrace%2Cstring "exportFasta(trace: ABIFTrace; outFile: string = \"\")")
  exportFastq- [exportFastq(trace: ABIFTrace; outFile: string = "")](#exportFastq%2CABIFTrace%2Cstring "exportFastq(trace: ABIFTrace; outFile: string = \"\")")
  getData- [getData(trace: ABIFTrace; tag: string): string](#getData%2CABIFTrace%2Cstring "getData(trace: ABIFTrace; tag: string): string")
  getQualityValues- [getQualityValues(trace: ABIFTrace): seq[int]](#getQualityValues%2CABIFTrace "getQualityValues(trace: ABIFTrace): seq[int]")
  getSampleName- [getSampleName(trace: ABIFTrace): string](#getSampleName%2CABIFTrace "getSampleName(trace: ABIFTrace): string")
  getSequence- [getSequence(trace: ABIFTrace): string](#getSequence%2CABIFTrace "getSequence(trace: ABIFTrace): string")
  getTagNames- [getTagNames(trace: ABIFTrace): seq[string]](#getTagNames%2CABIFTrace "getTagNames(trace: ABIFTrace): seq[string]")
  newABIFTrace- [newABIFTrace(filename: string; trimming: bool = false): ABIFTrace](#newABIFTrace%2Cstring%2Cbool "newABIFTrace(filename: string; trimming: bool = false): ABIFTrace")

[Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L1)
[Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L1)

This module provides a parser for ABIF (Applied Biosystems Input Format) files, commonly used for DNA sequencing data (e.g., .ab1 files).

The parser can read the binary format, extract key information such as sequences, quality values, and other metadata, and export the data to common bioinformatics formats like FASTA and FASTQ.

Example:

```
import abif

# Open an ABIF file
let trace = newABIFTrace("example.ab1")

# Get sequence data
echo trace.getSequence()

# Export to FASTA format
trace.exportFasta("output.fa")

# Close the file when done
trace.close()
```

# [Types](#7)

``` ABIFTrace = ref object stream*: FileStream ## File stream fileName*: string ## Path to the file version*: int ## ABIF format version numElems*: int ## Number of directory entries ## Offset to the directory tags*: TableRef[string, DirectoryEntry] ## Directory entries indexed by tag data*: TableRef[string, string] ## Extracted data values ```
:   Main object representing an ABIF file. Contains methods to extract and process the data.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L55)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L55)

``` DirectoryEntry = object tagName*: string ## Four-character tag name tagNum*: int ## Tag number elemType*: ElementType ## Type of data stored elemSize*: int ## Size of one element in bytes elemNum*: int ## Number of elements dataSize*: int ## Total size of data in bytes dataOffset*: int ## Offset to the data in the file dataHandle*: int ## Data handle (reserved) ```
:   Represents a directory entry in the ABIF file. Each entry contains metadata about a data element.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L43)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L43)

``` ElementType = enum etByte = 1, etChar = 2, etWord = 3, etShort = 4, etLong = 5, etRational = 6, etFloat = 7, etDouble = 8, etDate = 10, etTime = 11, etThumb = 12, etBool = 13, etPoint = 14, etRect = 15, etVPoint = 16, etVRect = 17, etPString = 18, etCString = 19, etTag = 20 ```
:   Represents the data types that can be stored in an ABIF file.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L36)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L36)

# [Procs](#12)

``` proc abifVersion(): string {....raises: [], tags: [], forbids: [].} ```
:   Returns the version of the abif library.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L28)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L28)

``` proc close(trace: ABIFTrace) {....raises: [IOError, OSError], tags: [WriteIOEffect], forbids: [].} ```
:   Closes the file stream associated with the trace.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L292)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L292)

``` proc exportFasta(trace: ABIFTrace; outFile: string = "") {. ...raises: [KeyError, IOError, OSError], tags: [ReadIOEffect, WriteIOEffect], forbids: [].} ```
:   Exports the sequence to a FASTA format file.

    Parameters: outFile: Path to the output file. If empty, "trace.fa" is used.

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L344)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L344)

``` proc exportFastq(trace: ABIFTrace; outFile: string = "") {. ...raises: [KeyError, IOError, OSError], tags: [ReadIOEffect, WriteIOEffect], forbids: [].} ```
:   Exports the sequence and quality values to a FASTQ format file.

    Parameters: outFile: Path to the output file. If empty, "trace.fq" is used.

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L363)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L363)

``` proc getData(trace: ABIFTrace; tag: string): string {. ...raises: [IOError, OSError, KeyError], tags: [ReadIOEffect], forbids: [].} ```
:   Retrieves data for a specific tag.

    Parameters: tag: The tag name to retrieve data for

    Returns: The data as a string, or an empty string if the tag does not exist

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L302)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L302)

``` proc getQualityValues(trace: ABIFTrace): seq[int] {. ...raises: [KeyError, IOError, OSError], tags: [ReadIOEffect], forbids: [].} ```
:   Returns the sequence quality values as a sequence of integers.

    Each value represents the quality score for the corresponding base in the sequence.

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L322)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L322)

``` proc getSampleName(trace: ABIFTrace): string {. ...raises: [KeyError, IOError, OSError], tags: [ReadIOEffect], forbids: [].} ```
:   Returns the sample name from the trace.

    Uses the pre-extracted "name" data or retrieves it from the SMPL1 tag.

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L336)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L336)

``` proc getSequence(trace: ABIFTrace): string {. ...raises: [KeyError, IOError, OSError], tags: [ReadIOEffect], forbids: [].} ```
:   Returns the DNA sequence from the trace.

    Uses the pre-extracted "sequence" data or retrieves it from the PBAS2 tag.

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L314)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L314)

``` proc getTagNames(trace: ABIFTrace): seq[string] {....raises: [], tags: [], forbids: [].} ```
:   Returns a sequence of all tag names in the ABIF file.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L297)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L297)

``` proc newABIFTrace(filename: string; trimming: bool = false): ABIFTrace {. ...raises: [IOError, OSError, KeyError], tags: [ReadIOEffect], forbids: [].} ```
:   Creates a new ABIFTrace object from the specified file.

    Parameters: filename: Path to the ABIF file trimming: If true, low quality regions are trimmed (not implemented)

    Returns: A new ABIFTrace object

    Raises: IOError: If the file cannot be opened or is not a valid ABIF file

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abif.nim#L241)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abif.nim#L241)

Made with Nim. Generated: 2025-07-23 15:08:19 UTC