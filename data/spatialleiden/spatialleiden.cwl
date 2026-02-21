cwlVersion: v1.2
class: CommandLineTool
baseCommand: spatialleiden
label: spatialleiden
doc: "A tool for community detection using the Leiden algorithm, typically applied
  in spatial transcriptomics (Note: The provided text contains container build logs
  rather than tool help text).\n\nTool homepage: https://github.com/HiDiHlabs/SpatialLeiden"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spatialleiden:0.4.0--pyhdfd78af_0
stdout: spatialleiden.out
