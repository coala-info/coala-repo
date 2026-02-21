cwlVersion: v1.2
class: CommandLineTool
baseCommand: goatools_find_enrichment.py
label: goatools_find_enrichment.py
doc: "Find enrichment of GO terms. (Note: The provided text appears to be a system
  error log regarding container execution and does not contain the tool's help documentation
  or argument list.)\n\nTool homepage: https://github.com/tanghaibao/goatools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goatools:1.2.3--pyh7cba7a3_2
stdout: goatools_find_enrichment.py.out
