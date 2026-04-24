cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - write_systems
label: panorama_write_systems
doc: "Write systems from pangenomes\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: association
    type:
      - 'null'
      - type: array
        items: string
    doc: Write association between systems and others pangenomes elements
    inputBinding:
      position: 101
      prefix: --association
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Write the canonical version of systems too.
    inputBinding:
      position: 101
      prefix: --canonical
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
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: models
    type:
      type: array
      items: File
    doc: Path to model list file. You can specify multiple models from different
      source. For that separate the model list files by a space and make sure 
      you give them in the same order as the sources.
    inputBinding:
      position: 101
      prefix: --models
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: List of organisms to write. If not specified, all organisms will be 
      written.
    inputBinding:
      position: 101
      prefix: --organisms
  - id: output_formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Visualization output format customization.
      - html
    inputBinding:
      position: 101
      prefix: --output_formats
  - id: pangenomes
    type:
      type: array
      items: File
    doc: A list of pangenome .h5 files in .tsv file
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: partition
    type:
      - 'null'
      - boolean
    doc: Write a heatmap file with for each organism, partition of the systems. 
      If organisms are specified, heatmap will be write only for them.
    inputBinding:
      position: 101
      prefix: --partition
  - id: projection
    type:
      - 'null'
      - boolean
    doc: Project the systems on organisms. If organisms are specified, 
      projection will be done only for them.
    inputBinding:
      position: 101
      prefix: --projection
  - id: proksee
    type:
      - 'null'
      - type: array
        items: string
    doc: Write a proksee file with systems. If you only want the systems with 
      genes, gene families and partition, use base value.Write RGPs, spots or 
      modules -split by `,` - if you want them.
    inputBinding:
      position: 101
      prefix: --proksee
  - id: sources
    type:
      type: array
      items: string
    doc: Name of the systems sources. You can specify multiple sources. For that
      separate names by a space and make sure you give them in the same order as
      the sources.
    inputBinding:
      position: 101
      prefix: --sources
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --threads
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
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
