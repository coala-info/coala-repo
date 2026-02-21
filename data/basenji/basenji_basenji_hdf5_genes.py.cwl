cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_hdf5_genes.py
label: basenji_basenji_hdf5_genes.py
doc: "A tool within the Basenji suite, likely used for processing gene data into HDF5
  format. (Note: The provided help text contains system error logs regarding a failed
  container build and does not list command-line arguments.)\n\nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_hdf5_genes.py.out
