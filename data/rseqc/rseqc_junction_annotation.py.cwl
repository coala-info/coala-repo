cwlVersion: v1.2
class: CommandLineTool
baseCommand: junction_annotation.py
label: rseqc_junction_annotation.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) indicating
  a failure to fetch or build the OCI image.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: rseqc_junction_annotation.py.out
