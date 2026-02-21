cwlVersion: v1.2
class: CommandLineTool
baseCommand: lighter
label: lighter
doc: "Lighter is a fast and memory-efficient error correction method for Illumina
  reads. (Note: The provided text is a container runtime error log and does not contain
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/mourisl/Lighter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lighter:1.1.3--h077b44d_2
stdout: lighter.out
