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
    default: 4
    inputBinding:
      position: 102
      prefix: --iop
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output to directory
    default: None
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: retain
    type:
      - 'null'
      - boolean
    doc: retain the same directory structure in the converted output as the 
      input (experimental)
    default: false
    inputBinding:
      position: 102
      prefix: --retain
outputs:
  - id: output_pod5
    type:
      - 'null'
      - File
    doc: output to FILE
    outputBinding:
      glob: $(inputs.output_pod5)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blue-crab:0.4.0--pyh05cac1d_1
