---
name: spaced
description: Manages and organizes files across multiple devices, clouds, and platforms using a virtual distributed filesystem. Use when user asks to access and manage files from a unified interface, leverage content-aware addressing for file identification and deduplication, perform transactional file operations with previews, utilize peer-to-peer synchronization without central servers, integrate cloud storage as first-class volumes, or benefit from local-first sync and offline access.
homepage: https://github.com/spacedriveapp/spacedrive
---


# spaced

yaml
name: spaced
description: Manages and organizes files across multiple devices, clouds, and platforms using a virtual distributed filesystem. Use when you need to:
  - Access and manage files from a unified interface across different storage locations.
  - Leverage content-aware addressing for file identification and deduplication.
  - Perform transactional file operations with previews.
  - Utilize peer-to-peer synchronization without central servers.
  - Integrate cloud storage (S3, Google Drive, Dropbox) as first-class volumes.
  - Benefit from local-first sync and offline access.
```

## Overview

The `spaced` skill allows you to manage and organize your files across various devices, cloud storage, and platforms through a single, unified interface. It operates on a virtual distributed filesystem (VDFS) that treats files as content-addressable objects, enabling features like deduplication across your entire digital footprint, semantic search, and transactional operations with previews. This skill is ideal for users who want to maintain control over their data while enjoying the convenience of multi-device access and synchronization, without relying on centralized cloud services.

## Usage Instructions

Spacedrive is primarily a GUI application. Its core functionality is accessed through its user interface. However, for advanced users and integration purposes, understanding its underlying principles and potential command-line interactions (if any are exposed or can be inferred from its architecture) is beneficial.

### Core Concepts and Features

*   **Content-Aware Addressing**: Spacedrive identifies files by their content, not just their path. This means a file is the same regardless of where it's stored.
    *   **Benefit**: Enables intelligent deduplication across all your connected devices and cloud storage.
*   **Virtual Distributed Filesystem (VDFS)**: Provides a unified view of your files, abstracting away their physical location.
    *   **Benefit**: Seamlessly access files from your local machine, NAS, or cloud services (S3, Google Drive, Dropbox) as if they were in one place.
*   **Transactional Actions**: All file operations (copy, move, delete) can be previewed before execution, showing you the exact impact on space, potential conflicts, and estimated time.
    *   **Benefit**: Prevents accidental data loss and provides clarity on operations.
*   **Peer-to-Peer (P2P) Sync**: Synchronization happens directly between your devices without requiring a central server.
    *   **Benefit**: Enhances privacy, security, and resilience.
*   **Offline-First**: Full functionality is available even without an internet connection. Syncing occurs automatically when devices reconnect.
    *   **Benefit**: Work with your files anywhere, anytime.
*   **Semantic Tagging**: Organize files using a graph-based system with hierarchies and aliases for powerful organization and retrieval.

### Interacting with Spacedrive

While Spacedrive is primarily a GUI application, its underlying architecture suggests potential for programmatic interaction or understanding its command-line behavior if exposed.

**General Usage (GUI Focus):**

1.  **Installation**: Download and install Spacedrive for your operating system from the official website or GitHub releases.
2.  **Connecting Storage**:
    *   Launch Spacedrive.
    *   Navigate to the "Add Volume" or similar option in the UI.
    *   Select the type of storage to connect: Local Folders, Cloud Storage (S3, Google Drive, Dropbox), or Network Attached Storage (NAS).
    *   Follow the on-screen prompts to authenticate and configure each connection.
3.  **File Management**:
    *   Browse your unified file system.
    *   Use drag-and-drop to move files between different storage locations.
    *   Create, rename, and delete files and folders as you would in a traditional file explorer.
4.  **Tagging**:
    *   Select files or folders.
    *   Use the tagging interface to assign tags, create hierarchies, and manage your organization.
5.  **Operations Preview**:
    *   Initiate a file operation (e.g., copying a large folder).
    *   Observe the preview window that details the expected outcome before confirming.

**Advanced/Inferred CLI Usage (Hypothetical):**

Based on the project's Rust foundation and focus on distributed systems, if command-line tools were to be exposed, they would likely focus on:

*   **Starting/Stopping the Spacedrive daemon**:
    ```bash
    spacedrive start
    spacedrive stop
    ```
*   **Adding/Removing storage volumes**:
    ```bash
    spacedrive add-volume --type s3 --bucket my-bucket --region us-east-1
    spacedrive remove-volume --id <volume-id>
    ```
*   **Listing connected volumes**:
    ```bash
    spacedrive list-volumes
    ```
*   **Performing file operations (less likely for direct CLI, more for scripting via API)**:
    ```bash
    # Hypothetical command for copying a file from a remote volume to local
    spacedrive cp "spacedrive://my-s3-volume/path/to/file.txt" "/local/path/"
    ```
*   **Sync status checks**:
    ```bash
    spacedrive sync-status
    ```

**Note:** The primary interaction method for Spacedrive is its graphical user interface. Direct command-line usage for file operations might not be extensively documented or supported for end-users. Refer to the official documentation for the most accurate and up-to-date information on any available CLI functionalities.

## Reference documentation
- [Spacedrive Documentation](./references/github_com_spacedriveapp_spacedrive.md)