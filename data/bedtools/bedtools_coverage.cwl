cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - coverage
label: bedtools_coverage
doc: "Returns the depth and breadth of coverage of features from B on the intervals
  in A.\n\nTool homepage: http://bedtools.readthedocs.org/"
inputs:
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Only report the count of overlaps, don't compute fraction, etc.
    inputBinding:
      position: 101
      prefix: -counts
  - id: depth_per_position
    type:
      - 'null'
      - boolean
    doc: Report the depth at each position in each A feature. Positions reported
      are one based.
    inputBinding:
      position: 101
      prefix: -d
  - id: genome_file
    type:
      - 'null'
      - File
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
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: Report a histogram of coverage for each feature in A as well as a 
      summary histogram for _all_ features in A.
    inputBinding:
      position: 101
      prefix: -hist
  - id: input_a
    type: File
    doc: Input BED/GFF/VCF file A
    inputBinding:
      position: 101
      prefix: -a
  - id: input_b
    type: File
    doc: Input BED/GFF/VCF file B
    inputBinding:
      position: 101
      prefix: -b
  - id: input_buffer_size
    type:
      - 'null'
      - string
    doc: Specify amount of memory to use for input buffer (e.g. 10M).
    inputBinding:
      position: 101
      prefix: -iobuf
  - id: mean
    type:
      - 'null'
      - boolean
    doc: Report the mean depth of all positions in each A feature.
    inputBinding:
      position: 101
      prefix: -mean
  - id: min_overlap_a
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of A.
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -f
  - id: min_overlap_b
    type:
      - 'null'
      - float
    doc: Minimum overlap required as a fraction of B.
    default: '1E-9'
    inputBinding:
      position: 101
      prefix: -F
  - id: no_buffer
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
      conventions for the same chromosome.
    inputBinding:
      position: 101
      prefix: -nonamecheck
  - id: opposite_strand
    type:
      - 'null'
      - boolean
    doc: Require different strandedness. That is, only report hits in B that 
      overlap A on the opposite strand.
    inputBinding:
      position: 101
      prefix: -S
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: If using BAM input, write output as BED.
    inputBinding:
      position: 101
      prefix: -bed
  - id: overlap_either
    type:
      - 'null'
      - boolean
    doc: Require that the minimum fraction be satisfied for A OR B.
    inputBinding:
      position: 101
      prefix: -e
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
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Use the "chromsweep" algorithm for sorted (-k1,1 -k2,2n) input.
    inputBinding:
      position: 101
      prefix: -sorted
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
stdout: bedtools_coverage.out
