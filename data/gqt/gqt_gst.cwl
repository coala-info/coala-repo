cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gqt
  - gst
label: gqt_gst
doc: "Calculate Gst statistic (Nei 1973) between the subpopulations defined by population queries. NOTE: gst and fst assume that variants are biallelic. If your data contains multiallelic sites, we recommend decomposing your VCF (see A. Tan, Bioinformatics 2015) prior to indexing.\n\nTool homepage: https://github.com/ryanlayer/gqt"
inputs:
  - id: gqt_file
    type: File
    secondaryFiles:
      - ^.vid
      - ^.off
      - ^.bim
    doc: gqt file (needs its .vid, .off and .bim files beside it)
    inputBinding:
      position: 101
      prefix: -i
  - id: ped_database_file
    type: File
    doc: ped database file
    inputBinding:
      position: 101
      prefix: -d
  - id: population_queries
    type:
      type: array
      items: string
      inputBinding:
        position: 101
        prefix: -p
    doc: Each population query defines one subpopulation, for example
      "Population = 'GBR'". Population queries are based on the PED file
      associated with the genotypes; any column in that PED file can be part of
      the query. Give one query per subpopulation.
  - id: tmp_directory
    type:
      - 'null'
      - string
    doc: tmp direcory name for remote files
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_gst.out
