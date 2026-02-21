cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-dists
label: snp-dists
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: https://github.com/tseemann/snp-dists"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-dists:1.2.0--h577a1d6_0
stdout: snp-dists.out
