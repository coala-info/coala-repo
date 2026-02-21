cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwama
label: gwama
doc: "Genome-Wide Association Meta-Analysis (GWAMA) software for performing meta-analysis
  of genome-wide association studies.\n\nTool homepage: https://www.geenivaramu.ee/en/tools/gwama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gwama:2.2.2--h077b44d_5
stdout: gwama.out
