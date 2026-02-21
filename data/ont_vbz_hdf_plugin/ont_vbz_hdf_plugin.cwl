cwlVersion: v1.2
class: CommandLineTool
baseCommand: ont_vbz_hdf_plugin
label: ont_vbz_hdf_plugin
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/nanoporetech"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont_vbz_hdf_plugin:1.0.12--h66404da_0
stdout: ont_vbz_hdf_plugin.out
