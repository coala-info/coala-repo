cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextDenovo
label: nextdenovo_nextDenovo
doc: "Fast and accurate de novo assembler for long reads\n\nTool homepage: https://github.com/Nextomics/NextDenovo"
inputs:
  - id: config_file
    type: File
    doc: Configuration file for NextDenovo
    inputBinding:
      position: 1
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file
    default: pidXXX.log.info
    inputBinding:
      position: 102
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextdenovo:2.5.2--py310h0ceaa1d_6
stdout: nextdenovo_nextDenovo.out
