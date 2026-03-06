cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - merge
label: bedtools_merge
doc: Merges overlapping BED/GFF/VCF entries into a single interval.
inputs:
  - id: columns
    type:
      - 'null'
      - string
    doc: Specify columns from the B file to map onto intervals in A. Multiple 
      columns can be specified in a comma-delimited list.
    inputBinding:
      position: 101
      prefix: -c
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Specify a custom delimiter for the collapse operations.
    inputBinding:
      position: 101
      prefix: -delim
  - id: force_specific_strand
    type:
      - 'null'
      - string
    doc: Force merge for one specific strand only. Follow with + or - to force 
      merge from only the forward or reverse strand, respectively.
    inputBinding:
      position: 101
      prefix: -S
  - id: force_strandedness
    type:
      - 'null'
      - boolean
    doc: Force strandedness. That is, only merge features that are on the same 
      strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header from the A file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: Specify amount of memory to use for input buffer. Takes an integer 
      argument. Optional suffixes K/M/G supported.
    inputBinding:
      position: 101
      prefix: -iobuf
  - id: input_file
    type: File
    doc: Input BED/GFF/VCF file. Must be sorted by chrom, then start.
    inputBinding:
      position: 101
      prefix: -i
  - id: max_distance
    type: int
    doc: Maximum distance between features allowed for features to be merged. 
      Negative values enforce the number of b.p. required for overlap.
    inputBinding:
      position: 101
      prefix: -d
  - id: no_buffer
    type:
      - 'null'
      - boolean
    doc: Disable buffered output. Each line of output is printed as it is 
      generated.
    inputBinding:
      position: 101
      prefix: -nobuf
  - id: operations
    type:
      - 'null'
      - string
    doc: Specify the operation that should be applied to -c (sum, min, max, 
      mean, etc.). Multiple operations can be specified in a comma-delimited 
      list.
    inputBinding:
      position: 101
      prefix: -o
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: If using BAM input, write output as BED.
    inputBinding:
      position: 101
      prefix: -bed
  - id: precision
    type:
      - 'null'
      - int
    doc: Sets the decimal precision for output
    inputBinding:
      position: 101
      prefix: -prec
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_merge.out
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
