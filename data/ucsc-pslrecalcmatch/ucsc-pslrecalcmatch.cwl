cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslRecalcMatch
label: ucsc-pslrecalcmatch
doc: "Recalculate match/mismatch counts for PSL files. Note: The provided help text
  contains a container runtime error and does not list command-line arguments.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslrecalcmatch:482--h0b57e2e_0
stdout: ucsc-pslrecalcmatch.out
