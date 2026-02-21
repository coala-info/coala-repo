cwlVersion: v1.2
class: CommandLineTool
baseCommand: openstructure
label: openstructure
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or argument definitions for the 'openstructure'
  tool.\n\nTool homepage: https://openstructure.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openstructure:2.11.1--py310h1f7f436_0
stdout: openstructure.out
