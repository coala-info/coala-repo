cwlVersion: v1.2
class: CommandLineTool
baseCommand: promoterwise
label: wise2_promoterwise
doc: "Seed restriction\n\nTool homepage: https://www.ebi.ac.uk/~birney/wise2/"
inputs:
  - id: query_sequence
    type: string
    doc: Query sequence
    inputBinding:
      position: 1
  - id: target_sequence
    type: string
    doc: Target sequence
    inputBinding:
      position: 2
  - id: align
    type:
      - 'null'
      - string
    doc: use normal DBA or motif alignment
    default: normal
    inputBinding:
      position: 103
      prefix: -align
  - id: ben_motif_library
    type:
      - 'null'
      - boolean
    doc: motif library is in Ben's IUPAC format (default is Ewan's)
    inputBinding:
      position: 103
      prefix: -ben
  - id: dycache
    type:
      - 'null'
      - boolean
    doc: implicitly cache dy matrix usage
    inputBinding:
      position: 103
      prefix: -dycache
  - id: dydebug
    type:
      - 'null'
      - boolean
    doc: drop into dynamite dp matrix debugger
    inputBinding:
      position: 103
      prefix: -dydebug
  - id: dymem
    type:
      - 'null'
      - string
    doc: memory style
    default: default
    inputBinding:
      position: 103
      prefix: -dymem
  - id: errorlog
    type:
      - 'null'
      - File
    doc: Log warning messages to file
    inputBinding:
      position: 103
      prefix: -errorlog
  - id: erroroffstd
    type:
      - 'null'
      - boolean
    doc: No warning messages to stderr
    inputBinding:
      position: 103
      prefix: -erroroffstd
  - id: errorstyle
    type:
      - 'null'
      - string
    doc: style of error reporting
    default: program
    inputBinding:
      position: 103
      prefix: -errorstyle
  - id: hithelp
    type:
      - 'null'
      - boolean
    doc: more detailed help on hitlist formats
    inputBinding:
      position: 103
      prefix: -hithelp
  - id: hitoutput
    type:
      - 'null'
      - string
    doc: pseudoblast by default
    default: pseudoblast
    inputBinding:
      position: 103
      prefix: -hitoutput
  - id: kbyte
    type:
      - 'null'
      - int
    doc: memory amount to use
    default: 4000
    inputBinding:
      position: 103
      prefix: -kbyte
  - id: lhaln
    type:
      - 'null'
      - float
    doc: aln score cutoff
    default: 8.0
    inputBinding:
      position: 103
      prefix: -lhaln
  - id: lhmax
    type:
      - 'null'
      - int
    doc: maximum number of processed hits
    default: 20000
    inputBinding:
      position: 103
      prefix: -lhmax
  - id: lhreject
    type:
      - 'null'
      - string
    doc: overlap rejection criteria in greedy assembly
    default: query
    inputBinding:
      position: 103
      prefix: -lhreject
  - id: lhscore
    type:
      - 'null'
      - boolean
    doc: sort final list by score (default by position)
    inputBinding:
      position: 103
      prefix: -lhscore
  - id: lhseed
    type:
      - 'null'
      - float
    doc: seed score cutoff
    default: 10.0
    inputBinding:
      position: 103
      prefix: -lhseed
  - id: lhwindow
    type:
      - 'null'
      - int
    doc: sequence window given to alignment
    default: 50
    inputBinding:
      position: 103
      prefix: -lhwindow
  - id: lr_motif_library
    type:
      - 'null'
      - boolean
    doc: motif library is in Laurence's format (default is Ewan's)
    inputBinding:
      position: 103
      prefix: -lr
  - id: mm_cons
    type:
      - 'null'
      - float
    doc: Probability of a match in a non-motif conserved
    default: 0.75
    inputBinding:
      position: 103
      prefix: -mm_cons
  - id: mm_cons_indel
    type:
      - 'null'
      - float
    doc: indel inside a conserved region
    default: 0.025
    inputBinding:
      position: 103
      prefix: -mm_cons_indel
  - id: mm_motif
    type:
      - 'null'
      - float
    doc: Probability of a match in a motif
    default: 0.9
    inputBinding:
      position: 103
      prefix: -mm_motif
  - id: mm_motif_indel
    type:
      - 'null'
      - float
    doc: indel inside a motif
    default: 1e-05
    inputBinding:
      position: 103
      prefix: -mm_motif_indel
  - id: mm_spacer
    type:
      - 'null'
      - float
    doc: Probability of a match in a spacer
    default: 0.35
    inputBinding:
      position: 103
      prefix: -mm_spacer
  - id: mm_spacer_indel
    type:
      - 'null'
      - float
    doc: indel inside a spacer
    default: 0.1
    inputBinding:
      position: 103
      prefix: -mm_spacer_indel
  - id: mm_switch_cons
    type:
      - 'null'
      - float
    doc: cost of switching to conserved match
    default: 1e-06
    inputBinding:
      position: 103
      prefix: -mm_switch_cons
  - id: mm_switch_motif
    type:
      - 'null'
      - float
    doc: cost of switching to motif match
    default: 0.05
    inputBinding:
      position: 103
      prefix: -mm_switch_motif
  - id: motiflib_file
    type:
      - 'null'
      - File
    doc: motif library file name
    inputBinding:
      position: 103
      prefix: -motiflib
  - id: nodycache
    type:
      - 'null'
      - boolean
    doc: implicitly cache dy matrix usage
    inputBinding:
      position: 103
      prefix: -nodycache
  - id: notfb_warn
    type:
      - 'null'
      - boolean
    doc: warn on small sequence number
    inputBinding:
      position: 103
      prefix: -notfb_warn
  - id: paldebug
    type:
      - 'null'
      - boolean
    doc: print PackAln after debugger run if used
    inputBinding:
      position: 103
      prefix: -paldebug
  - id: query_end_restriction
    type:
      - 'null'
      - boolean
    doc: query end position restriction
    inputBinding:
      position: 103
      prefix: -t
  - id: query_start_restriction
    type:
      - 'null'
      - boolean
    doc: query start position restriction
    inputBinding:
      position: 103
      prefix: -s
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No report/info on stderr
    inputBinding:
      position: 103
      prefix: -quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: No messages on stderr
    inputBinding:
      position: 103
      prefix: -silent
  - id: target_end_restriction
    type:
      - 'null'
      - boolean
    doc: target end position restriction
    inputBinding:
      position: 103
      prefix: -v
  - id: target_start_restriction
    type:
      - 'null'
      - boolean
    doc: target start position restriction
    inputBinding:
      position: 103
      prefix: -u
  - id: tfb_pseudo
    type:
      - 'null'
      - float
    doc: simple pseudo count
    default: 0.3
    inputBinding:
      position: 103
      prefix: -tfb_pseudo
  - id: tfb_warn
    type:
      - 'null'
      - boolean
    doc: warn on small sequence number
    inputBinding:
      position: 103
      prefix: -tfb_warn
  - id: tfm_cutoff
    type:
      - 'null'
      - float
    doc: bits cutoff for absolute matches
    default: 11.0
    inputBinding:
      position: 103
      prefix: -tfm_cutoff
  - id: tfm_rel
    type:
      - 'null'
      - float
    doc: Relative to best possible score, accept if above irregardless of score
    default: 0.95
    inputBinding:
      position: 103
      prefix: -tfm_rel
  - id: tfm_relbits
    type:
      - 'null'
      - float
    doc: If above relsoft and above this bits score, accept
    default: 11.0
    inputBinding:
      position: 103
      prefix: -tfm_relbits
  - id: tfm_relsoft
    type:
      - 'null'
      - float
    doc: Relative to best possible score, accept if above this relative and bit 
      score
    default: 0.9
    inputBinding:
      position: 103
      prefix: -tfm_relsoft
  - id: tfm_type
    type:
      - 'null'
      - string
    doc: 'type of cutoff: absolute, relative, relative mixed'
    default: abs
    inputBinding:
      position: 103
      prefix: -tfm_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wise2:2.4.1--h08bb679_0
stdout: wise2_promoterwise.out
