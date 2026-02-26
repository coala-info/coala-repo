cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr
label: coptr
doc: "CoPTR (v1.1.4): Compute PTRs from complete reference genomes and assemblies.\n\
  \nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: command
    type: string
    doc: Command to run.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
stdout: coptr.out
