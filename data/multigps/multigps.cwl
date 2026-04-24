cwlVersion: v1.2
class: CommandLineTool
baseCommand: multigps
label: multigps
doc: "MultiGPS version 0.74\n\nCopyright (C) Shaun Mahony 2012-2016\n<http://mahonylab.org/software/multigps>\n\
  \nMultiGPS comes with ABSOLUTELY NO WARRANTY.  This is free software, and you\n\
  are welcome to redistribute it under certain conditions.  See the MIT license \n\
  for details.\n\nTool homepage: https://github.com/shaunmahony/multigps-archive"
inputs:
  - id: alphascale
    type:
      - 'null'
      - float
    doc: alpha scaling factor
    inputBinding:
      position: 101
      prefix: --alphascale
  - id: binding_event_distribution_file
    type:
      - 'null'
      - File
    doc: binding event read distribution file
    inputBinding:
      position: 101
      prefix: --d
  - id: config
    type:
      - 'null'
      - File
    doc: 'config file: all options here can be specified in a name<space>value text
      file, over-ridden by command-line args'
    inputBinding:
      position: 101
      prefix: --config
  - id: ctrl_file
    type:
      - 'null'
      - File
    doc: file name (optional argument. must be same format as expt files)
    inputBinding:
      position: 101
      prefix: --ctrl
  - id: design_file
    type:
      - 'null'
      - File
    doc: experiment design file name to use instead of --expt and --ctrl; see 
      website for format
    inputBinding:
      position: 101
      prefix: --design
  - id: diffp
    type:
      - 'null'
      - float
    doc: minimum p-value for reporting differential enrichment
    inputBinding:
      position: 101
      prefix: --diffp
  - id: edgerod
    type:
      - 'null'
      - float
    doc: EdgeR overdispersion parameter
    inputBinding:
      position: 101
      prefix: --edgerod
  - id: eventsaretxt
    type:
      - 'null'
      - boolean
    doc: add .txt to events file extension
    inputBinding:
      position: 101
      prefix: --eventsaretxt
  - id: exclude_regions_file
    type:
      - 'null'
      - File
    doc: file of regions to ignore
    inputBinding:
      position: 101
      prefix: --exclude
  - id: expt_file
    type:
      - 'null'
      - File
    doc: file name
    inputBinding:
      position: 101
      prefix: --expt
  - id: fasta_seq_directory
    type:
      - 'null'
      - Directory
    doc: fasta seq directory reqd if using motif prior
    inputBinding:
      position: 101
      prefix: --seq
  - id: fixedalpha
    type:
      - 'null'
      - string
    doc: 'impose this alpha (default: set automatically)'
    inputBinding:
      position: 101
      prefix: --fixedalpha
  - id: fixedmodelrange
    type:
      - 'null'
      - boolean
    doc: 'flag to keep binding model range fixed to inital size (default: vary automatically)'
    inputBinding:
      position: 101
      prefix: --fixedmodelrange
  - id: fixedpb
    type:
      - 'null'
      - string
    doc: 'fixed per base limit (default: estimated from background model)'
    inputBinding:
      position: 101
      prefix: --fixedpb
  - id: fixedscaling
    type:
      - 'null'
      - string
    doc: 'multiply control counts by total tag count ratio and then by this factor
      (default: NCIS)'
    inputBinding:
      position: 101
      prefix: --fixedscaling
  - id: format
    type:
      - 'null'
      - string
    doc: SAM/BED/SCIDX
    inputBinding:
      position: 101
      prefix: --format
  - id: gaussmodelsmoothing
    type:
      - 'null'
      - boolean
    doc: flag to turn on Gaussian model smoothing (default = cubic spline)
    inputBinding:
      position: 101
      prefix: --gaussmodelsmoothing
  - id: gausssmoothparam
    type:
      - 'null'
      - float
    doc: Gaussian smoothing std dev
    inputBinding:
      position: 101
      prefix: --gausssmoothparam
  - id: genome_info_file
    type:
      - 'null'
      - File
    doc: genome info file
    inputBinding:
      position: 101
      prefix: --geninfo
  - id: jointinmodel
    type:
      - 'null'
      - boolean
    doc: flag to allow joint events in model updates (default=do not)
    inputBinding:
      position: 101
      prefix: --jointinmodel
  - id: mappability
    type:
      - 'null'
      - float
    doc: fraction of the genome that is mappable for these experiments
    inputBinding:
      position: 101
      prefix: --mappability
  - id: max_model_update_rounds
    type:
      - 'null'
      - int
    doc: max. model update rounds
    inputBinding:
      position: 101
      prefix: -r
  - id: medianscale
    type:
      - 'null'
      - boolean
    doc: flag to use scaling by median ratio (default = scaling by NCIS)
    inputBinding:
      position: 101
      prefix: --medianscale
  - id: meme1proc
    type:
      - 'null'
      - boolean
    doc: flag to enforce non-parallel version of MEME
    inputBinding:
      position: 101
      prefix: --meme1proc
  - id: memeargs
    type:
      - 'null'
      - string
    doc: additional args for MEME
    inputBinding:
      position: 101
      prefix: --memeargs
  - id: mememaxw
    type:
      - 'null'
      - int
    doc: maxw arg for MEME
    inputBinding:
      position: 101
      prefix: --mememaxw
  - id: mememinw
    type:
      - 'null'
      - int
    doc: minw arg for MEME
    inputBinding:
      position: 101
      prefix: --mememinw
  - id: memenmotifs
    type:
      - 'null'
      - int
    doc: number of motifs MEME should find for each condition
    inputBinding:
      position: 101
      prefix: --memenmotifs
  - id: memepath
    type:
      - 'null'
      - Directory
    doc: 'path to the meme bin dir (default: meme is in $PATH)'
    inputBinding:
      position: 101
      prefix: --memepath
  - id: min_event_fold_change
    type:
      - 'null'
      - float
    doc: minimum event fold-change vs scaled control
    inputBinding:
      position: 101
      prefix: --minfold
  - id: min_model_update_events
    type:
      - 'null'
      - int
    doc: minimum number of events to support an update
    inputBinding:
      position: 101
      prefix: --minmodelupdateevents
  - id: mlconfignotshared
    type:
      - 'null'
      - boolean
    doc: flag to not share component configs in the ML step
    inputBinding:
      position: 101
      prefix: --mlconfignotshared
  - id: nocache
    type:
      - 'null'
      - boolean
    doc: flag to turn off caching of the entire set of experiments (i.e. run 
      slower with less memory)
    inputBinding:
      position: 101
      prefix: --nocache
  - id: nodifftests
    type:
      - 'null'
      - boolean
    doc: flag to turn off differential enrichment tests
    inputBinding:
      position: 101
      prefix: --nodifftests
  - id: nomodelsmoothing
    type:
      - 'null'
      - boolean
    doc: flag to turn off binding model smoothing
    inputBinding:
      position: 101
      prefix: --nomodelsmoothing
  - id: nomodelupdate
    type:
      - 'null'
      - boolean
    doc: flag to turn off binding model updates
    inputBinding:
      position: 101
      prefix: --nomodelupdate
  - id: nomotifprior
    type:
      - 'null'
      - boolean
    doc: flag to turn off motif priors only
    inputBinding:
      position: 101
      prefix: --nomotifprior
  - id: nomotifs
    type:
      - 'null'
      - boolean
    doc: flag to turn off motif-finding & motif priors
    inputBinding:
      position: 101
      prefix: --nomotifs
  - id: nonunique
    type:
      - 'null'
      - boolean
    doc: flag to use non-unique reads
    inputBinding:
      position: 101
      prefix: --nonunique
  - id: noposprior
    type:
      - 'null'
      - boolean
    doc: flag to turn off inter-experiment positional prior (default=on)
    inputBinding:
      position: 101
      prefix: --noposprior
  - id: noscaling
    type:
      - 'null'
      - boolean
    doc: flag to turn off auto estimation of signal vs control scaling factor
    inputBinding:
      position: 101
      prefix: --noscaling
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: plotscaling
    type:
      - 'null'
      - boolean
    doc: flag to plot diagnostic information for the chosen scaling method
    inputBinding:
      position: 101
      prefix: --plotscaling
  - id: poissongausspb
    type:
      - 'null'
      - boolean
    doc: filter per base using a Poisson threshold parameterized by a local 
      Gaussian sliding window
    inputBinding:
      position: 101
      prefix: --poissongausspb
  - id: prlogconf
    type:
      - 'null'
      - float
    doc: Poisson log threshold for potential region scanning
    inputBinding:
      position: 101
      prefix: --prlogconf
  - id: probshared
    type:
      - 'null'
      - float
    doc: probability that events are shared across conditions
    inputBinding:
      position: 101
      prefix: --probshared
  - id: q_value_minimum
    type:
      - 'null'
      - float
    doc: Q-value minimum
    inputBinding:
      position: 101
      prefix: -q
  - id: regressionscale
    type:
      - 'null'
      - boolean
    doc: flag to use scaling by regression (default = scaling by NCIS)
    inputBinding:
      position: 101
      prefix: --regressionscale
  - id: rpath
    type:
      - 'null'
      - Directory
    doc: 'path to the R bin dir (default: R is in $PATH). Note that you need to install
      edgeR separately'
    inputBinding:
      position: 101
      prefix: --rpath
  - id: scalewin
    type:
      - 'null'
      - int
    doc: window size for scaling procedure
    inputBinding:
      position: 101
      prefix: --scalewin
  - id: sesscale
    type:
      - 'null'
      - boolean
    doc: flag to use scaling by SES (default = scaling by NCIS)
    inputBinding:
      position: 101
      prefix: --sesscale
  - id: splinesmoothparam
    type:
      - 'null'
      - string
    doc: spline smoothing parameter
    inputBinding:
      position: 101
      prefix: --splinesmoothparam
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: flag to print intermediate files and extra output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multigps:0.74--r3.3.1_0
stdout: multigps.out
