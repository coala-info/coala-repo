cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper paralog_retriever
label: hybpiper_paralog_retriever
doc: "Extracts paralogous genes from HybPiper output.\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs:
  - id: namelist
    type: File
    doc: Text file containing list of HybPiper output directories, one per line.
    inputBinding:
      position: 1
  - id: cpu
    type:
      - 'null'
      - int
    doc: Limit the number of CPUs. Default is to use all cores available minus 
      one.
    inputBinding:
      position: 102
      prefix: --cpu
  - id: fasta_dir_all
    type:
      - 'null'
      - Directory
    doc: Specify directory for output FASTA files (ALL).
    default: paralogs_all
    inputBinding:
      position: 102
      prefix: --fasta_dir_all
  - id: fasta_dir_no_chimeras
    type:
      - 'null'
      - Directory
    doc: Specify directory for output FASTA files (no putative chimeric 
      sequences).
    default: paralogs_no_chimeras
    inputBinding:
      position: 102
      prefix: --fasta_dir_no_chimeras
  - id: figure_height
    type:
      - 'null'
      - int
    doc: Height dimension (in inches) for the output heatmap file. Default is 
      automatically calculated based on the number of samples.
    inputBinding:
      position: 102
      prefix: --figure_height
  - id: figure_length
    type:
      - 'null'
      - int
    doc: Length dimension (in inches) for the output heatmap file. Default is 
      automatically calculated based on the number of genes.
    inputBinding:
      position: 102
      prefix: --figure_length
  - id: gene_text_size
    type:
      - 'null'
      - int
    doc: Size (in points) for the gene text labels in the output heatmap file. 
      Default is automatically calculated based on the number of genes.
    inputBinding:
      position: 102
      prefix: --gene_text_size
  - id: heatmap_dpi
    type:
      - 'null'
      - int
    doc: 'Dots per inch (DPI) for the output heatmap image. Default is: 100.'
    default: 100
    inputBinding:
      position: 102
      prefix: --heatmap_dpi
  - id: heatmap_filename
    type:
      - 'null'
      - string
    doc: Filename for the output heatmap, saved by default as a *.png file.
    default: paralog_heatmap
    inputBinding:
      position: 102
      prefix: --heatmap_filename
  - id: heatmap_filetype
    type:
      - 'null'
      - string
    doc: 'File type to save the output heatmap image as. Default is: png.'
    default: png
    inputBinding:
      position: 102
      prefix: --heatmap_filetype
  - id: hybpiper_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory containing HybPiper output sample folders. Default is
      the current working directory.
    default: .
    inputBinding:
      position: 102
      prefix: --hybpiper_dir
  - id: no_heatmap
    type:
      - 'null'
      - boolean
    doc: 'If supplied, do not create a heatmap figure. Default is: False.'
    default: false
    inputBinding:
      position: 102
      prefix: --no_heatmap
  - id: no_xlabels
    type:
      - 'null'
      - boolean
    doc: 'If supplied, do not render labels for x-axis (loci) in the saved heatmap
      figure. Default is: False.'
    default: false
    inputBinding:
      position: 102
      prefix: --no_xlabels
  - id: no_ylabels
    type:
      - 'null'
      - boolean
    doc: 'If supplied, do not render labels for y-axis (samples) in the saved heatmap
      figure. Default is: False.'
    default: false
    inputBinding:
      position: 102
      prefix: --no_ylabels
  - id: paralog_report_filename
    type:
      - 'null'
      - string
    doc: Specify the filename for the paralog *.tsv report table.
    default: paralog_report
    inputBinding:
      position: 102
      prefix: --paralog_report_filename
  - id: paralogs_above_threshold_report_filename
    type:
      - 'null'
      - string
    doc: Specify the filename for the *.txt list of genes with paralogs in 
      <paralogs_list_threshold_percentage> number of samples.
    default: paralogs_above_threshold_report
    inputBinding:
      position: 102
      prefix: --paralogs_above_threshold_report_filename
  - id: paralogs_list_threshold_percentage
    type:
      - 'null'
      - float
    doc: Percent of total number of samples and genes that must have paralog 
      warnings to be reported in the <genes_with_paralogs.txt> report file. The 
      default is 0.0, meaning that all genes and samples with at least one 
      paralog warning will be reported
    default: 0.0
    inputBinding:
      position: 102
      prefix: --paralogs_list_threshold_percentage
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: 'If supplied, run the subcommand using cProfile. Saves a *.csv file of results.
      Default is: False.'
    default: false
    inputBinding:
      position: 102
      prefix: --run_profiler
  - id: sample_text_size
    type:
      - 'null'
      - int
    doc: Size (in points) for the sample text labels in the output heatmap file.
      Default is automatically calculated based on the number of samples.
    inputBinding:
      position: 102
      prefix: --sample_text_size
  - id: targetfile_aa
    type: File
    doc: 'FASTA file containing amino-acid target sequences for each gene. Used to
      extract unique gene names for paralog recovery. The fasta headers must follow
      the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 102
      prefix: --targetfile_aa
  - id: targetfile_dna
    type: File
    doc: 'FASTA file containing DNA target sequences for each gene. Used to extract
      unique gene names for paralog recovery. The fasta headers must follow the naming
      convention: >TaxonID-geneName'
    inputBinding:
      position: 102
      prefix: --targetfile_dna
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_paralog_retriever.out
