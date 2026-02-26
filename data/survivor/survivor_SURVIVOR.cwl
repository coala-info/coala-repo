cwlVersion: v1.2
class: CommandLineTool
baseCommand: SURVIVOR
label: survivor_SURVIVOR
doc: "Tools for Structural Variations in the VCF format\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., simSV, eval, merge, filter, stats, vcftobed)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_SURVIVOR.out
