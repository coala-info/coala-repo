cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmash_MakeStreamingDNADatabase.py
label: cmash_MakeStreamingDNADatabase.py
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/dkoslicki/CMash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
stdout: cmash_MakeStreamingDNADatabase.py.out
