cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequana_variant_calling
label: sequana_sequana_variant_calling
doc: "A variant calling pipeline from the Sequana framework. (Note: The provided input
  text was a system error log regarding container extraction and did not contain command-line
  argument definitions.)\n\nTool homepage: https://sequana.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana:0.19.6--pyhdfd78af_0
stdout: sequana_sequana_variant_calling.out
