cwlVersion: v1.2
class: CommandLineTool
baseCommand: hap.py_pre.py
label: hap.py_pre.py
doc: "Preprocessing script for hap.py. (Note: The provided text is an error log and
  does not contain usage or help information.)\n\nTool homepage: https://github.com/Illumina/hap.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap.py:0.3.15--py27hcb73b3d_0
stdout: hap.py_pre.py.out
