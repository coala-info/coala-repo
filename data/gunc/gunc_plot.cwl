cwlVersion: v1.2
class: CommandLineTool
baseCommand: gunc_plot
label: gunc_plot
doc: "Plotting tool for GUNC results.\n\nTool homepage: https://github.com/grp-bork/gunc"
inputs:
  - id: contig_display_list
    type:
      - 'null'
      - string
    doc: Comma seperated list of contig names to plot
    inputBinding:
      position: 101
      prefix: --contig_display_list
  - id: contig_display_num
    type:
      - 'null'
      - int
    doc: Number of contigs to visualise. [0 plots all contigs]
    default: 0
    inputBinding:
      position: 101
      prefix: --contig_display_num
  - id: diamond_file
    type: File
    doc: GUNC diamond outputfile.
    inputBinding:
      position: 101
      prefix: --diamond_file
  - id: gunc_gene_count_file
    type:
      - 'null'
      - File
    doc: GUNC gene_counts.json file.
    inputBinding:
      position: 101
      prefix: --gunc_gene_count_file
  - id: remove_minor_clade_level
    type:
      - 'null'
      - string
    doc: Tax level at which to remove minor clades.
    inputBinding:
      position: 101
      prefix: --remove_minor_clade_level
  - id: tax_levels
    type:
      - 'null'
      - string
    doc: Tax levels to display (comma-seperated).
    inputBinding:
      position: 101
      prefix: --tax_levels
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
