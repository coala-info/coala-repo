cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacache build+query
label: metacache_build+query
doc: "Builds and queries a sequence cache.\n\nTool homepage: https://github.com/muellan/metacache"
inputs:
  - id: query
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence file or directory for queries
    inputBinding:
      position: 101
      prefix: --query
  - id: targets
    type:
      type: array
      items: File
    doc: Sequence file or directory for targets
    inputBinding:
      position: 101
      prefix: --targets
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_build+query.out
