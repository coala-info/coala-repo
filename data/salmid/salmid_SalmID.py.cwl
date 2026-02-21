cwlVersion: v1.2
class: CommandLineTool
baseCommand: salmid_SalmID.py
label: salmid_SalmID.py
doc: "The provided text is a container runtime error log and does not contain help
  documentation for the tool. SalmID is typically used for rapid confirmation of Salmonella
  species from genomic data.\n\nTool homepage: https://github.com/hcdenbakker/SalmID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/salmid:v0.1.23-1-deb_cv1
stdout: salmid_SalmID.py.out
