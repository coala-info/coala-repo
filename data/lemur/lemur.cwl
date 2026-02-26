cwlVersion: v1.2
class: CommandLineTool
baseCommand: lemur
label: lemur
doc: "Lemur example: lemur -i <input> -o <output_dir> -t <threads>\n\nTool homepage:
  https://github.com/treangenlab/lemur"
inputs:
  - id: aln_score
    type:
      - 'null'
      - string
    doc: 'AS: Use SAM AS tag for score, edit: Use edit-type distribution for score,
      markov: Score CIGAR as markov chain'
    inputBinding:
      position: 101
      prefix: --aln-score
  - id: aln_score_gene
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --aln-score-gene
  - id: db_prefix
    type:
      - 'null'
      - Directory
    doc: Path to the folder with individual Emu DBs for each marker gene
    inputBinding:
      position: 101
      prefix: --db-prefix
  - id: gid_name
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --gid-name
  - id: input
    type: File
    doc: Input FASTQ file for the analysis
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_alignments
    type:
      - 'null'
      - boolean
    doc: Keep SAM files after the mapping (might require a lot of disk space)
    inputBinding:
      position: 101
      prefix: --keep-alignments
  - id: log_file
    type:
      - 'null'
      - File
    doc: File for logging
    default: stdout
    inputBinding:
      position: 101
      prefix: --log-file
  - id: min_aln_len_ratio
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-aln-len-ratio
  - id: min_fidelity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-fidelity
  - id: mm2_k
    type:
      - 'null'
      - string
    doc: minibatch size for minimap2 mapping
    default: 500M
    inputBinding:
      position: 101
      prefix: --mm2-K
  - id: mm2_n
    type:
      - 'null'
      - int
    doc: minimap max number of secondary alignments per read
    default: 50
    inputBinding:
      position: 101
      prefix: --mm2-N
  - id: mm2_type
    type:
      - 'null'
      - string
    doc: 'ONT: map-ont [map-ont], PacBio (hifi): map-hifi, PacBio (CLR): map-pb, short-read:
      sr'
    default: map-ont
    inputBinding:
      position: 101
      prefix: --mm2-type
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads you want to use
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: rank
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --rank
  - id: ref_weight
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --ref-weight
  - id: sam_input
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sam-input
  - id: save_intermediate_profile
    type:
      - 'null'
      - boolean
    doc: Will save abundance profile at every EM step
    inputBinding:
      position: 101
      prefix: --save-intermediate-profile
  - id: tax_path
    type:
      - 'null'
      - File
    doc: Path to the taxonomy.tsv file (common for all DBs)
    inputBinding:
      position: 101
      prefix: --tax-path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable DEBUG level logging
    inputBinding:
      position: 101
      prefix: --verbose
  - id: width_filter
    type:
      - 'null'
      - boolean
    doc: Apply width filter
    inputBinding:
      position: 101
      prefix: --width-filter
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Folder where the Mob output will be stored
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lemur:1.0.1--hdfd78af_0
