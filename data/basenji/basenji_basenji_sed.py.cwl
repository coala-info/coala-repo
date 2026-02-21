cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_sed.py
label: basenji_basenji_sed.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log (no space left on device) during a container build process.
  No arguments could be extracted from the provided text.\n\nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_sed.py.out
