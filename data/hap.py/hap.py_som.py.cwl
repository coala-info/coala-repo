cwlVersion: v1.2
class: CommandLineTool
baseCommand: som.py
label: hap.py_som.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/Illumina/hap.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap.py:0.3.15--py27hcb73b3d_0
stdout: hap.py_som.py.out
