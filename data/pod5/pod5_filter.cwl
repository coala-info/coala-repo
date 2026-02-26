cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5_filter
label: pod5_filter
doc: "Take a subset of reads using a list of read_ids from one or more inputs\n\n\
  Tool homepage: https://github.com/nanoporetech/pod5-file-format"
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
    inputBinding:
      position: 102
      prefix: --duplicate-ok
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: ids_file
    type: File
    doc: A file containing a list of only valid read ids to filter from inputs
    inputBinding:
      position: 102
      prefix: --ids
  - id: missing_ok
    type:
      - 'null'
      - boolean
    doc: Allow missing read_ids
    inputBinding:
      position: 102
      prefix: --missing-ok
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    inputBinding:
      position: 102
      prefix: --recursive
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of workers
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Destination output filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
