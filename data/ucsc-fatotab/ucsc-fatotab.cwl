cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToTab
label: ucsc-fatotab
doc: "The provided text contains a container execution error rather than the tool's
  help output. Based on the tool name 'ucsc-fatotab', this utility converts FASTA
  formatted files to tab-separated files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatotab:482--h0b57e2e_0
stdout: ucsc-fatotab.out
