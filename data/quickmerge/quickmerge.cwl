cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickmerge
label: quickmerge
doc: "Merge overlapping sequences from a hybrid assembly.\n\nTool homepage: https://github.com/mahulchak/quickmerge"
inputs:
  - id: c
    type:
      - 'null'
      - float
    doc: Contig overlap cutoff
    inputBinding:
      position: 101
      prefix: -c
  - id: delta_file
    type: File
    doc: Delta file containing pairwise alignments
    inputBinding:
      position: 101
      prefix: -d
  - id: hco
    type:
      - 'null'
      - float
    doc: Hybrid contig overlap cutoff
    inputBinding:
      position: 101
      prefix: -hco
  - id: hybrid_fasta
    type: File
    doc: Hybrid assembly FASTA file
    inputBinding:
      position: 101
      prefix: -q
  - id: merging_length_cutoff
    type: int
    doc: Merging length cutoff
    inputBinding:
      position: 101
      prefix: -ml
  - id: prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: -p
  - id: seed_length_cutoff
    type: int
    doc: Seed length cutoff
    inputBinding:
      position: 101
      prefix: -l
  - id: self_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: merged_fasta
    type: File
    doc: Merged assembly (merged_<prefix>.fasta)
    outputBinding:
      glob: merged_$(inputs.prefix).fasta
  - id: aln_summary
    type:
      - 'null'
      - File
    doc: Alignment summary (aln_summary_<prefix>.tsv)
    outputBinding:
      glob: aln_summary_$(inputs.prefix).tsv
  - id: anchor_summary
    type:
      - 'null'
      - File
    doc: Anchor summary (anchor_summary_<prefix>.txt)
    outputBinding:
      glob: anchor_summary_$(inputs.prefix).txt
  - id: param_summary
    type:
      - 'null'
      - File
    doc: Parameter summary (param_summary_<prefix>.txt)
    outputBinding:
      glob: param_summary_$(inputs.prefix).txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmerge:0.3--pl5321h503566f_6
stdout: quickmerge.out
