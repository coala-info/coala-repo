cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgnify-pipelines-toolkit
  - gbk_generator
label: mgnify-pipelines-toolkit_gbk_generator
doc: "A tool within the MGnify pipelines toolkit for generating GenBank (GBK) files.\n
  \nTool homepage: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgnify-pipelines-toolkit:1.4.16--pyhdfd78af_0
stdout: mgnify-pipelines-toolkit_gbk_generator.out
