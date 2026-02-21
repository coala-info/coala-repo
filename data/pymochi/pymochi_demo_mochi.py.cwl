cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymochi_demo_mochi.py
label: pymochi_demo_mochi.py
doc: "The provided text does not contain help information or a description for the
  tool; it appears to be a log of a failed container build/fetch operation.\n\nTool
  homepage: https://github.com/lehner-lab/MoCHI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymochi:1.1--pyhdfd78af_0
stdout: pymochi_demo_mochi.py.out
