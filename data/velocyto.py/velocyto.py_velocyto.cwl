cwlVersion: v1.2
class: CommandLineTool
baseCommand: velocyto
label: velocyto.py_velocyto
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a container execution log showing a fatal error during the image build/fetch
  process.\n\nTool homepage: https://github.com/velocyto-team/velocyto.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velocyto.py:0.17.17--py38h24c8ff8_6
stdout: velocyto.py_velocyto.out
