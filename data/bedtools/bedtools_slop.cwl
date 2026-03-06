cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - slop
label: bedtools_slop
doc: Add requested base pairs of "slop" to each feature.
inputs:
  - id: both_directions
    type:
      - 'null'
      - float
    doc: Increase the BED/GFF/VCF entry -b base pairs in each direction. 
      (Integer) or (Float, e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -b
  - id: genome_file
    type: File
    doc: 'The genome file (tab delimited: <chromName><TAB><chromSize>).'
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header from the input file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_file
    type:
      - 'null'
      - File
    doc: The BED/GFF/VCF entry to be slopped.
    inputBinding:
      position: 101
      prefix: -i
  - id: left_slop
    type:
      - 'null'
      - float
    doc: The number of base pairs to subtract from the start coordinate. 
      (Integer) or (Float, e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -l
  - id: percentage
    type:
      - 'null'
      - boolean
    doc: Define -l and -r as a fraction of the feature's length. E.g. if used on
      a 1000bp feature, -l 0.50, will add 500 bp "upstream".
    inputBinding:
      position: 101
      prefix: -pct
  - id: right_slop
    type:
      - 'null'
      - float
    doc: The number of base pairs to add to the end coordinate. (Integer) or 
      (Float, e.g. 0.1) if used with -pct.
    inputBinding:
      position: 101
      prefix: -r
  - id: strand_sensitive
    type:
      - 'null'
      - boolean
    doc: Define -l and -r based on strand. E.g. if used, -l 500 for a 
      negative-stranded feature, it will add 500 bp downstream.
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_slop.out
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
