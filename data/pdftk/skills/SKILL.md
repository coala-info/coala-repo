---
name: pdftk
description: "pdftk is a command-line utility used to manipulate, secure, and manage PDF documents. Use when user asks to merge or split PDF files, rotate pages, apply backgrounds or watermarks, fill out PDF forms, and encrypt or decrypt documents."
homepage: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
metadata:
  docker_image: "pdftk/pdftk"
---


# pdftk

## Overview
The `pdftk` skill provides a specialized workflow for handling PDF manipulation tasks via the command line. It allows for complex operations such as concatenating multiple files, extracting specific page ranges, applying background stamps, and managing PDF metadata or form data (FDF/XFDF). Use this skill to perform deterministic PDF edits without needing a graphical editor.

## Common CLI Patterns

### Merging and Splitting
*   **Merge multiple PDFs**: `pdftk file1.pdf file2.pdf cat output combined.pdf`
*   **Merge using handles**: `pdftk A=file1.pdf B=file2.pdf cat A B output combined.pdf`
*   **Split a PDF into individual pages**: `pdftk large_file.pdf burst` (creates `pg_0001.pdf`, `pg_0002.pdf`, etc.)
*   **Extract specific pages**: `pdftk input.pdf cat 1-5 7 9-end output extracted.pdf`

### Rotation and Collation
*   **Rotate pages**: Use `north`, `south`, `east`, `west`, `left`, `right`.
    *   `pdftk input.pdf cat 1-endwest output rotated.pdf`
*   **Collate scanned pages**: If you have one PDF of odd pages and one of even pages (in reverse order):
    *   `pdftk A=odd.pdf B=even.pdf shuffle A Bend-1 output collated.pdf`

### Backgrounds and Watermarks
*   **Apply a background/watermark**: `pdftk input.pdf background watermark.pdf output final.pdf`
*   **Apply an overlay (foreground)**: `pdftk input.pdf stamp overlay.pdf output final.pdf`
*   **Multibackground**: Apply each page of a background PDF to the corresponding page of the input:
    *   `pdftk input.pdf multibackground back_pages.pdf output final.pdf`

### Form Filling and Data
*   **Generate a report of form fields**: `pdftk input.pdf dump_data_fields > fields.txt`
*   **Fill a form with FDF/XFDF data**: `pdftk form.pdf fill_form data.fdf output filled_form.pdf`
*   **Flatten a form**: (Prevents further editing of fields)
    *   `pdftk form.pdf fill_form data.fdf output filled.pdf flatten`
*   **Extract FDF from a PDF**: `pdftk filled.pdf generate_fdf output data.fdf`

### Security and Metadata
*   **Encrypt with a password**: `pdftk input.pdf output secured.pdf user_pw PROMPT owner_pw secret allow printing`
*   **Decrypt a PDF**: `pdftk secured.pdf input_pw secret output unsecured.pdf`
*   **Update Metadata**:
    1.  Dump: `pdftk input.pdf dump_data > report.txt`
    2.  Edit `report.txt`.
    3.  Update: `pdftk input.pdf update_info report.txt output updated.pdf`

## Expert Tips
*   **Handles**: Use uppercase letters (A, B, C) as aliases for long file paths to keep commands readable.
*   **UTF-8 Support**: When filling forms with special characters, ensure your environment supports UTF-8 and consider using `need_appearances` if the tool version supports it to ensure proper font rendering.
*   **Page Ranges**: Use `even` or `odd` keywords (e.g., `pdftk A.pdf cat A1-endsouth even output rotated_even.pdf`).
*   **Permissions**: When encrypting, you can granularly control permissions like `copy_contents`, `modify_contents`, or `screen_readers`.

## Reference documentation
- [PDFtk Server Manual](./references/www_pdflabs_com_tools_pdftk-the-pdf-toolkit.md)
- [php-pdftk README (Examples)](./references/github_com_mikehaertl_php-pdftk_blob_master_README.md)