cwlVersion: v1.2
class: CommandLineTool
baseCommand: biscuit
label: biscuit_algorithm
doc: "BISulfite-seq CUI Toolkit (BISCUIT) for bisulfite-seq data analysis, including
  mapping, BAM operations, base summary, and epiread manipulation.\n\nTool homepage:
  https://github.com/huishenlab/biscuit"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute. Valid commands include: index, align, tview,
      bsstrand, bsconv, cinread, pileup, vcf2bed, mergecg, epiread, rectangle, asm,
      version, help, qc, qc_coverage, bc.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
stdout: biscuit_algorithm.out
