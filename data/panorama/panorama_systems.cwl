cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - systems
label: panorama_systems
doc: "Detect biological systems in pangenomes from annotated gene families and system\
  \ models; the systems are written into the pangenome .h5 files.\n\nTool homepage:\
  \ https://github.com/labgem/panorama"
inputs:
  - id: annotation_sources
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of the annotation sources to load if different from the system source.
      Can specify more than one, separated by space.
    inputBinding:
      position: 101
      prefix: --annotation_sources
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
  - id: jaccard
    type:
      - 'null'
      - float
    doc: Minimum Jaccard similarity used to filter edges between gene families. Increasing
      this value improves precision but significantly lowers sensitivity.
    inputBinding:
      position: 101
      prefix: --jaccard
  - id: log
    type:
      - 'null'
      - string
    doc: Log output file name
    inputBinding:
      position: 101
      prefix: --log
  - id: models
    type: File
    doc: 'Path to model list file. Note: Use ''panorama utils --models'' to create
      the models list file.'
    inputBinding:
      position: 101
      prefix: --models
  - id: model_files
    type:
      - 'null'
      - type: array
        items: File
    doc: System model .json files named in the model list file(s). They are staged
      in the working directory, so the list must name them by file name.
  - id: pangenomes
    type: File
    doc: A list of pangenome .h5 files in a .tsv file.
    inputBinding:
      position: 101
      prefix: --pangenomes
  - id: pangenome_files
    type:
      type: array
      items: File
    doc: Pangenome .h5 files named in the pangenomes list. They are staged in the
      working directory, so the list must name them by file name (second column).
  - id: source
    type: string
    doc: Name of the annotation source to select in pangenomes.
    inputBinding:
      position: 101
      prefix: --source
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads.
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
outputs:
  - id: pangenomes_out
    type:
      type: array
      items: File
    doc: Pangenome .h5 files with the detected systems
    outputBinding:
      glob: $(inputs.pangenome_files.map(function(f){ return f.basename; }))
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
      - entry: $(inputs.pangenome_files)
        writable: true
      - $(inputs.model_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
