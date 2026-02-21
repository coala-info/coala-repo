cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalamari_filterTaxonomy.sh
label: kalamari_filterTaxonomy.sh
doc: "A tool for filtering taxonomy (Note: The provided text contains system error
  logs regarding container execution and does not include actual help or usage information).\n
  \nTool homepage: https://github.com/lskatz/kalamari"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalamari:5.8.0--pl5321hdfd78af_0
stdout: kalamari_filterTaxonomy.sh.out
