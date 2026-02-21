cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosextract
label: emboss-explorer_prosextract
doc: "Build the PROSITE motif database for use by pscan. Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-explorer:v2.2.0-10-deb_cv1
stdout: emboss-explorer_prosextract.out
