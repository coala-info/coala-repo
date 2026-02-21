cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmbuild
label: hmmer_hmmbuild
doc: "profile HMM construction from multiple sequence alignments\n\nTool homepage:
  http://hmmer.org/"
inputs:
  - id: msafile
    type: File
    doc: Input multiple sequence alignment file
    inputBinding:
      position: 1
  - id: amino
    type:
      - 'null'
      - boolean
    doc: input alignment is protein sequence data
    inputBinding:
      position: 102
      prefix: --amino
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel CPU workers for multithreads
    default: 2
    inputBinding:
      position: 102
      prefix: --cpu
  - id: dna
    type:
      - 'null'
      - boolean
    doc: input alignment is DNA sequence data
    inputBinding:
      position: 102
      prefix: --dna
  - id: eclust
    type:
      - 'null'
      - boolean
    doc: 'eff seq # is # of single linkage clusters'
    inputBinding:
      position: 102
      prefix: --eclust
  - id: eent
    type:
      - 'null'
      - boolean
    doc: 'adjust eff seq # to achieve relative entropy target'
    inputBinding:
      position: 102
      prefix: --eent
  - id: efl
    type:
      - 'null'
      - int
    doc: length of sequences for Forward exp tail tau fit
    default: 100
    inputBinding:
      position: 102
      prefix: --EfL
  - id: efn
    type:
      - 'null'
      - int
    doc: number of sequences for Forward exp tail tau fit
    default: 200
    inputBinding:
      position: 102
      prefix: --EfN
  - id: eft
    type:
      - 'null'
      - float
    doc: tail mass for Forward exponential tail tau fit
    default: 0.04
    inputBinding:
      position: 102
      prefix: --Eft
  - id: eid
    type:
      - 'null'
      - float
    doc: 'for --eclust: set fractional identity cutoff to <x>'
    default: 0.62
    inputBinding:
      position: 102
      prefix: --eid
  - id: eml
    type:
      - 'null'
      - int
    doc: length of sequences for MSV Gumbel mu fit
    default: 200
    inputBinding:
      position: 102
      prefix: --EmL
  - id: emn
    type:
      - 'null'
      - int
    doc: number of sequences for MSV Gumbel mu fit
    default: 200
    inputBinding:
      position: 102
      prefix: --EmN
  - id: enone
    type:
      - 'null'
      - boolean
    doc: 'no effective seq # weighting: just use nseq'
    inputBinding:
      position: 102
      prefix: --enone
  - id: ere
    type:
      - 'null'
      - float
    doc: 'for --eent: set minimum rel entropy/position to <x>'
    inputBinding:
      position: 102
      prefix: --ere
  - id: eset
    type:
      - 'null'
      - float
    doc: 'set eff seq # for all models to <x>'
    inputBinding:
      position: 102
      prefix: --eset
  - id: esigma
    type:
      - 'null'
      - float
    doc: 'for --eent: set sigma param to <x>'
    default: 45.0
    inputBinding:
      position: 102
      prefix: --esigma
  - id: evl
    type:
      - 'null'
      - int
    doc: length of sequences for Viterbi Gumbel mu fit
    default: 200
    inputBinding:
      position: 102
      prefix: --EvL
  - id: evn
    type:
      - 'null'
      - int
    doc: number of sequences for Viterbi Gumbel mu fit
    default: 200
    inputBinding:
      position: 102
      prefix: --EvN
  - id: fast
    type:
      - 'null'
      - boolean
    doc: assign cols w/ >= symfrac residues as consensus
    inputBinding:
      position: 102
      prefix: --fast
  - id: fragthresh
    type:
      - 'null'
      - float
    doc: if L <= x*alen, tag sequence as a fragment
    default: 0.5
    inputBinding:
      position: 102
      prefix: --fragthresh
  - id: hand
    type:
      - 'null'
      - boolean
    doc: manual construction (requires reference annotation)
    inputBinding:
      position: 102
      prefix: --hand
  - id: informat
    type:
      - 'null'
      - string
    doc: assert input alifile is in format <s> (no autodetect)
    inputBinding:
      position: 102
      prefix: --informat
  - id: maxinsertlen
    type:
      - 'null'
      - int
    doc: pretend all inserts are length <= <n>
    inputBinding:
      position: 102
      prefix: --maxinsertlen
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: run as an MPI parallel program
    inputBinding:
      position: 102
      prefix: --mpi
  - id: mx
    type:
      - 'null'
      - string
    doc: substitution score matrix (built-in matrices, with --singlemx)
    inputBinding:
      position: 102
      prefix: --mx
  - id: mxfile
    type:
      - 'null'
      - File
    doc: read substitution score matrix from file (with --singlemx)
    inputBinding:
      position: 102
      prefix: --mxfile
  - id: name
    type:
      - 'null'
      - string
    doc: name the HMM
    inputBinding:
      position: 102
      prefix: -n
  - id: pextend
    type:
      - 'null'
      - float
    doc: force gap extend prob. (w/ --singlemx)
    inputBinding:
      position: 102
      prefix: --pextend
  - id: plaplace
    type:
      - 'null'
      - boolean
    doc: use a Laplace +1 prior
    inputBinding:
      position: 102
      prefix: --plaplace
  - id: pnone
    type:
      - 'null'
      - boolean
    doc: don't use any prior; parameters are frequencies
    inputBinding:
      position: 102
      prefix: --pnone
  - id: popen
    type:
      - 'null'
      - float
    doc: force gap open prob. (w/ --singlemx)
    inputBinding:
      position: 102
      prefix: --popen
  - id: rna
    type:
      - 'null'
      - boolean
    doc: input alignment is RNA sequence data
    inputBinding:
      position: 102
      prefix: --rna
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed)'
    default: 42
    inputBinding:
      position: 102
      prefix: --seed
  - id: singlemx
    type:
      - 'null'
      - boolean
    doc: use substitution score matrix for single-sequence inputs
    inputBinding:
      position: 102
      prefix: --singlemx
  - id: stall
    type:
      - 'null'
      - boolean
    doc: 'arrest after start: for attaching debugger to process'
    inputBinding:
      position: 102
      prefix: --stall
  - id: symfrac
    type:
      - 'null'
      - float
    doc: sets sym fraction controlling --fast construction
    default: 0.5
    inputBinding:
      position: 102
      prefix: --symfrac
  - id: w_beta
    type:
      - 'null'
      - float
    doc: tail mass at which window length is determined
    inputBinding:
      position: 102
      prefix: --w_beta
  - id: w_length
    type:
      - 'null'
      - int
    doc: window length
    inputBinding:
      position: 102
      prefix: --w_length
  - id: wblosum
    type:
      - 'null'
      - boolean
    doc: Henikoff simple filter weights
    inputBinding:
      position: 102
      prefix: --wblosum
  - id: wgiven
    type:
      - 'null'
      - boolean
    doc: use weights as given in MSA file
    inputBinding:
      position: 102
      prefix: --wgiven
  - id: wgsc
    type:
      - 'null'
      - boolean
    doc: Gerstein/Sonnhammer/Chothia tree weights
    inputBinding:
      position: 102
      prefix: --wgsc
  - id: wid
    type:
      - 'null'
      - float
    doc: 'for --wblosum: set identity cutoff'
    default: 0.62
    inputBinding:
      position: 102
      prefix: --wid
  - id: wnone
    type:
      - 'null'
      - boolean
    doc: don't do any relative weighting; set all to 1
    inputBinding:
      position: 102
      prefix: --wnone
  - id: wpb
    type:
      - 'null'
      - boolean
    doc: Henikoff position-based weights
    inputBinding:
      position: 102
      prefix: --wpb
outputs:
  - id: hmmfile_out
    type: File
    doc: Output HMM file
    outputBinding:
      glob: '*.out'
  - id: summary_output
    type:
      - 'null'
      - File
    doc: direct summary output to file, not stdout
    outputBinding:
      glob: $(inputs.summary_output)
  - id: resave_msa
    type:
      - 'null'
      - File
    doc: resave annotated, possibly modified MSA to file
    outputBinding:
      glob: $(inputs.resave_msa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
