cwlVersion: v1.2
class: CommandLineTool
baseCommand: keggcharter
label: keggcharter
doc: "KEGGCharter - A tool for representing genomic potential and transcriptomic expression
  into KEGG pathways\n\nTool homepage: https://github.com/iquasere/KEGGCharter"
inputs:
  - id: cog_column
    type:
      - 'null'
      - string
    doc: Column with COG IDs.
    inputBinding:
      position: 101
      prefix: --cog-column
  - id: differential_colormap
    type:
      - 'null'
      - string
    doc: Matplotlib color map to use for differential maps [viridis]
    default: viridis
    inputBinding:
      position: 101
      prefix: --differential-colormap
  - id: distribute_quantification
    type:
      - 'null'
      - boolean
    doc: Quantification of each enzyme is divided by all KOs identified for it.
    inputBinding:
      position: 101
      prefix: --distribute-quantification
  - id: ec_column
    type:
      - 'null'
      - string
    doc: Column with EC numbers.
    inputBinding:
      position: 101
      prefix: --ec-column
  - id: include_missing_genomes
    type:
      - 'null'
      - boolean
    doc: Map the functions for KOs identified for organisms not present in KEGG 
      Genomes.
    inputBinding:
      position: 101
      prefix: --include-missing-genomes
  - id: input_file
    type: File
    doc: TSV or EXCEL table with information to chart
    inputBinding:
      position: 101
      prefix: --file
  - id: input_quantification
    type:
      - 'null'
      - boolean
    doc: If input table has no quantification, will create a mock quantification
      column
    inputBinding:
      position: 101
      prefix: --input-quantification
  - id: input_taxonomy
    type:
      - 'null'
      - string
    doc: If no taxonomy column exists and there is only one taxon in question.
    inputBinding:
      position: 101
      prefix: --input-taxonomy
  - id: kegg_column
    type:
      - 'null'
      - string
    doc: Column with KEGG IDs.
    inputBinding:
      position: 101
      prefix: --kegg-column
  - id: ko_column
    type:
      - 'null'
      - string
    doc: Column with KOs.
    inputBinding:
      position: 101
      prefix: --ko-column
  - id: map_all
    type:
      - 'null'
      - boolean
    doc: Ignore KEGG taxonomic information. All functions for all KOs will be 
      represented, even if they aren't attributed by KEGG to the specific 
      species.
    inputBinding:
      position: 101
      prefix: --map-all
  - id: metabolic_maps
    type:
      - 'null'
      - type: array
        items: string
    doc: IDs of metabolic maps to output
    inputBinding:
      position: 101
      prefix: --metabolic-maps
  - id: number_of_taxa
    type:
      - 'null'
      - int
    doc: Number of taxa to represent in genomic potential charts (comma 
      separated)
    inputBinding:
      position: 101
      prefix: --number-of-taxa
  - id: quantification_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of columns with quantification
    inputBinding:
      position: 101
      prefix: --quantification-columns
  - id: resources_directory
    type:
      - 'null'
      - Directory
    doc: Directory for storing KGML and CSV files.
    inputBinding:
      position: 101
      prefix: --resources-directory
  - id: resume
    type:
      - 'null'
      - boolean
    doc: If data inputed has already been analyzed by KEGGCharter.
    inputBinding:
      position: 101
      prefix: --resume
  - id: show_available_maps
    type:
      - 'null'
      - boolean
    doc: Outputs KEGG maps IDs and descriptions to the console (so you may pick 
      the ones you want!)
    inputBinding:
      position: 101
      prefix: --show-available-maps
  - id: step
    type:
      - 'null'
      - int
    doc: Number of IDs to submit per request through the KEGG API [40]
    default: 40
    inputBinding:
      position: 101
      prefix: --step
  - id: taxa_column
    type:
      - 'null'
      - string
    doc: 'Column with the taxa designations to represent with KEGGCharter. NOTE -
      for valid taxonomies, check: https://www.genome.jp/kegg/catalog/org_list.html'
    inputBinding:
      position: 101
      prefix: --taxa-column
  - id: taxa_list
    type:
      - 'null'
      - string
    doc: List of taxa to represent in genomic potential charts (comma separated)
    inputBinding:
      position: 101
      prefix: --taxa-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run KEGGCharter with [max available]
    default: max available
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/keggcharter:1.1.2--hdfd78af_0
