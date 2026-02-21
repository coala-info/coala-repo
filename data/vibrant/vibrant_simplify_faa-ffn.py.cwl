cwlVersion: v1.2
class: CommandLineTool
baseCommand: vibrant_simplify_faa-ffn.py
label: vibrant_simplify_faa-ffn.py
doc: "A tool to simplify FAA and FFN files. (Note: The provided text contains container
  runtime logs and error messages rather than the tool's help documentation, so no
  arguments could be extracted.)\n\nTool homepage: https://github.com/AnantharamanLab/VIBRANT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vibrant:1.2.1--hdfd78af_4
stdout: vibrant_simplify_faa-ffn.py.out
