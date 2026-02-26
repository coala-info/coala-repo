cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromatiblock
label: chromatiblock
doc: "Large scale whole genome visualisation using colinear blocks.\n\nTool homepage:
  http://github.com/mjsull/chromatiblock/"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of fasta/genbank files to use as input
    inputBinding:
      position: 1
  - id: add_fasta_labels
    type:
      - 'null'
      - boolean
    doc: add fasta names to figure
    inputBinding:
      position: 102
      prefix: --add_fasta_labels
  - id: categorise
    type:
      - 'null'
      - string
    doc: color blocks by category
    inputBinding:
      position: 102
      prefix: --categorise
  - id: extensions
    type:
      - 'null'
      - string
    doc: "When -d is used for input files, chromatiblock will\n                  \
      \      check against this comma seperated list to determine\n              \
      \          whether to add file to the list of input sequences."
    inputBinding:
      position: 102
      prefix: --extensions
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite working directory and output
    inputBinding:
      position: 102
      prefix: --force
  - id: gap
    type:
      - 'null'
      - int
    doc: gap between genomes
    inputBinding:
      position: 102
      prefix: --gap
  - id: genes_of_interest_blast
    type:
      - 'null'
      - File
    doc: mark genes of interest using BLASTx
    inputBinding:
      position: 102
      prefix: --genes_of_interest_blast
  - id: genes_of_interest_file
    type:
      - 'null'
      - File
    doc: mark genes of interest using a file
    inputBinding:
      position: 102
      prefix: --genes_of_interest_file
  - id: genome_height
    type:
      - 'null'
      - int
    doc: Height of genome blocks
    inputBinding:
      position: 102
      prefix: --genome_height
  - id: hue_end
    type:
      - 'null'
      - float
    inputBinding:
      position: 102
      prefix: --hue_end
  - id: hue_start
    type:
      - 'null'
      - float
    inputBinding:
      position: 102
      prefix: --hue_start
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: Directory of fasta files to use as input.
    inputBinding:
      position: 102
      prefix: --input_directory
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep working directory
    inputBinding:
      position: 102
      prefix: --keep
  - id: maf_alignment
    type:
      - 'null'
      - File
    doc: use a maf file for alignment.
    inputBinding:
      position: 102
      prefix: --maf_alignment
  - id: min_block_size
    type:
      - 'null'
      - int
    doc: Minimum size of syntenic block.
    inputBinding:
      position: 102
      prefix: --min_block_size
  - id: order_list
    type:
      - 'null'
      - type: array
        items: File
    doc: List of fasta files in desired order.
    inputBinding:
      position: 102
      prefix: --order_list
  - id: output_format
    type:
      - 'null'
      - string
    doc: "file format to write to, if all is selected --out will\n               \
      \         be a prefix and extension will be added"
    inputBinding:
      position: 102
      prefix: --output_format
  - id: ppi
    type:
      - 'null'
      - int
    doc: "pixels per inch (only used for png, figure width is 8\n                \
      \        inches)"
    inputBinding:
      position: 102
      prefix: --ppi
  - id: sibelia_mode
    type:
      - 'null'
      - string
    doc: mode for running sibelia <loose|fine|far>
    inputBinding:
      position: 102
      prefix: --sibelia_mode
  - id: sibelia_path
    type:
      - 'null'
      - string
    doc: "Specify path to sibelia (does not need to be set if\n                  \
      \      Sibelia binary is in path)."
    inputBinding:
      position: 102
      prefix: --sibelia_path
  - id: skip_blast
    type:
      - 'null'
      - boolean
    doc: use existing BLASTx file for annotation
    inputBinding:
      position: 102
      prefix: --skip_blast
  - id: skip_sibelia
    type:
      - 'null'
      - boolean
    doc: Use sibelia output already in working directory
    inputBinding:
      position: 102
      prefix: --skip_sibelia
  - id: svg_pan_zoom_location
    type:
      - 'null'
      - string
    doc: location of svg-pan-zoom.min.js
    inputBinding:
      position: 102
      prefix: --svg_pan_zoom_location
  - id: working_directory
    type: Directory
    doc: Folder to write intermediate files.
    inputBinding:
      position: 102
      prefix: --working_directory
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Location to write output.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromatiblock:1.0.0--py_0
