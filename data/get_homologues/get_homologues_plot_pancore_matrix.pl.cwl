cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_homologues_plot_pancore_matrix.pl
label: get_homologues_plot_pancore_matrix.pl
doc: "A tool for plotting pan-core matrices from get_homologues output. (Note: The
  provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_homologues_plot_pancore_matrix.pl.out
