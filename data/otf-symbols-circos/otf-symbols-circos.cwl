cwlVersion: v1.2
class: CommandLineTool
baseCommand: otf-symbols-circos
label: otf-symbols-circos
doc: The provided text contains system error messages related to a container 
  runtime failure and does not include the actual help documentation or usage 
  instructions for the tool. As a result, no arguments could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/otf-symbols-circos:v0.69.4dfsg-1-deb_cv1
stdout: otf-symbols-circos.out
