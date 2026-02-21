cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hifive
  - quasar-replicate
label: hifive_quasar-replicate
doc: "HiFive Quasar replicate analysis tool. (Note: The provided text contains container
  runtime error logs rather than help text; no arguments could be extracted from the
  input.)\n\nTool homepage: https://github.com/bxlab/hifive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifive:1.5.7--py27h24bf2e0_0
stdout: hifive_quasar-replicate.out
