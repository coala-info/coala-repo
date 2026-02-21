cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepnano-data
label: deepnano-data
doc: "Data tool for DeepNano (Oxford Nanopore basecaller). Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/ddd9898/DeepNano-data"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/deepnano-data:v0.0git20170813.e8a621e-3-deb_cv1
stdout: deepnano-data.out
