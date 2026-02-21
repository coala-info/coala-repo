cwlVersion: v1.2
class: CommandLineTool
baseCommand: faithpd
label: unifrac-binaries_faithpd
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the OCI image.\n\nTool homepage: https://github.com/biocore/unifrac-binaries"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac-binaries:1.6--h9d55e78_0
stdout: unifrac-binaries_faithpd.out
