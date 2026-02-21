cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqboot
label: phylip_seqboot
doc: "A general bootstrapping and data-set resampling program from the PHYLIP (Phylogeny
  Inference Package) suite. Note: The provided text appears to be a container engine
  error log rather than the tool's help output, so no arguments could be extracted.\n
  \nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_seqboot.out
