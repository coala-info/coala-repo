cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmbuild
label: hmmer_hmmbuild
doc: profile HMM construction from multiple sequence alignments
inputs:
  - id: hmmfile_out
    type: string
    doc: Output HMM file
    inputBinding:
      position: 1
  - id: msafile
    type:
      - 'null'
      - File
    doc: Input multiple sequence alignment file
    inputBinding:
      position: 2
  - id: name
    type:
      - 'null'
      - string
    doc: name the HMM
    inputBinding:
      position: 103
      prefix: -n
  - id: summary_output
    type: string
    doc: direct summary output to file, not stdout
    inputBinding:
      position: 103
      prefix: -o
  - id: resave_msa
    type: string
    doc: resave annotated, possibly modified MSA to file
    inputBinding:
      position: 103
      prefix: -O
  - id: amino
    type:
      - 'null'
      - boolean
    doc: input alignment is protein sequence data
    inputBinding:
      position: 103
      prefix: --amino
  - id: dna
    type:
      - 'null'
      - boolean
    doc: input alignment is DNA sequence data
    inputBinding:
      position: 103
      prefix: --dna
  - id: rna
    type:
      - 'null'
      - boolean
    doc: input alignment is RNA sequence data
    inputBinding:
      position: 103
      prefix: --rna
  - id: fast
    type:
      - 'null'
      - boolean
    doc: assign cols w/ >= symfrac residues as consensus
    inputBinding:
      position: 103
      prefix: --fast
  - id: hand
    type:
      - 'null'
      - boolean
    doc: manual construction (requires reference annotation)
    inputBinding:
      position: 103
      prefix: --hand
  - id: symfrac
    type:
      - 'null'
      - float
    doc: sets sym fraction controlling --fast construction
    inputBinding:
      position: 103
      prefix: --symfrac
  - id: fragthresh
    type:
      - 'null'
      - float
    doc: if L <= x*alen, tag sequence as a fragment
    inputBinding:
      position: 103
      prefix: --fragthresh
  - id: wpb
    type:
      - 'null'
      - boolean
    doc: Henikoff position-based weights
    inputBinding:
      position: 103
      prefix: --wpb
  - id: wgsc
    type:
      - 'null'
      - boolean
    doc: Gerstein/Sonnhammer/Chothia tree weights
    inputBinding:
      position: 103
      prefix: --wgsc
  - id: wblosum
    type:
      - 'null'
      - boolean
    doc: Henikoff simple filter weights
    inputBinding:
      position: 103
      prefix: --wblosum
  - id: wnone
    type:
      - 'null'
      - boolean
    doc: don't do any relative weighting; set all to 1
    inputBinding:
      position: 103
      prefix: --wnone
  - id: wgiven
    type:
      - 'null'
      - boolean
    doc: use weights as given in MSA file
    inputBinding:
      position: 103
      prefix: --wgiven
  - id: wid
    type:
      - 'null'
      - float
    doc: 'for --wblosum: set identity cutoff'
    inputBinding:
      position: 103
      prefix: --wid
  - id: eent
    type:
      - 'null'
      - boolean
    doc: 'adjust eff seq # to achieve relative entropy target'
    inputBinding:
      position: 103
      prefix: --eent
  - id: eclust
    type:
      - 'null'
      - boolean
    doc: 'eff seq # is # of single linkage clusters'
    inputBinding:
      position: 103
      prefix: --eclust
  - id: enone
    type:
      - 'null'
      - boolean
    doc: 'no effective seq # weighting: just use nseq'
    inputBinding:
      position: 103
      prefix: --enone
  - id: eset
    type:
      - 'null'
      - float
    doc: 'set eff seq # for all models'
    inputBinding:
      position: 103
      prefix: --eset
  - id: ere
    type:
      - 'null'
      - float
    doc: 'for --eent: set minimum rel entropy/position'
    inputBinding:
      position: 103
      prefix: --ere
  - id: esigma
    type:
      - 'null'
      - float
    doc: 'for --eent: set sigma param'
    inputBinding:
      position: 103
      prefix: --esigma
  - id: eid
    type:
      - 'null'
      - float
    doc: 'for --eclust: set fractional identity cutoff'
    inputBinding:
      position: 103
      prefix: --eid
  - id: pnone
    type:
      - 'null'
      - boolean
    doc: don't use any prior; parameters are frequencies
    inputBinding:
      position: 103
      prefix: --pnone
  - id: plaplace
    type:
      - 'null'
      - boolean
    doc: use a Laplace +1 prior
    inputBinding:
      position: 103
      prefix: --plaplace
  - id: singlemx
    type:
      - 'null'
      - boolean
    doc: use substitution score matrix for single-sequence inputs
    inputBinding:
      position: 103
      prefix: --singlemx
  - id: mx
    type:
      - 'null'
      - string
    doc: substitution score matrix (built-in matrices, with --singlemx)
    inputBinding:
      position: 103
      prefix: --mx
  - id: mxfile
    type:
      - 'null'
      - File
    doc: read substitution score matrix from file (with --singlemx)
    inputBinding:
      position: 103
      prefix: --mxfile
  - id: popen
    type:
      - 'null'
      - float
    doc: force gap open prob. (w/ --singlemx)
    inputBinding:
      position: 103
      prefix: --popen
  - id: pextend
    type:
      - 'null'
      - float
    doc: force gap extend prob. (w/ --singlemx)
    inputBinding:
      position: 103
      prefix: --pextend
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
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel CPU workers for multithreads
    inputBinding:
      position: 103
      prefix: --cpu
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: run as an MPI parallel program
    inputBinding:
      position: 103
      prefix: --mpi
  - id: stall
    type:
      - 'null'
      - boolean
    doc: 'arrest after start: for attaching debugger to process'
    inputBinding:
      position: 103
      prefix: --stall
  - id: informat
    type:
      - 'null'
      - string
    doc: assert input alifile is in format (no autodetect)
    inputBinding:
      position: 103
      prefix: --informat
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 103
      prefix: --seed
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
    doc: window length
    inputBinding:
      position: 103
      prefix: --w_length
  - id: maxinsertlen
    type:
      - 'null'
      - int
    doc: pretend all inserts are length <= <n>
    inputBinding:
      position: 103
      prefix: --maxinsertlen
outputs:
  - id: out_hmmfile_out
    type:
      type: array
      items: File
    doc: Output HMM file
    outputBinding:
      glob: '*.out'
  - id: output_summary_output
    type:
      - 'null'
      - File
    doc: direct summary output to file, not stdout
    outputBinding:
      glob: $(inputs.summary_output)
  - id: output_resave_msa
    type:
      - 'null'
      - File
    doc: resave annotated, possibly modified MSA to file
    outputBinding:
      glob: $(inputs.resave_msa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
s:url: http://hmmer.org/
$namespaces:
  s: https://schema.org/
