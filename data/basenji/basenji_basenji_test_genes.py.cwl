cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_test_genes.py
label: basenji_basenji_test_genes.py
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a failed container build process (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_test_genes.py.out
