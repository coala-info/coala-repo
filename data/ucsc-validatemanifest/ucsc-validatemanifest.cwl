cwlVersion: v1.2
class: CommandLineTool
baseCommand: validateManifest
label: ucsc-validatemanifest
doc: "A tool to validate manifest files, typically used in the context of UCSC Genome
  Browser data submissions.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-validatemanifest:482--h0b57e2e_0
stdout: ucsc-validatemanifest.out
