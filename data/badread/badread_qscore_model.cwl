cwlVersion: v1.2
class: CommandLineTool
baseCommand: badread_qscore_model
label: badread_qscore_model
doc: "Build a Badread qscore model\n\nTool homepage: https://github.com/rrwick/Badread"
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
    doc: 'Qscore model k-mer size (must be odd, default: 9)'
    default: 9
    inputBinding:
      position: 101
      prefix: --k_size
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: 'Only use this many alignments when generating qscore model (default: use
      all alignments)'
    inputBinding:
      position: 101
      prefix: --max_alignments
  - id: max_del
    type:
      - 'null'
      - int
    doc: 'Deletion runs longer than this will be collapsed to reduce the number of
      possible alignments (default: 6)'
    default: 6
    inputBinding:
      position: 101
      prefix: --max_del
  - id: max_output
    type:
      - 'null'
      - int
    doc: 'The outputted model will be limited to this many lines (default: 10000)'
    default: 10000
    inputBinding:
      position: 101
      prefix: --max_output
  - id: min_occur
    type:
      - 'null'
      - int
    doc: 'CIGARs which occur less than this many times will not be included in the
      model (default: 100)'
    default: 100
    inputBinding:
      position: 101
      prefix: --min_occur
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
stdout: badread_qscore_model.out
