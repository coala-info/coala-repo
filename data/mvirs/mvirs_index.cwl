cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mvirs
  - index
label: mvirs_index
doc: "Localisation of inducible prophages using NGS data\n\nTool homepage: https://github.com/SushiLab/mVIRs"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file. Can be gzipped.
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
stdout: mvirs_index.out
