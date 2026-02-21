cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_join_tables
label: humann2_humann2_join_tables
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
stdout: humann2_humann2_join_tables.out
