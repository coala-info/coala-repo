cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacache-build-refseq
label: metacache_metacache-build-refseq
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system logs and a fatal error regarding disk space during
  a container build process.\n\nTool homepage: https://github.com/muellan/metacache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_metacache-build-refseq.out
