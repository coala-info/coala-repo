cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgsql
label: ucsc-hggoldgapgl_hgsql
doc: "The provided text is a container execution error log and does not contain help
  information for the tool.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hggoldgapgl:377--h199ee4e_0
stdout: ucsc-hggoldgapgl_hgsql.out
