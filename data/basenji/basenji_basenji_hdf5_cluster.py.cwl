cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_basenji_hdf5_cluster.py
label: basenji_basenji_hdf5_cluster.py
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_hdf5_cluster.py.out
