cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot_rn_kmc
label: smudgeplot_rn_kmc
doc: "Smudgeplot: Inference of ploidy and heterozygosity from whole genome sequencing
  data. (Note: The provided text contains container runtime errors and does not include
  usage instructions or argument definitions.)\n\nTool homepage: https://github.com/RNieuwenhuis/smudgeplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_rn_kmc.out
