cwlVersion: v1.2
class: CommandLineTool
baseCommand: args_oap
label: args_oap
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/xinehc/args_oap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
stdout: args_oap.out
