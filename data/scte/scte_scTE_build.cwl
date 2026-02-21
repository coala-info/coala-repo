cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scTE
  - build
label: scte_scTE_build
doc: "The provided text is a system error log indicating a failure to build or fetch
  a container image due to insufficient disk space, rather than the help text for
  the tool itself. As a result, no command-line arguments or tool descriptions could
  be extracted from the input.\n\nTool homepage: https://github.com/JiekaiLab/scTE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scte:1.0.0--pyhdfd78af_0
stdout: scte_scTE_build.out
