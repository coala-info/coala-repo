---
name: pdftk
description: Pdftk is a command-line tool used for manipulating, merging, splitting, and securing PDF documents. Use when user asks to merge multiple PDFs, extract specific page ranges, split documents into individual pages, fill PDF forms, apply watermarks, or manage document encryption and permissions.
homepage: https://github.com/mikehaertl/php-pdftk
---


# pdftk

## Overview

The pdftk (PDF Toolkit) skill enables efficient, command-line based manipulation of PDF documents. It transforms complex PDF tasks—such as assembling multiple documents, extracting specific page ranges, or programmatically filling out forms—into simple, deterministic operations. Use this skill to handle PDF workflows that require high reliability, such as batch processing, document assembly, or security enforcement (passwords and permissions).

## Core CLI Operations

### 1. Merging and Page Manipulation (cat)
Use the `cat` operation to assemble pages from one or more input PDFs.

*   **Merge multiple files**: `pdftk file1.pdf file2.pdf cat output combined.pdf`
*   **Extract specific pages**: `pdftk A=input.pdf cat A1-5 A7 A9-11 output extracted.pdf`
*   **Rotate pages**: Append orientation (North, South, East, West, Left, Right) to the page range.
    *   `pdftk input.pdf cat 1-endsouth output rotated.pdf`
*   **Reverse page order**: `pdftk input.pdf cat end-1 output reversed.pdf`

### 2. Splitting Documents (burst)
The `burst` command splits a single PDF into individual pages.
*   `pdftk input.pdf burst`
*   *Note*: This generates files like `pg_0001.pdf`, `pg_0002.pdf`, and a `doc_data.txt` report.

### 3. Form Filling (fill_form)
Fill PDF form fields using data from an FDF or XFDF file.
*   **Basic fill**: `pdftk form.pdf fill_form data.fdf output filled_form.pdf`
*   **Flattening**: To make the form non-editable after filling, add the `flatten` option.
    *   `pdftk form.pdf fill_form data.fdf output filled.pdf flatten`
*   **UTF-8 Support**: When filling forms with special characters, use the `need_appearances` flag to ensure the PDF viewer generates the correct font appearances.

### 4. Backgrounds and Overlays
*   **Background (Watermark)**: Places the first page of the background PDF *behind* the input PDF pages.
    *   `pdftk input.pdf background watermark.pdf output watermarked.pdf`
*   **Overlay (Stamp)**: Places the first page of the stamp PDF *on top* of the input PDF pages.
    *   `pdftk input.pdf stamp stamp.pdf output stamped.pdf`
*   **Multibackground/Multistamp**: Applies each page of the background/stamp to the corresponding page of the input.

### 5. Metadata and Data Reporting
*   **Extract metadata**: `pdftk input.pdf dump_data output report.txt`
*   **Extract form field info**: `pdftk input.pdf dump_data_fields output fields.txt`
*   **Update metadata**: `pdftk input.pdf update_info new_metadata.txt output updated.pdf`

### 6. Security and Permissions
*   **Encrypt with password**: `pdftk input.pdf output secured.pdf user_pw <password>`
*   **Set permissions**: `pdftk input.pdf output secured.pdf owner_pw <password> allow Printing`
*   **Decrypt**: `pdftk secured.pdf input_pw <password> output open.pdf`

## Expert Tips
*   **Handles**: Use uppercase letters (A, B, C) as aliases for long file paths to keep commands readable: `pdftk A=very_long_path_1.pdf B=very_long_path_2.pdf cat A1-5 B3-10 output out.pdf`.
*   **Shuffle**: Use `shuffle` instead of `cat` to interleave pages from multiple files (e.g., for collating scanned double-sided documents).
*   **Drop Permissions**: To remove all security restrictions from a PDF (if you have the owner password), simply read it and output it without specifying security options.



## Subcommands

| Command | Description |
|---------|-------------|
| pdftk | Packs arbitrary files into a PDF using PDF's file attachment features. |
| pdftk | Applies a PDF watermark to the background of a single input PDF. Pdftk uses only the first page from the background PDF and applies it to every page of the input PDF. |
| pdftk | Splits a single input PDF document into individual pages. Also creates a report named doc_data.txt. |
| pdftk | Assembles (catenates) pages from input PDFs to create a new PDF. Use cat to merge PDF pages or to split PDF pages from documents. You can also use it to rotate PDF pages. |
| pdftk | Reads a single input PDF file and reports its metadata, bookmarks, page metrics, and other data to an output file or stdout. |
| pdftk | Reads a single input PDF file and reports annotation information (currently only link annotations) to the given output filename or stdout. |
| pdftk | Reads a single input PDF file and reports form field statistics to the given output filename or stdout. |
| pdftk | Reads a single input PDF file and reports form field statistics to the given output filename or stdout, encoded as UTF-8. Does not create a new PDF. |
| pdftk | Reads a single input PDF file and reports its metadata, bookmarks, page metrics, and other data to the given output filename or stdout, encoded as UTF-8. |
| pdftk | Fills the single input PDF's form fields with the data from an FDF file, XFDF file or stdin. |
| pdftk | Reads a single input PDF file and generates an FDF file suitable for fill_form out of it to the given output filename or (if no output is given) to stdout. Does not create a new PDF. |
| pdftk | Applies each page of the background PDF to the corresponding page of the input PDF. If the input PDF has more pages than the background PDF, then the final background page is repeated across the remaining pages. |
| pdftk | Apply each page of the stamp PDF to the corresponding page of the input PDF. If the input PDF has more pages than the stamp PDF, then the final stamp page is repeated across these remaining pages. |
| pdftk | Takes a single input PDF and rotates just the specified pages. All other pages remain unchanged. The page order remains unchanged. |
| pdftk | Collates pages from input PDFs to create a new PDF. Works like the cat operation except that it takes one page at a time from each page range to assemble the output PDF. |
| pdftk | Apply a foreground stamp to a PDF document. This behaves like the background operation except it overlays the stamp PDF page on top of the input PDF document's pages. |
| pdftk | Copies all of the attachments from the input PDF into the current folder or to an output directory given after output. |
| pdftk | Changes the bookmarks and metadata in a single PDF's Info dictionary to match the input data file. |
| pdftk | Changes the bookmarks and metadata in a single PDF's Info dictionary to match the input data file (UTF-8 encoded). |

## Reference documentation
- [php-pdftk README](./references/github_com_mikehaertl_php-pdftk_blob_master_README.md)