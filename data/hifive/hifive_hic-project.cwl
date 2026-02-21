cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifive_hic-project
label: hifive_hic-project
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container execution failure (no
  space left on device).\n\nTool homepage: https://github.com/bxlab/hifive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifive:1.5.7--py27h24bf2e0_0
stdout: hifive_hic-project.out
