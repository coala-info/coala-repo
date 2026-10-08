cwlVersion: v1.2
class: CommandLineTool
baseCommand: slim_graph.py
label: getorganelle_slim_graph.py
doc: "Exclude certain contigs from an assembly graph (fastg, gfa or fasta) by blast against label databases.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: assemblies
    type:
      type: array
      items: File
    doc: "Input assembly (graph) files (.fasta or .gfa or .fastg)."
    inputBinding:
      position: 2
  - id: organelle_types
    type:
      - 'null'
      - string
    doc: "Organelle type(s) to include: embplant_pt, other_pt, embplant_mt, embplant_nr, animal_mt, fungus_mt, fungus_nr, or a comma-separated combination. Uses the label databases in the config directory."
    inputBinding:
      position: 101
      prefix: -F
  - id: exclude_organelle_types
    type:
      - 'null'
      - string
    doc: "Organelle type(s) to exclude, same values as -F."
    inputBinding:
      position: 101
      prefix: -E
  - id: no_hits
    type:
      - 'null'
      - string
    doc: "Treatment for non-hitting contigs: ex_no_con (keep those connected with hitting-include contigs, default), ex_no_hit (exclude all), keep_all."
    inputBinding:
      position: 101
      prefix: --no-hits
  - id: max_slim_extending_len
    type:
      - 'null'
      - string
    doc: "Limit of the extending length below which a non-hit contig may be distant from a hit contig to be kept. An integer or inf."
    inputBinding:
      position: 101
      prefix: --max-slim-extending-len
  - id: significant
    type:
      - 'null'
      - float
    doc: "If the query-score of hitting A is more than this many times (default 3.0) the score of hitting B, the contig is treated as only A related."
    inputBinding:
      position: 101
      prefix: --significant
  - id: depth_cutoff
    type:
      - 'null'
      - float
    doc: "Contigs beyond this many times of the detected target coverage are excluded. Default: 10000.0"
    inputBinding:
      position: 101
      prefix: --depth-cutoff
  - id: min_depth
    type:
      - 'null'
      - float
    doc: "Filter graph by a minimum depth. Default: 0.0"
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: max_depth
    type:
      - 'null'
      - string
    doc: "Filter graph by a maximum depth (a number or inf). Default: inf"
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: merge
    type:
      - 'null'
      - boolean
    doc: "Merge all possible contigs."
    inputBinding:
      position: 101
      prefix: --merge
  - id: include
    type:
      - 'null'
      - type: array
        items: File
    doc: "Blastn database(s) (fasta files) to include."
    inputBinding:
      position: 101
      prefix: --include
      itemSeparator: ','
  - id: include_priority
    type:
      - 'null'
      - type: array
        items: File
    doc: "Blastn database(s) (fasta files) to include with priority."
    inputBinding:
      position: 101
      prefix: --include-priority
      itemSeparator: ','
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: "Blastn database(s) (fasta files) to exclude."
    inputBinding:
      position: 101
      prefix: --exclude
      itemSeparator: ','
  - id: exclude_priority
    type:
      - 'null'
      - type: array
        items: File
    doc: "Blastn database(s) (fasta files) to exclude with priority."
    inputBinding:
      position: 101
      prefix: --exclude-priority
      itemSeparator: ','
  - id: no_hits_labeled_tab
    type:
      - 'null'
      - boolean
    doc: "Disable producing the tab file."
    inputBinding:
      position: 101
      prefix: --no-hits-labeled-tab
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Keep the temp files produced by blast and this script."
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: out_dir
    type: string
    doc: "Output directory (required here, because the input files are read-only)."
    inputBinding:
      position: 101
      prefix: -o
  - id: evalue
    type:
      - 'null'
      - string
    doc: "blastn evalue threshold. Default: 1e-25"
    inputBinding:
      position: 101
      prefix: -e
  - id: percent_identity
    type:
      - 'null'
      - float
    doc: "blastn percent identity threshold. Default unset."
    inputBinding:
      position: 101
      prefix: --percent
  - id: blast_options
    type:
      - 'null'
      - string
    doc: "Other blastn options, e.g. \"-word_size 13\"."
    inputBinding:
      position: 101
      prefix: --blast-options
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Add prefix to the output basename. Conflicts with out_base."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: out_base
    type:
      - 'null'
      - string
    doc: "New output basename. Conflicts with prefix and with multiple input files."
    inputBinding:
      position: 101
      prefix: --out-base
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Generate a log file."
    inputBinding:
      position: 101
      prefix: --log
  - id: wrapper
    type:
      - 'null'
      - boolean
    doc: "Wrapper mode logging when called by get_organelle*.py."
    inputBinding:
      position: 101
      prefix: --wrapper
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "For debug usage."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: "Specified for calling from get_organelle_from_reads.py."
    inputBinding:
      position: 101
      prefix: --continue
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: "Do not overwrite existing output results."
    inputBinding:
      position: 101
      prefix: --no-overwrite
  - id: which_blast
    type:
      - 'null'
      - string
    doc: "Path to BLAST binary files if not added to the path."
    inputBinding:
      position: 101
      prefix: --which-blast
  - id: config_dir
    type:
      - 'null'
      - Directory
    doc: "The directory where the default databases were placed."
    inputBinding:
      position: 101
      prefix: --config-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: "Threads for blastn."
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_directory
    type: Directory
    doc: "The output directory with the slimmed graph files."
    outputBinding:
      glob: "$(inputs.out_dir)"
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_slim_graph.py.out
