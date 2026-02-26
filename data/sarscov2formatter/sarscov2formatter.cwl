cwlVersion: v1.2
class: CommandLineTool
baseCommand: sarscov2formatter
label: sarscov2formatter
doc: "Metadata extractor for SARS-CoV-2 selection analysis pipeline in Galaxy\n\n\
  Tool homepage: https://github.com/nickeener/sarscov2formatter"
inputs:
  - id: alignment
    type: File
    doc: Mulitple sequence alignment file
    inputBinding:
      position: 101
      prefix: --alignment
  - id: metadata
    type:
      - 'null'
      - File
    doc: tabular metadata
    inputBinding:
      position: 101
      prefix: --metadata
  - id: ncbimetadata
    type:
      - 'null'
      - File
    doc: "yaml metadata from NCBI. if neither -n nor -m is given\nit will be downloaded
      from\nhttps://www.ncbi.nlm.nih.gov/projects/genome/sars-\ncov-2-seqs/ncov-sequences.yaml"
    inputBinding:
      position: 101
      prefix: --ncbimetadata
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sarscov2formatter:1.0--pyhdfd78af_0
stdout: sarscov2formatter.out
