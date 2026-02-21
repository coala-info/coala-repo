cwlVersion: v1.2
class: CommandLineTool
baseCommand: cvbio
label: cvbio
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build (Apptainer/Singularity) due to insufficient disk space.\n
  \nTool homepage: https://github.com/clintval/cvbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cvbio:3.0.0--0
stdout: cvbio.out
