cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam repeat
label: rustybam_repeat
doc: "Report the longest exact repeat length at every position in a fasta\n\nTool
  homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input fasta file
    default: '-'
    inputBinding:
      position: 1
  - id: min_repeat_length
    type:
      - 'null'
      - int
    doc: The smallest repeat length to report
    default: 21
    inputBinding:
      position: 102
      prefix: --min
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_repeat.out
