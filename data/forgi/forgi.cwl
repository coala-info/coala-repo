cwlVersion: v1.2
class: CommandLineTool
baseCommand: forgi
label: forgi
doc: "RNA secondary structure manipulation and analysis tool (Note: The provided text
  contains container runtime error messages rather than tool help documentation).\n
  \nTool homepage: http://www.tbi.univie.ac.at/~pkerp/forgi/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/forgi:2.2.3--py310h84f13bb_1
stdout: forgi.out
