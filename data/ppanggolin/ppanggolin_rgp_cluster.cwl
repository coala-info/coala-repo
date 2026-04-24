cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin rgp_cluster
label: ppanggolin_rgp_cluster
doc: "Cluster RGPs based on gene repertoire relatedness.\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: add_metadata
    type:
      - 'null'
      - boolean
    doc: Include metadata information in the output files if any have been added
      to pangenome elements (see ppanggolin metadata command).
    inputBinding:
      position: 101
      prefix: --add_metadata
  - id: basename
    type:
      - 'null'
      - string
    doc: basename for the output file
    inputBinding:
      position: 101
      prefix: --basename
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: graph_formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Format of the output graph.
    inputBinding:
      position: 101
      prefix: --graph_formats
  - id: grr_cutoff
    type:
      - 'null'
      - float
    doc: Min gene repertoire relatedness metric used in the rgp clustering
    inputBinding:
      position: 101
      prefix: --grr_cutoff
  - id: grr_metric
    type:
      - 'null'
      - string
    doc: "The grr (Gene Repertoire Relatedness) is used to assess the similarity between
      two RGPs based on their gene families.There are three different modes for calculating
      the grr value: 'min_grr', 'max_grr' or  'incomplete_aware_grr'.'min_grr': Computes
      the number of gene families shared between the two RGPs and divides it by the
      smaller number of gene families among the two RGPs.'max_grr': Calculates the
      number of gene families shared between the two RGPs and divides it by the larger
      number of gene families among the two RGPs.'incomplete_aware_grr' (default):
      If at least one RGP is considered incomplete, which occurs when it is located
      at the border of a contig,the 'min_grr' mode is used. Otherwise, the 'max_grr'
      mode is applied."
    inputBinding:
      position: 101
      prefix: --grr_metric
  - id: ignore_incomplete_rgp
    type:
      - 'null'
      - boolean
    doc: Do not cluster RGPs located on a contig border which are likely 
      incomplete.
    inputBinding:
      position: 101
      prefix: --ignore_incomplete_rgp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: metadata_sep
    type:
      - 'null'
      - string
    doc: The separator used to join multiple metadata values for elements with 
      multiple metadata values from the same source. This character should not 
      appear in metadata values.
    inputBinding:
      position: 101
      prefix: --metadata_sep
  - id: metadata_sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Which source of metadata should be written. By default all metadata 
      sources are included.
    inputBinding:
      position: 101
      prefix: --metadata_sources
  - id: no_identical_rgp_merging
    type:
      - 'null'
      - boolean
    doc: Do not merge in one node identical RGP (i.e. having the same family 
      content) before clustering.
    inputBinding:
      position: 101
      prefix: --no_identical_rgp_merging
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
