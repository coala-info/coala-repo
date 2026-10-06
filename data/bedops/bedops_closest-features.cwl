cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - closest-features
label: bedops_closest-features
doc: For every element in <input-file>, determine the two elements from 
  <query-file> falling nearest to its left and right edges. By default, echo the
  <input-file> element, followed by those left and right elements found in 
  <query-file>.
inputs:
  - id: input_file
    type: File
    doc: Input file in BED or Starch format (must be sorted per sort-bed; '-' 
      for stdin BED only)
    inputBinding:
      position: 201
  - id: query_file
    type: File
    doc: Query file in BED or Starch format (must be sorted per sort-bed; '-' 
      for stdin BED only)
    inputBinding:
      position: 202
  - id: chrom
    type:
      - 'null'
      - string
    doc: Jump to and process data for given <chromosome> only.
    inputBinding:
      position: 103
      prefix: --chrom
  - id: closest
    type:
      - 'null'
      - boolean
    doc: Choose the closest element for output only. Ties go the left element.
    inputBinding:
      position: 103
      prefix: --closest
  - id: delim
    type:
      - 'null'
      - string
    doc: Change output delimiter from '|' to <delim> between columns (e.g. '\t')
    inputBinding:
      position: 103
      prefix: --delim
  - id: dist
    type:
      - 'null'
      - boolean
    doc: Print the signed distances to the <input-file> element as additional 
      columns of output. An overlapping element has a distance of 0.
    inputBinding:
      position: 103
      prefix: --dist
  - id: ec
    type:
      - 'null'
      - boolean
    doc: Error check all input files (slower).
    inputBinding:
      position: 103
      prefix: --ec
  - id: header
    type:
      - 'null'
      - boolean
    doc: Accept headers (VCF, GFF, SAM, BED, WIG) in any input file.
    inputBinding:
      position: 103
      prefix: --header
  - id: no_overlaps
    type:
      - 'null'
      - boolean
    doc: Overlapping elements from <query-file> will not be reported.
    inputBinding:
      position: 103
      prefix: --no-overlaps
  - id: no_ref
    type:
      - 'null'
      - boolean
    doc: Do not echo elements from <input-file>.
    inputBinding:
      position: 103
      prefix: --no-ref
  - id: no_query
    type:
      - 'null'
      - boolean
    doc: Do not echo elements from <query-file>.
    inputBinding:
      position: 103
      prefix: --no-query
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: closest-features.out
s:url: http://bedops.readthedocs.io
$namespaces:
  s: https://schema.org/
