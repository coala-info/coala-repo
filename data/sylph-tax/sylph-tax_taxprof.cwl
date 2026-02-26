cwlVersion: v1.2
class: CommandLineTool
baseCommand: sylph-tax taxprof
label: sylph-tax_taxprof
doc: "Generates a taxonomy profile from SYLPH result files.\n\nTool homepage: https://github.com/bluenote-1577/sylph-tax"
inputs:
  - id: sylph_files
    type:
      type: array
      items: File
    doc: sylph result files (TSV)
    inputBinding:
      position: 1
  - id: add_folder_information
    type:
      - 'null'
      - boolean
    doc: Include directory/folder path information in the output files. This is 
      needed if your samples have the same read name but different directory 
      structures.
    inputBinding:
      position: 102
      prefix: --add-folder-information
  - id: annotate_virus_hosts
    type:
      - 'null'
      - boolean
    doc: Add additional column(s) by integrating viral-host information 
      available (currently available for IMGVR4.1, UHGV taxonomies)
    inputBinding:
      position: 102
      prefix: --annotate-virus-hosts
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Append this prefix to the outputs. Output files will be 'prefix + 
      Sample_file_column + .sylphmpa'
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwriting of output files.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: pavian
    type:
      - 'null'
      - boolean
    doc: Make a pavian-compatible taxonomy file for visualization. Not 
      recommended except for use with pavian.
    inputBinding:
      position: 102
      prefix: --pavian
  - id: taxonomy_metadata
    type:
      type: array
      items: File
    doc: 'Taxonomy metadata inputs. If multiple are provided, they will be merged.
      Provided taxonomies: [FungiRefSeq-latest, FungiRefSeq-2024-07-25, GTDB_r214,
      GTDB_r220, GTDB_r226, IMGVR_4.1, UHGV_default, UHGV_ictv, OceanDNA, SoilSMAG,
      TaraEukaryoticSMAG, GlobDB_r226]. Custom metadata files (.tsv) can be used as
      well; see online manual.'
    inputBinding:
      position: 102
      prefix: --taxonomy-metadata
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
stdout: sylph-tax_taxprof.out
