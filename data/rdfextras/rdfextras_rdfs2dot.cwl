cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdfextras_rdfs2dot
label: rdfextras_rdfs2dot
doc: "A tool to convert RDFS (Resource Description Framework Schema) files to DOT
  format for visualization with Graphviz.\n\nTool homepage: https://github.com/RDFLib/rdfextras"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_rdfs2dot.out
