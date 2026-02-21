cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hifive
  - hic-mrheatmap
label: hifive_hic-mrheatmap
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding container image acquisition and disk space.\n\n
  Tool homepage: https://github.com/bxlab/hifive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifive:1.5.7--py27h24bf2e0_0
stdout: hifive_hic-mrheatmap.out
