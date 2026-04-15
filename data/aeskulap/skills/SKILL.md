---
name: aeskulap
description: Aeskulap is a DICOM viewer and network client for medical imaging. Use when user asks to view DICOM files, query a PACS, or fetch DICOM studies from a PACS.
homepage: https://github.com/pipelka/aeskulap
metadata:
  docker_image: "biocontainers/aeskulap:v0.2.2-beta2git20180219.8787e95-2-deb_cv1"
---

# aeskulap

---
## Overview
Aeskulap is an open-source tool designed for medical imaging professionals. It functions as both a DICOM image viewer and a DICOM network client, enabling users to interact with DICOM files and DICOM servers (PACS). This skill is useful for tasks such as loading and reviewing DICOM image series, querying DICOM archives for specific studies, and fetching those studies for local viewing.

## Usage Instructions

Aeskulap is primarily a GUI application. While direct command-line interaction for complex operations is limited, the following provides guidance on its general use and potential command-line invocation if available.

### Viewing Local DICOM Files

To open local DICOM files or directories containing DICOM files, you can typically launch Aeskulap and use its file browser or drag-and-drop functionality.

If Aeskulap supports direct file path arguments, the command might look like this:

```bash
aeskulap /path/to/your/dicom/file.dcm
```

or for a directory:

```bash
aeskulap /path/to/your/dicom/directory/
```

### DICOM Network Client Operations (PACS Interaction)

Aeskulap can query and fetch DICOM images from DICOM archives (PACS) over the network. This involves configuring Aeskulap with the PACS server details (AE Title, IP address, port).

**Querying a PACS:**
1. Launch Aeskulap.
2. Navigate to the network/PACS client section.
3. Configure your PACS server details (AE Title, IP, Port).
4. Use the query interface to search for studies based on criteria like Patient Name, Patient ID, Study Date, etc.

**Fetching Studies from a PACS:**
1. After performing a query, select the desired study or studies from the results.
2. Initiate a "fetch" or "C-MOVE" operation to download the selected DICOM data to your local machine.

**Configuration:**
Aeskulap uses configuration files (e.g., `gconfmm` based) for storing PACS server details and other preferences. Refer to the application's GUI for managing these settings.

### Version History and Features

Aeskulap has evolved with various features over its versions. Key functionalities include:
*   Loading DICOM series for review.
*   Querying and fetching DICOM images from PACS.
*   Network error handling.
*   Preferences dialog for configuration.
*   C-Echo test for network connectivity.
*   Server group management.
*   Date filtering for queries.
*   3D cursor for slice synchronization.
*   Support for multiframe images and lossy compression.
*   Window leveling tools (e.g., "invert").

For detailed version history and specific feature implementations, consult the `ChangeLog` file.

## Expert Tips

*   **Network Configuration:** Ensure your network settings and firewall rules allow Aeskulap to connect to the PACS server on the specified port.
*   **AE Titles:** Correctly identify and configure both your Aeskulap AE Title and the target PACS AE Title for successful network communication.
*   **Query Filters:** Utilize specific query filters (Patient ID, Study Date, etc.) to efficiently locate desired studies in large PACS archives.
*   **Performance:** For large datasets or slow network connections, consider Aeskulap's support for lossy compression if available and acceptable for your use case.
*   **Build Issues:** If encountering build issues, refer to the `README` and `INSTALL` files for build prerequisites and instructions. The issue `#2` in the GitHub repository indicates potential build problems.

## Reference documentation
- [Aeskulap README](./references/github_com_pipelka_aeskulap.md)
- [Aeskulap ChangeLog](./references/github_com_pipelka_aeskulap.md)