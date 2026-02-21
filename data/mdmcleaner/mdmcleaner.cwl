cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdmcleaner
label: mdmcleaner
doc: "A tool for cleaning and refining Metagenome-Assembled Genomes (MAGs). Note:
  The provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
stdout: mdmcleaner.out
