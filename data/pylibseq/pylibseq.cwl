cwlVersion: v1.2
class: CommandLineTool
baseCommand: pylibseq
label: pylibseq
doc: "The provided text does not contain help information for the tool; it contains
  container runtime (Apptainer/Singularity) error logs regarding a failure to fetch
  the OCI image.\n\nTool homepage: http://pypi.python.org/pypi/pylibseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pylibseq:0.2.3--py39h4994899_8
stdout: pylibseq.out
