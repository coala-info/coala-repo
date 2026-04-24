cwlVersion: v1.2
class: CommandLineTool
baseCommand: racon
label: racon
doc: "Ultrafast consensus module for raw de novo DNA assembly of long uncorrected
  reads.\n\nTool homepage: https://github.com/lbcb-sci/racon"
inputs:
  - id: sequences
    type: File
    doc: input file in FASTA/FASTQ format containing sequences used for correction
    inputBinding:
      position: 1
  - id: overlaps
    type: File
    doc: input file in MHAP/PAF/SAM format containing overlaps between sequences and
      target
    inputBinding:
      position: 2
  - id: target
    type: File
    doc: input file in FASTA/FASTQ format containing sequences which will be corrected
    inputBinding:
      position: 3
  - id: error_threshold
    type:
      - 'null'
      - float
    doc: maximum allowed error rate used for filtering overlaps
    inputBinding:
      position: 104
      prefix: --error-threshold
  - id: fragment_correction
    type:
      - 'null'
      - boolean
    doc: perform fragment correction instead of contig polishing
    inputBinding:
      position: 104
      prefix: --fragment-correction
  - id: gap
    type:
      - 'null'
      - int
    doc: gap penalty (must be negative)
    inputBinding:
      position: 104
      prefix: --gap
  - id: include_unpolished
    type:
      - 'null'
      - boolean
    doc: output unpolished target sequences
    inputBinding:
      position: 104
      prefix: --include-unpolished
  - id: match
    type:
      - 'null'
      - int
    doc: score for matching bases
    inputBinding:
      position: 104
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: score for mismatching bases
    inputBinding:
      position: 104
      prefix: --mismatch
  - id: quality_threshold
    type:
      - 'null'
      - float
    doc: threshold for average base quality of windows used in consensus generation
    inputBinding:
      position: 104
      prefix: --quality-threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: --threads
  - id: window_length
    type:
      - 'null'
      - int
    doc: size of window on which POA is performed
    inputBinding:
      position: 104
      prefix: --window-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/racon:1.5.0--h077b44d_8
stdout: racon.out
