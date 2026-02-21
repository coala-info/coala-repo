cwlVersion: v1.2
class: CommandLineTool
baseCommand: trinityrnaseq
label: trinityrnaseq
doc: "Trinity RNA-Seq de novo transcriptome assembly (Note: The provided input text
  was a container build error log and did not contain help documentation).\n\nTool
  homepage: https://github.com/trinityrnaseq/trinityrnaseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/trinityrnaseq:v2.6.6dfsg-6-deb_cv1
stdout: trinityrnaseq.out
