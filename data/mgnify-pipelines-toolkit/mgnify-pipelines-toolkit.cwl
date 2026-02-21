cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgnify-pipelines-toolkit
label: mgnify-pipelines-toolkit
doc: "A toolkit of scripts for MGnify pipelines. (Note: The provided text contains
  container runtime error logs rather than command-line help documentation, so no
  arguments could be extracted.)\n\nTool homepage: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgnify-pipelines-toolkit:1.4.16--pyhdfd78af_0
stdout: mgnify-pipelines-toolkit.out
