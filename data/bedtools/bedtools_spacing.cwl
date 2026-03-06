cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - spacing
label: bedtools_spacing
doc: Report (last col.) the gap lengths between intervals in a file.
inputs:
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
    doc: Input file (bed/gff/vcf/bam). Must be sorted by chrom, start.
    inputBinding:
      position: 101
      prefix: -i
  - id: no_buffer
    type:
      - 'null'
      - boolean
    doc: Disable buffered output. Using this option will cause each line of 
      output to be printed as it is generated, rather than saved in a buffer.
    inputBinding:
      position: 101
      prefix: -nobuf
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: If using BAM input, write output as BED.
    inputBinding:
      position: 101
      prefix: -bed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_spacing.out
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
