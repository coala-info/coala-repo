cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - fisher
label: bedtools_fisher
doc: Calculate Fisher statistic b/w two feature files.
inputs:
  - id: bed_output
    type:
      - 'null'
      - boolean
    doc: If using BAM input, write output as BED.
    inputBinding:
      position: 101
      prefix: -bed
  - id: diff_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness. That is, only report hits in B that 
      overlap A on the opposite strand.
    inputBinding:
      position: 101
      prefix: -S
  - id: either_fraction
    type:
      - 'null'
      - boolean
    doc: Require that the minimum fraction be satisfied for A OR B.
    inputBinding:
      position: 101
      prefix: -e
  - id: genome
    type: File
    doc: Provide a genome file to enforce consistent chromosome sort order 
      across input files. Only applies when used with -sorted option.
    inputBinding:
      position: 101
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header from the A file prior to results.
    inputBinding:
      position: 101
      prefix: -header
  - id: input_a
    type:
      - 'null'
      - File
    doc: Input bed/gff/vcf file A
    inputBinding:
      position: 101
      prefix: -a
  - id: input_b
    type:
      - 'null'
      - File
    doc: Input bed/gff/vcf file B
    inputBinding:
      position: 101
      prefix: -b
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: Specify amount of memory to use for input buffer. Takes an integer 
      argument. Optional suffixes K/M/G supported.
    inputBinding:
      position: 101
      prefix: -iobuf
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge overlapping intervals before looking at overlap.
    inputBinding:
      position: 101
      prefix: -m
  - id: no_buf
    type:
      - 'null'
      - boolean
    doc: Disable buffered output.
    inputBinding:
      position: 101
      prefix: -nobuf
  - id: no_name_check
    type:
      - 'null'
      - boolean
    doc: For sorted data, don't throw an error if the file has different naming 
      conventions for the same chromosome. ex. "chr1" vs "chr01".
    inputBinding:
      position: 101
      prefix: -nonamecheck
  - id: overlap_fraction_a
    type: float
    doc: Minimum overlap required as a fraction of A.
    inputBinding:
      position: 101
      prefix: -f
  - id: overlap_fraction_b
    type: float
    doc: Minimum overlap required as a fraction of B.
    inputBinding:
      position: 101
      prefix: -F
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: Require that the fraction overlap be reciprocal for A AND B.
    inputBinding:
      position: 101
      prefix: -r
  - id: same_strand
    type:
      - 'null'
      - boolean
    doc: Require same strandedness. That is, only report hits in B that overlap 
      A on the same strand.
    inputBinding:
      position: 101
      prefix: -s
  - id: split
    type:
      - 'null'
      - boolean
    doc: Treat "split" BAM or BED12 entries as distinct BED intervals.
    inputBinding:
      position: 101
      prefix: -split
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_fisher.out
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
