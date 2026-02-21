cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinker
label: clinker-py
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  indicating a 'no space left on device' failure during the image build/extraction
  process.\n\nTool homepage: https://github.com/gamcil/clinker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinker-py:0.0.32--pyhdfd78af_0
stdout: clinker-py.out
