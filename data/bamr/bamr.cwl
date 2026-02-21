cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamr
label: bamr
doc: "The provided text does not contain help information or a description for the
  tool 'bamr'; it consists of error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/cschu/bamr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamr:0.2.0--pyhdfd78af_0
stdout: bamr.out
