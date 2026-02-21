cwlVersion: v1.2
class: CommandLineTool
baseCommand: influx_si
label: influx_si
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to insufficient disk space.\n\nTool
  homepage: https://metasys.insa-toulouse.fr/software/influx/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/influx-si-data-manager:1.1.1--pyhdfd78af_0
stdout: influx_si.out
