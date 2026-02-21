cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfx
  - VCFX_ld_calculator
label: vcfx_VCFX_ld_calculator
doc: "The provided text does not contain help information for the tool. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: https://github.com/ieeta-pt/VCFX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfx:1.1.4--py312h3a3ee5b_0
stdout: vcfx_VCFX_ld_calculator.out
