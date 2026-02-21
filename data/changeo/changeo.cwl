cwlVersion: v1.2
class: CommandLineTool
baseCommand: changeo
label: changeo
doc: "The provided text does not contain help information for the 'changeo' tool.
  It appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: http://changeo.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/changeo:1.3.4--pyhdfd78af_0
stdout: changeo.out
