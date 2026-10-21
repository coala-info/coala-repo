cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaffold_builder.py
label: scaffold_builder_scaffold_builder.py
doc: "Scaffold_builder combines de novo assembled contigs into scaffolds, guided by a reference genome (it maps the contigs with nucmer, orders them and merges overlapping ends).\n\nTool homepage: http://edwards.sdsu.edu/scaffold_builder"
inputs:
  - id: query_file
    type: File
    doc: Fasta file of contigs (query). These contigs may be the output of a de
      novo assembly program.
    inputBinding:
      position: 101
      prefix: -q
  - id: reference_file
    type: File
    doc: Fasta file containing the reference genome.
    inputBinding:
      position: 101
      prefix: -r
  - id: output_prefix
    type: string
    doc: Prefix of the output files.
    inputBinding:
      position: 101
      prefix: -p
  - id: terminus_length
    type:
      - 'null'
      - int
    doc: Length of terminus that will be aligned (default 300 nt).
    inputBinding:
      position: 102
      prefix: -t
  - id: min_identity
    type:
      - 'null'
      - int
    doc: Minimum identity for merging contigs (default 80 percent).
    inputBinding:
      position: 102
      prefix: -i
  - id: ambiguous_percent
    type:
      - 'null'
      - int
    doc: Minimum length for ambiguously mapped contigs (default 95 percent).
    inputBinding:
      position: 102
      prefix: -a
  - id: rearrangement_behavior
    type:
      - 'null'
      - int
    doc: 'Behavior for rearrangements: 0 places contigs end-to-end (default), 1
      creates a new scaffold sequence.'
    inputBinding:
      position: 102
      prefix: -b
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap length allowed (default 5000 nt).
    inputBinding:
      position: 102
      prefix: -g
outputs:
  - id: scaffold_fasta
    type: File
    doc: Scaffolded sequences.
    outputBinding:
      glob: $(inputs.output_prefix)_Scaffold.fasta
  - id: output_report
    type: File
    doc: Log and statistics of the scaffolding.
    outputBinding:
      glob: $(inputs.output_prefix)_output.txt
  - id: coords_file
    type: File
    doc: Nucmer show-coords mapping of the contigs on the reference.
    outputBinding:
      glob: $(inputs.output_prefix).coords
  - id: overlap_alignment_dir
    type: Directory
    doc: Alignments of overlapping contig ends.
    outputBinding:
      glob: $(inputs.output_prefix)_overlap_alignment
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaffold_builder:2.3--pyhdfd78af_0
