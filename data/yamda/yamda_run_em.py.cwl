cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_em.py
label: yamda_run_em.py
doc: "Train model.\n\nTool homepage: https://github.com/daquang/YAMDA"
inputs:
  - id: alpha
    type:
      - 'null'
      - string
    doc: Alphabet
    default: dna
    inputBinding:
      position: 101
      prefix: --alpha
  - id: batchsize
    type:
      - 'null'
      - int
    doc: Input batch size for training
    default: 1000
    inputBinding:
      position: 101
      prefix: --batchsize
  - id: erasewhole
    type:
      - 'null'
      - boolean
    doc: 'Erase an entire sequence if it contains a discovered motif (default: erase
      individual motif occurrences).'
    inputBinding:
      position: 101
      prefix: --erasewhole
  - id: fudge
    type:
      - 'null'
      - float
    doc: Fudge factor to help with extremely rare motifs. Should be >0 and <=1
    default: 0.1
    inputBinding:
      position: 101
      prefix: --fudge
  - id: halflength
    type:
      - 'null'
      - int
    doc: k-mer half-length for gapped k-mer search seeding
    default: 6
    inputBinding:
      position: 101
      prefix: --halflength
  - id: input
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: input2
    type:
      - 'null'
      - File
    doc: Input FASTA file of negative sequences
    inputBinding:
      position: 101
      prefix: --input2
  - id: maxiter
    type:
      - 'null'
      - int
    doc: Maximum number of refining iterations of batch EM to run from any 
      starting point. Batch EM is run for maxiter iterations or until 
      convergence (see -tolerance, below) from each starting point for refining
    default: 20
    inputBinding:
      position: 101
      prefix: --maxiter
  - id: maxsites
    type:
      - 'null'
      - int
    doc: Maximum number of motif occurrences. If left unspecified, will default 
      to number ofsequences.
    inputBinding:
      position: 101
      prefix: --maxsites
  - id: minsites
    type:
      - 'null'
      - int
    doc: Minimum number of motif occurrences
    default: 100
    inputBinding:
      position: 101
      prefix: --minsites
  - id: model
    type:
      - 'null'
      - string
    doc: Model
    default: tcm
    inputBinding:
      position: 101
      prefix: --model
  - id: nmotifs
    type:
      - 'null'
      - int
    doc: Number of motifs to find
    default: 1
    inputBinding:
      position: 101
      prefix: --nmotifs
  - id: no_cuda
    type:
      - 'null'
      - boolean
    doc: Disable the default CUDA training.
    inputBinding:
      position: 101
      prefix: --no_cuda
  - id: nseeds
    type:
      - 'null'
      - int
    doc: Number of motif seeds to try. If left unspecified, will default to 100 
      (for gapped k-mersearch) or 1000 (for randomly sampled subsequence 
      method).
    inputBinding:
      position: 101
      prefix: --nseeds
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: 'Consider both the given strand and the reverse complement strand when searching
      for motifs in a complementable alphabet (default: consider given strand only).'
    inputBinding:
      position: 101
      prefix: --revcomp
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    default: 1337
    inputBinding:
      position: 101
      prefix: --seed
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Stop iterating refining batch/on-line EM when the change in the motif 
      probability matrix is less than tolerance. Change is defined as the 
      euclidean distance between two successive frequency matrices
    default: 0.001
    inputBinding:
      position: 101
      prefix: --tolerance
  - id: width
    type:
      - 'null'
      - int
    doc: Motif width
    default: 20
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: outputdir
    type:
      - 'null'
      - Directory
    doc: The output directory. Causes error if the directory already exists.
    outputBinding:
      glob: $(inputs.outputdir)
  - id: outputdirc
    type:
      - 'null'
      - Directory
    doc: The output directory. Will overwrite if directory already exists.
    outputBinding:
      glob: $(inputs.outputdirc)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yamda:0.1.00e9c9d--py_0
