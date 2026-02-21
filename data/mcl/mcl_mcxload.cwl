cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcxload
label: mcl_mcxload
doc: "The provided text is an error log and does not contain help information. mcxload
  is typically used to read label data and transform it into a native matrix file
  for MCL.\n\nTool homepage: https://micans.org/mcl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcl:22.282--pl5321h7b50bb2_4
stdout: mcl_mcxload.out
