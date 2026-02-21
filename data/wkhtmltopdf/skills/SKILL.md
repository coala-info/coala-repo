---
name: wkhtmltopdf
description: wkhtmltopdf is a command-line toolset (including wkhtmltoimage) that renders HTML content into PDF or various image formats.
homepage: https://github.com/wkhtmltopdf/wkhtmltopdf
---

# wkhtmltopdf

## Overview

wkhtmltopdf is a command-line toolset (including wkhtmltoimage) that renders HTML content into PDF or various image formats. It utilizes a headless instance of the Qt WebKit engine, allowing it to process CSS and JavaScript without requiring a display service (like X11). It is the industry standard for server-side "HTML-to-PDF" conversion where high fidelity to web layouts is required.

## Core Usage Patterns

### Basic Conversion
The simplest form takes an input (URL or local file) and an output path:
```bash
wkhtmltopdf https://example.com output.pdf
wkhtmltopdf local_file.html output.pdf
```

### Page Setup and Margins
Control the physical layout of the PDF document:
- **Margins**: Use `--margin-top`, `--margin-bottom`, `--margin-left`, and `--margin-right` (e.g., `--margin-top 20mm`).
- **Orientation**: Use `-O Landscape` or `-O Portrait`.
- **Page Size**: Use `-s A4`, `-s Letter`, etc.

### Content Rendering Control
- **Print Media Type**: Use `--print-media-type` to force the use of `@media print` CSS instead of `@media screen`.
- **JavaScript Execution**: By default, JS is enabled. Use `--no-stop-slow-scripts` for complex visualizations or `--javascript-delay <msec>` to wait for asynchronous content to load.
- **Forms**: Use `--enable-forms` to convert HTML input elements into interactive PDF form fields.

### Headers and Footers
Add dynamic content to every page:
- **Standard Headers**: Use `--header-line` to add a separator and `--header-center "Text"`.
- **HTML Templates**: Use `--header-html <url>` or `--footer-html <url>` for complex, styled headers/footers.
- **Variables**: Use `[page]`, `[topage]`, `[date]`, and `[time]` within header/footer text strings.

## Expert Tips

- **Headless Execution**: Since the tool is inherently headless, it is ideal for Docker containers and CI/CD pipelines. Ensure necessary fonts are installed in the environment, as WebKit relies on system fonts for rendering.
- **Internal Linking**: Ensure anchor tags have `href` attributes. For internal document links, use standard ID fragments (e.g., `<a href="#section1">`).
- **Smart Width**: When using `wkhtmltoimage`, use `--smart-width` to automatically determine the width of the output image based on the content.
- **Table of Contents**: Generate a TOC automatically by inserting the `toc` object:
  ```bash
  wkhtmltopdf toc https://example.com/report output.pdf
  ```
- **Handling Assets**: If converting local HTML files, ensure image and CSS paths are absolute or use the `--allow <path>` flag to grant the renderer access to local directories.

## Reference documentation
- [Main Repository and README](./references/github_com_wkhtmltopdf_wkhtmltopdf.md)
- [Issue Tracker (Feature Flags and Bug Context)](./references/github_com_wkhtmltopdf_wkhtmltopdf_issues.md)
- [Pull Requests (Advanced Configuration Options)](./references/github_com_wkhtmltopdf_wkhtmltopdf_pulls.md)