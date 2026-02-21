cwlVersion: v1.2
class: CommandLineTool
baseCommand: ideas_runideaspipe.R
label: ideas_runideaspipe.R
doc: "Integrative and Discriminative Epigenome Annotation System (IDEAS) pipeline.
  Note: The provided text appears to be a container runtime error message rather than
  help text, so no arguments could be extracted.\n\nTool homepage: https://github.com/yuzhang123/IDEAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ideas:1.20--h9948957_7
stdout: ideas_runideaspipe.R.out
