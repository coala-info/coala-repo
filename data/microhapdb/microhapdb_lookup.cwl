cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - microhapdb
  - lookup
label: microhapdb_lookup
doc: "Retrieve marker or population records by name or identifier\n\nTool homepage: https://github.com/bioforensics/MicroHapDB/"
inputs:
  - id: id
    type: string
    doc: Record identifier (marker name, rsID or population name).
    inputBinding:
      position: 1
outputs:
  - id: result
    type: stdout
    doc: Matching records (standard output).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
stdout: microhapdb_lookup.out
