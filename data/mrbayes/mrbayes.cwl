cwlVersion: v1.2
class: CommandLineTool
baseCommand: mb
label: mrbayes
doc: "MrBayes is a program for Bayesian inference and model selection across a wide
  spectrum of phylogenetic and evolutionary models.\n\nTool homepage: http://mrbayes.sourceforge.net"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Nexus file containing the data and MrBayes blocks
    inputBinding:
      position: 1
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Force interactive mode
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: parameter_samples
    type:
      type: array
      items: File
    doc: Sampled parameter values of each run (<input>.run*.p)
    outputBinding:
      glob: '*.p'
  - id: tree_samples
    type:
      type: array
      items: File
    doc: Sampled trees of each run (<input>.run*.t)
    outputBinding:
      glob: '*.t'
  - id: mcmc_diagnostics
    type:
      - 'null'
      - File
    doc: MCMC diagnostics file (<input>.mcmc)
    outputBinding:
      glob: '*.mcmc'
  - id: consensus_tree
    type:
      - 'null'
      - File
    doc: Consensus tree file (<input>.con.tre)
    outputBinding:
      glob: '*.con.tre'
  - id: summary_files
    type:
      type: array
      items: File
    doc: Other result files such as .trprobs, .tstat, .vstat, .parts, .ckp
    outputBinding:
      glob: ['*.trprobs', '*.tstat', '*.vstat', '*.parts', '*.ckp']
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrbayes:3.2.7--hd0d793b_7
stdout: mrbayes.out
