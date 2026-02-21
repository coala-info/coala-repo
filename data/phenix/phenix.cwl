cwlVersion: v1.2
class: CommandLineTool
baseCommand: phenix
label: phenix
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/phe-bioinformatics/PHEnix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h3dcb392_1
stdout: phenix.out
