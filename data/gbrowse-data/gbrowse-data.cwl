cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbrowse-data
label: gbrowse-data
doc: "A tool for managing or providing data for the Generic Genome Browser (GBrowse).
  Note: The provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://www.gnu.org/software/sed/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gbrowse-data:v2.56dfsg-4-deb_cv1
stdout: gbrowse-data.out
