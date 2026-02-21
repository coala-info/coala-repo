cwlVersion: v1.2
class: CommandLineTool
baseCommand: rcsbsearch
label: rcsbsearch
doc: "A tool for searching the RCSB Protein Data Bank (PDB). Note: The provided help
  text contains only system error messages and no usage information.\n\nTool homepage:
  https://github.com/sbliven/rcsbsearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rcsbsearch:0.2.3--pyhdfd78af_0
stdout: rcsbsearch.out
