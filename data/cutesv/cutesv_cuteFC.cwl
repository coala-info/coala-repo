cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuteFC
label: cutesv_cuteFC
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  or extract the OCI image due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://github.com/tjiangHIT/cuteSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutesv:2.1.3--pyhdfd78af_0
stdout: cutesv_cuteFC.out
