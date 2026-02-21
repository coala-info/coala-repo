cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - hmmratac
label: macs3_hmmratac
doc: "HMMRATAC is a dedicated tool specifically designed for processing ATAC-seq data
  using a Hidden Markov Model to learn the nucleosome structure around open chromatin
  regions.\n\nTool homepage: https://pypi.org/project/MACS3/"
inputs:
  - id: binsize
    type:
      - 'null'
      - int
    doc: Size of the bins to split the pileup signals for training and decoding 
      with Hidden Markov Model.
    default: 10
    inputBinding:
      position: 101
      prefix: --binsize
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Filename of blacklisted regions to exclude.
    inputBinding:
      position: 101
      prefix: --blacklist
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    default: 100000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: cutoff_analysis_max
    type:
      - 'null'
      - int
    doc: The maximum cutoff score for performing cutoff analysis.
    default: 100
    inputBinding:
      position: 101
      prefix: --cutoff-analysis-max
  - id: cutoff_analysis_only
    type:
      - 'null'
      - boolean
    doc: Only run the cutoff analysis and output a report. After generating the 
      report, the process will stop.
    inputBinding:
      position: 101
      prefix: --cutoff-analysis-only
  - id: cutoff_analysis_steps
    type:
      - 'null'
      - int
    doc: Steps for performing cutoff analysis.
    default: 100
    inputBinding:
      position: 101
      prefix: --cutoff-analysis-steps
  - id: decoding_steps
    type:
      - 'null'
      - int
    doc: Number of candidate regions to be decoded at a time.
    default: 1000
    inputBinding:
      position: 101
      prefix: --decoding-steps
  - id: format
    type:
      - 'null'
      - string
    doc: Format of input files, 'BAMPE' or 'BEDPE'.
    default: BAMPE
    inputBinding:
      position: 101
      prefix: --format
  - id: hmm_type
    type:
      - 'null'
      - string
    doc: Select a Gaussian ('gaussian') or Poisson ('poisson') model for the 
      hidden markov model.
    default: gaussian
    inputBinding:
      position: 101
      prefix: --hmm-type
  - id: input_file
    type:
      type: array
      items: File
    doc: Input files containing the alignment results for ATAC-seq paired end 
      reads. The file should be in BAMPE or BEDPE format.
    inputBinding:
      position: 101
      prefix: --input
  - id: lower
    type:
      - 'null'
      - float
    doc: Lower limit on fold change range for choosing training sites.
    default: 10
    inputBinding:
      position: 101
      prefix: --lower
  - id: max_train
    type:
      - 'null'
      - int
    doc: Maximum number of training regions to use.
    default: 1000
    inputBinding:
      position: 101
      prefix: --maxTrain
  - id: means
    type:
      - 'null'
      - type: array
        items: float
    doc: Initial mean values for the fragment distribution for short fragments, 
      mono-, di-, and tri-nucleosomal fragments.
    default:
      - 50
      - 200
      - 400
      - 600
    inputBinding:
      position: 101
      prefix: --means
  - id: min_frag_p
    type:
      - 'null'
      - float
    doc: Probability threshold to exclude abnormal fragments.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --min-frag-p
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum length of open region to call accessible regions.
    default: 100
    inputBinding:
      position: 101
      prefix: --minlen
  - id: model_file
    type:
      - 'null'
      - File
    doc: A JSON file generated from previous HMMRATAC run to use instead of 
      creating new one.
    inputBinding:
      position: 101
      prefix: --model
  - id: model_only
    type:
      - 'null'
      - boolean
    doc: Stop the program after generating model.
    default: false
    inputBinding:
      position: 101
      prefix: --modelonly
  - id: name
    type:
      - 'null'
      - string
    doc: Name for this experiment, which will be used as a prefix to generate 
      output file names.
    default: NA
    inputBinding:
      position: 101
      prefix: --name
  - id: no_fragem
    type:
      - 'null'
      - boolean
    doc: Do not perform EM training on the fragment distribution.
    default: false
    inputBinding:
      position: 101
      prefix: --no-fragem
  - id: pileup_short
    type:
      - 'null'
      - boolean
    doc: Pileup only the short fragments to identify regions for training and 
      candidate regions for decoding.
    default: false
    inputBinding:
      position: 101
      prefix: --pileup-short
  - id: prescan_cutoff
    type:
      - 'null'
      - float
    doc: The fold change cutoff for prescanning candidate regions in the whole 
      dataset.
    default: 1.2
    inputBinding:
      position: 101
      prefix: --prescan-cutoff
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed to set for random sampling of training regions.
    default: 10151
    inputBinding:
      position: 101
      prefix: --randomSeed
  - id: remove_dup
    type:
      - 'null'
      - boolean
    doc: Remove duplicated fragments from analysis.
    default: false
    inputBinding:
      position: 101
      prefix: --remove-dup
  - id: save_digested
    type:
      - 'null'
      - boolean
    doc: Save the digested ATAC signals of short-, mono-, di-, and tri- signals 
      in three BedGraph files.
    default: false
    inputBinding:
      position: 101
      prefix: --save-digested
  - id: save_likelihoods
    type:
      - 'null'
      - boolean
    doc: Save the likelihoods to each state annotation in three BedGraph files.
    default: false
    inputBinding:
      position: 101
      prefix: --save-likelihoods
  - id: save_states
    type:
      - 'null'
      - boolean
    doc: Save all open and nucleosomal state annotations into a BED file.
    default: false
    inputBinding:
      position: 101
      prefix: --save-states
  - id: save_training_data
    type:
      - 'null'
      - boolean
    doc: Save the training regions and training data into 
      NAME_training_regions.bed and NAME_training_data.txt.
    default: false
    inputBinding:
      position: 101
      prefix: --save-training-data
  - id: stddevs
    type:
      - 'null'
      - type: array
        items: float
    doc: Initial standard deviation values for fragment distribution for short 
      fragments, mono-, di-, and tri-nucleosomal fragments.
    default:
      - 20
      - 20
      - 20
      - 20
    inputBinding:
      position: 101
      prefix: --stddevs
  - id: training_flanking
    type:
      - 'null'
      - int
    doc: Training regions will be expanded to both side with this number of 
      basepairs.
    default: 1000
    inputBinding:
      position: 101
      prefix: --training-flanking
  - id: training_regions
    type:
      - 'null'
      - File
    doc: Filename of training regions to use for training HMM.
    inputBinding:
      position: 101
      prefix: --training
  - id: upper
    type:
      - 'null'
      - float
    doc: Upper limit on fold change range for choosing training sites.
    default: 20
    inputBinding:
      position: 101
      prefix: --upper
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbose level of runtime message.
    default: 2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
