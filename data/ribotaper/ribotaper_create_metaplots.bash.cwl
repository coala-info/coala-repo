cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotaper_create_metaplots.bash
label: ribotaper_create_metaplots.bash
doc: "Create metaplots for Ribo-seq data (Note: The provided text contains container
  execution errors rather than help documentation, so arguments could not be extracted).\n
  \nTool homepage: https://github.com/boboppie/RiboTaper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotaper:1.3.1--0
stdout: ribotaper_create_metaplots.bash.out
