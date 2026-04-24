cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove
label: smoove_merge
doc: "Merge VCF files from smoove runs.\n\nTool homepage: https://github.com/brentp/smoove"
inputs:
  - id: vcfs
    type:
      type: array
      items: File
    doc: path to vcfs.
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: fasta file.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: name
    type: string
    doc: project name used in output files.
    inputBinding:
      position: 102
      prefix: --name
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory.
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
stdout: smoove_merge.out
