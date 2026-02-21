cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmash_MakeDNADatabase.py
label: cmash_MakeDNADatabase.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the OCI image due to lack of disk space.\n\nTool
  homepage: https://github.com/dkoslicki/CMash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
stdout: cmash_MakeDNADatabase.py.out
