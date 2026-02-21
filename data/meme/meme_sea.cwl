cwlVersion: v1.2
class: CommandLineTool
baseCommand: sea
label: meme_sea
doc: "Simple Enrichment Analysis (SEA) for motifs in sequences.\n\nTool homepage:
  https://meme-suite.org"
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
    doc: motifs will be converted to this custom alphabet
    inputBinding:
      position: 101
      prefix: --xalph
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
    doc: 'control (negative) sequence file name; defaults: if --n is not given, then
      SEA creates one by shuffling the primary sequences'
    inputBinding:
      position: 101
      prefix: --n
  - id: description_file
    type:
      - 'null'
      - File
    doc: include contents of this description file in HTML
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
  - id: exclude_pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: name pattern to exclude as motif; may be repeated
    inputBinding:
      position: 101
      prefix: --exc
  - id: hold_out_fraction
    type:
      - 'null'
      - float
    doc: fraction of sequences in hold-out set
    default: 0.1
    inputBinding:
      position: 101
      prefix: --hofract
  - id: include_pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: name pattern to select as motif; may be repeated
    inputBinding:
      position: 101
      prefix: --inc
  - id: motif_pseudocount
    type:
      - 'null'
      - float
    doc: pseudocount for creating PWMs from motifs
    default: 0.1
    inputBinding:
      position: 101
      prefix: --motif-pseudo
  - id: motifs
    type:
      type: array
      items: File
    doc: motif file name (may be repeated)
    inputBinding:
      position: 101
      prefix: --m
  - id: no_pgc
    type:
      - 'null'
      - boolean
    doc: do not show actual genomic coordinates for the motif sites reported in the
      Sites TSV file
    inputBinding:
      position: 101
      prefix: --no-pgc
  - id: no_seqs
    type:
      - 'null'
      - boolean
    doc: do not output matching sequences TSV file
    inputBinding:
      position: 101
      prefix: --noseqs
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: do not trim the control sequences even if their average length is greater
      the than primary sequences
    inputBinding:
      position: 101
      prefix: --notrim
  - id: order
    type:
      - 'null'
      - int
    doc: estimate an m-order background model and use an m-order shuffle if creating
      control sequences from primary sequences
    inputBinding:
      position: 101
      prefix: --order
  - id: primary_sequences
    type: File
    doc: primary (positive) sequence file name
    inputBinding:
      position: 101
      prefix: --p
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
      - string
    doc: 'significance threshold for reporting enriched motifs; default: E-value=
      10 (0.05 if --qvalue or --pvalue given)'
    inputBinding:
      position: 101
      prefix: --thresh
  - id: use_pvalue
    type:
      - 'null'
      - boolean
    doc: use p-value significance threshold
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: use_qvalue
    type:
      - 'null'
      - boolean
    doc: use q-value significance threshold
    inputBinding:
      position: 101
      prefix: --qvalue
  - id: verbosity
    type:
      - 'null'
      - int
    doc: level of diagnostic output
    default: 2
    inputBinding:
      position: 101
      prefix: --verbosity
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
