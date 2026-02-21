cwlVersion: v1.2
class: CommandLineTool
baseCommand: airr
label: airr
doc: "The provided text does not contain help information for the 'airr' tool; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space ('no space left on device').\n
  \nTool homepage: http://docs.airr-community.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/airr:1.5.1--pyh7cba7a3_0
stdout: airr.out
