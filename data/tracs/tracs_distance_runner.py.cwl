cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_distance_runner.py
label: tracs_distance_runner.py
doc: "A tool from the TRACS (Tool for Retrospective Analysis of Critical Systems)
  suite. Note: The provided text is an error log regarding a container build failure
  ('no space left on device') and does not contain help documentation or argument
  definitions.\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs_distance_runner.py.out
