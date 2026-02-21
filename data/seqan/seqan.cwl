cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan
label: seqan
doc: "The provided text does not contain help documentation or usage instructions
  for the 'seqan' tool. It is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract a Docker image due to insufficient disk
  space ('no space left on device').\n\nTool homepage: http://www.seqan.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqan:2.4.0--0
stdout: seqan.out
