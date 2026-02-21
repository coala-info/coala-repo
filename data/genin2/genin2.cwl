cwlVersion: v1.2
class: CommandLineTool
baseCommand: genin2
label: genin2
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the SIF format due to insufficient disk space.\n\n
  Tool homepage: https://github.com/izsvenezie-virology/genin2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genin2:2.1.5--pyhdfd78af_0
stdout: genin2.out
