cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_vsnp_path_adder.py
label: vsnp_vsnp_path_adder.py
doc: "A tool associated with the vSNP pipeline. Note: The provided text is a container
  build error log and does not contain the actual help documentation or usage instructions
  for the tool.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_path_adder.py.out
