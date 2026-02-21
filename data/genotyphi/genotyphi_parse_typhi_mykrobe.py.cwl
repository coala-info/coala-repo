cwlVersion: v1.2
class: CommandLineTool
baseCommand: genotyphi_parse_typhi_mykrobe.py
label: genotyphi_parse_typhi_mykrobe.py
doc: "A tool to parse Mykrobe results for Genotyphi (Note: The provided text contains
  container runtime errors rather than help documentation, so arguments could not
  be extracted).\n\nTool homepage: https://github.com/katholt/genotyphi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genotyphi:2.0--hdfd78af_1
stdout: genotyphi_parse_typhi_mykrobe.py.out
