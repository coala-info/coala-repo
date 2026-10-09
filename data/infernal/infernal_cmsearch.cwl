cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmsearch
label: infernal_cmsearch
doc: "search CM(s) against a sequence database\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: 'Covariance model file (calibrated for E-values)'
    inputBinding:
      position: 200
  - id: seqdb
    type: File
    doc: 'Target sequence database (FASTA or other supported format)'
    inputBinding:
      position: 201
  - id: glocal
    type:
      - 'null'
      - boolean
    doc: 'configure CM for glocal alignment [default: local]'
    inputBinding:
      position: 101
      prefix: -g
  - id: search_space_mb
    type:
      - 'null'
      - float
    doc: 'set search space size in *Mb* to <x> for E-value calculations (x>0)'
    inputBinding:
      position: 101
      prefix: -Z
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'direct output to file <f>, not stdout'
    inputBinding:
      position: 101
      prefix: -o
  - id: aln_out
    type:
      - 'null'
      - string
    doc: 'save multiple alignment of all significant hits to file <s>'
    inputBinding:
      position: 101
      prefix: -A
  - id: tblout
    type:
      - 'null'
      - string
    doc: 'save parseable table of hits to file <s>'
    inputBinding:
      position: 101
      prefix: --tblout
  - id: fmt
    type:
      - 'null'
      - int
    doc: 'set hit table format to <n> (1<=n<=3)'
    inputBinding:
      position: 101
      prefix: --fmt
  - id: acc
    type:
      - 'null'
      - boolean
    doc: 'prefer accessions over names in output'
    inputBinding:
      position: 101
      prefix: --acc
  - id: noali
    type:
      - 'null'
      - boolean
    doc: 'don''t output alignments, so output is smaller'
    inputBinding:
      position: 101
      prefix: --noali
  - id: notextw
    type:
      - 'null'
      - boolean
    doc: 'unlimit ASCII text output line width'
    inputBinding:
      position: 101
      prefix: --notextw
  - id: textw
    type:
      - 'null'
      - int
    doc: 'set max width of ASCII text output lines [120] (n>=120)'
    inputBinding:
      position: 101
      prefix: --textw
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'report extra information; mainly useful for debugging'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: nomiss
    type:
      - 'null'
      - boolean
    doc: 'with -A, do not mark truncated hits with missing (~) chars'
    inputBinding:
      position: 101
      prefix: --nomiss
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'report sequences <= this E-value threshold in output [10.0] (x>0)'
    inputBinding:
      position: 101
      prefix: -E
  - id: score
    type:
      - 'null'
      - float
    doc: 'report sequences >= this score threshold in output'
    inputBinding:
      position: 101
      prefix: -T
  - id: incE
    type:
      - 'null'
      - float
    doc: 'consider sequences <= this E-value threshold as significant [0.01]'
    inputBinding:
      position: 101
      prefix: --incE
  - id: incT
    type:
      - 'null'
      - float
    doc: 'consider sequences >= this score threshold as significant'
    inputBinding:
      position: 101
      prefix: --incT
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: 'use CM''s GA gathering cutoffs as reporting thresholds'
    inputBinding:
      position: 101
      prefix: --cut_ga
  - id: cut_nc
    type:
      - 'null'
      - boolean
    doc: 'use CM''s NC noise cutoffs as reporting thresholds'
    inputBinding:
      position: 101
      prefix: --cut_nc
  - id: cut_tc
    type:
      - 'null'
      - boolean
    doc: 'use CM''s TC trusted cutoffs as reporting thresholds'
    inputBinding:
      position: 101
      prefix: --cut_tc
  - id: max
    type:
      - 'null'
      - boolean
    doc: 'turn all heuristic filters off (slow)'
    inputBinding:
      position: 101
      prefix: --max
  - id: nohmm
    type:
      - 'null'
      - boolean
    doc: 'skip all HMM filter stages, use only CM (slow)'
    inputBinding:
      position: 101
      prefix: --nohmm
  - id: mid
    type:
      - 'null'
      - boolean
    doc: 'skip first two HMM filter stages (SSV & Vit)'
    inputBinding:
      position: 101
      prefix: --mid
  - id: default
    type:
      - 'null'
      - boolean
    doc: 'default: run search space size-dependent pipeline [default]'
    inputBinding:
      position: 101
      prefix: --default
  - id: rfam
    type:
      - 'null'
      - boolean
    doc: 'set heuristic filters at Rfam-level (fast)'
    inputBinding:
      position: 101
      prefix: --rfam
  - id: hmmonly
    type:
      - 'null'
      - boolean
    doc: 'use HMM only, don''t use a CM at all'
    inputBinding:
      position: 101
      prefix: --hmmonly
  - id: FZ
    type:
      - 'null'
      - float
    doc: 'set filters to defaults used for a search space of size <x> Mb'
    inputBinding:
      position: 101
      prefix: --FZ
  - id: Fmid
    type:
      - 'null'
      - float
    doc: 'with --mid, set P-value threshold for HMM stages to <x> [0.02]'
    inputBinding:
      position: 101
      prefix: --Fmid
  - id: notrunc
    type:
      - 'null'
      - boolean
    doc: 'do not allow truncated hits at sequence termini'
    inputBinding:
      position: 101
      prefix: --notrunc
  - id: anytrunc
    type:
      - 'null'
      - boolean
    doc: 'allow full+truncated hits at terminii and anywhere within seqs'
    inputBinding:
      position: 101
      prefix: --anytrunc
  - id: nonull_model3
    type:
      - 'null'
      - boolean
    doc: 'turn off the NULL3 post hoc additional null model'
    inputBinding:
      position: 101
      prefix: --nonull3
  - id: mxsize
    type:
      - 'null'
      - float
    doc: 'set max allowed alnment mx size to <x> Mb [df: autodetermined]'
    inputBinding:
      position: 101
      prefix: --mxsize
  - id: smxsize
    type:
      - 'null'
      - float
    doc: 'set max allowed size of search DP matrices to <x> Mb [128.]'
    inputBinding:
      position: 101
      prefix: --smxsize
  - id: cyk
    type:
      - 'null'
      - boolean
    doc: 'use scanning CM CYK algorithm, not Inside in final stage'
    inputBinding:
      position: 101
      prefix: --cyk
  - id: acyk
    type:
      - 'null'
      - boolean
    doc: 'align hits with CYK, not optimal accuracy'
    inputBinding:
      position: 101
      prefix: --acyk
  - id: wcx
    type:
      - 'null'
      - float
    doc: 'set W (expected max hit len) as <x> * cm->clen (model len)'
    inputBinding:
      position: 101
      prefix: --wcx
  - id: toponly
    type:
      - 'null'
      - boolean
    doc: 'only search the top strand'
    inputBinding:
      position: 101
      prefix: --toponly
  - id: bottomonly
    type:
      - 'null'
      - boolean
    doc: 'only search the bottom strand'
    inputBinding:
      position: 101
      prefix: --bottomonly
  - id: tformat
    type:
      - 'null'
      - string
    doc: 'assert target <seqdb> is in format <s>: no autodetection'
    inputBinding:
      position: 101
      prefix: --tformat
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'number of parallel CPU workers to use for multithreads [4]'
    inputBinding:
      position: 101
      prefix: --cpu
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: 'direct output to file <f>, not stdout'
    outputBinding:
      glob: $(inputs.outfile)
  - id: output_aln_out
    type:
      - 'null'
      - File
    doc: 'save multiple alignment of all significant hits to file <s>'
    outputBinding:
      glob: $(inputs.aln_out)
  - id: output_tblout
    type:
      - 'null'
      - File
    doc: 'save parseable table of hits to file <s>'
    outputBinding:
      glob: $(inputs.tblout)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmsearch.out
