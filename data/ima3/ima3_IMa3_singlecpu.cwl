cwlVersion: v1.2
class: CommandLineTool
baseCommand: ima3
label: ima3_IMa3_singlecpu
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/jodyhey/IMa3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ima3:1.13--h503566f_2
stdout: ima3_IMa3_singlecpu.out
