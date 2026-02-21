cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapless_gapless.sh
label: gapless_gapless.sh
doc: "A tool for gapless assembly (scaffolding/finishing). Note: The provided help
  text contains only system error messages and no usage information.\n\nTool homepage:
  https://github.com/schmeing/gapless"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
stdout: gapless_gapless.sh.out
