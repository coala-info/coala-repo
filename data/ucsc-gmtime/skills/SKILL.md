---
name: ucsc-gmtime
description: The ucsc-gmtime tool translates Unix timestamps (integer seconds) into a standardized GMT/UTC calendar format. Use when user asks to convert Unix timestamps to GMT/UTC, get the current GMT time, process multiple timestamps from a file, or verify data currency from database timestamps.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-gmtime

## Overview
The `gmtime` utility is a lightweight command-line tool provided by the UCSC Genome Browser team. It serves a single, specific purpose: translating Unix "ticks" (integer seconds) into a standardized GMT/UTC calendar format. While many modern systems have built-in date commands, this tool is often used within bioinformatics pipelines and shell scripts that interact with the UCSC Kent utility suite to ensure consistent time formatting across different Unix-like environments.

## Usage Instructions

### Basic Command Pattern
To convert a timestamp, pass the integer value as the only argument:
```bash
gmtime 1707072000
```
**Output format:** `Sun Feb  4 18:40:00 2024`

### Common CLI Patterns
*   **Current Time:** Since the tool expects an argument, you can combine it with the system `date` command to see the current GMT time in the tool's specific output format:
    ```bash
    gmtime $(date +%s)
    ```
*   **Batch Processing:** To convert a column of timestamps in a text file (e.g., a log file where the first column is the timestamp):
    ```bash
    cat log.txt | awk '{print $1}' | xargs -I {} gmtime {}
    ```

### Expert Tips & Best Practices
*   **GMT vs. Localtime:** Always remember that `gmtime` outputs Greenwich Mean Time. If you need the time adjusted for your local timezone, use the companion tool `localtime` (also found in the UCSC binary directory).
*   **Permissions:** If you have just downloaded the binary, you must grant execution permissions before use:
    ```bash
    chmod +x gmtime
    ./gmtime <timestamp>
    ```
*   **Integration with MySQL:** UCSC database tables often store update times as integers. When querying the public MySQL server (`genome-mysql.soe.ucsc.edu`), you can pipe the resulting timestamps into `gmtime` for quick verification of data currency.
*   **No Arguments:** Running the command with no arguments will typically display a brief usage statement.

## Reference documentation
- [UCSC Genome Browser Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Utility List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [macOS ARM64 Utility List](./references/hgdownload_cse_ucsc_edu_admin_exe_macOSX.arm64.md)