cwlVersion: v1.2
class: CommandLineTool
baseCommand: msf-data
label: macsyfinder_msf_data
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
stdout: macsyfinder_msf_data.out
