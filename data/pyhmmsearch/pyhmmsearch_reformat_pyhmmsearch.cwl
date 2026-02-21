cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyhmmsearch
  - reformat
label: pyhmmsearch_reformat_pyhmmsearch
doc: "Reformat pyhmmsearch output (Note: The provided help text contains only container
  runtime logs and no usage information.)\n\nTool homepage: https://github.com/new-atlantis-labs/pyhmmsearch-stable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
stdout: pyhmmsearch_reformat_pyhmmsearch.out
