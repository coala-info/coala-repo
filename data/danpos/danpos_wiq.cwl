cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danpos
  - wiq
label: danpos_wiq
doc: "Wig data normalization and comparison (part of the DANPOS suite for nucleosome
  positioning analysis). Note: The provided text is a container build log and does
  not contain CLI help information.\n\nTool homepage: https://sites.google.com/site/danposdoc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
stdout: danpos_wiq.out
