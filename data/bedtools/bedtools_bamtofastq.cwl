cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - bamtofastq
label: bedtools_bamtofastq
doc: Convert BAM alignments to FASTQ files.
inputs:
  - id: fastq_1
    type: string
    doc: FASTQ for first end (or single-end).
    inputBinding:
      position: 101
      prefix: -fq
  - id: fastq_2
    type: string
    doc: FASTQ for second end. Used if BAM contains paired-end data. BAM should 
      be sorted by query name if creating paired FASTQ.
    inputBinding:
      position: 101
      prefix: -fq2
  - id: input_bam
    type:
      - 'null'
      - File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: use_tags
    type:
      - 'null'
      - boolean
    doc: Create FASTQ based on the mate info in the BAM R2 and Q2 tags.
    inputBinding:
      position: 101
      prefix: -tags
outputs:
  - id: output_fastq_1
    type: File
    doc: FASTQ for first end (or single-end).
    outputBinding:
      glob: $(inputs.fastq_1)
  - id: output_fastq_2
    type:
      - 'null'
      - File
    doc: FASTQ for second end. Used if BAM contains paired-end data. BAM should 
      be sorted by query name if creating paired FASTQ.
    outputBinding:
      glob: $(inputs.fastq_2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
