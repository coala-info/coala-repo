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
      - string
    doc: Log output file name
    inputBinding:
      position: 101
      prefix: --log
  - id: models
    type:
      type: array
      items: File
    doc: Path to model list file. You can specify multiple models from different source.
      For that separate the model list files by a space and make sure you give them
      in the same order as the sources.
    inputBinding:
      position: 101
      prefix: --models
  - id: model_json_files
    type:
      - 'null'
      - type: array
        items: File
    doc: System model .json files named in the model list file(s). They are staged
      in the working directory, so the list must name them by file name.
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: List of organisms to write. If not specified, all organisms will be written.
    inputBinding:
      position: 101
      prefix: --organisms
  - id: output_formats
    type:
      - 'null'
      - type: array
        items: string
    doc: Visualization output format customization. - html
    inputBinding:
      position: 101
      prefix: --output_formats
  - id: pangenomes
    type: File
    doc: A list of pangenome .h5 files in .tsv file
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: pangenome_files
    type:
      type: array
      items: File
    doc: Pangenome .h5 files named in the pangenomes list. They are staged in the
      working directory, so the list must name them by file name (second column).
  - id: partition
    type:
      - 'null'
      - boolean
    doc: Write a heatmap file with for each organism, partition of the systems. If
      organisms are specified, heatmap will be write only for them.
    inputBinding:
      position: 101
      prefix: --partition
  - id: projection
    type:
      - 'null'
      - boolean
    doc: Project the systems on organisms. If organisms are specified, projection
      will be done only for them.
    inputBinding:
      position: 101
      prefix: --projection
  - id: proksee
    type:
      - 'null'
      - type: array
        items: string
    doc: Write a proksee file with systems. If you only want the systems with genes,
      gene families and partition, use base value.Write RGPs, spots or modules -split
      by `,` - if you want them.
    inputBinding:
      position: 101
      prefix: --proksee
  - id: sources
    type:
      type: array
      items: string
    doc: Name of the systems sources. You can specify multiple sources. For that separate
      names by a space and make sure you give them in the same order as the sources.
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
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 for
      debug)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file (with log)
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.pangenome_files)
      - $(inputs.model_json_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
