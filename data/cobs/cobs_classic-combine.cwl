cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cobs
  - classic-combine
label: cobs_classic-combine
doc: "Combines multiple COBS indices into a single index.\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: in_dir
    type: Directory
    doc: path to the input directory
    inputBinding:
      position: 1
  - id: out_dir
    type: string
    doc: path to the output directory
    inputBinding:
      position: 2
  - id: out_file
    type: string
    doc: path to the output file
    inputBinding:
      position: 3
  - id: keep_temporary
    type:
      - 'null'
      - boolean
    doc: keep temporary files during construction
    inputBinding:
      position: 103
      prefix: --keep-temporary
  - id: memory
    type:
      - 'null'
      - int
    doc: memory in bytes to use
    inputBinding:
      position: 103
      prefix: --memory
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_out_file
    type: File
    doc: path to the output file
    outputBinding:
      glob: '$(inputs.out_file)'
  - id: out_dir_dir
    type:
      - 'null'
      - Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
