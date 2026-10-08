cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNreset
label: fastga_ALNreset
doc: "Resets the source genome paths stored in a .1aln alignment file (the file is rewritten).\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
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
    doc: Alignment file (.1aln).
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
  - id: reset_alignments
    type: File
    doc: Alignment file with the new genome paths.
    outputBinding:
      glob: $(inputs.alignments.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.alignments)
        writable: true
      - $(inputs.source1)
      - $(inputs.source2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNreset.out
