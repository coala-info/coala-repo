cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_modules_graphs
label: kegg-pathways-completeness_plot_modules_graphs
doc: "Script generates plots for each contig\n\nTool homepage: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool"
inputs:
  - id: graphs
    type:
      - 'null'
      - File
    doc: graphs in pickle format
    inputBinding:
      position: 101
      prefix: --graphs
  - id: input_completeness
    type:
      - 'null'
      - File
    doc: Output table from give_completeness.py
    inputBinding:
      position: 101
      prefix: --input-completeness
  - id: list_separator
    type:
      - 'null'
      - string
    doc: Modules separator in file
    inputBinding:
      position: 101
      prefix: --file-separator
  - id: modules_file
    type:
      - 'null'
      - File
    doc: File containing modules accessions
    inputBinding:
      position: 101
      prefix: --modules-file
  - id: modules_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of modules accessions
    inputBinding:
      position: 101
      prefix: --modules
  - id: pathways
    type:
      - 'null'
      - File
    doc: Pathways of kos
    inputBinding:
      position: 101
      prefix: --definitions
  - id: use_pydot
    type:
      - 'null'
      - boolean
    doc: Use pydot instead of graphviz
    inputBinding:
      position: 101
      prefix: --use-pydot
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/kegg-pathways-completeness:1.3.0--pyhdfd78af_0
