cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rustybam
  - fastx-split
label: rustybam_fastx-split
doc: "Splits fastx from stdin into multiple files.\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: fastx_files
    type:
      type: array
      items: File
    doc: List of fastx files to write to
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_fastx-split.out
