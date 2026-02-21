cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysam
  - tabix
label: pysam_tabix
doc: "The provided text does not contain help information or usage instructions for
  the tool; it appears to be a container build log indicating a failure to fetch an
  OCI image.\n\nTool homepage: https://github.com/pysam-developers/pysam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysam:0.23.3--py39hdd5828d_1
stdout: pysam_tabix.out
