cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfviewer
label: gfviewer
doc: "Process input arguments for the GFViewer tool.\n\nTool homepage: https://github.com/sakshar/GFViewer"
inputs:
  - id: centromeres
    type:
      - 'null'
      - boolean
    doc: "Plot centromeres of the chromosomes along with multi\n                 \
      \       gene families"
    inputBinding:
      position: 101
      prefix: --centromeres
  - id: color_map_file
    type:
      - 'null'
      - File
    doc: "A text (.txt) file containing the gene family (gf) ids\n               \
      \         with their color codes; <gf_id>,<color_code> or\n                \
      \        <gf_id>,<[0,1]>,<[0,1]>,<[0,1]> per line"
    inputBinding:
      position: 101
      prefix: --color_map_file
  - id: concatenate_pages
    type:
      - 'null'
      - boolean
    doc: Concatenate the pages into a single PDF file
    inputBinding:
      position: 101
      prefix: --concatenate_pages
  - id: data_file
    type: File
    doc: A file (.xlsx/.csv/.tsv) containing gene family and location 
      information for each gene
    inputBinding:
      position: 101
      prefix: --data_file
  - id: genome_file
    type: File
    doc: "A fasta (.fasta/.fna/.fa) file containing the genome sequence or a text
      (.txt) file containing the chromosome ids with their lengths;\n            \
      \            <seq_id>,<seq_length> per line"
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: legend_location
    type:
      - 'null'
      - string
    doc: "Specify the location (upper/lower/left/right) of\n                     \
      \   legends only when adding them to each page (default: lower)"
    default: lower
    inputBinding:
      position: 101
      prefix: --legend_location
  - id: legend_orientation
    type:
      - 'null'
      - string
    doc: "Specify the orientation (horizontal/vertical) of\n                     \
      \   legends only when plotting legends separately\n                        (default:
      horizontal)"
    default: horizontal
    inputBinding:
      position: 101
      prefix: --legend_orientation
  - id: legends_per_page
    type:
      - 'null'
      - boolean
    doc: Plot legends per page in the PDF
    inputBinding:
      position: 101
      prefix: --legends_per_page
  - id: number_of_chromosomes_per_page
    type:
      - 'null'
      - int
    doc: "Number of chromosomes to be plotted per page (default:\n               \
      \         3)"
    default: 3
    inputBinding:
      position: 101
      prefix: --number_of_chromosomes_per_page
  - id: number_of_rows_in_legends
    type:
      - 'null'
      - int
    doc: 'Number of rows in the legends (default: 2)'
    default: 2
    inputBinding:
      position: 101
      prefix: --number_of_rows_in_legends
  - id: telomere_length
    type:
      - 'null'
      - int
    doc: "The length of telomeres in bp used in the plot\n                       \
      \ (default: 10000)"
    default: 10000
    inputBinding:
      position: 101
      prefix: --telomere_length
outputs:
  - id: output_directory
    type: Directory
    doc: Path to the output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfviewer:1.0.4--pyhdfd78af_0
