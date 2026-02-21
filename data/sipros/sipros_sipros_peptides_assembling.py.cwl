cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_sipros_peptides_assembling.py
label: sipros_sipros_peptides_assembling.py
doc: "Sipros peptides assembling tool. (Note: The provided help text contains only
  system logs and error messages; no argument definitions were found.)\n\nTool homepage:
  https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_sipros_peptides_assembling.py.out
