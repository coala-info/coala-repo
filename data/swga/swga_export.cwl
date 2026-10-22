cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - swga
  - export
label: swga_export
doc: "Retrieve or export primers or sets from the database\n\nTool homepage: https://github.com/eclarke/swga"
inputs:
  - id: fg_genome
    type: File
    doc: Foreground genome FASTA given to swga init (staged as fg.fa)
  - id: bg_genome
    type: File
    doc: Background genome FASTA given to swga init (staged as bg.fa)
  - id: exclude_genome
    type: File
    doc: Exclusion FASTA given to swga init (staged as ex.fa)
  - id: workspace_db
    type: File
    doc: swga workspace database (swga.db) made by swga init
  - id: parameters_cfg
    type: File
    doc: swga parameters file (parameters.cfg) made by swga init
  - id: what
    type: string
    doc: What to export (set, sets, primer, primers, bedfile, bedgraph, lorenz)
    inputBinding:
      position: 2
  - id: output_file_path
    type: ['null', string]
    doc: Where to write results
    inputBinding:
      position: 1
      prefix: --output
  - id: order_by
    type: ['null', string]
    doc: Order the results before any limit
    inputBinding:
      position: 1
      prefix: --order_by
  - id: descending
    type: ['null', boolean]
    doc: Return in descending order when --order_by is used
    inputBinding:
      position: 1
      prefix: --descending
  - id: limit
    type: ['null', int]
    doc: Maximum number of results (below zero means no limit)
    inputBinding:
      position: 1
      prefix: --limit
  - id: ids
    type:
      - 'null'
      - type: array
        items: int
    doc: IDs of the sets or primers to use
    inputBinding:
      position: 1
      prefix: --ids
  - id: no_header
    type: ['null', boolean]
    doc: Do not display the header
    inputBinding:
      position: 1
      prefix: --no_header
  - id: opts_str
    type: ['null', string]
    doc: (bedgraph only) options string added to the track line
    inputBinding:
      position: 1
      prefix: --opts_str
  - id: window_size
    type: ['null', int]
    doc: (bedgraph only) size of the sliding window
    inputBinding:
      position: 1
      prefix: --window_size
  - id: step_size
    type: ['null', int]
    doc: (bedgraph only) step size of the sliding window
    inputBinding:
      position: 1
      prefix: --step_size
  - id: output_folder
    type: ['null', string]
    doc: (bedfile and bedgraph) folder for the output files
    inputBinding:
      position: 1
      prefix: --output_folder
outputs:
  - id: workspace_db_out
    type: File
    doc: Updated swga workspace database
    outputBinding:
      glob: swga.db
  - id: output_file
    type: ['null', File]
    doc: Exported results
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: output_dir
    type: ['null', Directory]
    doc: Folder with bed or bedgraph files
    outputBinding:
      glob: $(inputs.output_folder)
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: swga.db
        entry: $(inputs.workspace_db)
        writable: true
      - entryname: fg.fa
        entry: $(inputs.fg_genome)
        writable: true
      - entryname: bg.fa
        entry: $(inputs.bg_genome)
        writable: true
      - entryname: ex.fa
        entry: $(inputs.exclude_genome)
        writable: true
      - entryname: parameters.cfg
        entry: $(inputs.parameters_cfg)
        writable: true
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swga:0.4.4--py27hd28b015_1
    dockerOutputDirectory: /swga_work
stdout: swga_export.stdout.txt
