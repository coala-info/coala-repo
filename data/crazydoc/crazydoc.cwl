cwlVersion: v1.2
class: CommandLineTool
baseCommand: crazydoc
label: crazydoc
doc: "A tool for identifying and correcting common errors in GenBank files.\n\nTool
  homepage: https://github.com/Edinburgh-Genome-Foundry/crazydoc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crazydoc:0.2.2--pyh7e72e81_0
stdout: crazydoc.out
