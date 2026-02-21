cwlVersion: v1.2
class: CommandLineTool
baseCommand: var-agg
label: var-agg
doc: "Variant Aggregator (Note: The provided text appears to be a container build
  log rather than help text; no arguments could be extracted from the input).\n\n
  Tool homepage: https://github.com/bihealth/var-agg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/var-agg:0.1.1--h2c42bab_0
stdout: var-agg.out
