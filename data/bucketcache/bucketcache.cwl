cwlVersion: v1.2
class: CommandLineTool
baseCommand: bucketcache
label: bucketcache
doc: "A tool for caching genomic data (Note: The provided text contained error logs
  rather than help documentation, so no arguments could be parsed).\n\nTool homepage:
  https://github.com/RazerM/bucketcache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bucketcache:0.12.0--py36_0
stdout: bucketcache.out
