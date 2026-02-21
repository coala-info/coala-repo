cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_normalize-by-median.py
label: khmer_normalize-by-median.py
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log related to a Singularity/Apptainer environment failure
  (no space left on device).\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_normalize-by-median.py.out
