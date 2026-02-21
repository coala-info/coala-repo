cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_filtercolumns.jar
label: ibdne_filtercolumns.jar
doc: "A tool for filtering columns, typically used in the context of IBDne (Identity
  By Descent effective population size estimation). Note: The provided input text
  consists of system error messages regarding container image extraction and does
  not contain actual help documentation or argument definitions.\n\nTool homepage:
  https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_filtercolumns.jar.out
