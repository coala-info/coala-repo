cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - dist_plot
label: checkm-genome_dist_plot
doc: "Create image with GC, CD, and TD distribution plots together.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: results_dir
    type: Directory
    doc: 'directory specified during analyze command'
    inputBinding:
      position: 1
  - id: bin_input
    type:
      - Directory
      - File
    doc: 'directory containing bins (fasta format) or path to file describing
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome
      translation file (pep)]'
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: 'directory to hold plots'
    inputBinding:
      position: 3
  - id: tetra_profile
    type: File
    doc: 'tetranucleotide profiles for each sequence (see tetra command)'
    inputBinding:
      position: 4
  - id: dist_value
    type:
      type: array
      items: int
    doc: 'reference distribution(s) to plot; integer between 0 and 100'
    inputBinding:
      position: 5
  - id: image_type
    type:
      - 'null'
      - string
    doc: 'desired image type: eps, pdf, png, ps or svg (default: png)'
    inputBinding:
      position: 101
      prefix: --image_type
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'desired DPI of output image (default: 600)'
    inputBinding:
      position: 101
      prefix: --dpi
  - id: font_size
    type:
      - 'null'
      - int
    doc: 'Desired font size (default: 8)'
    inputBinding:
      position: 101
      prefix: --font_size
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (other files in directory are ignored) (default: fna)'
    inputBinding:
      position: 101
      prefix: --extension
  - id: width
    type:
      - 'null'
      - float
    doc: 'width of output image (default: 6.5)'
    inputBinding:
      position: 101
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: 'height of output image (default: 8)'
    inputBinding:
      position: 101
      prefix: --height
  - id: gc_window_size
    type:
      - 'null'
      - int
    doc: 'window size used to calculate GC histogram (default: 5000)'
    inputBinding:
      position: 101
      prefix: --gc_window_size
  - id: td_window_size
    type:
      - 'null'
      - int
    doc: 'window size used to calculate TD histogram (default: 5000)'
    inputBinding:
      position: 101
      prefix: --td_window_size
  - id: cd_window_size
    type:
      - 'null'
      - int
    doc: 'window size used to calculate CD histogram (default: 10000)'
    inputBinding:
      position: 101
      prefix: --cd_window_size
  - id: gc_bin_width
    type:
      - 'null'
      - float
    doc: 'width of GC bars in histogram (default: 0.01)'
    inputBinding:
      position: 101
      prefix: --gc_bin_width
  - id: td_bin_width
    type:
      - 'null'
      - float
    doc: 'width of TD bars in histogram (default: 0.01)'
    inputBinding:
      position: 101
      prefix: --td_bin_width
  - id: cd_bin_width
    type:
      - 'null'
      - float
    doc: 'width of CD bars in histogram (default: 0.01)'
    inputBinding:
      position: 101
      prefix: --cd_bin_width
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_dir_out
    type: Directory
    doc: 'directory to hold plots'
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
