---
name: visionegg
description: VisionEgg is a specialized Python library used to produce high-accuracy, real-time visual stimuli for vision science experiments.
homepage: https://github.com/visionegg/visionegg
---

# visionegg

## Overview
VisionEgg is a specialized Python library used to produce high-accuracy, real-time visual stimuli for vision science experiments. It utilizes OpenGL to ensure hardware-accelerated graphics performance. While it is a legacy tool (primarily developed between 2001-2008), it remains relevant for reproducing older experiments or maintaining existing laboratory setups. This skill focuses on the core utility scripts and known technical hurdles associated with the library's environment.

## Installation and Setup
VisionEgg is typically installed from source within a Python 2.x environment.

*   **Standard Installation**: Run the setup script from the base directory.
    ```bash
    python setup.py install
    ```
*   **Prerequisites**: Ensure that OpenGL drivers and necessary dependencies (like Pygame or Pyglet) are installed before attempting the VisionEgg installation.

## Configuration and Verification
Before running experiments, verify the system's compatibility and the library's status using the built-in configuration utility.

*   **Check Configuration**: Use `check-config.py` to display information about the current installation and identify missing prerequisites.
    ```bash
    python check-config.py
    ```
*   **Demo Exploration**: Demos are not installed to the system path but are available in the source package. Navigate to the `demo` directory to run sample stimuli and verify performance.

## Troubleshooting and Expert Tips
VisionEgg has several known issues related to modern Python environments and specific OpenGL calls.

*   **Numpy Compatibility**: VisionEgg frequently references `numpy.oldnumeric`. In newer versions of NumPy, this module has been removed. You may need to use an older version of NumPy or patch the source imports to use the modern NumPy API.
*   **Tkinter Dependency**: The function `get_default_screen()` may fail if `_tkinter` is not properly configured in your Python environment. Ensure Tk/Tcl development headers are present.
*   **OpenGL State Management**: The `FixationCross` object is known to potentially break the OpenGL state. If you notice rendering artifacts after drawing a fixation cross, you may need to manually reset specific OpenGL flags.
*   **Mac Support**: Installation on modern macOS versions is complex due to the library's reliance on older graphics frameworks and Python 2.7.

## Reference documentation
- [VisionEgg Main Repository](./references/github_com_visionegg_visionegg.md)
- [VisionEgg Issues and Bug Reports](./references/github_com_visionegg_visionegg_issues.md)
- [VisionEgg Commit History and Documentation Updates](./references/github_com_visionegg_visionegg_commits_master.md)