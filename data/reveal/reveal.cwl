cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal
label: reveal
doc: "A graph-based multi-genome alignment and analysis tool (Note: The provided text
  was a container build log and did not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/hakimel/reveal.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal.out
