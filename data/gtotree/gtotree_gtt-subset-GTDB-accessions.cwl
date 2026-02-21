cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtt-subset-GTDB-accessions
label: gtotree_gtt-subset-GTDB-accessions
doc: "A tool from the GToTree suite for subsetting GTDB accessions. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree_gtt-subset-GTDB-accessions.out
