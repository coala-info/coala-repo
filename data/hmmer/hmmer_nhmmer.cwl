cwlVersion: v1.2
class: CommandLineTool
baseCommand: nhmmer
label: hmmer_nhmmer
doc: "search a DNA model, alignment, or sequence against a DNA database\n\nTool homepage:
  http://hmmer.org/"
inputs:
  - id: query_file
    type: File
    doc: query hmmfile, alignfile, or seqfile
    inputBinding:
      position: 1
  - id: target_seqfile
    type: File
    doc: target sequence database file
    inputBinding:
      position: 2
  - id: acc
    type:
      - 'null'
      - boolean
    doc: prefer accessions over names in output
    inputBinding:
      position: 103
      prefix: --acc
  - id: block_length
    type:
      - 'null'
      - int
    doc: length of blocks read from target database (threaded)
    inputBinding:
      position: 103
      prefix: --block_length
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel CPU workers to use for multithreads
    inputBinding:
      position: 103
      prefix: --cpu
  - id: crick
    type:
      - 'null'
      - boolean
    doc: only search the bottom strand
    inputBinding:
      position: 103
      prefix: --crick
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: use profile's GA gathering cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_ga
  - id: cut_nc
    type:
      - 'null'
      - boolean
    doc: use profile's NC noise cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_nc
  - id: cut_tc
    type:
      - 'null'
      - boolean
    doc: use profile's TC trusted cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_tc
  - id: database_size
    type:
      - 'null'
      - float
    doc: set database size (Megabases) to x for E-value calculations
    inputBinding:
      position: 103
      prefix: -Z
  - id: dna
    type:
      - 'null'
      - boolean
    doc: input alignment is DNA sequence data
    inputBinding:
      position: 103
      prefix: --dna
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: report sequences <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: -E
  - id: f1
    type:
      - 'null'
      - float
    doc: 'Stage 1 (SSV) threshold: promote hits w/ P <= F1'
    inputBinding:
      position: 103
      prefix: --F1
  - id: f2
    type:
      - 'null'
      - float
    doc: 'Stage 2 (Vit) threshold: promote hits w/ P <= F2'
    inputBinding:
      position: 103
      prefix: --F2
  - id: f3
    type:
      - 'null'
      - float
    doc: 'Stage 3 (Fwd) threshold: promote hits w/ P <= F3'
    inputBinding:
      position: 103
      prefix: --F3
  - id: incE
    type:
      - 'null'
      - float
    doc: consider sequences <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: --incE
  - id: incT
    type:
      - 'null'
      - float
    doc: consider sequences >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: --incT
  - id: max
    type:
      - 'null'
      - boolean
    doc: Turn all heuristic filters off (less speed, more power)
    inputBinding:
      position: 103
      prefix: --max
  - id: mxfile
    type:
      - 'null'
      - File
    doc: read substitution score matrix from file
    inputBinding:
      position: 103
      prefix: --mxfile
  - id: noali
    type:
      - 'null'
      - boolean
    doc: don't output alignments, so output is smaller
    inputBinding:
      position: 103
      prefix: --noali
  - id: nobias
    type:
      - 'null'
      - boolean
    doc: turn off composition bias filter
    inputBinding:
      position: 103
      prefix: --nobias
  - id: nonull2
    type:
      - 'null'
      - boolean
    doc: turn off biased composition score corrections
    inputBinding:
      position: 103
      prefix: --nonull2
  - id: notextw
    type:
      - 'null'
      - boolean
    doc: unlimit ASCII text output line width
    inputBinding:
      position: 103
      prefix: --notextw
  - id: pextend
    type:
      - 'null'
      - float
    doc: gap extend probability
    inputBinding:
      position: 103
      prefix: --pextend
  - id: popen
    type:
      - 'null'
      - float
    doc: gap open probability
    inputBinding:
      position: 103
      prefix: --popen
  - id: qformat
    type:
      - 'null'
      - string
    doc: assert query is in format (can be seq or msa format)
    inputBinding:
      position: 103
      prefix: --qformat
  - id: qsingle_seqs
    type:
      - 'null'
      - boolean
    doc: force query to be read as individual sequences, even if in an msa format
    inputBinding:
      position: 103
      prefix: --qsingle_seqs
  - id: rna
    type:
      - 'null'
      - boolean
    doc: input alignment is RNA sequence data
    inputBinding:
      position: 103
      prefix: --rna
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
    doc: 'set RNG seed to n (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 103
      prefix: --seed
  - id: seed_consens_match
    type:
      - 'null'
      - int
    doc: consecutive matches to consensus will override score threshold
    inputBinding:
      position: 103
      prefix: --seed_consens_match
  - id: seed_drop_lim
    type:
      - 'null'
      - float
    doc: in seed, max drop in a run of length [fm_drop_max_len]
    inputBinding:
      position: 103
      prefix: --seed_drop_lim
  - id: seed_drop_max_len
    type:
      - 'null'
      - int
    doc: maximum run length with score under (max - [fm_drop_lim])
    inputBinding:
      position: 103
      prefix: --seed_drop_max_len
  - id: seed_max_depth
    type:
      - 'null'
      - int
    doc: seed length at which bit threshold must be met
    inputBinding:
      position: 103
      prefix: --seed_max_depth
  - id: seed_req_pos
    type:
      - 'null'
      - int
    doc: minimum number consecutive positive scores in seed
    inputBinding:
      position: 103
      prefix: --seed_req_pos
  - id: seed_sc_density
    type:
      - 'null'
      - float
    doc: seed must maintain this bit density from one of two ends
    inputBinding:
      position: 103
      prefix: --seed_sc_density
  - id: seed_sc_thresh
    type:
      - 'null'
      - float
    doc: Default req. score for FM seed (bits)
    inputBinding:
      position: 103
      prefix: --seed_sc_thresh
  - id: seed_ssv_length
    type:
      - 'null'
      - int
    doc: length of window around FM seed to get full SSV diagonal
    inputBinding:
      position: 103
      prefix: --seed_ssv_length
  - id: singlemx
    type:
      - 'null'
      - boolean
    doc: use substitution score matrix w/ single-sequence MSA-format inputs
    inputBinding:
      position: 103
      prefix: --singlemx
  - id: textw
    type:
      - 'null'
      - int
    doc: set max width of ASCII text output lines
    inputBinding:
      position: 103
      prefix: --textw
  - id: tformat
    type:
      - 'null'
      - string
    doc: assert target is in format
    inputBinding:
      position: 103
      prefix: --tformat
  - id: w_beta
    type:
      - 'null'
      - float
    doc: tail mass at which window length is determined
    inputBinding:
      position: 103
      prefix: --w_beta
  - id: w_length
    type:
      - 'null'
      - int
    doc: window length - essentially max expected hit length
    inputBinding:
      position: 103
      prefix: --w_length
  - id: watson
    type:
      - 'null'
      - boolean
    doc: only search the top strand
    inputBinding:
      position: 103
      prefix: --watson
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: direct output to file, not stdout
    outputBinding:
      glob: $(inputs.output_file)
  - id: alignment_output
    type:
      - 'null'
      - File
    doc: save multiple alignment of all hits to file
    outputBinding:
      glob: $(inputs.alignment_output)
  - id: tblout
    type:
      - 'null'
      - File
    doc: save parseable table of hits to file
    outputBinding:
      glob: $(inputs.tblout)
  - id: dfamtblout
    type:
      - 'null'
      - File
    doc: save table of hits to file, in Dfam format
    outputBinding:
      glob: $(inputs.dfamtblout)
  - id: aliscoresout
    type:
      - 'null'
      - File
    doc: save scores for each position in each alignment to file
    outputBinding:
      glob: $(inputs.aliscoresout)
  - id: hmmout
    type:
      - 'null'
      - File
    doc: if input is alignment(s), write produced hmms to file
    outputBinding:
      glob: $(inputs.hmmout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
