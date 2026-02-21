cwlVersion: v1.2
class: CommandLineTool
baseCommand: sword
label: sword
doc: "SWORD is a protein database search tool that utilizes a heuristic Smith-Waterman
  algorithm for sensitive and fast sequence alignment.\n\nTool homepage: https://github.com/rvaser/sword"
inputs:
  - id: database_file
    type: File
    doc: Database file in FASTA format
    inputBinding:
      position: 101
      prefix: -j
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of alignments to report
    inputBinding:
      position: 101
      prefix: -a
  - id: outfmt
    type:
      - 'null'
      - int
    doc: Output format (0 for m8, 1 for pairwise)
    inputBinding:
      position: 101
      prefix: -f
  - id: query_file
    type: File
    doc: Query file in FASTA format
    inputBinding:
      position: 101
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: threshold
    type:
      - 'null'
      - int
    doc: Score threshold for reporting alignments
    inputBinding:
      position: 101
      prefix: -T
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sword:1.0.4--h9948957_5
