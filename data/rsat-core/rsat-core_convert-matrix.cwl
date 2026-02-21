cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert-matrix
label: rsat-core_convert-matrix
doc: "The provided text does not contain help information for the tool. It contains
  container engine (Singularity/Apptainer) log messages indicating a failure to fetch
  the OCI image.\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_convert-matrix.out
