cwlVersion: v1.2
class: CommandLineTool
baseCommand: bmge
label: bmge
doc: "Block Mapping and Gathering with Entropy (BMGE). Note: The provided text contains
  system error messages regarding container extraction and does not include the tool's
  help documentation or argument definitions.\n\nTool homepage: https://bioweb.pasteur.fr/packages/pack@BMGE@1.12"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bmge:1.12--hdfd78af_1
stdout: bmge.out
