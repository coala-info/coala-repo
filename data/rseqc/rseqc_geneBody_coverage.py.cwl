cwlVersion: v1.2
class: CommandLineTool
baseCommand: geneBody_coverage.py
label: rseqc_geneBody_coverage.py
doc: Calculate the RNA-seq reads coverage over gene body.
inputs:
  - id: input_files
    type:
      - 'null'
      - string
    doc: 'Input file(s) in BAM format. "-i" takes these input: 1) a single BAM file.
      2) "," separated BAM files. 3) directory containing one or more bam files. 4)
      plain text file containing the path of one or more bam file (Each row is a BAM
      file path). All BAM files should be sorted and indexed using samtools.'
    inputBinding:
      position: 101
      prefix: --input
  - id: refgene
    type: File
    doc: Reference gene model in bed format.
    inputBinding:
      position: 101
      prefix: --refgene
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Minimum mRNA length (bp). mRNA smaller than "min_mRNA_length" will be 
      skipped.
    inputBinding:
      position: 101
      prefix: --minimum_length
  - id: format
    type:
      - 'null'
      - string
    doc: Output file format, 'pdf', 'png' or 'jpeg'.
    inputBinding:
      position: 101
      prefix: --format
  - id: out_prefix
    type: string
    doc: Prefix of output files(s).
    inputBinding:
      position: 101
      prefix: --out-prefix
outputs:
  - id: output_out_prefix
    type: File[]
    doc: Prefix of output files(s).
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
