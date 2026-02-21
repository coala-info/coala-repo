cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedmap
label: bedops_bedmap
doc: "The bedmap utility retrieves and processes genomic features from a map file
  that overlap with features in a reference file. It is part of the BEDOPS suite.\n
  \nTool homepage: http://bedops.readthedocs.io"
inputs:
  - id: reference_file
    type: File
    doc: The reference BED file.
    inputBinding:
      position: 1
  - id: map_file
    type:
      - 'null'
      - File
    doc: The map BED file containing features to be mapped onto the reference.
    inputBinding:
      position: 2
  - id: count
    type:
      - 'null'
      - boolean
    doc: Count the number of overlapping map elements.
    inputBinding:
      position: 103
      prefix: --count
  - id: delim
    type:
      - 'null'
      - string
    doc: Use a custom delimiter for output.
    inputBinding:
      position: 103
      prefix: --delim
  - id: echo
    type:
      - 'null'
      - boolean
    doc: Echo the reference element.
    inputBinding:
      position: 103
      prefix: --echo
  - id: echo_map
    type:
      - 'null'
      - boolean
    doc: Echo the overlapping map elements.
    inputBinding:
      position: 103
      prefix: --echo-map
  - id: max
    type:
      - 'null'
      - boolean
    doc: Calculate the maximum of the signal column for overlapping map elements.
    inputBinding:
      position: 103
      prefix: --max
  - id: mean
    type:
      - 'null'
      - boolean
    doc: Calculate the mean of the signal column for overlapping map elements.
    inputBinding:
      position: 103
      prefix: --mean
  - id: min
    type:
      - 'null'
      - boolean
    doc: Calculate the minimum of the signal column for overlapping map elements.
    inputBinding:
      position: 103
      prefix: --min
  - id: overlap
    type:
      - 'null'
      - string
    doc: Specify the overlap criteria (e.g., bp or percentage).
    inputBinding:
      position: 103
      prefix: --overlap
  - id: sum
    type:
      - 'null'
      - boolean
    doc: Calculate the sum of the signal column for overlapping map elements.
    inputBinding:
      position: 103
      prefix: --sum
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_bedmap.out
