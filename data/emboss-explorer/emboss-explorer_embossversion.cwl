cwlVersion: v1.2
class: CommandLineTool
baseCommand: embossversion
label: emboss-explorer_embossversion
doc: "Report EMBOSS version number\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer_embossversion.out
