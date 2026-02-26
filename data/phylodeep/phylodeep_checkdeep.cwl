cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkdeep
label: phylodeep_checkdeep
doc: "A priori model adequacy check of phylogenetic trees for phylodynamic models.
  Recommended to perform before selecting phylodynamic models and estimating parameters.\n\
  \nTool homepage: https://github.com/evolbioinfo/phylodeep"
inputs:
  - id: model
    type: string
    doc: Choose one of the models for the a priori check. For trees of size, 
      between 50 and 199 tips you can choose either BD (constant-rate 
      birth-death with incomplete sampling), or BDEI (BD with exposed-infectious
      class). For trees of size >= 200 tips, you can choose between BD, BDEI and
      BDSS (BD with superspreading).
    inputBinding:
      position: 101
      prefix: --model
  - id: tree_file
    type: File
    doc: input tree in newick format (must be rooted, without polytomies and 
      containing at least 50 tips).
    inputBinding:
      position: 101
      prefix: --tree_file
outputs:
  - id: outputfile_png
    type: File
    doc: The name of the output file (in png format).
    outputBinding:
      glob: $(inputs.outputfile_png)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
