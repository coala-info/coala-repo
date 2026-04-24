cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper stats
label: hybpiper_stats
doc: "Sequence type (gene or supercontig) to recover lengths for.\n\nTool homepage:
  https://github.com/mossmatters/HybPiper"
inputs:
  - id: sequence_type
    type: string
    doc: Sequence type (gene or supercontig) to recover lengths for.
    inputBinding:
      position: 1
  - id: namelist
    type: File
    doc: Text file with names of HybPiper output directories, one per line.
    inputBinding:
      position: 2
  - id: cpu
    type:
      - 'null'
      - int
    doc: Limit the number of CPUs.
    inputBinding:
      position: 103
      prefix: --cpu
  - id: figure_height
    type:
      - 'null'
      - int
    doc: Height dimension (in inches) for the output heatmap file.
    inputBinding:
      position: 103
      prefix: --figure_height
  - id: figure_length
    type:
      - 'null'
      - int
    doc: Length dimension (in inches) for the output heatmap file.
    inputBinding:
      position: 103
      prefix: --figure_length
  - id: gene_read_counts_filename
    type:
      - 'null'
      - File
    doc: File name for the gene read counts *.tsv file.
    inputBinding:
      position: 103
      prefix: --gene_read_counts_filename
  - id: gene_text_size
    type:
      - 'null'
      - int
    doc: Size (in points) for the gene text labels in the output heatmap file.
    inputBinding:
      position: 103
      prefix: --gene_text_size
  - id: heatmap_dpi
    type:
      - 'null'
      - int
    doc: Dots per inch (DPI) for the output heatmap image.
    inputBinding:
      position: 103
      prefix: --heatmap_dpi
  - id: heatmap_filename
    type:
      - 'null'
      - File
    doc: Filename for the output heatmap, saved by default as a *.png file.
    inputBinding:
      position: 103
      prefix: --heatmap_filename
  - id: heatmap_filetype
    type:
      - 'null'
      - string
    doc: File type to save the output heatmap image as.
    inputBinding:
      position: 103
      prefix: --heatmap_filetype
  - id: hybpiper_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory containing HybPiper output sample folders.
    inputBinding:
      position: 103
      prefix: --hybpiper_dir
  - id: no_heatmap
    type:
      - 'null'
      - boolean
    doc: If supplied, do not create a gene read counts heatmap.
    inputBinding:
      position: 103
      prefix: --no_heatmap
  - id: no_xlabels
    type:
      - 'null'
      - boolean
    doc: If supplied, do not render labels for x-axis (loci) in the saved 
      heatmap figure.
    inputBinding:
      position: 103
      prefix: --no_xlabels
  - id: no_ylabels
    type:
      - 'null'
      - boolean
    doc: If supplied, do not render labels for y-axis (samples) in the saved 
      heatmap figure.
    inputBinding:
      position: 103
      prefix: --no_ylabels
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: If supplied, run the subcommand using cProfile. Saves a *.csv file of 
      results
    inputBinding:
      position: 103
      prefix: --run_profiler
  - id: sample_text_size
    type:
      - 'null'
      - int
    doc: Size (in points) for the sample text labels in the output heatmap file.
    inputBinding:
      position: 103
      prefix: --sample_text_size
  - id: seq_lengths_filename
    type:
      - 'null'
      - File
    doc: File name for the sequence lengths *.tsv file.
    inputBinding:
      position: 103
      prefix: --seq_lengths_filename
  - id: stats_filename
    type:
      - 'null'
      - File
    doc: File name for the stats *.tsv file.
    inputBinding:
      position: 103
      prefix: --stats_filename
  - id: targetfile_aa
    type: File
    doc: 'FASTA file containing amino-acid target sequences for each gene. The fasta
      headers must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 103
      prefix: --targetfile_aa
  - id: targetfile_dna
    type: File
    doc: 'FASTA file containing DNA target sequences for each gene. The fasta headers
      must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 103
      prefix: --targetfile_dna
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_stats.out
