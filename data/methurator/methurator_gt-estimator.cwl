cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methurator
  - gt-estimator
label: methurator_gt-estimator
doc: "Fit the Chao estimator.\n\nTool homepage: https://github.com/VIBTOBIlab/methurator"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: Path to a single .bam file or to multiple ones (e.g. files/*.bam).
    inputBinding:
      position: 1
  - id: bootstrap_replicates
    type:
      - 'null'
      - int
    doc: Number of bootstrap replicates. (INTEGER RANGE 10<=x<=100)
    inputBinding:
      position: 102
      prefix: --bootstrap-replicates
  - id: compute_ci
    type:
      - 'null'
      - boolean
    doc: Compute confidence intervals.
    inputBinding:
      position: 102
      prefix: --compute_ci
  - id: conf
    type:
      - 'null'
      - float
    doc: Confidence level for the bootstrap confidence intervals. (FLOAT RANGE 
      0.1<=x<=0.99)
    inputBinding:
      position: 102
      prefix: --conf
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file of the reference genome used to align the samples. If not 
      provided, it will download it according to the specified genome.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome used to align the samples. (hg19|hg38|GRCh37|GRCh38|mm10|mm39)
    inputBinding:
      position: 102
      prefix: --genome
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: If set to True, temporary files will be kept after the analysis.
    inputBinding:
      position: 102
      prefix: --keep-temporary-files
  - id: minimum_coverage
    type:
      - 'null'
      - string
    doc: CpG coverage to estimate sequencing saturation. It can be either a 
      single integer or a list of integers (e.g 1,3,5).
    inputBinding:
      position: 102
      prefix: --minimum-coverage
  - id: mt
    type:
      - 'null'
      - int
    doc: An positive integer constraining possible rational function 
      approximations.
    inputBinding:
      position: 102
      prefix: --mt
  - id: mu
    type:
      - 'null'
      - float
    doc: Initial value for the mu parameter in the negative binomial 
      distribution for the EM algorithm.
    inputBinding:
      position: 102
      prefix: --mu
  - id: rrbs
    type:
      - 'null'
      - boolean
    doc: If set to True, MethylDackel extract will consider the RRBS nature of 
      the data adding the --keepDupes flag.
    inputBinding:
      position: 102
      prefix: --rrbs
  - id: size
    type:
      - 'null'
      - float
    doc: A positive double, the initial value of the parameter size in the 
      negative binomial distribution for the EM algorithm.
    inputBinding:
      position: 102
      prefix: --size
  - id: t_max
    type:
      - 'null'
      - float
    doc: Maximum value of t for prediction. (FLOAT RANGE 2.0<=x<=1000.0)
    inputBinding:
      position: 102
      prefix: --t-max
  - id: t_step
    type:
      - 'null'
      - float
    doc: Step size taken when predicting future unique CpGs at increasing depth.
    inputBinding:
      position: 102
      prefix: --t-step
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Default: all available threads - 2.'
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Default output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
