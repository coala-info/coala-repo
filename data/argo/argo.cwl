cwlVersion: v1.2
class: CommandLineTool
baseCommand: argo
label: argo
doc: "The provided text does not contain help information or usage instructions for
  the tool 'argo'. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/xinehc/argo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argo:0.2.1--pyhdfd78af_0
stdout: argo.out
