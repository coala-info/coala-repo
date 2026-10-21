cwlVersion: v1.2
class: CommandLineTool
baseCommand: [split_paired_bam.py]
label: rseqc_split_paired_bam.py
doc: "Split a paired-end BAM file into two single-end BAM files, one with the first read and one with the second read.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_file
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: "Alignment file in BAM or SAM format. BAM file should be sorted and indexed"
    inputBinding:
      position: 1
      prefix: --input-file
  - id: output_prefix
    type: string
    doc: "Prefix of output files(s). \"prefix.R1.bam\" file contains the 1st read, \"prefix.R2.bam\" file contains the 2nd read"
    inputBinding:
      position: 1
      prefix: --out-prefix
outputs:
  - id: r1_bam
    type: File
    doc: "First reads of the pairs."
    outputBinding:
      glob: "$(inputs.output_prefix).R1.bam"
  - id: r2_bam
    type: File
    doc: "Second reads of the pairs."
    outputBinding:
      glob: "$(inputs.output_prefix).R2.bam"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
