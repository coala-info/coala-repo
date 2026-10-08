cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - pansystems
label: panorama_pansystems
doc: "Run the whole systems workflow on pangenomes: annotation, systems detection\
  \ and writing of the systems.\n\nTool homepage: https://github.com/labgem/panorama"
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
  - id: only_best_hit
    type:
      - 'null'
      - boolean
    doc: alias to keep only the best hit for each gene family.
    inputBinding:
      position: 101
      prefix: -b
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
    doc: Force writing in output directory and in pangenome output file
    inputBinding:
      position: 101
      prefix: --force
  - id: hmm
    type:
      - 'null'
      - File
    doc: 'A tab-separated file with HMM information and path.Note: Use panorama utils
      --hmm to create the HMM list file'
    inputBinding:
      position: 101
      prefix: --hmm
  - id: hmm_files
    type:
      - 'null'
      - type: array
        items: File
    doc: HMM files named in the HMM list file. They are staged in the working directory,
      so the list must name them by file name.
  - id: jaccard
    type:
      - 'null'
      - float
    doc: minimum jaccard similarity used to filter edges between gene families. Increasing
      it will improve precision but lower sensitivity a lot.
    inputBinding:
      position: 101
      prefix: --jaccard
  - id: k_best_hit
    type:
      - 'null'
      - int
    doc: Number of best hits to consider
    inputBinding:
      position: 101
      prefix: --k_best_hit
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep the temporary files
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - string
    doc: Log output file name
    inputBinding:
      position: 101
      prefix: --log
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode for detection (fast, profile, sensitive)
    inputBinding:
      position: 101
      prefix: --mode
  - id: models
    type: File
    doc: 'Path to model list file.Note: Use panorama utils --models to create the
      models list file'
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
  - id: msa
    type:
      - 'null'
      - File
    doc: Path to Multiple Sequence Alignment file
    inputBinding:
      position: 101
      prefix: --msa
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
    doc: Write a heatmap file with for each organism, partition of the systems
    inputBinding:
      position: 101
      prefix: --partition
  - id: projection
    type:
      - 'null'
      - boolean
    doc: Project the systems on organisms
    inputBinding:
      position: 101
      prefix: --projection
  - id: proksee
    type:
      - 'null'
      - type: array
        items: string
    doc: Write a proksee file with systems
    inputBinding:
      position: 101
      prefix: --proksee
  - id: save_hits
    type:
      - 'null'
      - type: array
        items: string
    doc: Save hits in specified formats (tblout, domtblout, pfamtblout)
    inputBinding:
      position: 101
      prefix: --save_hits
  - id: source
    type: string
    doc: Name of the annotation source where panorama as to select in pangenomes
    inputBinding:
      position: 101
      prefix: --source
  - id: table
    type:
      - 'null'
      - File
    doc: A list of tab-separated file, containing annotation of gene families.Expected
      format is pangenome name in first column and path to the TSV with annotation
      in second column.
    inputBinding:
      position: 101
      prefix: --table
  - id: table_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Annotation TSV files named in the --table list. They are staged in the working
      directory, so the list must name them by file name.
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - string
    doc: Path to temporary directory
    inputBinding:
      position: 101
      prefix: --tmp
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 for
      debug)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: z
    type:
      - 'null'
      - int
    doc: Number of sequences to process
    inputBinding:
      position: 101
      prefix: -Z
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
  - id: pangenomes_out
    type:
      type: array
      items: File
    doc: Pangenome .h5 files with the annotation and the detected systems
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
      - $(inputs.hmm_files)
      - $(inputs.model_files)
      - $(inputs.table_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
