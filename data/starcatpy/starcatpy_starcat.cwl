cwlVersion: v1.2
class: CommandLineTool
baseCommand: starcat
label: starcatpy_starcat
doc: "StarCAT (Star Classifier and Aligner Tool) - Note: The provided help text contains
  only system logs and error messages, no command-line arguments could be extracted.\n
  \nTool homepage: https://github.com/immunogenomics/starCAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starcatpy:1.0.9--pyh7e72e81_0
stdout: starcatpy_starcat.out
