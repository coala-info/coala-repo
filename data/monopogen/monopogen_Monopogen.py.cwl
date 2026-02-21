cwlVersion: v1.2
class: CommandLineTool
baseCommand: Monopogen.py
label: monopogen_Monopogen.py
doc: "Monopogen is a tool for germline variant calling and lineage tracing from single-cell
  sequencing data.\n\nTool homepage: https://github.com/KChen-lab/Monopogen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monopogen:1.6.0--pyhdfd78af_0
stdout: monopogen_Monopogen.py.out
