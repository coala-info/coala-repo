cwlVersion: v1.2
class: CommandLineTool
baseCommand: hairsplitter_hairsplitter.py
label: hairsplitter_hairsplitter.py
doc: "A tool for processing genomic data (description unavailable due to execution
  error in provided text).\n\nTool homepage: https://github.com/RolandFaure/HairSplitter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hairsplitter:1.9.10--h8b7377a_1
stdout: hairsplitter_hairsplitter.py.out
