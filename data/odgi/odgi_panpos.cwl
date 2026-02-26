cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi panpos
label: odgi_panpos
doc: "Get the pangenome position of a given path and nucleotide position (1-based).\n\
  \nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: idx
    type: File
    doc: Load the succinct variation graph index in xp format from this *FILE*. 
      The file name usually ends with *.xp*.
    inputBinding:
      position: 101
      prefix: --idx
  - id: nuc_pos
    type: int
    doc: The nucleotide position of the query.
    inputBinding:
      position: 101
      prefix: --nuc-pos
  - id: path
    type: string
    doc: The path name of the query.
    inputBinding:
      position: 101
      prefix: --path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_panpos.out
