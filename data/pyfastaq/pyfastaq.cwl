cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq
label: pyfastaq
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the pyfastaq tool.\n
  \nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
stdout: pyfastaq.out
