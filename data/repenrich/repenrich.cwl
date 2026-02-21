cwlVersion: v1.2
class: CommandLineTool
baseCommand: repenrich
label: repenrich
doc: "RepEnrich is a tool for repetitive element enrichment analysis. (Note: The provided
  input text was a container build error log and did not contain CLI help information.)\n
  \nTool homepage: https://github.com/nskvir/RepEnrich"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repenrich:1.2--py27_1
stdout: repenrich.out
