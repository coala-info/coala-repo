---
name: pdftk
description: pdftk is a command-line utility used for manipulating PDF documents through operations like merging, splitting, and form filling. Use when user asks to merge multiple PDFs, split a document into individual pages, rotate pages, fill PDF forms, apply watermarks, or manage document metadata and security.
homepage: https://github.com/mikehaertl/php-pdftk
---


# pdftk

## Overview
pdftk (PDF Toolkit) is a powerful command-line utility designed for "handy" PDF operations. It allows for complex document manipulation without the need for a heavy GUI. It is the industry standard for programmatic PDF tasks such as concatenating files, bursting a single PDF into individual pages, applying background stamps (watermarking), and programmatically filling form fields using FDF or XFDF data.

## Common CLI Patterns

### Merging and Page Manipulation
Use handles (A, B, etc.) to reference multiple input files clearly.

*   **Merge multiple PDFs**:
    `pdftk A=file1.pdf B=file2.pdf cat A B output combined.pdf`
*   **Select specific page ranges**:
    `pdftk A=input.pdf cat A1-5 A7 A9-end output subset.pdf`
*   **Rotate pages**:
    Append rotation keywords (North, South, East, West, Left, Right) to page ranges.
    `pdftk in.pdf cat 1-endE output rotated.pdf` (Rotates all pages 90 degrees clockwise)

### Splitting and Bursting
*   **Split PDF into single pages**:
    `pdftk large_doc.pdf burst`
    *Note: This creates files like pg_0001.pdf, pg_0002.pdf and a doc_data.txt file.*
*   **Specify output format for burst**:
    `pdftk in.pdf burst output page_%02d.pdf`

### Form Filling
To fill a form, you typically need an FDF or XFDF file containing the data.

*   **Fill a form and keep it editable**:
    `pdftk form.pdf fill_form data.fdf output filled_form.pdf`
*   **Fill a form and "flatten" it (make it non-editable)**:
    `pdftk form.pdf fill_form data.fdf output flattened.pdf flatten`
*   **Generate a data template from a form**:
    `pdftk form.pdf generate_fdf output template.fdf`

### Backgrounds and Watermarks
*   **Apply a background (watermark) to every page**:
    `pdftk document.pdf background watermark.pdf output watermarked.pdf`
*   **Apply a different background to each page (Multibackground)**:
    `pdftk document.pdf multibackground backgrounds.pdf output result.pdf`
*   **Apply an overlay (stamp) on top of content**:
    `pdftk document.pdf stamp overlay.pdf output stamped.pdf`

### Metadata and Security
*   **Extract PDF metadata and field names**:
    `pdftk document.pdf dump_data output metadata.txt`
    `pdftk document.pdf dump_data_fields output fields.txt`
*   **Update PDF metadata**:
    `pdftk in.pdf update_info metadata.txt output out.pdf`
*   **Encrypt a PDF with a password**:
    `pdftk in.pdf output secured.pdf owner_pw yourpassword user_pw yourpassword encrypt_128bit`
*   **Remove a password**:
    `pdftk secured.pdf input_pw yourpassword output open.pdf`

## Expert Tips
*   **Handles**: Always use uppercase letters for handles (A, B, C) to avoid confusion with command keywords.
*   **UTF-8 Support**: When filling forms with special characters, ensure you are using `pdftk-java` or version 2.x+, and consider using the `need_appearances` flag if the PDF viewer fails to render fonts correctly.
*   **Performance**: For very large operations, `pdftk` is significantly faster than most GUI-based tools because it operates directly on the PDF object stream.
*   **Collation**: Use the `shuffle` command instead of `cat` to interleave pages from multiple files (e.g., `pdftk A=even.pdf B=odd.pdf shuffle A B output collated.pdf`).

## Reference documentation
- [php-pdftk README](./references/github_com_mikehaertl_php-pdftk.md)