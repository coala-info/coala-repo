cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hormon
  - monomer_inference
label: hormon_monomer_inference
doc: "A tool for monomer inference (Note: The provided text is a system error log
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/ablab/HORmon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hormon:1.0.0--pyhdfd78af_0
stdout: hormon_monomer_inference.out
