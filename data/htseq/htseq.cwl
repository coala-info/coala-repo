cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq
label: htseq
doc: "The provided text is a system error log from a container runtime (Singularity/Apptainer)
  and does not contain CLI help information or arguments for the htseq tool.\n\nTool
  homepage: https://github.com/htseq/htseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq:2.0.9--py311h8fb3dee_0
stdout: htseq.out
