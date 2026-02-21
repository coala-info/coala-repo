cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smudgeplot
  - rn_smudge_pairs
label: smudgeplot_rn_smudge_pairs
doc: "A subcommand of smudgeplot (Note: The provided text contains container runtime
  logs and an error message rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/RNieuwenhuis/smudgeplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_rn_smudge_pairs.out
