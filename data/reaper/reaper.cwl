cwlVersion: v1.2
class: CommandLineTool
baseCommand: reaper
label: reaper
doc: "Reaper is a tool for processing sequencing reads, particularly for removing
  adapters and other unwanted sequences.\n\nTool homepage: https://www.ebi.ac.uk/~stijn/reaper/reaper.html"
inputs:
  - id: basename
    type:
      - 'null'
      - string
    doc: pfx.lint.gz, pfx.clean.gz pfx.report etc will be constructed
    inputBinding:
      position: 101
      prefix: -basename
  - id: bcq_early
    type:
      - 'null'
      - boolean
    doc: perform early 'B' quality filtering (when reading sequences)
    inputBinding:
      position: 101
      prefix: --bcq-early
  - id: bcq_late
    type:
      - 'null'
      - boolean
    doc: perform late 'B' quality filtering (before outputting sequences)
    inputBinding:
      position: 101
      prefix: --bcq-late
  - id: clean_length
    type:
      - 'null'
      - int
    doc: minimum allowed clean length
    inputBinding:
      position: 101
      prefix: -clean-length
  - id: debug
    type:
      - 'null'
      - string
    doc: a=alignments c=clean l=lint
    inputBinding:
      position: 101
      prefix: -debug
  - id: dust_suffix_threshold
    type:
      - 'null'
      - int
    doc: dust theshold for read suffix
    inputBinding:
      position: 101
      prefix: -dust-suffix
  - id: fasta_in
    type:
      - 'null'
      - boolean
    doc: read FASTA input
    inputBinding:
      position: 101
      prefix: --fasta-in
  - id: five_prime_barcode
    type:
      - 'null'
      - string
    doc: l/e[/g[/o]] (default 0/0/0/2)
    inputBinding:
      position: 101
      prefix: -5p-barcode
  - id: five_prime_sequence_insert
    type:
      - 'null'
      - string
    doc: five prime sequence insert
    inputBinding:
      position: 101
      prefix: -5psi
  - id: five_prime_sinsert
    type:
      - 'null'
      - string
    doc: l/e[/g[/o]] (default 0/2/1/1)
    inputBinding:
      position: 101
      prefix: -5p-sinsert
  - id: format_clean
    type:
      - 'null'
      - string
    doc: output for clean reads
    inputBinding:
      position: 101
      prefix: -format-clean
  - id: format_lint
    type:
      - 'null'
      - string
    doc: output for filtered reads
    inputBinding:
      position: 101
      prefix: -format-lint
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: only allow reads not shortened in any filter step
    inputBinding:
      position: 101
      prefix: --full-length
  - id: geometry_mode
    type: string
    doc: mode in {no-bc, 3p-bc, 5p-bc}
    inputBinding:
      position: 101
      prefix: -geom
  - id: guard
    type:
      - 'null'
      - int
    doc: protect first <int> bases in read from adapter and tabu matching
    inputBinding:
      position: 101
      prefix: -guard
  - id: input_stream
    type:
      - 'null'
      - File
    doc: input stream (gzipped file allowed)
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: delete rather than discard reads (e.g. tabu match, missing 5p-sinsert)
    inputBinding:
      position: 101
      prefix: --keep-all
  - id: meta_file
    type: File
    doc: 'file with geometry-dependent format. Required columns: Geometry Columns:
      no-bc 3p-ad - - - tabu 3p-bc 3p-ad barcode 3p-si - tabu 5p-bc 3p-ad barcode
      - 5p-si tabu bc=barcode, ad=adaptor, si=sequence insert Columns 3p-si, 5p-si,
      3p-ad and tabu may all be empty Alternatively, to express absence, a single
      hyphen may be used'
    inputBinding:
      position: 101
      prefix: -meta
  - id: mr_tabu
    type:
      - 'null'
      - string
    doc: l/e[/g[/o]] (default 16/2/1/0)
    inputBinding:
      position: 101
      prefix: -mr-tabu
  - id: nnn_check
    type:
      - 'null'
      - string
    doc: "disregard read onwards from seeing <count> N's in <outof> bases (format:
      <count>/<outof>)"
    inputBinding:
      position: 101
      prefix: -nnn-check
  - id: noqc
    type:
      - 'null'
      - boolean
    doc: do not output quality report files
    inputBinding:
      position: 101
      prefix: --noqc
  - id: nozip
    type:
      - 'null'
      - boolean
    doc: do not output gzipped files
    inputBinding:
      position: 101
      prefix: --nozip
  - id: polya
    type:
      - 'null'
      - int
    doc: remove trailing A's if length exceeds <int>
    inputBinding:
      position: 101
      prefix: -polya
  - id: qqq_check
    type:
      - 'null'
      - string
    doc: 'cut sequence when median quality drops below <val> (format: <val>/<winlen>
      or <val>/<winlen>/<winofs> or <val>/<winlen>/<winofs>/<readofs>)'
    inputBinding:
      position: 101
      prefix: -qqq-check
  - id: record_format
    type:
      - 'null'
      - string
    doc: record format (record description, default @%I%A%n%R%n+%#%Q%n)
    inputBinding:
      position: 101
      prefix: -record-format
  - id: record_format2
    type:
      - 'null'
      - string
    doc: 'simple line formats, one field per line: R read, I read identifier, Q quality
      scores, D discard field'
    inputBinding:
      position: 101
      prefix: -record-format2
  - id: restrict
    type:
      - 'null'
      - int
    doc: only use the first <int> bases of adapter or tabu sequence. This is to 
      avoid false positive matches
    inputBinding:
      position: 101
      prefix: -restrict
  - id: sample
    type:
      - 'null'
      - string
    doc: if debug, sample every c/l clean/lint read
    inputBinding:
      position: 101
      prefix: -sample
  - id: sc_max
    type:
      - 'null'
      - float
    doc: threshold for complexity of suffix following prefix match
    inputBinding:
      position: 101
      prefix: -sc-max
  - id: swp_costs
    type:
      - 'null'
      - string
    doc: M/S/G match/substitution/gap gain/cost/cost (default 4/1/3)
    inputBinding:
      position: 101
      prefix: -swp
  - id: tabu_sequence
    type:
      - 'null'
      - string
    doc: tabu sequence
    inputBinding:
      position: 101
      prefix: -tabu
  - id: three_prime_adaptor
    type:
      - 'null'
      - string
    doc: three prime adaptor
    inputBinding:
      position: 101
      prefix: -3pa
  - id: three_prime_barcode
    type:
      - 'null'
      - string
    doc: l/e[/g[/o]] (default 0/6/1/0)
    inputBinding:
      position: 101
      prefix: -3p-barcode
  - id: three_prime_global
    type:
      - 'null'
      - string
    doc: l/e[/g[/o]] (default 14/2/1/0)
    inputBinding:
      position: 101
      prefix: -3p-global
  - id: three_prime_head_to_tail
    type:
      - 'null'
      - int
    doc: minimal trailing perfect match length
    inputBinding:
      position: 101
      prefix: -3p-head-to-tail
  - id: three_prime_prefix
    type:
      - 'null'
      - string
    doc: l/e[/g[/o]] (default 8/2/0/2)
    inputBinding:
      position: 101
      prefix: -3p-prefix
  - id: tri_threshold
    type:
      - 'null'
      - float
    doc: filter out reads with tri-nt score > threshold a reasonable <threshold>
      is 35
    inputBinding:
      position: 101
      prefix: -tri
  - id: trim_length
    type:
      - 'null'
      - int
    doc: cut reads back to length <int>
    inputBinding:
      position: 101
      prefix: -trim-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reaper:16.098--ha92aebf_2
stdout: reaper.out
