cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-interface-common
label: snakemake-interface-common
doc: "The provided text does not contain help information or usage instructions; it
  is a log output from a container runtime (Apptainer/Singularity) reporting a fatal
  error during an image build process.\n\nTool homepage: https://github.com/snakemake/snakemake-interface-common"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-interface-common:1.22.0--pyhd4c3c12_0
stdout: snakemake-interface-common.out
