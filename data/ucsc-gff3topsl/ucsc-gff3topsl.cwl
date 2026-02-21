cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToPsl
label: ucsc-gff3topsl
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  indicating a failure to fetch or build the OCI image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gff3topsl:482--h0b57e2e_0
stdout: ucsc-gff3topsl.out
