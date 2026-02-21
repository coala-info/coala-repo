cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-refinement_bin_refinement.sh
label: metawrap-refinement_bin_refinement.sh
doc: "A tool for bin refinement within the metaWRAP pipeline. Note: The provided help
  text contains only system error messages and no usage information.\n\nTool homepage:
  https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-refinement:1.3.0--hdfd78af_3
stdout: metawrap-refinement_bin_refinement.sh.out
