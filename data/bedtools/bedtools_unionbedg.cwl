cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - unionbedg
label: bedtools_unionbedg
doc: Combines multiple BedGraph files into a single file, allowing coverage 
  comparisons between them.
inputs:
  - id: empty
    type:
      - 'null'
      - boolean
    doc: Report empty regions (i.e., start/end intervals w/o values in all 
      files). Requires the '-g FILE' parameter.
    inputBinding:
      position: 101
      prefix: -empty
  - id: examples
    type:
      - 'null'
      - boolean
    doc: Show detailed usage examples.
    inputBinding:
      position: 101
      prefix: -examples
  - id: filler
    type:
      - 'null'
      - string
    doc: Use TEXT when representing intervals having no value. Default is '0', 
      but you can use 'N/A' or any text.
    inputBinding:
      position: 101
      prefix: -filler
  - id: genome
    type: File
    doc: Use genome file to calculate empty regions.
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header line (chrom/start/end + names of each file).
    inputBinding:
      position: 101
      prefix: -header
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BedGraph files to combine. Assumes that each BedGraph file is sorted by
      chrom/start and that the intervals in each are non-overlapping.
    inputBinding:
      position: 101
      prefix: -i
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of names (one/file) to describe each file in -i. These names 
      will be printed in the header line.
    inputBinding:
      position: 101
      prefix: -names
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_unionbedg.out
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
