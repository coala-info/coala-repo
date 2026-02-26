cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - pansystems
label: panorama_pansystems
doc: "PANORAMA (0.6.0) is an opensource bioinformatic tools under CeCILL FREE SOFTWARE
  LICENSE AGREEMENT\n\nTool homepage: https://github.com/labgem/panorama"
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
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Output in binary format
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
  - id: jaccard
    type:
      - 'null'
      - float
    doc: minimum jaccard similarity used to filter edges between gene families. 
      Increasing it will improve precision but lower sensitivity a lot.
    default: 0.8
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
      - File
    doc: log output file
    default: stdout
    inputBinding:
      position: 101
      prefix: --log
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode for detection (fast, profile, sensitive)
    default: fast
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
    doc: A list of tab-separated file, containing annotation of gene 
      families.Expected format is pangenome name in first column and path to the
      TSV with annotation in second column.
    inputBinding:
      position: 101
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Path to temporary directory
    default: /tmp/panorama
    inputBinding:
      position: 101
      prefix: --tmp
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    default: 1
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
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
