cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonkit
label: taxonkit
doc: "TaxonKit - A Practical and Efficient NCBI Taxonomy Toolkit\n\nTool homepage:
  https://github.com/shenwei356/taxonkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
stdout: taxonkit.out
