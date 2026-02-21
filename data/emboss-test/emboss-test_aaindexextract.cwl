cwlVersion: v1.2
class: CommandLineTool
baseCommand: aaindexextract
label: emboss-test_aaindexextract
doc: "Extract data from AAindex\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-test:v6.6.0dfsg-7-deb_cv1
stdout: emboss-test_aaindexextract.out
