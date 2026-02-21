cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsngs
label: ngsngs
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the 'ngsngs' tool. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/rahenriksen/ngsngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsngs:0.9.2--h13024bc_2
stdout: ngsngs.out
