cwlVersion: v1.2
class: CommandLineTool
baseCommand: svdb
label: svdb
doc: "The provided text does not contain help information for the tool 'svdb'. It
  appears to be an error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the image.\n\nTool homepage: https://github.com/J35P312/SVDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdb:2.8.3--py39hff726c5_0
stdout: svdb.out
