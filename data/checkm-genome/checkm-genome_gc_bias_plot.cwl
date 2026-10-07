cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - gc_bias_plot
label: checkm-genome_gc_bias_plot
doc: "Plot bin coverage as a function of GC.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
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
  - id: bam_file
    type: File
    doc: 'BAM file to interrogate for coverage information (indexed)'
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 3
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
    doc: 'height of output image (default: 3.5)'
    inputBinding:
      position: 101
      prefix: --height
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'window size used to calculate plot statistics (default: 5000)'
    inputBinding:
      position: 101
      prefix: --window_size
  - id: all_reads
    type:
      - 'null'
      - boolean
    doc: 'use all reads to estimate coverage instead of just those in proper pairs'
    inputBinding:
      position: 101
      prefix: --all_reads
  - id: min_align
    type:
      - 'null'
      - float
    doc: 'minimum alignment length as percentage of read length (default: 0.98)'
    inputBinding:
      position: 101
      prefix: --min_align
  - id: max_edit_dist
    type:
      - 'null'
      - float
    doc: 'maximum edit distance as percentage of read length (default: 0.02)'
    inputBinding:
      position: 101
      prefix: --max_edit_dist
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
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
