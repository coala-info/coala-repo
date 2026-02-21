cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadOutJoined
label: ucsc-hgloadoutjoined_hgLoadOutJoined
doc: "A tool to load RepeatMasker .out files into a database. Note: The provided help
  text contains only container execution errors and does not list specific command-line
  arguments.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadoutjoined:482--h0b57e2e_0
stdout: ucsc-hgloadoutjoined_hgLoadOutJoined.out
