cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5_merge
label: pod5_merge
doc: "Merge multiple pod5 files\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Pod5 filepaths to use as inputs
    inputBinding:
      position: 1
  - id: duplicate_ok
    type:
      - 'null'
      - boolean
    doc: Allow duplicate read_ids
    default: false
    inputBinding:
      position: 102
      prefix: --duplicate-ok
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    default: false
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: readers
    type:
      - 'null'
      - int
    doc: number of merge readers TESTING ONLY
    default: 20
    inputBinding:
      position: 102
      prefix: --readers
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    default: false
    inputBinding:
      position: 102
      prefix: --recursive
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of workers
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output filepath
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
