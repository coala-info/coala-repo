cwlVersion: v1.2
class: CommandLineTool
baseCommand: badread error_model
label: badread_error_model
doc: "Build a Badread error model\n\nTool homepage: https://github.com/rrwick/Badread"
inputs:
  - id: alignment
    type: File
    doc: PAF alignment of reads aligned to reference
    inputBinding:
      position: 101
      prefix: --alignment
  - id: k_size
    type:
      - 'null'
      - int
    doc: Error model k-mer size
    default: 7
    inputBinding:
      position: 101
      prefix: --k_size
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: Only use this many alignments when generating error model
    inputBinding:
      position: 101
      prefix: --max_alignments
  - id: max_alt
    type:
      - 'null'
      - int
    doc: Only save up to this many alternatives to each k-mer
    default: 25
    inputBinding:
      position: 101
      prefix: --max_alt
  - id: reads
    type: File
    doc: FASTQ of real reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
stdout: badread_error_model.out
