cwlVersion: v1.2
class: CommandLineTool
baseCommand: yass
label: yass
doc: "YASS (Yet Another Similarity Searcher) is a genomic local alignment tool. Note:
  The provided text is a container execution error log and does not contain the standard
  help documentation or argument definitions.\n\nTool homepage: https://bioinfo.lifl.fr/yass"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yass:1.16--h7b50bb2_0
stdout: yass.out
