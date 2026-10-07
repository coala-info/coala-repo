cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - nx_plot
label: checkm-genome_nx_plot
doc: "Create Nx-plots.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: bin_input
    type:
      - Directory
      - File
    doc: 'directory containing bins (fasta format) or path to file describing
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome
      translation file (pep)]'
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    doc: 'directory to hold plots'
    inputBinding:
      position: 2
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
    doc: 'height of output image (default: 6.5)'
    inputBinding:
      position: 101
      prefix: --height
  - id: step_size
    type:
      - 'null'
      - float
    doc: 'x step size for calculating Nx (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --step_size
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
