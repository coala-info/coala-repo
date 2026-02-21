cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit
label: seqkit
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or pull the image due to insufficient disk space.\n
  \nTool homepage: https://github.com/shenwei356/seqkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
stdout: seqkit.out
