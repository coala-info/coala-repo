cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgsqldump
label: ucsc-hgsqldump_hgsqldump
doc: "A tool from the UCSC Genome Browser utility suite, typically used to dump MySQL
  databases. Note: The provided help text contains only container runtime error messages
  and no usage information.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgsqldump:482--h0b57e2e_0
stdout: ucsc-hgsqldump_hgsqldump.out
