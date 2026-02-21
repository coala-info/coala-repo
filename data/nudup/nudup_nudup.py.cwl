cwlVersion: v1.2
class: CommandLineTool
baseCommand: nudup.py
label: nudup_nudup.py
doc: "The provided text is an error message indicating a system failure (no space
  left on device) while attempting to run the tool via a container. No help text or
  argument information was available in the input to parse.\n\nTool homepage: http://nugentechnologies.github.io/nudup/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nudup:2.3.3--py27_0
stdout: nudup_nudup.py.out
