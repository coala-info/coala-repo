cwlVersion: v1.2
class: CommandLineTool
baseCommand: embossversion
label: emboss-lib_embossversion
doc: "Report the current EMBOSS version number\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-lib:v6.6.0dfsg-6-deb_cv1
stdout: emboss-lib_embossversion.out
