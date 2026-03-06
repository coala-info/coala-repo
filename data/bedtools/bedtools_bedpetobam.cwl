cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - bedpetobam
label: bedtools_bedpetobam
doc: Converts feature records to BAM format.
inputs:
  - id: genome_file
    type: File
    doc: Genome file
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input bed/gff/vcf file
    inputBinding:
      position: 101
      prefix: -i
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: Set the mapping quality for the BAM records.
    inputBinding:
      position: 101
      prefix: -mapq
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Write uncompressed BAM output. Default writes compressed BAM.
    inputBinding:
      position: 101
      prefix: -ubam
outputs:
  - id: output_uncompressed_bam
    type:
      - 'null'
      - File
    doc: Write uncompressed BAM output. Default writes compressed BAM.
    outputBinding:
      glob: $(inputs.uncompressed_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
