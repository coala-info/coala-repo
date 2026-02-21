---
name: cytoscape
description: Cytoscape is a premier open-source platform designed for the integration, analysis, and visualization of complex networks, such as molecular interactions, biological pathways, and social networks.
homepage: https://cytoscape.org
---

# cytoscape

## Overview
Cytoscape is a premier open-source platform designed for the integration, analysis, and visualization of complex networks, such as molecular interactions, biological pathways, and social networks. While primarily known for its desktop GUI, Cytoscape supports robust automation through a RESTful API (CyREST) and a headless command-line distribution. This skill enables users to manage Cytoscape installations via Bioconda, optimize performance through environment variables, and implement automated network analysis workflows.

## Installation and Execution
Cytoscape is available as a platform-independent Java application.

### Bioconda Installation
For bioinformatics environments, install Cytoscape using conda:
```bash
conda install bioconda::cytoscape
```

### Launching the Application
Navigate to the installation directory and use the platform-specific launch script:
- **Linux/Mac**: `./cytoscape.sh`
- **Windows**: `cytoscape.bat`

### Headless Mode
Cytoscape 3.x supports a headless distribution for command-line usage. This is essential for server-side processing or integration into automated pipelines where a graphical user interface is not required.

## Environment Configuration
Proper configuration of the Java Runtime Environment (JRE) is critical for Cytoscape performance and stability.

### Setting JAVA_HOME
Cytoscape requires a compatible Java version (typically Java 11 or 17 depending on the version).
- **Mac/Linux**: `export JAVA_HOME=/path/to/jdk`
- **Windows**: Set `JAVA_HOME` in System Environment Variables to the JDK installation path (e.g., `C:\Program Files\Java\jdk-17`).

### Memory and Optimization
If you encounter memory issues with large networks, adjust the Java heap size or use `EXTRA_JAVA_OPTS` to pass parameters to the JVM.
- **Fixing CEN Header Errors (Java 11.0.8/17.0.20)**:
  ```bash
  export EXTRA_JAVA_OPTS="-Djdk.util.zip.disableZip64ExtraFieldValidation=true"
  ```

### High DPI Scaling (Linux)
If the interface does not scale correctly on high-resolution monitors, add the following to `cytoscape.sh`:
```bash
export GDK_SCALE=2
```

## Automation and Programmatic Access
Automation in Cytoscape 3 is primarily handled through the **CyREST** API and the **Commands** system.

### CyREST API
CyREST allows you to control Cytoscape from any scripting language (Python, R, etc.) that supports HTTP requests.
- **Core Capabilities**: Create networks, apply layouts, import data, and export images.
- **Workflow**: Start Cytoscape (desktop or headless), then send REST calls to `localhost:1234`.

### Command-Line Arguments
When running via the terminal, you can pass scripts or commands directly:
- Use the script console within the GUI or the REST API to execute batch commands for repetitive tasks like layout application or filtering.

## Troubleshooting Common Issues
- **Inability to Start (Mac)**: If OpenCL-based apps cause crashes, create a `disable-opencl.dummy` file in the `~/CytoscapeConfiguration/` directory.
- **Log Files**: Check `framework-cytoscape.log` located in the `CytoscapeConfiguration/3/` folder for detailed error traces.
- **OpenCL Issues**: Use `touch ~/CytoscapeConfiguration/disable-opencl.dummy` to bypass GPU-related startup failures.

## Reference documentation
- [Common Issues](./references/cytoscape_org_common_issues.html.md)
- [What is Cytoscape?](./references/cytoscape_org_what_is_cytoscape.html.md)
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cytoscape_overview.md)
- [User Documentation](./references/cytoscape_org_documentation_users.html.md)