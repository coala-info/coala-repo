cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-plot-transcript-wiggles
label: rsem_rsem-plot-transcript-wiggles
doc: "Generate PDF wiggle plots from transcript or gene ids. This program
  generates transcript wiggle plots and outputs them in a pdf file. It accepts
  either a list of transcript ids or gene ids and has two modes of showing
  wiggle plots. If '--show-unique' is not specified, the wiggle plot for each
  transcript is a histogram where each position has the expected read depth at
  this position as its height. If '--show-unique' is specified, for each
  transcript a stacked bar plot is generated: the read depth of unique reads is
  shown in black and the read depth of multi-reads in red on top of it. The
  program uses files that rsem-calculate-expression generated earlier (the
  transcript BAM file), so they must be in the working directory.\n\nTool
  homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: sample_name
    type: string
    doc: The name of the sample analyzed.
    inputBinding:
      position: 1
  - id: input_list
    type: File
    doc: A list of transcript ids or gene ids. It cannot be a mixture of 
      transcript and gene ids. Each id occupies one line without extra spaces.
    inputBinding:
      position: 2
  - id: output_plot_file
    type: string
    doc: The file name of the pdf file which contains all plots.
    inputBinding:
      position: 3
  - id: sample_files
    type:
      type: array
      items: File
    doc: The files rsem-calculate-expression wrote for the sample, all with the 
      sample_name prefix (sample_name.transcript.bam, 
      sample_name.isoforms.results, sample_name.genes.results). They are staged 
      writable in the working directory.
  - id: gene_list
    type:
      - 'null'
      - boolean
    doc: 'The input-list is a list of gene ids. (Default: off)'
    inputBinding:
      position: 0
      prefix: --gene-list
  - id: transcript_list
    type:
      - 'null'
      - boolean
    doc: 'The input-list is a list of transcript ids. This option can only be 
      turned on if allele-specific expression is calculated. (Default: off)'
    inputBinding:
      position: 0
      prefix: --transcript-list
  - id: show_unique
    type:
      - 'null'
      - boolean
    doc: 'Show the wiggle plots as stacked bar plots. (Default: off)'
    inputBinding:
      position: 0
      prefix: --show-unique
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads we can use. (Default: 1)'
    inputBinding:
      position: 0
      prefix: --num-threads
  - id: memory_per_thread
    type:
      - 'null'
      - string
    doc: "Set the maximum allowable memory per thread. <string> represents the
      memory and accepts suffices 'K/M/G'. (Default: 1G)"
    inputBinding:
      position: 0
      prefix: --memory-per-thread
outputs:
  - id: plot_pdf
    type: File
    outputBinding:
      glob: $(inputs.output_plot_file)
    doc: The PDF file with all plots.
  - id: generated_files
    type:
      type: array
      items: File
    outputBinding:
      glob:
        - $(inputs.sample_name).transcript.sorted.bam
        - $(inputs.sample_name).transcript.readdepth
        - $(inputs.sample_name).uniq.transcript.bam
        - $(inputs.sample_name).uniq.transcript.sorted.bam
        - $(inputs.sample_name).uniq.transcript.readdepth
    doc: Sorted BAM and read depth files the program makes when they are missing.
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sample_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
