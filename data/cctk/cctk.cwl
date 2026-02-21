cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk
label: cctk
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/execution error (no
  space left on device).\n\nTool homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
stdout: cctk.out
