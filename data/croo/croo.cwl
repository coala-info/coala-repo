cwlVersion: v1.2
class: CommandLineTool
baseCommand: croo
label: croo
doc: "The provided text does not contain help information for the tool 'croo'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the container image due to lack of disk space.\n\n
  Tool homepage: https://github.com/ENCODE-DCC/croo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/croo:0.6.0--pyhdfd78af_0
stdout: croo.out
