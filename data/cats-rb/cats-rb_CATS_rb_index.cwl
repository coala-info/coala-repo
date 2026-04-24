cwlVersion: v1.2
class: CommandLineTool
baseCommand: cats_rb_index
label: cats-rb_CATS_rb_index
doc: "genome index generation script\n\nTool homepage: https://github.com/bodulic/CATS-rb"
inputs:
  - id: genome
    type: File
    doc: Genome file
    inputBinding:
      position: 1
  - id: max_gene_length
    type:
      - 'null'
      - int
    doc: Maximum gene length (in bp)
    inputBinding:
      position: 102
      prefix: -m
  - id: overwrite_index
    type:
      - 'null'
      - boolean
    doc: Overwrite the genome index directory
    inputBinding:
      position: 102
      prefix: -O
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
stdout: cats-rb_CATS_rb_index.out
