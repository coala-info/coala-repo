cwlVersion: v1.2
class: CommandLineTool
baseCommand: blue-crab p2s
label: blue-crab_p2s
doc: "Convert POD5 -> SLOW5/BLOW5\n\nTool homepage: https://github.com/Psy-Fer/blue-crab"
inputs:
  - id: pod5_files
    type:
      type: array
      items: File
    doc: pod5 file/s or directories to convert
    inputBinding:
      position: 1
  - id: batchsize
    type:
      - 'null'
      - int
    doc: batch size used for encoding S/BLOW5 records in a single process
    inputBinding:
      position: 102
      prefix: --batchsize
  - id: compress
    type:
      - 'null'
      - string
    doc: record compression method (only for .blow5 format)
    inputBinding:
      position: 102
      prefix: --compress
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
      - Directory
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
  - id: sig_compress
    type:
      - 'null'
      - string
    doc: signal compression method (only for .blow5 format)
    inputBinding:
      position: 102
      prefix: --sig-compress
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads used for encoding S/BLOW5 records in a single process
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blue-crab:0.4.0--pyh05cac1d_1
