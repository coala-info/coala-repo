cwlVersion: v1.2
class: CommandLineTool
baseCommand: dindel
label: dindel
doc: "Dindel is a program for calling small indels from short-read sequence data.\n
  \nTool homepage: https://github.com/genome/dindel-tgi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dindel:v1.01-wu1-3dfsg-1b1-deb_cv1
stdout: dindel.out
