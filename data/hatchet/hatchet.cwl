cwlVersion: v1.2
class: CommandLineTool
baseCommand: hatchet
label: hatchet
doc: "HATCHet v2.1.0\n\nTool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: command
    type: string
    doc: 'The command to execute. Supported commands: count-reads, count-reads-fw,
      genotype-snps, count-alleles, combine-counts, combine-counts-fw, cluster-bins,
      plot-bins, compute-cn, plot-cn, run, check, download-panel, phase-snps, cluster-bins-gmm,
      plot-cn-1d2d, plot-bins-1d2d'
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet.out
