---
name: gwyddion-plugins
description: This tool extends Gwyddion's capabilities for handling multi-channel scanning probe microscopy data through specialized Python plugins. Use when user asks to batch export all data channels to a structured directory or isolate a single channel into a new workspace while preserving metadata.
homepage: https://github.com/tuxu/gwyddion-plugins
metadata:
  docker_image: "biocontainers/gwyddion-plugins:v2.52-1-deb_cv1"
---

# gwyddion-plugins

## Overview

This skill provides guidance on extending Gwyddion's capabilities using the `gwyddion-plugins` collection. These tools are essential for researchers and engineers who need to handle multi-channel SPM files (such as AFM, STM, or SNOM data) more efficiently than the standard GUI allows. The skill focuses on two primary workflows: batch-exporting every data field in a container to a structured directory and extracting a single channel into a standalone workspace without losing associated metadata.

## Installation and Setup

To use these plugins, Gwyddion must be compiled with Python (Pygwy) support.

1.  Locate your local Gwyddion Python plugin directory: `~/.gwyddion/pygwy/`.
2.  Copy the desired `.py` plugin files into this directory.
3.  Restart Gwyddion or refresh the plugin list. The new tools will appear under the **Plug-ins** menu.

## Plugin Workflows

### Batch Exporting Channels
Use `export_all_channels.py` when you need to convert a multi-channel Gwyddion container into individual image files for reports or external analysis.

*   **Menu Path**: `Plug-ins` > `Export all channels`
*   **Output Structure**: The plugin creates a subfolder in the same directory as the source file. The folder name follows the pattern: `{Original_Filename}_{OUTPUT_SUFFIX}`.
*   **File Naming**: Exported files are named using the format `###_TITLE.OUTPUT_SUFFIX`, where `###` is the datafield ID and `TITLE` is the channel name.
*   **Expert Tip**: The export dialog only appears for the **first** datafield. The settings you choose (file format, color map, scale bars) are automatically applied to all subsequent channels in that container. Ensure your first channel's settings are representative of the desired output for the entire set.

### Channel Isolation
Use `isolate_channel.py` when you want to perform destructive operations or complex filtering on a single channel without affecting the rest of the data container.

*   **Menu Path**: `Plug-ins` > `Isolate channel`
*   **Functionality**: This creates a completely new Gwyddion container containing only the currently selected data field.
*   **Metadata Preservation**: Unlike a simple copy-paste, this plugin ensures that all related metadata (scan parameters, timestamps, and hardware settings) is copied to the new container, maintaining the scientific integrity of the isolated data.

## Best Practices

*   **Metadata Verification**: Always use the "Isolate channel" plugin instead of manual extraction if you intend to perform quantitative analysis later, as manual extraction often strips the physical units and calibration data.
*   **Batch Processing**: When using the export plugin, if you require different color scales for different channels (e.g., Topography vs. Phase), you may need to export them in separate passes or adjust the script's `OUTPUT_SUFFIX` to avoid overwriting.

## Reference documentation
- [Gwyddion Plugins README](./references/github_com_tuxu_gwyddion-plugins_blob_master_README.md)