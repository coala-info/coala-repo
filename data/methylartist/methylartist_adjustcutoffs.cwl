cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - adjustcutoffs
label: methylartist_adjustcutoffs
doc: "Adjust methylation cutoffs in a methylartist database\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: db
    type: File
    doc: methylartist database
    inputBinding:
      position: 101
      prefix: --db
  - id: methylated
    type: float
    doc: mark as methylated above cutoff value
    inputBinding:
      position: 101
      prefix: --methylated
  - id: mod
    type: string
    doc: modification to plot (will list for user if incorrect)
    inputBinding:
      position: 101
      prefix: --mod
  - id: unmethylated
    type: float
    doc: mark as unmethylated below cutoff value
    inputBinding:
      position: 101
      prefix: --unmethylated
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
stdout: methylartist_adjustcutoffs.out
