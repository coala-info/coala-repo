cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalamari_buildTaxonomy.sh
label: kalamari_buildTaxonomy.sh
doc: "Build taxonomy for Kalamari (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/lskatz/kalamari"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalamari:5.8.0--pl5321hdfd78af_0
stdout: kalamari_buildTaxonomy.sh.out
