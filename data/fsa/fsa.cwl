cwlVersion: v1.2
class: CommandLineTool
baseCommand: fsa
label: fsa
doc: "Distance-based alignment of DNA, RNA and proteins.\n\nTool homepage: http://fsa.sourceforge.net/"
inputs:
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Input sequence file(s) must be in FASTA format.
    inputBinding:
      position: 1
  - id: alignment_fraction
    type:
      - 'null'
      - float
    doc: randomized fraction of all (n choose 2) pairs of sequences to consider 
      during alignment inference (default is 1)
    inputBinding:
      position: 102
      prefix: --alignment-fraction
  - id: alignment_number
    type:
      - 'null'
      - int
    doc: total number of (randomized) pairs of sequences to consider during 
      alignment inference
    inputBinding:
      position: 102
      prefix: --alignment-number
  - id: alphar
    type:
      - 'null'
      - float
    doc: 'Tamura-Nei rate alpha_R (transition: purine) (default is 1.3)'
    inputBinding:
      position: 102
      prefix: --alphar
  - id: alphay
    type:
      - 'null'
      - float
    doc: 'Tamura-Nei rate alpha_Y (transition: pyrimidine) (default is 1.3)'
    inputBinding:
      position: 102
      prefix: --alphay
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: banding (default is no banding)
    inputBinding:
      position: 102
      prefix: --bandwidth
  - id: beta
    type:
      - 'null'
      - float
    doc: Tamura-Nei rate beta (transversion) (default is 1)
    inputBinding:
      position: 102
      prefix: --beta
  - id: degree
    type:
      - 'null'
      - int
    doc: use --degree number of pairwise comparisons between closest sequences 
      (default is 0)
    inputBinding:
      position: 102
      prefix: --degree
  - id: dynamicweights
    type:
      - 'null'
      - boolean
    doc: (default) enable dynamic edge re-weighting (--nodynamicweights to 
      disable)
    inputBinding:
      position: 102
      prefix: --dynamicweights
  - id: fast
    type:
      - 'null'
      - boolean
    doc: 'fast alignment: use 5 * Erdos-Renyi threshold percent of sequence pairs
      for alignment and 2 * for learning'
    inputBinding:
      position: 102
      prefix: --fast
  - id: gapextend1
    type:
      - 'null'
      - float
    doc: initial gap-extend probability (for set 1 of indel states)
    inputBinding:
      position: 102
      prefix: --gapextend1
  - id: gapextend2
    type:
      - 'null'
      - float
    doc: initial gap-extend probability (for set 2 of indel states)
    inputBinding:
      position: 102
      prefix: --gapextend2
  - id: gapfactor
    type:
      - 'null'
      - float
    doc: gap factor; 0 for highest sensitivity (the internal effective minimum 
      is 0.01); >1 for higher specificity (default is 1)
    inputBinding:
      position: 102
      prefix: --gapfactor
  - id: gapopen1
    type:
      - 'null'
      - float
    doc: initial gap-open probability (for set 1 of indel states)
    inputBinding:
      position: 102
      prefix: --gapopen1
  - id: gapopen2
    type:
      - 'null'
      - float
    doc: initial gap-open probability (for set 2 of indel states)
    inputBinding:
      position: 102
      prefix: --gapopen2
  - id: gui
    type:
      - 'null'
      - boolean
    doc: record alignment & statistical model for interactive Java GUI
    inputBinding:
      position: 102
      prefix: --gui
  - id: indel2
    type:
      - 'null'
      - boolean
    doc: use two sets of indel states in Pair HMM (use --noindel2 to use 1 set 
      only)
    inputBinding:
      position: 102
      prefix: --indel2
  - id: kmer
    type:
      - 'null'
      - int
    doc: length of k-mers to use when determining sequence similarity
    inputBinding:
      position: 102
      prefix: --kmer
  - id: learnemit_all
    type:
      - 'null'
      - boolean
    doc: (default for proteins) estimate emission probabilities averaged over 
      all sequences (--nolearnemit-all to disable)
    inputBinding:
      position: 102
      prefix: --learnemit-all
  - id: learnemit_bypair
    type:
      - 'null'
      - boolean
    doc: (default for DNA and RNA) estimate emission probabilities for each pair
      of sequences (--nolearnemit-bypair to disable)
    inputBinding:
      position: 102
      prefix: --learnemit-bypair
  - id: learngap
    type:
      - 'null'
      - boolean
    doc: estimate indel probabilities for each pair of sequences (--nolearngap 
      to disable)
    inputBinding:
      position: 102
      prefix: --learngap
  - id: load_probs
    type:
      - 'null'
      - string
    doc: load pairwise posterior probabilities from a file rather than 
      performing inference with Pair HMM
    inputBinding:
      position: 102
      prefix: --load-probs
  - id: log
    type:
      - 'null'
      - string
    doc: turn on diagnostic logging (-loghelp shows syntax)
    inputBinding:
      position: 102
      prefix: --log
  - id: logcopy
    type:
      - 'null'
      - File
    doc: log to file and standard error
    inputBinding:
      position: 102
      prefix: --logcopy
  - id: logerr
    type:
      - 'null'
      - boolean
    doc: log on standard error (default)
    inputBinding:
      position: 102
      prefix: --logerr
  - id: logfile
    type:
      - 'null'
      - File
    doc: log to file
    inputBinding:
      position: 102
      prefix: --logfile
  - id: logtime
    type:
      - 'null'
      - boolean
    doc: timestamp standard error (logfile stamped automatically)
    inputBinding:
      position: 102
      prefix: --logtime
  - id: logxml
    type:
      - 'null'
      - boolean
    doc: add XML timestamps (--nologxml to disable)
    inputBinding:
      position: 102
      prefix: --logxml
  - id: maxram
    type:
      - 'null'
      - int
    doc: maximum RAM to use (in megabytes) (default is 51188)
    inputBinding:
      position: 102
      prefix: --maxram
  - id: maxrounds
    type:
      - 'null'
      - int
    doc: maximum number of iterations of EM (default is 3)
    inputBinding:
      position: 102
      prefix: --maxrounds
  - id: maxsn
    type:
      - 'null'
      - boolean
    doc: maximum sensitivity (instead of highest accuracy)
    inputBinding:
      position: 102
      prefix: --maxsn
  - id: mercator
    type:
      - 'null'
      - string
    doc: input Mercator constraints
    inputBinding:
      position: 102
      prefix: --mercator
  - id: minemitdata
    type:
      - 'null'
      - int
    doc: minimum amount of sequence data (# of aligned pairs of characters) for 
      training emission probs
    inputBinding:
      position: 102
      prefix: --minemitdata
  - id: mingapdata
    type:
      - 'null'
      - int
    doc: minimum amount of sequence data (# of aligned pairs of characters) for 
      training gap probs
    inputBinding:
      position: 102
      prefix: --mingapdata
  - id: mininc
    type:
      - 'null'
      - float
    doc: minimum fractional increase in log-likelihood per round of EM (default 
      is 0.1)
    inputBinding:
      position: 102
      prefix: --mininc
  - id: minprob
    type:
      - 'null'
      - float
    doc: minimum posterior probability to store (default is 0.01)
    inputBinding:
      position: 102
      prefix: --minprob
  - id: model
    type:
      - 'null'
      - int
    doc: 'initial substitution model: 0 = Jukes-Cantor, 1 = Tamura-Nei / BLOSUM62-like
      (proteins) (default is 1)'
    inputBinding:
      position: 102
      prefix: --model
  - id: mst_max
    type:
      - 'null'
      - int
    doc: build --mst-max maximum spanning trees on input sequences for pairwise 
      comparisons (default is 0)
    inputBinding:
      position: 102
      prefix: --mst-max
  - id: mst_min
    type:
      - 'null'
      - int
    doc: build --mst-min minimum spanning trees on input sequences for pairwise 
      comparisons (default is 3)
    inputBinding:
      position: 102
      prefix: --mst-min
  - id: mst_palm
    type:
      - 'null'
      - int
    doc: build --mst-palm minimum spanning palm trees on input sequences for 
      pairwise comparisons (default is 0)
    inputBinding:
      position: 102
      prefix: --mst-palm
  - id: nodynamicweights
    type:
      - 'null'
      - boolean
    doc: disable dynamic edge re-weighting
    inputBinding:
      position: 102
      prefix: --nodynamicweights
  - id: noindel2
    type:
      - 'null'
      - boolean
    doc: use one set of indel states in Pair HMM
    inputBinding:
      position: 102
      prefix: --noindel2
  - id: nolearn
    type:
      - 'null'
      - boolean
    doc: disable ALL parameter learning (use ProbCons defaults)
    inputBinding:
      position: 102
      prefix: --nolearn
  - id: nolearnemit_all
    type:
      - 'null'
      - boolean
    doc: disable averaged emission probability estimation
    inputBinding:
      position: 102
      prefix: --nolearnemit-all
  - id: nolearnemit_bypair
    type:
      - 'null'
      - boolean
    doc: disable emission probability estimation per pair
    inputBinding:
      position: 102
      prefix: --nolearnemit-bypair
  - id: nolearngap
    type:
      - 'null'
      - boolean
    doc: disable indel probability estimation
    inputBinding:
      position: 102
      prefix: --nolearngap
  - id: nologxml
    type:
      - 'null'
      - boolean
    doc: disable XML timestamps
    inputBinding:
      position: 102
      prefix: --nologxml
  - id: noregularize
    type:
      - 'null'
      - boolean
    doc: disable regularization of learned probabilities
    inputBinding:
      position: 102
      prefix: --noregularize
  - id: nucprot
    type:
      - 'null'
      - boolean
    doc: align input nucleotide sequences (must all be nucleotide) in protein 
      space
    inputBinding:
      position: 102
      prefix: --nucprot
  - id: refalign
    type:
      - 'null'
      - boolean
    doc: alignment to a reference sequence only (reference must be first 
      sequence in file)
    inputBinding:
      position: 102
      prefix: --refalign
  - id: refinement
    type:
      - 'null'
      - int
    doc: number of iterative refinement steps (default is unlimited; 0 for none)
    inputBinding:
      position: 102
      prefix: --refinement
  - id: regularization_emitscale
    type:
      - 'null'
      - float
    doc: scaling factor for emission Dirichlet prior
    inputBinding:
      position: 102
      prefix: --regularization-emitscale
  - id: regularization_gapscale
    type:
      - 'null'
      - float
    doc: scaling factor for transition prior
    inputBinding:
      position: 102
      prefix: --regularization-gapscale
  - id: regularize
    type:
      - 'null'
      - boolean
    doc: (default) regularize learned emission and gap probabilities with 
      Dirichlet prior (--noregularize to disable)
    inputBinding:
      position: 102
      prefix: --regularize
  - id: require_homology
    type:
      - 'null'
      - boolean
    doc: require that there be some detectable homology between all input 
      sequences
    inputBinding:
      position: 102
      prefix: --require-homology
  - id: stockholm
    type:
      - 'null'
      - boolean
    doc: output Stockholm alignments (default is multi-FASTA format)
    inputBinding:
      position: 102
      prefix: --stockholm
  - id: time
    type:
      - 'null'
      - float
    doc: Jukes-Cantor/Tamura-Nei evolutionary time parameter (default is 0.4)
    inputBinding:
      position: 102
      prefix: --time
  - id: treeweights
    type:
      - 'null'
      - string
    doc: weights for sequence pairs based on a tree
    inputBinding:
      position: 102
      prefix: --treeweights
  - id: write_params
    type:
      - 'null'
      - boolean
    doc: write learned emission distributions (substitution matrices) to disk
    inputBinding:
      position: 102
      prefix: --write-params
  - id: write_posteriors
    type:
      - 'null'
      - boolean
    doc: write learned pairwise posterior alignment probability matrices to disk
    inputBinding:
      position: 102
      prefix: --write-posteriors
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fsa:1.15.9--h5ca1c30_5
stdout: fsa.out
