cwlVersion: v1.2
class: CommandLineTool
baseCommand: chorus2
label: chorus2
doc: "Chorus2: Oligo FISH probe design software. (Note: The provided text contains
  container build logs and error messages rather than command-line help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/zhangtaolab/Chorus2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chorus2:2.01--py39h079770c_2
stdout: chorus2.out
