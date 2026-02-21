cwlVersion: v1.2
class: CommandLineTool
baseCommand: mage-tab-merger
label: mage-tab-merger
doc: "A tool for merging MAGE-TAB (MicroArray Gene Expression Tabular) files.\n\n
  Tool homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mage-tab-merger:0.0.4--pyh5e36f6f_0
stdout: mage-tab-merger.out
