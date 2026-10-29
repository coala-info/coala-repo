cwlVersion: v1.2
class: CommandLineTool
baseCommand: evaluate_assembly_using_mapping.py
label: getorganelle_evaluate_assembly_using_mapping.py
doc: "Evaluate an assembly (fasta) by mapping the original reads back with Bowtie2 and summarising the coverage.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: assembly_fasta
    type:
      - File
    doc: "Input assembly fasta file."
    inputBinding:
      position: 101
      prefix: "-f"
  - id: original_fq_1
    type:
      - 'null'
      - File
    doc: "Original reads, first file."
    inputBinding:
      position: 101
      prefix: "-1"
  - id: original_fq_2
    type:
      - 'null'
      - File
    doc: "Original reads, second file."
    inputBinding:
      position: 101
      prefix: "-2"
  - id: unpaired_fq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input file(s) with unpaired (single-end) reads to be added to the pool (sent as a comma-separated list)."
    inputBinding:
      position: 101
      prefix: "-u"
      itemSeparator: ','
  - id: max_lib_len
    type:
      - 'null'
      - int
    doc: "Corresponding to '-X' option in Bowtie2. Default: 1200."
    inputBinding:
      position: 101
      prefix: "-X"
  - id: is_circular
    type:
      - 'null'
      - string
    doc: "(yes/no/auto) input fasta is circular. If auto was chosen, the input fasta would be treated as circular when the sequence name ends with '(circular)'. Default: auto"
    inputBinding:
      position: 101
      prefix: "-c"
  - id: output_base
    type:
      - string
    doc: "Output folder."
    inputBinding:
      position: 101
      prefix: "-o"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Threads."
    inputBinding:
      position: 101
      prefix: "-t"
  - id: continue_mode
    type:
      - 'null'
      - boolean
    doc: "Continue mode."
    inputBinding:
      position: 101
      prefix: "--continue"
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator. Default: 12345"
    inputBinding:
      position: 101
      prefix: "--seed"
  - id: draw
    type:
      - 'null'
      - boolean
    doc: "Draw density plot using matplotlib, which should be installed."
    inputBinding:
      position: 101
      prefix: "--draw"
  - id: plot_format
    type:
      - 'null'
      - string
    doc: "Default: pdf,png"
    inputBinding:
      position: 101
      prefix: "--plot-format"
  - id: plot_title
    type:
      - 'null'
      - string
    doc: "Default: the file name of the input fasta"
    inputBinding:
      position: 101
      prefix: "--plot-title"
  - id: plot_subtitle
    type:
      - 'null'
      - string
    doc: "A 4-space indicates a line break. Default: None"
    inputBinding:
      position: 101
      prefix: "--plot-subtitle"
  - id: plot_transparent
    type:
      - 'null'
      - boolean
    doc: "Default: False"
    inputBinding:
      position: 101
      prefix: "--plot-transparent"
  - id: plot_x_density
    type:
      - 'null'
      - float
    doc: "Default: 12000.0"
    inputBinding:
      position: 101
      prefix: "--plot-x-density"
  - id: plot_x_gap_dots
    type:
      - 'null'
      - int
    doc: "Number of sites added in-between isolated contigs. Default: 3000"
    inputBinding:
      position: 101
      prefix: "--plot-x-gap-dots"
  - id: plot_figure_height
    type:
      - 'null'
      - float
    doc: "Default: 5.0"
    inputBinding:
      position: 101
      prefix: "--plot-figure-height"
  - id: plot_y_lim
    type:
      - 'null'
      - float
    doc: "Y axis value limit."
    inputBinding:
      position: 101
      prefix: "--plot-y-lim"
  - id: plot_font
    type:
      - 'null'
      - string
    doc: "For plot of unicode characters in some environments. Use 'Times New Roman','Arial' etc. Default: None."
    inputBinding:
      position: 101
      prefix: "--plot-font"
  - id: disable_customized_error_rate
    type:
      - 'null'
      - boolean
    doc: "Disable the customized error rate."
    inputBinding:
      position: 101
      prefix: "--disable-customized-error-rate"
  - id: which_bowtie2
    type:
      - 'null'
      - string
    doc: "Assign the path to Bowtie2 binary files if not added to the path. Default: try GetOrganelleDep/linux/bowtie2 first, then $PATH"
    inputBinding:
      position: 101
      prefix: "--which-bowtie2"
  - id: bowtie2_mode
    type:
      - 'null'
      - string
    doc: "Default: --sensitive"
    inputBinding:
      position: 101
      prefix: "--bowtie2-mode"
  - id: bowtie2_options
    type:
      - 'null'
      - string
    doc: "Default: --no-discordant --dovetail"
    inputBinding:
      position: 101
      prefix: "--bowtie2-options"
  - id: stat_mode
    type:
      - 'null'
      - string
    doc: "Statistical mode for counting multiple hits of a single read: best/all. The all mode is meaningful only when '-k <INT>' was included in '--bowtie2-options'. Default: best"
    inputBinding:
      position: 101
      prefix: "--stat-mode"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Turn on debug mode."
    inputBinding:
      position: 101
      prefix: "--debug"
outputs:
  - id: output_dir
    type:
      - Directory
    doc: "Output folder."
    outputBinding:
      glob: "$(inputs.output_base)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_evaluate_assembly_using_mapping.py.out
