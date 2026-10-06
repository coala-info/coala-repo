cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blue-crab
  - s2p
label: blue-crab_s2p
doc: "Convert SLOW5/BLOW5 -> POD5\n\nTool homepage: https://github.com/Psy-Fer/blue-crab"
inputs:
  - id: slow5_files
    type:
      type: array
      items: File
    doc: s/blow5 file to convert
    inputBinding:
      position: 1
  - id: iop
    type:
      - 'null'
      - int
    doc: number of I/O processes to use during conversion of multiple files
    inputBinding:
      position: 102
      prefix: --iop
  - id: out_dir
    type:
      - 'null'
      - string
    doc: output to directory
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: retain
    type:
      - 'null'
      - boolean
    doc: retain the same directory structure in the converted output as the 
      input (experimental)
    inputBinding:
      position: 102
      prefix: --retain
  - id: output_pod5_path
    type:
      - 'null'
      - string
    doc: 'output to FILE (.pod5) (default: None)'
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output_pod5
    type:
      - 'null'
      - File
    doc: output to FILE
    outputBinding:
      glob: $(inputs.output_pod5_path)
  - id: out_dir_dir
    type:
      - 'null'
      - Directory
    doc: output to directory
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blue-crab:0.4.0--pyh05cac1d_1
