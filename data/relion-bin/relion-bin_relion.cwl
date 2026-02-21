cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion
label: relion-bin_relion
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin:v1.4dfsg-4-deb_cv1
stdout: relion-bin_relion.out
