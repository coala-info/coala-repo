cwlVersion: v1.2
class: CommandLineTool
baseCommand: parsimonious
label: parsimonious
doc: "The provided text contains error messages from a container runtime (Singularity/Apptainer)
  indicating a failure to pull or build the image due to lack of disk space. It does
  not contain help text, usage instructions, or argument definitions for the tool
  'parsimonious'.\n\nTool homepage: https://github.com/erikrose/parsimonious"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parsimonious:0.10.0
stdout: parsimonious.out
