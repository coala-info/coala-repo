cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesm_create_newcase
label: cesm_create_newcase
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/ESCOMP/cesm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesm:2.1.3--py39hd40aa7f_3
stdout: cesm_create_newcase.out
