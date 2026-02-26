cwlVersion: v1.2
class: CommandLineTool
baseCommand: SUPPA
label: suppa_suppa.py
doc: "SUPPA allows you to generate all the possible Alternative Splicing events from
  an annotation file, calculate the PSI values per event, calculate differential splicing
  across multiple conditions with replicates, and cluster events across conditions\n\
  \nTool homepage: https://github.com/comprna/SUPPA"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run. Available subcommands: generateEvents, psiPerEvent, psiPerIsoform,
      diffSplice, clusterEvents, joinFiles'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
stdout: suppa_suppa.py.out
