cwlVersion: v1.2
class: CommandLineTool
baseCommand: give_completeness
label: kegg-pathways-completeness_give_completeness
doc: "Script generates modules pathways completeness by given set of KOs\n\nTool homepage:
  https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool"
inputs:
  - id: add_per_contig
    type:
      - 'null'
      - boolean
    doc: Creates per-contig summary table (makes sense to use if input table has
      information about contigs). Does not work with --input-list option
    inputBinding:
      position: 101
      prefix: --add-per-contig
  - id: classes
    type:
      - 'null'
      - File
    doc: Modules classes
    inputBinding:
      position: 101
      prefix: --classes
  - id: definitions
    type:
      - 'null'
      - File
    doc: All modules definitions
    inputBinding:
      position: 101
      prefix: --definitions
  - id: graphs
    type:
      - 'null'
      - File
    doc: graphs in pickle format
    inputBinding:
      position: 101
      prefix: --graphs
  - id: include_weights
    type:
      - 'null'
      - boolean
    doc: add weights for each KO in output
    inputBinding:
      position: 101
      prefix: --include-weights
  - id: input_file
    type: File
    doc: Each line = pathway
    inputBinding:
      position: 101
      prefix: --input
  - id: input_list
    type: File
    doc: File with KOs comma separated
    inputBinding:
      position: 101
      prefix: --input-list
  - id: list_separator
    type: string
    doc: Separator for list option
    inputBinding:
      position: 101
      prefix: --list-separator
  - id: names
    type:
      - 'null'
      - File
    doc: Modules names
    inputBinding:
      position: 101
      prefix: --names
  - id: outprefix
    type:
      - 'null'
      - string
    doc: prefix for output filename
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: plot_pathways
    type:
      - 'null'
      - boolean
    doc: Create images with pathways completeness
    inputBinding:
      position: 101
      prefix: --plot-pathways
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/kegg-pathways-completeness:1.3.0--pyhdfd78af_0
