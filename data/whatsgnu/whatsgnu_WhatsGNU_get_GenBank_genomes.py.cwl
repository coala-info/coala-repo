cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatsgnu_WhatsGNU_get_GenBank_genomes.py
label: whatsgnu_WhatsGNU_get_GenBank_genomes.py
doc: "A tool to retrieve GenBank genomes (Note: The provided text contains execution
  logs and error messages rather than help documentation, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
stdout: whatsgnu_WhatsGNU_get_GenBank_genomes.py.out
