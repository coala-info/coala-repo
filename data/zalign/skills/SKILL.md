---
name: zalign
description: ZAlign automates the layout and organization of LabVIEW Front Panel objects, arranging them based on the connector pane and adjusting the window bounds. Use when user asks to rearrange controls, organize Front Panel objects, align selected elements, identify unconnected controls, or fit the window to content.
homepage: https://github.com/Zuehlke/ZAlign
---


# zalign

## Overview
ZAlign is a LabVIEW QuickDrop plugin designed to automate the layout and organization of Front Panel objects. It eliminates the manual effort of positioning controls and indicators by logically arranging them based on the VI's connector pane configuration and adjusting the window bounds to fit the content. It is particularly useful for maintaining professional UI standards and identifying unconnected "local" controls.

## Usage and Shortcuts
ZAlign operates within the LabVIEW QuickDrop environment. Use the following commands on the Front Panel:

*   **Standard Alignment**: Press `CTRL + Space` to open QuickDrop, then press `CTRL + A`. This automatically rearranges all controls according to the connector pane and shrinks the window to fit.
*   **Extended Mode (Selection-based)**: Select a specific group of elements, then press `CTRL + Space` followed by `CTRL + A`. ZAlign will arrange only the selected elements in the upper-left quadrant of their current area, leaving unselected elements in place.
*   **Unconnected Controls**: Any controls not assigned to the connector pane are automatically grouped and moved to a "Locals" section to help identify unused or internal UI elements.

## Configuration and Best Practices
*   **Customizing the Grid**: You can modify the alignment grid by editing the `ZAlign.ini` file.
    *   **Path**: `C:\Program Files (x86)\National Instruments\LabVIEW 20XX\resource\dialog\QuickDrop\plugins\ZAlign`
*   **Connector Pane Dependency**: Ensure your connector pane is defined before running ZAlign, as the tool uses the pane's pattern to determine the logical order of inputs (left) and outputs (right).
*   **UI Consistency**: Use ZAlign as a final step before saving a VI to ensure all Front Panels across a project follow a consistent, compact layout.

## Reference documentation
- [ZAlign README](./references/github_com_Zuehlke_ZAlign.md)