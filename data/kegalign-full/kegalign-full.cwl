cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign-full
label: kegalign-full
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full.out
