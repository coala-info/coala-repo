cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadOutJoined
label: ucsc-hgloadout_hgLoadOutJoined
doc: "A tool from the UCSC Genome Browser utilities (hgLoadOutJoined). Note: The provided
  help text contains only container execution logs and no usage information.\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadout:482--h0b57e2e_0
stdout: ucsc-hgloadout_hgLoadOutJoined.out
