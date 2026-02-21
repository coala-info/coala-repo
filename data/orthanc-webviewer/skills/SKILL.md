---
name: orthanc-webviewer
description: The Orthanc Web Viewer is a specialized plugin for the Orthanc DICOM server that enables high-performance medical image visualization directly within a web browser.
homepage: https://github.com/orthanc-team/osimis-webviewer-deprecated
---

# orthanc-webviewer

## Overview
The Orthanc Web Viewer is a specialized plugin for the Orthanc DICOM server that enables high-performance medical image visualization directly within a web browser. It transforms Orthanc from a storage and routing server into a functional workstation for clinicians and researchers. Use this skill to understand the deployment of the viewer via Docker or manual installation, and to leverage its suite of 2D manipulation tools—including windowing, measurements, and multiframe support—for diagnostic or research purposes.

## Installation and Deployment

### Docker (Recommended for Linux)
The most efficient way to run the web viewer is through the official Orthanc Docker images that come pre-bundled with plugins.

```bash
# Run Orthanc with the Web Viewer plugin enabled
docker run -p 4242:4242 -p 8042:8042 --rm \
    jodogne/orthanc-plugins
```

### Manual Installation (Windows/macOS)
1. Download the latest binaries for your operating system.
2. For macOS, unzip the package and execute the `startOrthanc.command` file.
3. For Windows, ensure the plugin DLL is referenced in your Orthanc configuration file.

## Configuration
The viewer is configured through the main Orthanc JSON configuration file. To enable and customize the plugin, ensure the `Plugins` array includes the path to the web viewer shared library.

### Key Configuration Options
While the viewer works out-of-the-box, you can modify its behavior in the JSON config:
- **Enable/Disable**: Control whether the viewer is active.
- **GDCM**: By default, `GdcmEnabled` is false in newer versions (1.7.0+) as it assumes the standalone GDCM plugin is used for decoding.

## Toolset and Capabilities
Once the viewer is loaded (typically accessible via the "View" button in the Orthanc Explorer), the following tools are available for image manipulation:

- **Navigation**: Panning and Zooming.
- **Image Adjustment**: Windowing (Level/Width), Image Flipping, and Rotation.
- **Analysis**: 
    - Length Measurement.
    - Angle Measurement.
    - Regions of Interest (ROI): Point, Circle, and Rectangle.
- **Multiframe Support**: Essential for viewing cine loops (e.g., Cardiology or Ultrasound).

## Development and Troubleshooting
The project is structured into several functional areas:
- `backend/`: Contains the C++ plugin source code.
- `frontend/`: Contains the HTML5/JavaScript source code.
- `reverse-proxy/`: Useful for development environments to handle CORS and authentication.

### Common Patterns
- **Authentication**: If using an authentication proxy, refer to the `procedures/develop-auth-proxy.md` documentation within the repository.
- **Logs**: If the viewer fails to load, check the Orthanc logs using the `--verbose` flag to ensure the plugin shared library was loaded successfully.

## Reference documentation
- [Osimis Web Viewer README](./references/github_com_orthanc-team_osimis-webviewer-deprecated.md)