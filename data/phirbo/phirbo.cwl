cwlVersion: v1.2
class: CommandLineTool
baseCommand: phirbo
label: phirbo
doc: "The provided text does not contain help information or argument definitions.
  It appears to be an error log from a container runtime (Singularity/Apptainer) failing
  to fetch the tool's image.\n\nTool homepage: https://github.com/aziele/phirbo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phirbo:1.0--0
stdout: phirbo.out
