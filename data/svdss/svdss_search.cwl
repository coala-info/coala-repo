cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SVDSS
  - search
label: svdss_search
doc: "Extract the sample-specific strings (SFS) from a BAM or FASTQ file; the list goes to standard output\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs:
  - id: index
    type: File
    doc: "FMD index of the reference."
    inputBinding:
      position: 101
      prefix: --index
  - id: bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - .bai?
    doc: "Input BAM file (smoothed)."
    inputBinding:
      position: 101
      prefix: --bam
  - id: fastq
    type:
      - 'null'
      - File
    doc: "Input FASTQ file."
    inputBinding:
      position: 101
      prefix: --fastq
  - id: bsize
    type:
      - 'null'
      - int
    doc: "Batch size (default: 10000)."
    inputBinding:
      position: 101
      prefix: --bsize
  - id: noputative
    type:
      - 'null'
      - boolean
    doc: "When input is smoothed bam, do not filter unsmoothed reads (default: putative)."
    inputBinding:
      position: 101
      prefix: --noputative
  - id: noassemble
    type:
      - 'null'
      - boolean
    doc: "Do not assemble specific strings overlapping on a read (default: assemble)."
    inputBinding:
      position: 101
      prefix: --noassemble
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 4)."
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: specifics
    type: stdout
    doc: List of specific strings written to standard output.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: specifics.txt
