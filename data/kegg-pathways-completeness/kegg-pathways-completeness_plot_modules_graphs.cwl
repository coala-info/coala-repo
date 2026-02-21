cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kegg-pathways-completeness
  - plot_modules_graphs
label: kegg-pathways-completeness_plot_modules_graphs
doc: "Plot KEGG modules graphs for pathway completeness. (Note: The provided help
  text contains only container runtime error messages and no usage information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegg-pathways-completeness:1.3.0--pyhdfd78af_0
stdout: kegg-pathways-completeness_plot_modules_graphs.out
