---
name: tidyp
description: The tidyp tool cleans and validates HTML content. Use when user asks to clean HTML, validate HTML, or format HTML.
homepage: https://github.com/jbengler/tidyplots
metadata:
  docker_image: "quay.io/biocontainers/tidyp:1.04--h7b50bb2_9"
---

# tidyp

---
## Overview
The `tidyp` tool is designed to clean and validate HTML content. It helps ensure that HTML is well-formed, fixing common errors and inconsistencies, making it suitable for further processing or display.

## Usage

The `tidyp` tool is primarily used via its command-line interface.

### Basic Usage

To clean and validate an HTML file, you can pipe the content to `tidyp` or specify an input file.

**Piping HTML content:**
```bash
cat your_file.html | tidyp
```

**Specifying an input file:**
```bash
tidyp your_file.html
```

By default, `tidyp` outputs the cleaned HTML to standard output.

### Options

While the provided documentation does not detail specific command-line flags for `tidyp`, common functionalities for such tools include:

*   **Output to a file:** Redirecting the output to a new file.
    ```bash
    tidyp input.html > output.html
    ```
*   **Validation only:** Some tools offer an option to only report errors without modifying the HTML. (Specific flag not provided in documentation).
*   **Pretty printing:** Options to format the output HTML for readability. (Specific flag not provided in documentation).

### Best Practices

*   **Always back up original files** before processing with `tidyp`, especially when dealing with critical HTML content.
*   **Redirect output to a new file** to avoid overwriting your original HTML unintentionally.
*   If `tidyp` encounters significant errors, review the output carefully to understand the changes made and ensure they align with your expectations.

## Reference documentation
- [Overview](https://anaconda.org/bioconda/tidyp)