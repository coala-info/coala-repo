cwlVersion: v1.2
class: CommandLineTool
baseCommand: vgorient_kmer_rotation_multiprocessing.py
label: vgorient_kmer_rotation_multiprocessing.py
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to fetch
  or build the OCI image.\n\nTool homepage: https://github.com/whelixw/vgOrient"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
stdout: vgorient_kmer_rotation_multiprocessing.py.out
