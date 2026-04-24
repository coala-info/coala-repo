cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./estimate.R
label: contammix
doc: "Estimate the proportion of authentic sequences in a sample, accounting for potential
  contamination and aDNA damage.\n\nTool homepage: https://github.com/plfjohnson/contamMix"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: hyperparameter to Dirichlet prior distribution; may need to be tweaked 
      if MCMC is mixing poorly
    inputBinding:
      position: 101
      prefix: --alpha
  - id: baseq
    type:
      - 'null'
      - int
    doc: base quality threshold below which to discard data (default 30; 0 
      signals NO threshold)
    inputBinding:
      position: 101
      prefix: --baseq
  - id: cons_id
    type:
      - 'null'
      - string
    doc: consensus id in multiple alignment (if not supplied, assumes this is 
      identical to the reference id in the SAM/BAM)
    inputBinding:
      position: 101
      prefix: --consId
  - id: maln_fn
    type: File
    doc: FASTA-format multiple alignment of consensus and potential contaminants
    inputBinding:
      position: 101
      prefix: --malnFn
  - id: n_chains
    type:
      - 'null'
      - int
    doc: number of MCMC chains to run from different random starting parameters,
      which are used for Gelman-Rubin convergence testing (default 3; uses 
      multiple processors if available)
    inputBinding:
      position: 101
      prefix: --nChains
  - id: n_iter
    type:
      - 'null'
      - int
    doc: number of iterations in Markov chain
    inputBinding:
      position: 101
      prefix: --nIter
  - id: nr_threads
    type:
      - 'null'
      - int
    doc: The number of threads to use. Defaults to 1. If a number higher than 
      the available threads is used, the maximum available number of threads 
      will be used instead.
    inputBinding:
      position: 101
      prefix: --nrThreads
  - id: sam_fn
    type: File
    doc: SAM/BAM data file aligned to consensus
    inputBinding:
      position: 101
      prefix: --samFn
  - id: save_data
    type:
      - 'null'
      - boolean
    doc: save chain data to specified file (in .Rdata format) for manual 
      diagnostics
    inputBinding:
      position: 101
      prefix: --saveData
  - id: save_mn
    type:
      - 'null'
      - boolean
    doc: save MN intermediate file for manual debugging (will use filename 
      '<samFn>.mn')
    inputBinding:
      position: 101
      prefix: --saveMN
  - id: tab_output
    type:
      - 'null'
      - boolean
    doc: 'output a single line of text with the following tab-separated values: <inferred-error-rate>
      <MAP-authentic> <2.5% authentic> <97.5% authentic> <gelman diagnostic> <gelman
      diag upper bound>'
    inputBinding:
      position: 101
      prefix: --tabOutput
  - id: transver_only
    type:
      - 'null'
      - boolean
    doc: only use sites with transversions (avoids potential for bias from aDNA 
      damage, but has significantly less power)
    inputBinding:
      position: 101
      prefix: --transverOnly
  - id: trim_bases
    type:
      - 'null'
      - int
    doc: 'trim this # of bases from ends of sequence (reducing effect of aDNA damage)'
    inputBinding:
      position: 101
      prefix: --trimBases
outputs:
  - id: figure
    type:
      - 'null'
      - File
    doc: 'if supplied, generates a PDF figure with 3 panels: convergence of gelman
      diagnostic (if --nChains>1), Pr(authentic) as a function of MC iteration, estimated
      posterior density for Pr(authentic)'
    outputBinding:
      glob: $(inputs.figure)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contammix:1.0.11--r45h28c4f14_5
