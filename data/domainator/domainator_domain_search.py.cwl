cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_domain_search.py
label: domainator_domain_search.py
doc: "A tool for domain searching (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator_domain_search.py.out
