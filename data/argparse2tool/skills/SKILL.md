---
name: argparse2tool
description: This tool converts Python command-line interfaces into Galaxy Tool XML by acting as a drop-in replacement for the standard argparse module. Use when user asks to generate Galaxy tool wrappers, convert Python scripts to XML, or synchronize tool parameters with Galaxy.
homepage: https://github.com/erasche/argparse2tool
metadata:
  docker_image: "quay.io/biocontainers/argparse2tool:0.5.2--pyhdfd78af_0"
---

# argparse2tool

## Overview
This skill facilitates the automatic conversion of Python command-line interfaces into Galaxy Tool XML. By acting as a drop-in replacement for the standard `argparse` module, `argparse2tool` intercepts argument definitions and translates them into the structured XML format required by Galaxy. This is particularly useful for maintaining a single source of truth for tool parameters and ensuring that Galaxy wrappers stay in sync with the underlying Python script.

## Usage Instructions

### Environment Setup
To enable the tool, you must ensure the `argparse2tool` drop-in directory precedes the standard library in your Python path. Use the helper command to identify the correct path:

```bash
export PYTHONPATH=$(argparse2tool)
```

### Generating Galaxy XML
Once the environment is configured, run your Python script with the `--generate_galaxy_xml` flag. This flag is injected by the library and does not need to be defined in your script.

```bash
python your_script.py --generate_galaxy_xml > your_tool.xml
```

### Best Practices for Python Scripts
To ensure high-quality XML generation, follow these `argparse` patterns:

- **Type Hinting**: Use `argparse.FileType('w')` for output arguments. The tool specifically looks for this type to populate the `<outputs>` section of the Galaxy XML.
- **Help Strings**: Always provide a `help=` string for every argument; these become the help text for the corresponding input fields in the Galaxy UI.
- **Defaults**: Set `default=` values in `add_argument()` to ensure the Galaxy tool form is pre-populated with sensible defaults.
- **Choices**: Use the `choices=[]` parameter to automatically generate dropdown menus (select fields) in Galaxy.

### Troubleshooting Module Order
If the `--generate_galaxy_xml` flag is not recognized, the standard `argparse` is likely being loaded instead of the wrapper. Verify your configuration:
- Run `argparse2tool` without arguments. If it returns "no dropins dir...", the installation is broken or the path is incorrect.
- Ensure `PYTHONPATH` is exported in the same shell session where you run the generation command.

## Reference documentation
- [argparse2tool GitHub Repository](./references/github_com_hexylena_argparse2tool.md)