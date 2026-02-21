cwlVersion: v1.2
class: CommandLineTool
baseCommand: mast
label: meme_mast
doc: "Motif Alignment and Search Tool (MAST) - searches for motifs in sequence databases.\n
  \nTool homepage: https://meme-suite.org"
inputs:
  - id: motif_file
    type: File
    doc: File containing motifs
    inputBinding:
      position: 1
  - id: sequence_file
    type: File
    doc: File containing sequences to search
    inputBinding:
      position: 2
  - id: best
    type:
      - 'null'
      - boolean
    doc: include only the best motif in diagrams; hit_list mode only
    inputBinding:
      position: 103
      prefix: -best
  - id: bfile
    type:
      - 'null'
      - File
    doc: read background frequencies from <bf>
    inputBinding:
      position: 103
      prefix: -bfile
  - id: comp
    type:
      - 'null'
      - boolean
    doc: adjust p-values and E-values for sequence composition
    inputBinding:
      position: 103
      prefix: -comp
  - id: count
    type:
      - 'null'
      - int
    doc: only use the first <count> motifs or all motifs when <count> is zero
    inputBinding:
      position: 103
      prefix: -c
  - id: database_name_display
    type:
      - 'null'
      - string
    doc: in results use <df> as database name; ignored when option -dblist is specified
    inputBinding:
      position: 103
      prefix: -df
  - id: dblist
    type:
      - 'null'
      - boolean
    doc: the file specified as database contains a list of databases
    inputBinding:
      position: 103
      prefix: -dblist
  - id: diag
    type:
      - 'null'
      - string
    doc: nominal order and spacing of motifs
    inputBinding:
      position: 103
      prefix: -diag
  - id: dna
    type:
      - 'null'
      - boolean
    doc: translate DNA sequences to protein
    inputBinding:
      position: 103
      prefix: -dna
  - id: evalue_threshold
    type:
      - 'null'
      - float
    doc: print results for sequences with E-value < <ev>
    default: 10
    inputBinding:
      position: 103
      prefix: -ev
  - id: hit_list
    type:
      - 'null'
      - boolean
    doc: print only a list of non-overlapping hits to stdout
    inputBinding:
      position: 103
      prefix: -hit_list
  - id: link_display
    type:
      - 'null'
      - string
    doc: in results use <dl> as link to search sequence names; ignored when -dblist
      specified
    inputBinding:
      position: 103
      prefix: -dl
  - id: min_seqs
    type:
      - 'null'
      - int
    doc: lower bound on number of sequences in db
    inputBinding:
      position: 103
      prefix: -minseqs
  - id: motif_evalue_threshold
    type:
      - 'null'
      - float
    doc: use only motifs with E-values (or p-values) less than or equal to <thresh>
    inputBinding:
      position: 103
      prefix: -mev
  - id: motif_file_name_display
    type:
      - 'null'
      - string
    doc: in results use <mf> as motif file name
    inputBinding:
      position: 103
      prefix: -mv
  - id: motif_index
    type:
      - 'null'
      - type: array
        items: int
    doc: use only motif(s) numbered <m> (overrides -mev); can be repeated
    inputBinding:
      position: 103
      prefix: -mi
  - id: motif_name
    type:
      - 'null'
      - type: array
        items: string
    doc: use only motif(s) named <id> (overrides -mev); can be repeated
    inputBinding:
      position: 103
      prefix: -m
  - id: no_html
    type:
      - 'null'
      - boolean
    doc: do not generate html output
    inputBinding:
      position: 103
      prefix: -nohtml
  - id: no_status
    type:
      - 'null'
      - boolean
    doc: do not print progress report
    inputBinding:
      position: 103
      prefix: -nostatus
  - id: no_text
    type:
      - 'null'
      - boolean
    doc: do not generate text output
    inputBinding:
      position: 103
      prefix: -notext
  - id: norc
    type:
      - 'null'
      - boolean
    doc: do not score reverse complement DNA strand
    inputBinding:
      position: 103
      prefix: -norc
  - id: pvalue_threshold
    type:
      - 'null'
      - float
    doc: show motif matches with p-value < mt
    default: 0.0001
    inputBinding:
      position: 103
      prefix: -mt
  - id: remcorr
    type:
      - 'null'
      - boolean
    doc: remove highly correlated motifs from query
    inputBinding:
      position: 103
      prefix: -remcorr
  - id: sep
    type:
      - 'null'
      - boolean
    doc: score reverse complement DNA strand as a separate sequence
    inputBinding:
      position: 103
      prefix: -sep
  - id: seqp
    type:
      - 'null'
      - boolean
    doc: 'use SEQUENCE p-values for motif thresholds (default: use POSITION p-values)'
    inputBinding:
      position: 103
      prefix: -seqp
  - id: show_weak
    type:
      - 'null'
      - boolean
    doc: show weak matches (mt < p-value < mt*10) in angle brackets
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: directory to output mast results
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_dir_overwrite
    type:
      - 'null'
      - Directory
    doc: directory to output mast results with overwriting allowed
    outputBinding:
      glob: $(inputs.output_dir_overwrite)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meme:5.5.9--pl5321h1ca524f_0
