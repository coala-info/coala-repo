cwlVersion: v1.2
class: CommandLineTool
baseCommand: hunspell-de-med
label: hunspell-de-med
doc: "German medical dictionary for Hunspell. Note: The provided text contains system
  error messages regarding container image extraction and does not include specific
  CLI usage or argument details.\n\nTool homepage: https://github.com/glutanimate/hunspell-de-med-workaround"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hunspell-de-med:v20160103-3-deb_cv1
stdout: hunspell-de-med.out
