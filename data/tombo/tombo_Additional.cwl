cwlVersion: v1.2
class: CommandLineTool
baseCommand: tombo
label: tombo_Additional
doc: "Tombo is a suite of tools primarily for the identification of modified nucleotides
  from nanopore sequencing data.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: subcommand
    type: string
    doc: 'The tombo subcommand to run. Options include: resquiggle, test_significance,
      write_wiggles, write_most_significant_fasta, plot_max_coverage, plot_genome_location,
      plot_motif_centered, plot_max_difference, plot_most_significant, plot_motif_with_stats,
      plot_per_read, plot_correction, plot_multi_correction, cluster_most_significant,
      plot_kmer, clear_filters, filter_stuck, event_resquiggle, model_resquiggle,
      estimate_kmer_reference, estimate_alt_reference'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
stdout: tombo_Additional.out
