cwlVersion: v1.2
class: CommandLineTool
baseCommand: chexmix
label: chexmix
doc: "ChExMix is a tool for identifying and characterizing binding events and subtypes
  from ChIP-seq data.\n\nTool homepage: http://mahonylab.org/software/chexmix/"
inputs:
  - id: alphascale
    type:
      - 'null'
      - float
    doc: alpha scaling factor; increase for stricter event calls (default=1.0)
    default: 1.0
    inputBinding:
      position: 101
      prefix: --alphascale
  - id: back
    type:
      - 'null'
      - File
    doc: Markov background model file reqd if finding motif
    inputBinding:
      position: 101
      prefix: --back
  - id: betascale
    type:
      - 'null'
      - float
    doc: beta scaling factor; sparse prior on subtype assignment (default=0.05)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --betascale
  - id: bmwindowmax
    type:
      - 'null'
      - int
    doc: max. window size for running a mixture model over binding events 
      (default=2000)
    default: 2000
    inputBinding:
      position: 101
      prefix: --bmwindowmax
  - id: config
    type:
      - 'null'
      - File
    doc: 'config file: all options here can be specified in a name<space>value text
      file, over-ridden by command-line args'
    inputBinding:
      position: 101
      prefix: --config
  - id: ctrl
    type:
      - 'null'
      - File
    doc: file name (optional argument. must be same format as expt files)
    inputBinding:
      position: 101
      prefix: --ctrl
  - id: design
    type:
      - 'null'
      - File
    doc: experiment design file name to use instead of --expt and --ctrl; see 
      website for format
    inputBinding:
      position: 101
      prefix: --design
  - id: epsilonscale
    type:
      - 'null'
      - float
    doc: epsilon scaling factor; increase for more weight on motif in subtype 
      assignment (default=0.2)
    default: 0.2
    inputBinding:
      position: 101
      prefix: --epsilonscale
  - id: exclude
    type:
      - 'null'
      - File
    doc: file of regions to ignore
    inputBinding:
      position: 101
      prefix: --exclude
  - id: excludebed
    type:
      - 'null'
      - File
    doc: file of regions to ignore in bed format
    inputBinding:
      position: 101
      prefix: --excludebed
  - id: expt
    type:
      - 'null'
      - File
    doc: file name
    inputBinding:
      position: 101
      prefix: --expt
  - id: fixedalpha
    type:
      - 'null'
      - string
    doc: 'binding events must have at least this number of reads (default: set automatically)'
    inputBinding:
      position: 101
      prefix: --fixedalpha
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
    doc: SAM/BED/IDX
    inputBinding:
      position: 101
      prefix: --format
  - id: galaxyhtml
    type:
      - 'null'
      - boolean
    doc: produce a html output appropreate for galaxy
    inputBinding:
      position: 101
      prefix: --galaxyhtml
  - id: geninfo
    type:
      - 'null'
      - File
    doc: genome info file
    inputBinding:
      position: 101
      prefix: --geninfo
  - id: kldivergencethres
    type:
      - 'null'
      - float
    doc: KL divergence dissimilarity threshold for merging subtypes using read 
      distributions; increase for fewer subtypes (default=-10)
    default: -10.0
    inputBinding:
      position: 101
      prefix: --kldivergencethres
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: report events that pass significance in >=1 replicate *or* the 
      condition as a whole.
    inputBinding:
      position: 101
      prefix: --lenient
  - id: lenientplus
    type:
      - 'null'
      - boolean
    doc: report events that pass significance in condition OR (>=1 replicate AND
      no signif diff between replicates)
    inputBinding:
      position: 101
      prefix: --lenientplus
  - id: mappability
    type:
      - 'null'
      - float
    doc: fraction of the genome that is mappable for these experiments 
      (default=0.8)
    default: 0.8
    inputBinding:
      position: 101
      prefix: --mappability
  - id: medianscale
    type:
      - 'null'
      - boolean
    doc: use scaling by median ratio (default = scaling by NCIS)
    inputBinding:
      position: 101
      prefix: --medianscale
  - id: memeargs
    type:
      - 'null'
      - string
    doc: additional args for MEME (default=  -dna -mod zoops -revcomp -nostatus)
    default: -dna -mod zoops -revcomp -nostatus
    inputBinding:
      position: 101
      prefix: --memeargs
  - id: mememaxw
    type:
      - 'null'
      - int
    doc: maxw arg for MEME (default=18)
    default: 18
    inputBinding:
      position: 101
      prefix: --mememaxw
  - id: mememinw
    type:
      - 'null'
      - int
    doc: minw arg for MEME (default=6)
    default: 6
    inputBinding:
      position: 101
      prefix: --mememinw
  - id: memenmotifs
    type:
      - 'null'
      - int
    doc: number of motifs MEME should find for each condition (default=3)
    default: 3
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
  - id: minfold
    type:
      - 'null'
      - float
    doc: minimum event fold-change vs scaled control (default=1.5)
    default: 1.5
    inputBinding:
      position: 101
      prefix: --minfold
  - id: minmodelupdateevents
    type:
      - 'null'
      - int
    doc: minimum number of events to support an update using read distributions 
      (default=100)
    default: 100
    inputBinding:
      position: 101
      prefix: --minmodelupdateevents
  - id: minmodelupdaterefs
    type:
      - 'null'
      - int
    doc: minimum number of motif reference to support an subtype distribution 
      update (default=50)
    default: 50
    inputBinding:
      position: 101
      prefix: --minmodelupdaterefs
  - id: minroc
    type:
      - 'null'
      - float
    doc: minimum motif ROC value (default=0.7)
    default: 0.7
    inputBinding:
      position: 101
      prefix: --minroc
  - id: minsubtypefrac
    type:
      - 'null'
      - float
    doc: subtypes must have at least this percentage of associated binding 
      events; increase for fewer subtypes (default=0.05)
    default: 0.05
    inputBinding:
      position: 101
      prefix: --minsubtypefrac
  - id: motfile
    type:
      - 'null'
      - File
    doc: file of motifs in transfac format to initialize subtype motifs
    inputBinding:
      position: 101
      prefix: --motfile
  - id: motifpccthres
    type:
      - 'null'
      - float
    doc: motif length adjusted similarity threshold for merging subtypes using 
      motifs; decrease for fewer subtypes (default=0.95)
    default: 0.95
    inputBinding:
      position: 101
      prefix: --motifpccthres
  - id: nocache
    type:
      - 'null'
      - boolean
    doc: turn off caching of the entire set of experiments (i.e. run slower with
      less memory)
    inputBinding:
      position: 101
      prefix: --nocache
  - id: noclustering
    type:
      - 'null'
      - boolean
    doc: turn off read distribution clustering
    inputBinding:
      position: 101
      prefix: --noclustering
  - id: nomodelupdate
    type:
      - 'null'
      - boolean
    doc: turn off binding model updates
    inputBinding:
      position: 101
      prefix: --nomodelupdate
  - id: nomotifprior
    type:
      - 'null'
      - boolean
    doc: turn off motif priors only
    inputBinding:
      position: 101
      prefix: --nomotifprior
  - id: nomotifs
    type:
      - 'null'
      - boolean
    doc: turn off motif-finding & motif priors
    inputBinding:
      position: 101
      prefix: --nomotifs
  - id: nonunique
    type:
      - 'null'
      - boolean
    doc: use non-unique reads
    inputBinding:
      position: 101
      prefix: --nonunique
  - id: noscaling
    type:
      - 'null'
      - boolean
    doc: turn off auto estimation of signal vs control scaling factor
    inputBinding:
      position: 101
      prefix: --noscaling
  - id: noupdateinitmotifs
    type:
      - 'null'
      - boolean
    doc: leave initial motifs (provided by --motfile) fixed
    inputBinding:
      position: 101
      prefix: --noupdateinitmotifs
  - id: numcomps
    type:
      - 'null'
      - int
    doc: number of components to cluster (default=500)
    default: 500
    inputBinding:
      position: 101
      prefix: --numcomps
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: peakf
    type:
      - 'null'
      - File
    doc: file of peaks to initialize component positions
    inputBinding:
      position: 101
      prefix: --peakf
  - id: plotscaling
    type:
      - 'null'
      - boolean
    doc: plot diagnostic information for the chosen scaling method
    inputBinding:
      position: 101
      prefix: --plotscaling
  - id: poissongausspb
    type:
      - 'null'
      - string
    doc: filter per base using a Poisson threshold parameterized by a local 
      Gaussian sliding window
    inputBinding:
      position: 101
      prefix: --poissongausspb
  - id: pref
    type:
      - 'null'
      - float
    doc: preference value for read distribution clustering (default=-0.1)
    default: -0.1
    inputBinding:
      position: 101
      prefix: --pref
  - id: prlogconf
    type:
      - 'null'
      - float
    doc: Poisson log threshold for potential region scanning (default=-6)
    default: -6.0
    inputBinding:
      position: 101
      prefix: --prlogconf
  - id: q
    type:
      - 'null'
      - float
    doc: Q-value minimum (default=0.01)
    default: 0.01
    inputBinding:
      position: 101
      prefix: --q
  - id: regressionscale
    type:
      - 'null'
      - boolean
    doc: use scaling by regression (default = scaling by NCIS)
    inputBinding:
      position: 101
      prefix: --regressionscale
  - id: round
    type:
      - 'null'
      - int
    doc: max. model update rounds (default=3)
    default: 3
    inputBinding:
      position: 101
      prefix: --round
  - id: scalewin
    type:
      - 'null'
      - int
    doc: window size for scaling procedure (default=10000)
    default: 10000
    inputBinding:
      position: 101
      prefix: --scalewin
  - id: seq
    type:
      - 'null'
      - Directory
    doc: fasta seq directory reqd if finding motif
    inputBinding:
      position: 101
      prefix: --seq
  - id: seqrmthres
    type:
      - 'null'
      - float
    doc: Filter out sequences with motifs below this threshold for recursively 
      finding motifs (default=0.1)
    default: 0.1
    inputBinding:
      position: 101
      prefix: --seqrmthres
  - id: sesscale
    type:
      - 'null'
      - boolean
    doc: use scaling by SES (default = scaling by NCIS)
    inputBinding:
      position: 101
      prefix: --sesscale
  - id: standard
    type:
      - 'null'
      - boolean
    doc: report events that pass significance threshold in condition as a whole 
      (default mode)
    inputBinding:
      position: 101
      prefix: --standard
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 1
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
  - id: win
    type:
      - 'null'
      - int
    doc: window size of read profiles (default=150)
    default: 150
    inputBinding:
      position: 101
      prefix: --win
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chexmix:0.52--hdfd78af_0
stdout: chexmix.out
