cwlVersion: v1.2
class: CommandLineTool
baseCommand: symbiontscreener_sysc_strobmer_mode.sh
label: symbiontscreener_sysc_strobmer_mode.sh
doc: "A tool for symbiont screening using strobemer mode. (Note: The provided help
  text contains container runtime logs and error messages rather than command usage
  instructions.)\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_sysc_strobmer_mode.sh.out
