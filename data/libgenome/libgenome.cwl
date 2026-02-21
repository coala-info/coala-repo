cwlVersion: v1.2
class: CommandLineTool
baseCommand: libgenome
label: libgenome
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for the libgenome tool.\n
  \nTool homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libgenome:1.3.1--h9f5acd7_4
stdout: libgenome.out
