cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - partition-genomes
label: metacache_metacache-partition-genomes
doc: "Partition genomes for MetaCache (Note: The provided help text contained only
  system error messages and no usage information).\n\nTool homepage: https://github.com/muellan/metacache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_metacache-partition-genomes.out
