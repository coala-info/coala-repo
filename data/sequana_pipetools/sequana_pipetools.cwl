cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequana_pipetools
label: sequana_pipetools
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/sequana/sequana_pipetools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana_pipetools.out
