cwlVersion: v1.2
class: CommandLineTool
baseCommand: streme
label: streme
doc: "STREME (Sensitive, Thorough, Rapid, Enriched Motif Elicitation) discovers motifs
  in a set of sequences.\n\nTool homepage: https://meme-suite.org"
inputs:
  - id: align
    type:
      - 'null'
      - string
    doc: align sequences left/center/right for site positional distribution plots
    default: center
    inputBinding:
      position: 101
      prefix: --align
  - id: alphabet_file
    type:
      - 'null'
      - File
    doc: sequences use alphabet defined in <alph_file>
    inputBinding:
      position: 101
      prefix: --alph
  - id: background_file
    type:
      - 'null'
      - File
    doc: use the background model contained in bfile instead of creating it from the
      control sequences
    inputBinding:
      position: 101
      prefix: --bfile
  - id: control_sequences
    type:
      - 'null'
      - File
    doc: control (negative) sequence file name
    inputBinding:
      position: 101
      prefix: --n
  - id: description_file
    type:
      - 'null'
      - File
    doc: include contents of this description file in HTML, overrides --desc
    inputBinding:
      position: 101
      prefix: --dfile
  - id: description_text
    type:
      - 'null'
      - string
    doc: include this description text in HTML
    inputBinding:
      position: 101
      prefix: --desc
  - id: dna
    type:
      - 'null'
      - boolean
    doc: sequences use standard DNA alphabet (default)
    inputBinding:
      position: 101
      prefix: --dna
  - id: hold_out_fraction
    type:
      - 'null'
      - float
    doc: fraction of sequences in hold-out set
    default: 0.1
    inputBinding:
      position: 101
      prefix: --hofract
  - id: kmer
    type:
      - 'null'
      - int
    doc: '[deprecated: use --order instead]'
    inputBinding:
      position: 101
      prefix: --kmer
  - id: max_width
    type:
      - 'null'
      - int
    doc: maximum width for motifs (must be <= 30)
    default: 15
    inputBinding:
      position: 101
      prefix: --maxw
  - id: min_width
    type:
      - 'null'
      - int
    doc: minimum width for motifs (must be >= 3)
    default: 8
    inputBinding:
      position: 101
      prefix: --minw
  - id: neval
    type:
      - 'null'
      - int
    doc: evaluate <neval> seeds of each width
    default: 25
    inputBinding:
      position: 101
      prefix: --neval
  - id: niter
    type:
      - 'null'
      - int
    doc: iterate refinement at most <niter> times per seed
    default: 20
    inputBinding:
      position: 101
      prefix: --niter
  - id: nmotifs
    type:
      - 'null'
      - int
    doc: stop if <nmotifs> motifs have been output; overrides --thresh if > 0
    inputBinding:
      position: 101
      prefix: --nmotifs
  - id: no_pgc
    type:
      - 'null'
      - boolean
    doc: do not show actual genomic coordinates for the discovered motif sites reported
      in the Sites TSV file
    inputBinding:
      position: 101
      prefix: --no-pgc
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: do not trim the control sequences even if their average length is greater
      than the primary sequences
    inputBinding:
      position: 101
      prefix: --notrim
  - id: nref
    type:
      - 'null'
      - int
    doc: refine <nref> evaluated seeds of each width
    default: 4
    inputBinding:
      position: 101
      prefix: --nref
  - id: objective_function
    type:
      - 'null'
      - string
    doc: 'objective function to optimize in motif discovery (de: Differential Enrichment,
      cd: Central Distance)'
    default: de
    inputBinding:
      position: 101
      prefix: --objfun
  - id: order
    type:
      - 'null'
      - int
    doc: estimates an m-order background model for scoring sites and uses an m-order
      shuffle if creating control sequences
    inputBinding:
      position: 101
      prefix: --order
  - id: patience
    type:
      - 'null'
      - int
    doc: quit after <patience> consecutive motifs exceed <thresh>
    default: 3
    inputBinding:
      position: 101
      prefix: --patience
  - id: primary_sequences
    type: File
    doc: primary (positive) sequence file name
    inputBinding:
      position: 101
      prefix: --p
  - id: protein
    type:
      - 'null'
      - boolean
    doc: sequences use standard protein alphabet
    inputBinding:
      position: 101
      prefix: --protein
  - id: rna
    type:
      - 'null'
      - boolean
    doc: sequences use standard RNA alphabet
    inputBinding:
      position: 101
      prefix: --rna
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for shuffling sequences
    default: 0
    inputBinding:
      position: 101
      prefix: --seed
  - id: text_only
    type:
      - 'null'
      - boolean
    doc: output text only; overrides --o and --oc
    inputBinding:
      position: 101
      prefix: --text
  - id: threshold
    type:
      - 'null'
      - float
    doc: significance threshold for reporting enriched motifs
    default: 0.05
    inputBinding:
      position: 101
      prefix: --thresh
  - id: time_limit
    type:
      - 'null'
      - int
    doc: quit before <t> CPU seconds consumed
    inputBinding:
      position: 101
      prefix: --time
  - id: total_length
    type:
      - 'null'
      - int
    doc: truncate each sequence set to length <len>; 0 means do not truncate
    default: 0
    inputBinding:
      position: 101
      prefix: --totallength
  - id: use_evalue
    type:
      - 'null'
      - boolean
    doc: 'use p-value significance threshold; default: p-value'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: verbosity
    type:
      - 'null'
      - int
    doc: level of diagnostic output (1-5)
    default: 2
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: width
    type:
      - 'null'
      - int
    doc: sets <minwidth> and <maxwidth> to <w> (must be <= 30)
    inputBinding:
      position: 101
      prefix: --w
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir_overwrite
    type:
      - 'null'
      - Directory
    doc: allow overwriting output directory
    outputBinding:
      glob: $(inputs.output_dir_overwrite)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
