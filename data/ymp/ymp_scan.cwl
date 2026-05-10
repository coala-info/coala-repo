cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - scan
label: ymp_scan
doc: "Scan folders for YMP files\n\nTool homepage: https://ymp.readthedocs.io"
inputs:
  - id: folders
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Folders to scan
    inputBinding:
      position: 1
  - id: export_lane
    type:
      - 'null'
      - boolean
    doc: Export lane information
    inputBinding:
      position: 102
      prefix: --export-lane
  - id: export_slot
    type:
      - 'null'
      - boolean
    doc: Export slot information
    inputBinding:
      position: 102
      prefix: --export-slot
  - id: folder_re
    type:
      - 'null'
      - string
    doc: Regular expression to match folder names
    inputBinding:
      position: 102
      prefix: --folder-re
  - id: sample_re
    type:
      - 'null'
      - string
    doc: Regular expression to match sample names
    inputBinding:
      position: 102
      prefix: --sample-re
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
