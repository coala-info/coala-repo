cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge-seq
label: rsat-core_purge-seq
doc: "The provided text does not contain help information or documentation for the
  tool; it is a fatal error log from a container runtime (Apptainer/Singularity) failing
  to pull the image.\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_purge-seq.out
