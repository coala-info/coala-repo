cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwameth
label: bwameth
doc: "The provided text does not contain help information for bwameth; it contains
  system error messages related to Singularity and disk space.\n\nTool homepage: https://github.com/brentp/bwa-meth"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwameth:0.20--py35_0
stdout: bwameth.out
