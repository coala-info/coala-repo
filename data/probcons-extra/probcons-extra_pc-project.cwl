cwlVersion: v1.2
class: CommandLineTool
baseCommand: pc-project
label: probcons-extra_pc-project
doc: "Project a multiple alignment onto all pairwise alignments, one FASTA file per sequence pair.\n\nTool homepage: http://probcons.stanford.edu/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: alignment
    type: File
    doc: "Multiple alignment (MFA)"
    inputBinding:
      position: 1
  - id: nocompressgaps
    type:
      - 'null'
      - boolean
    doc: "do not compress gap-only columns"
    inputBinding:
      position: 2
      prefix: -nocompressgaps
outputs:
  - id: pairwise_alignments
    type:
      type: array
      items: File
    doc: One FASTA file per sequence pair
    outputBinding:
      glob: '*.fasta'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons-extra:v1.12-12-deb_cv1
stdout: probcons-extra_pc-project.out
