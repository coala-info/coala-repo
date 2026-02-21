cwlVersion: v1.2
class: CommandLineTool
baseCommand: cityhash
label: cityhash
doc: "CityHash is a family of hash functions for strings.\n\nTool homepage: https://github.com/escherba/python-cityhash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cityhash:0.2.3.post9--py27_0
stdout: cityhash.out
