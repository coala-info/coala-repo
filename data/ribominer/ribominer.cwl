cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribominer
label: ribominer
doc: "Ribosome profiling data analysis toolset (Note: The provided text contains container
  build logs and a fatal error rather than command-line help documentation).\n\nTool
  homepage: https://github.com/xryanglab/RiboMiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribominer:0.2.3.2--pyh5e36f6f_0
stdout: ribominer.out
