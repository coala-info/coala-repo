cwlVersion: v1.2
class: CommandLineTool
baseCommand: beacon2-import
label: beacon2-import
doc: "A tool for importing data into a Beacon v2 search engine. (Note: The provided
  text was an error log and did not contain usage instructions; arguments could not
  be extracted.)\n\nTool homepage: https://pypi.org/project/beacon2-import/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beacon2-import:2.2.4--pyhdfd78af_0
stdout: beacon2-import.out
