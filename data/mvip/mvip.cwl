cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip
label: mvip
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the 'mvip' tool.\n
  \nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip.out
