cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem
label: refinem
doc: "RefineM is a set of tools for improving metagenome-assembled genomes (MAGs).
  Note: The provided text contains container build logs and error messages rather
  than the tool's help documentation.\n\nTool homepage: http://pypi.python.org/pypi/refinem/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
stdout: refinem.out
