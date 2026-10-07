cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - carpedeam
  - ancient_correction
label: carpedeam_ancient_correction
doc: "By Louis Kraft <lokraf@dtu.dk>\n\nTool homepage: https://github.com/LouisPwr/CarpeDeam"
inputs:
  - id: sequence_db
    type: File
    doc: Input sequence database (MMseqs2 format; the .index, .dbtype and _h
      header files sit beside it)
    secondaryFiles:
      - .index
      - .dbtype
      - _h
      - _h.index
      - _h.dbtype
      - pattern: .lookup
        required: false
      - pattern: .source
        required: false
    inputBinding:
      position: 1
  - id: aln_result
    type: File
    doc: Input alignment result (MMseqs2 format; .index and .dbtype sit beside
      it)
    secondaryFiles:
      - .index
      - .dbtype
    inputBinding:
      position: 2
  - id: ancient_damage
    type:
      - 'null'
      - File
    doc: Damage matrix (ancient), given as the <prefix>5p.prof file; the matching
      <prefix>3p.prof file must sit beside it. The tool gets the shared prefix.
    secondaryFiles:
      - pattern: $(self.basename.replace(/5p\.prof$/, '3p.prof'))
        required: true
    inputBinding:
      position: 103
      prefix: --ancient-damage
      valueFrom: $(self.path.replace(/5p\.prof$/, ''))
  - id: excess_penalty
    type:
      - 'null'
      - float
    doc: 'Use float: 0.25 to 0.5 (ancient)'
    inputBinding:
      position: 103
      prefix: --excess-penalty
  - id: ext_random_align
    type:
      - 'null'
      - float
    doc: 'Use either: 0.8 or 0.9 (ancient)'
    inputBinding:
      position: 103
      prefix: --ext-random-align
  - id: keep_target
    type:
      - 'null'
      - boolean
    doc: Keep target sequences
    inputBinding:
      position: 103
      prefix: --keep-target
  - id: likelihood_ratio_threshold
    type:
      - 'null'
      - float
    doc: Min. odds ratio to accept read extension. Range 0-1 (ancient)
    inputBinding:
      position: 103
      prefix: --likelihood-ratio-threshold
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 103
      prefix: --max-seq-len
  - id: min_cov_safe
    type:
      - 'null'
      - int
    doc: Minimum coverage of extending region (ancient)
    inputBinding:
      position: 103
      prefix: --min-cov-safe
  - id: min_merge_seq_id
    type:
      - 'null'
      - float
    doc: Min. seq. ident. of contig overlaps (ancient) (range 0.0-1.0)
    inputBinding:
      position: 103
      prefix: --min-merge-seq-id
  - id: min_ryseq_id_corr_reads
    type:
      - 'null'
      - float
    doc: Min. RY-mer space seq. ident in correction phase. Range 0-1 (ancient)
    inputBinding:
      position: 103
      prefix: --min-ryseq-id-corr-reads
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 
      0.0-1.0)
    inputBinding:
      position: 103
      prefix: --min-seq-id
  - id: min_seqid_corr_contigs
    type:
      - 'null'
      - float
    doc: Min. seq. ident. for contig correction (ancient) (range 0.0-1.0)
    inputBinding:
      position: 103
      prefix: --min-seqid-corr-contigs
  - id: min_seqid_corr_reads
    type:
      - 'null'
      - float
    doc: Min. seq. ident. in correction phase. Range 0-1 (ancient)
    inputBinding:
      position: 103
      prefix: --min-seqid-corr-reads
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance, 1: local alignment (score only),
      2: local alignment, 3: global alignment, 4: longest alignment fulfilling window
      quality criterion'
    inputBinding:
      position: 103
      prefix: --rescore-mode
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 103
      prefix: --threads
  - id: unsafe
    type:
      - 'null'
      - boolean
    doc: Maximize the contig length, but higher misassembly rate (ancient)
    inputBinding:
      position: 103
      prefix: --unsafe
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 103
      prefix: -v
  - id: repr_seq_db_path
    type: string
    doc: Output representative sequence database
    inputBinding:
      position: 3
outputs:
  - id: repr_seq_db
    type:
      type: array
      items: File
    doc: Output representative sequence database (all of its files)
    outputBinding:
      glob: '$(inputs.repr_seq_db_path)*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
