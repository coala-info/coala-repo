cwlVersion: v1.2
class: CommandLineTool
baseCommand: PAFtoALN
label: fastga_PAFtoALN
doc: "Converts a PAF file with CIGAR strings to a .1aln alignment file.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.alignments.basename)
  - position: 101
    valueFrom: $(inputs.source1.basename)
  - position: 102
    valueFrom: '$(inputs.source2 ? inputs.source2.basename : null)'
inputs:
  - id: alignments
    type: File
    doc: Alignment file in PAF format with CIGAR strings (for example from FastGA -pafx).
  - id: source1
    type: File
    doc: 'First genome (.1gdb, FASTA or 1-code sequence file).'
  - id: source2
    type:
      - 'null'
      - File
    doc: Second genome.
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. [default: 8]'
    inputBinding:
      position: 101
      prefix: '-T'
      separate: false
outputs:
  - id: alignment_1aln
    type: File
    doc: Alignment file in 1aln format.
    outputBinding:
      glob: $(inputs.alignments.nameroot).1aln
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.alignments)
      - $(inputs.source1)
      - $(inputs.source2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_PAFtoALN.out
