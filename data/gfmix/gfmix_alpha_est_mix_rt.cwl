cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfmix_alpha_est_mix_rt
label: gfmix_alpha_est_mix_rt
doc: "gfmix_alpha_est_mix_rt\n\nTool homepage: https://www.mathstat.dal.ca/~tsusko/doc/gfmix.pdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfmix:1.0.2--h503566f_3
stdout: gfmix_alpha_est_mix_rt.out
