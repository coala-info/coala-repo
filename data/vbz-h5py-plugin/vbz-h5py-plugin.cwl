cwlVersion: v1.2
class: CommandLineTool
baseCommand: vbz-h5py-plugin
label: vbz-h5py-plugin
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains log messages and a fatal error related to a container build
  process.\n\nTool homepage: https://github.com/nanoporetech/vbz-h5py-plugin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vbz-h5py-plugin:1.0.1--pyhdfd78af_0
stdout: vbz-h5py-plugin.out
