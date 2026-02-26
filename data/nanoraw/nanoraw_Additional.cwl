cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw
label: nanoraw_Additional
doc: "nanoraw: error: invalid choice: 'Additional' (choose from 'genome_resquiggle',
  'plot_max_coverage', 'plot_genome_location', 'plot_motif_centered', 'plot_max_difference',
  'plot_most_significant', 'plot_motif_with_stats', 'plot_correction', 'plot_multi_correction',
  'cluster_most_significant', 'plot_kmer', 'write_most_significant_fasta', 'write_wiggles')\n\
  \nTool homepage: https://github.com/marcus1487/nanoraw"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to execute. Available subcommands: genome_resquiggle, plot_max_coverage,
      plot_genome_location, plot_motif_centered, plot_max_difference, plot_most_significant,
      plot_motif_with_stats, plot_correction, plot_multi_correction, cluster_most_significant,
      plot_kmer, write_most_significant_fasta, write_wiggles'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_Additional.out
