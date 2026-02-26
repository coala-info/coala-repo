cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi pathindex
label: odgi_pathindex
doc: "Create a path index for a given graph.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*.
    inputBinding:
      position: 101
      prefix: --idx
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Write the succinct variation graph index to this FILE. A file ending 
      with *.xp* is recommended.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
