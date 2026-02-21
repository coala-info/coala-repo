cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqsero_SeqSero2_package.py
label: seqsero_SeqSero2_package.py
doc: "SeqSero2: Salmonella serotyping from genome sequencing data (Note: The provided
  text contained only system error logs and no help documentation to parse arguments
  from).\n\nTool homepage: https://github.com/denglab/SeqSero2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqsero:v1.0.1dfsg-1-deb_cv1
stdout: seqsero_SeqSero2_package.py.out
