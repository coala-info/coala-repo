cwlVersion: v1.2
class: CommandLineTool
baseCommand: transindel_transIndel_build_DNA.py
label: transindel_transIndel_build_DNA.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains error logs related to a failed Singularity/Apptainer container
  build process.\n\nTool homepage: https://github.com/cauyrd/transIndel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transindel:2.0--hdfd78af_0
stdout: transindel_transIndel_build_DNA.py.out
