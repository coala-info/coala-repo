cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbmltoolbox
label: sbmltoolbox
doc: "SBMLToolbox (Note: The provided text is a container runtime error log and does
  not contain help documentation or argument definitions).\n\nTool homepage: https://github.com/sbmlteam/SBMLToolbox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sbmltoolbox:v4.1.0-4-deb_cv1
stdout: sbmltoolbox.out
