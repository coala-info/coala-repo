cwlVersion: v1.2
class: CommandLineTool
baseCommand: combined-pvalues_comb-p
label: combined-pvalues_comb-p
doc: "Tools for viewing and adjusting p-values in BED files.\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: subcommand
    type: string
    doc: 'One of the following subcommands: acf, slk, fdr, peaks, region_p, filter,
      hist, manhattan, pipeline'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues_comb-p.out
