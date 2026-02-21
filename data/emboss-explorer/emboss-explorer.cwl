cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss-explorer
label: emboss-explorer
doc: "A web-based graphical user interface to the EMBOSS suite of bioinformatics tools.\n
  \nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer.out
