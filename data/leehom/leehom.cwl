cwlVersion: v1.2
class: CommandLineTool
baseCommand: leehom
label: leehom
doc: "Leehom is a tool for the Bayesian reconstruction of ancient DNA fragments, including
  adapter trimming and merging of paired-end reads.\n\nTool homepage: https://grenaud.github.io/leeHom/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leehom:1.2.15--hdc46a4b_6
stdout: leehom.out
