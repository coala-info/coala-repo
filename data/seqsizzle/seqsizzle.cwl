cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqsizzle
label: seqsizzle
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a failed container build (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/ChangqingW/SeqSizzle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
stdout: seqsizzle.out
