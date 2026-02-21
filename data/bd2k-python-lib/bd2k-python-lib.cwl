cwlVersion: v1.2
class: CommandLineTool
baseCommand: bd2k-python-lib
label: bd2k-python-lib
doc: "A Python library containing common code for BD2K projects. (Note: The provided
  text appears to be a container build error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/BD2KGenomics/bd2k-python-lib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bd2k-python-lib:1.14a1.dev48--pyh864c0ab_2
stdout: bd2k-python-lib.out
