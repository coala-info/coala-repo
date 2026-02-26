cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-extract_region.py
label: amptk_database
doc: "Script searches for primers and removes them if found. Useful for trimming a
  reference dataset for assigning taxonomy after OTU clustering. It is also capable
  of reformatting UNITE taxonomy fasta headers to be compatible with UTAX and creating
  USEARCH/UTAX UBD databases for assigning taxonomy.\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: cpus
    type:
      - 'null'
      - string
    doc: 'Number of CPUs. Default: auto'
    default: auto
    inputBinding:
      position: 101
      prefix: --cpus
  - id: create_db
    type:
      - 'null'
      - string
    doc: Create USEARCH DB
    default: None
    inputBinding:
      position: 101
      prefix: --create_db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Remove Intermediate Files
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: derep_fulllength
    type:
      - 'null'
      - boolean
    doc: 'De-replicate sequences. Default: off'
    default: false
    inputBinding:
      position: 101
      prefix: --derep_fulllength
  - id: drop_ns
    type:
      - 'null'
      - int
    doc: "Drop Seqeunces with more than X # of N's"
    default: 8
    inputBinding:
      position: 101
      prefix: --drop_ns
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: FASTA input
    default: None
    inputBinding:
      position: 101
      prefix: --fasta
  - id: format
    type:
      - 'null'
      - string
    doc: Reformat FASTA headers for UTAX
    default: unite2utax
    inputBinding:
      position: 101
      prefix: --format
  - id: fwd_primer
    type: string
    doc: Forward primer (fITS7)
    default: fITS7
    inputBinding:
      position: 101
      prefix: --fwd_primer
  - id: install
    type:
      - 'null'
      - boolean
    doc: Install into AMPtk database
    default: false
    inputBinding:
      position: 101
      prefix: --install
  - id: lca
    type:
      - 'null'
      - boolean
    doc: Run LCA (last common ancestor) for dereplicating taxonomy
    default: false
    inputBinding:
      position: 101
      prefix: --lca
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum read length to keep
    default: 1200
    inputBinding:
      position: 101
      prefix: --max_len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length to keep
    default: 100
    inputBinding:
      position: 101
      prefix: --min_len
  - id: output_base_name
    type:
      - 'null'
      - string
    doc: Base Name Output files
    default: None
    inputBinding:
      position: 101
      prefix: --out
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Max Primer Mismatch
    default: 2
    inputBinding:
      position: 101
      prefix: --primer_mismatch
  - id: primer_required
    type:
      - 'null'
      - string
    doc: 'Keep Seq if primer found Default: for'
    default: for
    inputBinding:
      position: 101
      prefix: --primer_required
  - id: rev_primer
    type:
      - 'null'
      - string
    doc: Reverse primer (ITS4)
    default: ITS4
    inputBinding:
      position: 101
      prefix: --rev_primer
  - id: skip_trimming
    type:
      - 'null'
      - boolean
    doc: Skip Primer trimming (not recommended)
    default: false
    inputBinding:
      position: 101
      prefix: --skip_trimming
  - id: source
    type:
      - 'null'
      - string
    doc: 'DB source and version separated by :'
    default: ':'
    inputBinding:
      position: 101
      prefix: --source
  - id: subsample
    type:
      - 'null'
      - string
    doc: Random subsample
    default: None
    inputBinding:
      position: 101
      prefix: --subsample
  - id: trunclen
    type:
      - 'null'
      - int
    doc: Truncate reads to length
    default: None
    inputBinding:
      position: 101
      prefix: --trunclen
  - id: usearch
    type:
      - 'null'
      - File
    doc: USEARCH9 EXE
    default: usearch9
    inputBinding:
      position: 101
      prefix: --usearch
  - id: utax_splitlevels
    type:
      - 'null'
      - string
    doc: UTAX training parameters
    default: NVkpcofgs
    inputBinding:
      position: 101
      prefix: --utax_splitlevels
  - id: utax_trainlevels
    type:
      - 'null'
      - string
    doc: UTAX training parameters
    default: kpcofgs
    inputBinding:
      position: 101
      prefix: --utax_trainlevels
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_database.out
