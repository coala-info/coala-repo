cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakentools_combine_kreports.py
label: krakentools_combine_kreports.py
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  indicating a 'no space left on device' error during image construction.\n\nTool
  homepage: https://github.com/jenniferlu717/KrakenTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
stdout: krakentools_combine_kreports.py.out
