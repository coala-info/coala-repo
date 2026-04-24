cwlVersion: v1.2
class: CommandLineTool
baseCommand: jackhmmer
label: hmmer_jackhmmer
doc: "iteratively search a protein sequence against a protein database\n\nTool homepage:
  http://hmmer.org/"
inputs:
  - id: seqfile
    type: File
    doc: Query protein sequence file
    inputBinding:
      position: 1
  - id: seqdb
    type: File
    doc: Target protein database file
    inputBinding:
      position: 2
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel CPU workers to use for multithreads
    inputBinding:
      position: 103
      prefix: --cpu
  - id: dom_e_value_threshold
    type:
      - 'null'
      - float
    doc: report domains <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: --domE
  - id: dom_score_threshold
    type:
      - 'null'
      - float
    doc: report domains >= this score cutoff in output
    inputBinding:
      position: 103
      prefix: --domT
  - id: dom_z_comparisons
    type:
      - 'null'
      - float
    doc: 'set # of significant seqs, for domain E-value calculation'
    inputBinding:
      position: 103
      prefix: --domZ
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: report sequences <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: -E
  - id: eclust
    type:
      - 'null'
      - boolean
    doc: 'eff seq # is # of single linkage clusters'
    inputBinding:
      position: 103
      prefix: --eclust
  - id: eent
    type:
      - 'null'
      - boolean
    doc: 'adjust eff seq # to achieve relative entropy target'
    inputBinding:
      position: 103
      prefix: --eent
  - id: eentexp
    type:
      - 'null'
      - boolean
    doc: 'adjust eff seq # to reach rel. ent. target using exp scaling'
    inputBinding:
      position: 103
      prefix: --eentexp
  - id: efl
    type:
      - 'null'
      - int
    doc: length of sequences for Forward exp tail tau fit
    inputBinding:
      position: 103
      prefix: --EfL
  - id: efn
    type:
      - 'null'
      - int
    doc: number of sequences for Forward exp tail tau fit
    inputBinding:
      position: 103
      prefix: --EfN
  - id: eft
    type:
      - 'null'
      - float
    doc: tail mass for Forward exponential tail tau fit
    inputBinding:
      position: 103
      prefix: --Eft
  - id: eid
    type:
      - 'null'
      - float
    doc: 'for --eclust: set fractional identity cutoff to <x>'
    inputBinding:
      position: 103
      prefix: --eid
  - id: eml
    type:
      - 'null'
      - int
    doc: length of sequences for MSV Gumbel mu fit
    inputBinding:
      position: 103
      prefix: --EmL
  - id: emn
    type:
      - 'null'
      - int
    doc: number of sequences for MSV Gumbel mu fit
    inputBinding:
      position: 103
      prefix: --EmN
  - id: enone
    type:
      - 'null'
      - boolean
    doc: 'no effective seq # weighting: just use nseq'
    inputBinding:
      position: 103
      prefix: --enone
  - id: ere
    type:
      - 'null'
      - float
    doc: 'for --eent[exp]: set minimum rel entropy/position to <x>'
    inputBinding:
      position: 103
      prefix: --ere
  - id: eset
    type:
      - 'null'
      - float
    doc: 'set eff seq # for all models to <x>'
    inputBinding:
      position: 103
      prefix: --eset
  - id: esigma
    type:
      - 'null'
      - float
    doc: 'for --eent[exp]: set sigma param to <x>'
    inputBinding:
      position: 103
      prefix: --esigma
  - id: evl
    type:
      - 'null'
      - int
    doc: length of sequences for Viterbi Gumbel mu fit
    inputBinding:
      position: 103
      prefix: --EvL
  - id: evn
    type:
      - 'null'
      - int
    doc: number of sequences for Viterbi Gumbel mu fit
    inputBinding:
      position: 103
      prefix: --EvN
  - id: f1_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 1 (MSV) threshold: promote hits w/ P <= F1'
    inputBinding:
      position: 103
      prefix: --F1
  - id: f2_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 2 (Vit) threshold: promote hits w/ P <= F2'
    inputBinding:
      position: 103
      prefix: --F2
  - id: f3_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 3 (Fwd) threshold: promote hits w/ P <= F3'
    inputBinding:
      position: 103
      prefix: --F3
  - id: fragment_threshold
    type:
      - 'null'
      - float
    doc: if L <= x*alen, tag sequence as a fragment
    inputBinding:
      position: 103
      prefix: --fragthresh
  - id: gap_extend_prob
    type:
      - 'null'
      - float
    doc: gap extend probability
    inputBinding:
      position: 103
      prefix: --pextend
  - id: gap_open_prob
    type:
      - 'null'
      - float
    doc: gap open probability
    inputBinding:
      position: 103
      prefix: --popen
  - id: inc_dom_e_value_threshold
    type:
      - 'null'
      - float
    doc: consider domains <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: --incdomE
  - id: inc_dom_score_threshold
    type:
      - 'null'
      - float
    doc: consider domains >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: --incdomT
  - id: inc_e_value_threshold
    type:
      - 'null'
      - float
    doc: consider sequences <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: --incE
  - id: inc_score_threshold
    type:
      - 'null'
      - float
    doc: consider sequences >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: --incT
  - id: matrix_file
    type:
      - 'null'
      - File
    doc: read substitution score matrix from file <f>
    inputBinding:
      position: 103
      prefix: --mxfile
  - id: max_heuristics
    type:
      - 'null'
      - boolean
    doc: Turn all heuristic filters off (less speed, more power)
    inputBinding:
      position: 103
      prefix: --max
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: set maximum number of iterations to <n>
    inputBinding:
      position: 103
      prefix: -N
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: run as an MPI parallel program
    inputBinding:
      position: 103
      prefix: --mpi
  - id: no_alignments
    type:
      - 'null'
      - boolean
    doc: don't output alignments, so output is smaller
    inputBinding:
      position: 103
      prefix: --noali
  - id: no_bias
    type:
      - 'null'
      - boolean
    doc: turn off composition bias filter
    inputBinding:
      position: 103
      prefix: --nobias
  - id: no_null2
    type:
      - 'null'
      - boolean
    doc: turn off biased composition score corrections
    inputBinding:
      position: 103
      prefix: --nonull2
  - id: no_text_width_limit
    type:
      - 'null'
      - boolean
    doc: unlimit ASCII text output line width
    inputBinding:
      position: 103
      prefix: --notextw
  - id: plaplace
    type:
      - 'null'
      - boolean
    doc: use a Laplace +1 prior
    inputBinding:
      position: 103
      prefix: --plaplace
  - id: pnone
    type:
      - 'null'
      - boolean
    doc: don't use any prior; parameters are frequencies
    inputBinding:
      position: 103
      prefix: --pnone
  - id: prefer_accessions
    type:
      - 'null'
      - boolean
    doc: prefer accessions over names in output
    inputBinding:
      position: 103
      prefix: --acc
  - id: query_format
    type:
      - 'null'
      - string
    doc: 'assert query <seqfile> is in format <s>: no autodetection'
    inputBinding:
      position: 103
      prefix: --qformat
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: report sequences >= this score threshold in output
    inputBinding:
      position: 103
      prefix: -T
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 103
      prefix: --seed
  - id: stall
    type:
      - 'null'
      - boolean
    doc: 'arrest after start: for debugging MPI under gdb'
    inputBinding:
      position: 103
      prefix: --stall
  - id: substitution_matrix
    type:
      - 'null'
      - string
    doc: substitution score matrix choice (of some built-in matrices)
    inputBinding:
      position: 103
      prefix: --mx
  - id: target_format
    type:
      - 'null'
      - string
    doc: 'assert target <seqdb> is in format <s>: no autodetection'
    inputBinding:
      position: 103
      prefix: --tformat
  - id: text_width
    type:
      - 'null'
      - int
    doc: set max width of ASCII text output lines
    inputBinding:
      position: 103
      prefix: --textw
  - id: wblosum
    type:
      - 'null'
      - boolean
    doc: Henikoff simple filter weights
    inputBinding:
      position: 103
      prefix: --wblosum
  - id: wgsc
    type:
      - 'null'
      - boolean
    doc: Gerstein/Sonnhammer/Chothia tree weights
    inputBinding:
      position: 103
      prefix: --wgsc
  - id: wid
    type:
      - 'null'
      - float
    doc: 'for --wblosum: set identity cutoff'
    inputBinding:
      position: 103
      prefix: --wid
  - id: wnone
    type:
      - 'null'
      - boolean
    doc: don't do any relative weighting; set all to 1
    inputBinding:
      position: 103
      prefix: --wnone
  - id: wpb
    type:
      - 'null'
      - boolean
    doc: Henikoff position-based weights
    inputBinding:
      position: 103
      prefix: --wpb
  - id: z_comparisons
    type:
      - 'null'
      - float
    doc: 'set # of comparisons done, for E-value calculation'
    inputBinding:
      position: 103
      prefix: -Z
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: direct output to file <f>, not stdout
    outputBinding:
      glob: $(inputs.output_file)
  - id: alignment_output
    type:
      - 'null'
      - File
    doc: save multiple alignment of hits to file <f>
    outputBinding:
      glob: $(inputs.alignment_output)
  - id: tblout
    type:
      - 'null'
      - File
    doc: save parseable table of per-sequence hits to file <f>
    outputBinding:
      glob: $(inputs.tblout)
  - id: domtblout
    type:
      - 'null'
      - File
    doc: save parseable table of per-domain hits to file <f>
    outputBinding:
      glob: $(inputs.domtblout)
  - id: chkhmm
    type:
      - 'null'
      - File
    doc: save HMM checkpoints to files <f>-<iteration>.hmm
    outputBinding:
      glob: $(inputs.chkhmm)
  - id: chkali
    type:
      - 'null'
      - File
    doc: save alignment checkpoints to files <f>-<iteration>.sto
    outputBinding:
      glob: $(inputs.chkali)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
