cwlVersion: v1.2
class: CommandLineTool
baseCommand: piler
label: piler
doc: "The provided text contains system error messages regarding disk space and container
  image conversion rather than the tool's help documentation. No arguments or descriptions
  could be extracted.\n\nTool homepage: https://github.com/alvarotrigo/pagePiling.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/piler:v020140707-2-deb_cv1
stdout: piler.out
