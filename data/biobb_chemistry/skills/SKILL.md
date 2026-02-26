---
name: biobb_chemistry
description: Biobb_chemistry performs chemical transformations and force field conversions by wrapping various bioinformatics and chemistry tools. Use when user asks to convert AMBER topologies to GROMACS format, automate MD simulation chemistry setups, or perform structure preparation and format interoperation.
homepage: https://github.com/bioexcel/biobb_chemistry
---


# biobb_chemistry

## Overview
Biobb_chemistry is a specialized module within the BioExcel Building Blocks (biobb) ecosystem focused on chemical transformations. It serves as a wrapper for popular bioinformatics and chemistry tools, providing a consistent interface for tasks such as force field conversion and structure preparation. This skill should be used to automate the "chemistry" stage of MD simulation setups, ensuring interoperability between different simulation engines and chemical formats.

## Installation and Setup
The module is best managed via Conda to ensure all underlying chemical libraries and dependencies (like Acpype or OpenBabel) are correctly linked.

```bash
conda install -c bioconda biobb_chemistry
```

For environments where local installation is restricted, use the official Docker container:
```bash
docker pull quay.io/biocontainers/biobb_chemistry:5.2.0--pyhdfd78af_1
```

## Command Line Usage Patterns
Biobb_chemistry tools follow a standardized command-line interface. Every tool requires explicit input file paths, output file paths, and optional properties passed as a JSON string.

### Standard Execution Template
```bash
[tool_name] --input_[name] [path_to_file] --output_[name] [path_to_file] --properties '{"property_name": "value"}'
```

### Specific Tool: AcpypeConvertAMBERtoGMX
This tool is frequently used to bridge AMBER-based ligand preparation with GROMACS simulations.
- **Inputs**: AMBER topology (.top or .prmtop) and coordinates (.crd or .inpcrd).
- **Outputs**: GROMACS topology (.itp) and coordinates (.gro).

**CLI Pattern:**
```bash
acpype_convert_amber_to_gmx --input_path_top molecule.prmtop --input_path_crd molecule.inpcrd --output_path_itp molecule.itp --output_path_gro molecule.gro
```

## Best Practices and Expert Tips
- **Property Configuration**: Instead of complex shell escaping for JSON strings, you can pass a path to a `.json` file containing your configuration to the `--properties` flag.
- **Container Execution**: When using Docker, remember to mount your local working directory to the container to allow the tool to read inputs and write outputs:
  `docker run -v $(pwd):/data quay.io/biocontainers/biobb_chemistry:5.2.0--pyhdfd78af_1 acpype_convert_amber_to_gmx --input_path_top /data/in.prmtop ...`
- **Dependency Management**: If a tool fails with a "command not found" error despite biobb_chemistry being installed, verify that the underlying functional tool (e.g., `acpype`) is in your system PATH. Using the Bioconda installation usually handles this automatically.
- **Temporary Files**: Biobb tools create temporary working directories. If a process is interrupted, check for `sandbox` or `tmp` directories that may need manual cleanup to save disk space.

## Reference documentation
- [biobb_chemistry - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_biobb_chemistry_overview.md)
- [GitHub - bioexcel/biobb_chemistry](./references/github_com_bioexcel_biobb_chemistry.md)