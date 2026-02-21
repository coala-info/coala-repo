cwlVersion: v1.2
class: CommandLineTool
baseCommand: symbiontscreener
label: symbiontscreener
doc: "A tool for screening symbionts. (Note: The provided text is a container build
  error log and does not contain usage instructions or argument definitions.)\n\n
  Tool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener.out
