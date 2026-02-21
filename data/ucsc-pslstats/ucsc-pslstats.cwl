cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslStats
label: ucsc-pslstats
doc: "The provided text is a container runtime error log and does not contain help
  information for the tool. pslStats is a UCSC Genome Browser utility used to generate
  statistics from PSL (Pattern Space Layout) files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslstats:482--h0b57e2e_0
stdout: ucsc-pslstats.out
