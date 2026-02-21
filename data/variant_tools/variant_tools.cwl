cwlVersion: v1.2
class: CommandLineTool
baseCommand: variant_tools
label: variant_tools
doc: "The provided text does not contain help information or usage instructions for
  variant_tools. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/vatlab/varianttools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variant_tools:3.1.3--py38hd52fbc2_2
stdout: variant_tools.out
