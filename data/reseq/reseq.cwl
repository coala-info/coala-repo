cwlVersion: v1.2
class: CommandLineTool
baseCommand: reseq
label: reseq
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the 'reseq'
  tool.\n\nTool homepage: https://github.com/schmeing/ReSeq/tree/devel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
stdout: reseq.out
