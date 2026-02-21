cwlVersion: v1.2
class: CommandLineTool
baseCommand: closest-features
label: bedops_closest-features
doc: "For every element in <input-file>, find the closest elements in <query-file>.
  By default, this tool finds the closest features to the left and right of the input
  feature.\n\nTool homepage: http://bedops.readthedocs.io"
inputs:
  - id: input_file
    type: File
    doc: The reference BED file.
    inputBinding:
      position: 1
  - id: query_file
    type: File
    doc: The BED file to search for closest features.
    inputBinding:
      position: 2
  - id: closest
    type:
      - 'null'
      - boolean
    doc: Only return the single closest feature. If there is a tie, the feature that
      comes first in the query file is chosen.
    inputBinding:
      position: 103
      prefix: --closest
  - id: dist
    type:
      - 'null'
      - boolean
    doc: Print the signed distance between the reference and the closest features.
    inputBinding:
      position: 103
      prefix: --dist
  - id: header
    type:
      - 'null'
      - boolean
    doc: Accept headers (e.g. UCSC track lines) in the input files.
    inputBinding:
      position: 103
      prefix: --header
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: Do not include features that overlap the reference feature as 'closest'.
    inputBinding:
      position: 103
      prefix: --no-overlap
  - id: no_ref
    type:
      - 'null'
      - boolean
    doc: Do not print the reference feature; only print the closest features found
      in the query file.
    inputBinding:
      position: 103
      prefix: --no-ref
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_closest-features.out
