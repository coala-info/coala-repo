cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribodiff_main.py
label: ribodiff_main.py
doc: "The provided text does not contain help information or usage instructions for
  ribodiff_main.py. It appears to be a log of a failed container image build/fetch
  process.\n\nTool homepage: https://github.com/ml4bio/RiboDiffusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribodiff:0.2.2--py27_1
stdout: ribodiff_main.py.out
