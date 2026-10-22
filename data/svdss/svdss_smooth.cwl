cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SVDSS
  - smooth
label: svdss_smooth
doc: "Smooth the reads of a BAM file against the reference (removes SNPs, small indels and errors); the smoothed BAM goes to standard output\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai?
    doc: "Reference FASTA."
    inputBinding:
      position: 101
      prefix: --reference
  - id: bam
    type: File
    secondaryFiles:
      - .bai?
    doc: "Input BAM file."
    inputBinding:
      position: 101
      prefix: --bam
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality (default: 20)."
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: accp
    type:
      - 'null'
      - float
    doc: "Accuracy percentile for alignments filtering (default: 0.98)."
    inputBinding:
      position: 101
      prefix: --accp
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 4)."
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: smoothed_bam
    type: stdout
    doc: Smoothed BAM written to standard output.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: smoothed.bam
