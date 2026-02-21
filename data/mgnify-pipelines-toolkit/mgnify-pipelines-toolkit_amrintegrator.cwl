cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgnify-pipelines-toolkit
  - amrintegrator
label: mgnify-pipelines-toolkit_amrintegrator
doc: "A tool within the MGnify pipelines toolkit for integrating AMR (Antimicrobial
  Resistance) results. Note: The provided help text contains only system error logs
  regarding container execution and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgnify-pipelines-toolkit:1.4.16--pyhdfd78af_0
stdout: mgnify-pipelines-toolkit_amrintegrator.out
