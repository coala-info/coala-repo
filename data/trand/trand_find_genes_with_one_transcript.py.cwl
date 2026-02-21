cwlVersion: v1.2
class: CommandLineTool
baseCommand: trand_find_genes_with_one_transcript.py
label: trand_find_genes_with_one_transcript.py
doc: "A tool to find genes with only one transcript. Note: The provided help text
  contains only system error logs regarding container extraction and does not list
  command-line arguments.\n\nTool homepage: https://github.com/McIntyre-Lab/TranD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trand:22.10.13--pyhdfd78af_0
stdout: trand_find_genes_with_one_transcript.py.out
