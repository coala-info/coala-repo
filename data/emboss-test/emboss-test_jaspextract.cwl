cwlVersion: v1.2
class: CommandLineTool
baseCommand: jaspextract
label: emboss-test_jaspextract
doc: "Extract data from JASPAR. (Note: The provided help text contains system error
  messages regarding container execution and does not list command-line arguments.)\n
  \nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-test:v6.6.0dfsg-7-deb_cv1
stdout: emboss-test_jaspextract.out
