cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastdup
label: fastdup
doc: "The provided text contains system log messages and a fatal error regarding a
  container runtime (Apptainer/Singularity) failure, rather than the tool's help documentation.
  No command-line arguments or tool descriptions were found in the input.\n\nTool
  homepage: https://github.com/zzhofict/FastDup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastdup:1.0.0--hc033996_0
stdout: fastdup.out
