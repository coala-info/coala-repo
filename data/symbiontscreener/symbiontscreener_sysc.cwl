cwlVersion: v1.2
class: CommandLineTool
baseCommand: symbiontscreener
label: symbiontscreener_sysc
doc: "SymbiontScreener is a tool for screening symbionts. (Note: The provided text
  is an error log from a container build process and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_sysc.out
