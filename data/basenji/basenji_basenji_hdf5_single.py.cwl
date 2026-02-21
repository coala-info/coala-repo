cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_basenji_hdf5_single.py
label: basenji_basenji_hdf5_single.py
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container build process. No arguments could be extracted.\n\n
  Tool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_hdf5_single.py.out
