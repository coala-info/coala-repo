cwlVersion: v1.2
class: CommandLineTool
baseCommand: imseq
label: imseq
doc: "The provided text does not contain help information for the tool 'imseq'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: http://www.imtools.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imseq:1.1.0--h077b44d_8
stdout: imseq.out
