cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapsolo_preprocessfasta.py
label: hapsolo_preprocessfasta.py
doc: "A script to preprocess FASTA files for use with HapSolo. (Note: The provided
  text contains container runtime error logs and does not include the actual help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/esolares/HapSolo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapsolo:2021.10.09--py27hdfd78af_0
stdout: hapsolo_preprocessfasta.py.out
