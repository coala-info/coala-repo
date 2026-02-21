cwlVersion: v1.2
class: CommandLineTool
baseCommand: pykofamsearch_reformat_pykofamsearch
label: pykofamsearch_reformat_pykofamsearch
doc: "A tool for reformatting pykofamsearch results. (Note: The provided help text
  contains only container runtime logs and a fatal error, so no specific arguments
  could be extracted.)\n\nTool homepage: https://github.com/jolespin/pykofamsearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
stdout: pykofamsearch_reformat_pykofamsearch.out
