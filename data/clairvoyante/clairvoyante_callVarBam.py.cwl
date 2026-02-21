cwlVersion: v1.2
class: CommandLineTool
baseCommand: clairvoyante_callVarBam.py
label: clairvoyante_callVarBam.py
doc: "A tool for calling variants from BAM files using Clairvoyante. (Note: The provided
  help text contains only system error logs and no argument definitions.)\n\nTool
  homepage: https://github.com/aquaskyline/Clairvoyante"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
stdout: clairvoyante_callVarBam.py.out
