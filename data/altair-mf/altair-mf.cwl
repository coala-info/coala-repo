cwlVersion: v1.2
class: CommandLineTool
baseCommand: altair-mf
label: altair-mf
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help documentation or usage instructions for the tool 'altair-mf'.\n
  \nTool homepage: https://cobilab.github.io/altair/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/altair-mf:1.0.1--h077b44d_4
stdout: altair-mf.out
