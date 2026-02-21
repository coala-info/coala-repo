cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - db-info
label: metacache_metacache-db-info
doc: "A tool to display information about a MetaCache database. (Note: The provided
  help text contained only system error logs and no usage information.)\n\nTool homepage:
  https://github.com/muellan/metacache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_metacache-db-info.out
