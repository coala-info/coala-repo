cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddrage
label: ddrage
doc: "RAGE -- the ddRAD generator -- simulates ddRADseq\n\nTool homepage: https://bitbucket.org/genomeinformatics/rage"
inputs:
  - id: barcode_set
    type:
      - 'null'
      - string
    doc: "Path to barcodes file or predefined barcode set like 'barcodes', 'small',
      'full' or 'full'. Default: 'barcodes', a generic population. Take a look at
      the rage/barcode_handler/barcodes folder for more information."
    default: barcodes
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: bbd_alpha
    type:
      - 'null'
      - float
    doc: Alpha parameter of the Beta-binomial distribution. Higher values 
      increase the left tailing of the coverage distribution, if the BBD model 
      is used.
    default: 6
    inputBinding:
      position: 101
      prefix: --BBD-alpha
  - id: bbd_beta
    type:
      - 'null'
      - float
    doc: Beta parameter of the Beta-binomial distribution. Higher values 
      increase the right tailing of the coverage distribution, if the BBD model 
      is used.
    default: 2
    inputBinding:
      position: 101
      prefix: --BBD-beta
  - id: combine_p7_bcs
    type:
      - 'null'
      - boolean
    doc: Combine individuals with multiple p7 barcodes in one output file.
    default: false
    inputBinding:
      position: 101
      prefix: --combine-p7-bcs
  - id: coverage
    type:
      - 'null'
      - int
    doc: Expected coverage that will be created by normal duplication and 
      mutations. The exact coverage value is determined using a probabilistic 
      process.
    default: 30
    inputBinding:
      position: 101
      prefix: --coverage
  - id: coverage_model
    type:
      - 'null'
      - string
    doc: Model to choose coverage values. Can be either 'poisson' or 
      'betabinomial'. The Betabinomial model is the default as it can be easily 
      adapted to different coverage profiles using the --BBD-alpha and 
      --BBD-beta parameters.
    inputBinding:
      position: 101
      prefix: --coverage-model
  - id: dbr
    type:
      - 'null'
      - string
    doc: "Sequence of the degenerate base region (DBR) in IUPAC ambiguity code. Default:
      'NNNNNNMMGGACG'. To not include a DBR sequence use --dbr ''"
    default: NNNNNNMMGGACG
    inputBinding:
      position: 101
      prefix: --dbr
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set debug-friendly values for the data set, i.e. all mutation events 
      and mutation types are equally probable.
    inputBinding:
      position: 101
      prefix: --DEBUG
  - id: diversity
    type:
      - 'null'
      - float
    doc: 'Parameter for the number of genotypes created per locus. This will be used
      as parameter for a Poisson distribution. Default: 1.0, increase for more alleles/
      genotypes per locus.'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --diversity
  - id: event_probabilities
    type:
      - 'null'
      - string
    doc: 'Probability profile for the distribution of event types (common, dropout,
      mutation; in this order). Example: ``python ddrage.py --event-probabilities
      0.9 0.05 0.05`` -> common 90%, dropout 5%, mutation 5% (Default). Each entry
      can be given as a float or a string of python code (see example above) which
      is helpful for small probability values.'
    inputBinding:
      position: 101
      prefix: --event-probabilities
  - id: gc_content
    type:
      - 'null'
      - float
    doc: GC content of the generated sequences.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --gc-content
  - id: get_barcodes
    type:
      - 'null'
      - boolean
    doc: Write copies of the default barcode files into the current folder.
    inputBinding:
      position: 101
      prefix: --get-barcodes
  - id: hrl_max_cov
    type:
      - 'null'
      - int
    doc: Maximum coverage for Highly Repetitive Loci (HRLs) (per individual). 
      The minimum coverage is determined as mean + 2 standard deviations of the 
      main coverage generating function.
    default: 1000
    inputBinding:
      position: 101
      prefix: --hrl-max-coverage
  - id: hrl_number
    type:
      - 'null'
      - float
    doc: 'Number of Highly Repetitive Loci (HRLs) that will be added, given as fraction
      of total locus size. Example: ``-l 100 --hrl-number 0.1`` for 10 HRLs.'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --hrl-number
  - id: hrl_pcr_copies
    type:
      - 'null'
      - float
    doc: 'Probability of PCR copies for HRL reads in relation to normal reads. Default:
      0.9, i.e. the probability for a PCR copy of a HRL read is prob_pcr_copy * hrl_pcr
      copies = 0.2 * 0.9 = 0.18'
    default: 0.9
    inputBinding:
      position: 101
      prefix: --hrl-pcr-copies
  - id: loci
    type:
      - 'null'
      - string
    doc: Number of loci for which reads will be created or path to a FASTA file 
      with predefined fragments.
    default: '3'
    inputBinding:
      position: 101
      prefix: --loci
  - id: max_pcr_copies
    type:
      - 'null'
      - int
    doc: Maximum number of PCR copies that can be created for each finalized 
      (potentially mutated and multiplied) read.
    default: 3
    inputBinding:
      position: 101
      prefix: --max-pcr-copies
  - id: multiple_p7_barcodes
    type:
      - 'null'
      - boolean
    doc: Combine individuals with multiple p7 barcodes in one output file.
    default: false
    inputBinding:
      position: 101
      prefix: --multiple-p7-barcodes
  - id: mutation_type_probabilities
    type:
      - 'null'
      - string
    doc: "Probability profile for the distribution of mutation types (snp, insertion,
      deletion, p5 na alternative, p7 na alternative, p5 na dropout, p7 na dropout;
      in this order). Example: ``python ddrage.py --mutation-type- probabilities 0.8999
      0.05 0.05 '0.0001*0.001' '0.0001*0.05' '0.0001*0.899' '0.0001*0.05'`` -> snp
      89.99%, insertion 5%, deletion 5%, p5 na alternative 0.00001% , p7 na alternative
      0.0005%, p5 na dropout 0.00899%, p7 na dropout 0.0005% (Default). Each entry
      can be given as a float or a string of python code (see example above) which
      is helpful for small probability values."
    inputBinding:
      position: 101
      prefix: --mutation-type-probabilities
  - id: name
    type:
      - 'null'
      - string
    doc: Name for the data set that will be used in the file name. If none is 
      given, the name 'RAGEdataset' will be used.
    default: RAGEdataset
    inputBinding:
      position: 101
      prefix: --name
  - id: no_singletons
    type:
      - 'null'
      - boolean
    doc: Disable generation of singleton reads.
    inputBinding:
      position: 101
      prefix: --no-singletons
  - id: nr_individuals
    type:
      - 'null'
      - int
    doc: Number of individuals in the result.
    default: 3
    inputBinding:
      position: 101
      prefix: --nr-individuals
  - id: output_path_prefix
    type:
      - 'null'
      - Directory
    doc: Prefix of the output path. At this point a folder will be created that 
      contains all output files created by ddrage.
    inputBinding:
      position: 101
      prefix: --output
  - id: overlap
    type:
      - 'null'
      - float
    doc: Overlap factor (between 0 and 1.0) of randomly generated reads.
    default: 0
    inputBinding:
      position: 101
      prefix: --overlap
  - id: p5_overhang
    type:
      - 'null'
      - string
    doc: Sequence of the p5 overhang.
    default: TGCAT
    inputBinding:
      position: 101
      prefix: --p5-overhang
  - id: p5_rec_site
    type:
      - 'null'
      - string
    doc: Sequence of the p5 recognition site.
    default: ATGCAT
    inputBinding:
      position: 101
      prefix: --p5-rec-site
  - id: p7_overhang
    type:
      - 'null'
      - string
    doc: Sequence of the p7 overhang.
    default: TAC
    inputBinding:
      position: 101
      prefix: --p7-overhang
  - id: p7_rec_site
    type:
      - 'null'
      - string
    doc: Sequence of the p7 recognition site.
    default: GTCA
    inputBinding:
      position: 101
      prefix: --p7-rec-site
  - id: prob_heterozygocity
    type:
      - 'null'
      - float
    doc: Probability of mutations being heterozygous.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --prob-heterozygous
  - id: prob_incomplete_digestion
    type:
      - 'null'
      - float
    doc: Probability of incomplete digestion for an individual at a locus.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --prob-incomplete-digestion
  - id: prob_pcr_copy
    type:
      - 'null'
      - float
    doc: Probability that a (potentially mutated and multiplied) read will 
      receive PCR copies. This influences the simulated PCR copy rate.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --prob-pcr-copy
  - id: prob_seq_error
    type:
      - 'null'
      - float
    doc: Probability of sequencing substitution errors.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --prob-seq-error
  - id: quality_model
    type:
      - 'null'
      - File
    doc: Path to a quality model file (.qmodel.npz). A qmodel file contains a 
      probability vector for each read position. For details, please refer to 
      the documentation.
    inputBinding:
      position: 101
      prefix: --quality-model
  - id: rate_incomplete_digestion
    type:
      - 'null'
      - float
    doc: Expected fraction of reads that are being lost in the event of 
      Incomplete Digestion.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --rate-incomplete-digestion
  - id: read_length
    type:
      - 'null'
      - int
    doc: Total sequence length of the reads (including overhang, barcodes, 
      etc.). The officially supported and well tested range is 50-500bp but 
      longer or shorter reads are also possible.
    default: 100
    inputBinding:
      position: 101
      prefix: --read-length
  - id: se
    type:
      - 'null'
      - boolean
    doc: Write a single-end dataset. Only writes a p5 FASTQ file.
    default: false
    inputBinding:
      position: 101
      prefix: --se
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Write a single-end dataset. Only writes a p5 FASTQ file.
    default: false
    inputBinding:
      position: 101
      prefix: --single-end
  - id: singleton_pcr_copies
    type:
      - 'null'
      - float
    doc: 'Probability of PCR copies for singleton reads in relation to normal reads.
      Default: 1/3, i.e. the probability for a PCR copy of a singleton read is prob_pcr_copy
      * singleton_pcr_copies = 0.2 * (1/3) = 0.0666...'
    default: 1/3
    inputBinding:
      position: 101
      prefix: --singleton-pcr-copies
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity of output. -v: Show progress of simulation. -vv: Print
      used parameters after simulation. -vvv: Show details for each simulated locus.'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zip
    type:
      - 'null'
      - boolean
    doc: Write output as gzipped fastq.
    inputBinding:
      position: 101
      prefix: --zip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddrage:1.8.1--pyhdfd78af_0
stdout: ddrage.out
