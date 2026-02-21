cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst_bowtie2
label: metamlst_bowtie2
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building and disk
  space.\n\nTool homepage: https://github.com/SegataLab/metamlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_bowtie2.out
