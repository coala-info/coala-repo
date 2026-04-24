cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedSort
label: ngs-bits_BedSort
doc: "Sort the regions in a BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input BED file. If unset, reads from STDIN.
    inputBinding:
      position: 101
      prefix: -in
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: If set, entries with the same chr/start/end are removed after sorting.
    inputBinding:
      position: 101
      prefix: -uniq
  - id: with_name
    type:
      - 'null'
      - boolean
    doc: Uses name column (i.e. the 4th column) to sort if chr/start/end are 
      equal.
    inputBinding:
      position: 101
      prefix: -with_name
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
