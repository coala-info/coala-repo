cwlVersion: v1.2
class: CommandLineTool
baseCommand: qtip
label: qtip
doc: "Align a collection of input reads, simulate a tandem dataset, align the tandem
  dataset, and emit both the input read alignments and the training data derived from
  the tandem read alignments.\n\nTool homepage: https://github.com/BenLangmead/qtip"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'Which aligner to use: bowtie2 | bwa-mem | snap'
    inputBinding:
      position: 101
      prefix: --aligner
  - id: assess_accuracy
    type:
      - 'null'
      - boolean
    doc: When correctness can be inferred from simulated read names, assess 
      accuracy of old and new MAPQ predictions
    inputBinding:
      position: 101
      prefix: --assess-accuracy
  - id: assess_limit
    type:
      - 'null'
      - int
    doc: The maximum number of alignments to assess when assessing accuracy
    inputBinding:
      position: 101
      prefix: --assess-limit
  - id: bt2_exe
    type:
      - 'null'
      - File
    doc: Path to Bowtie 2 aligner exe, "bowtie2"
    inputBinding:
      position: 101
      prefix: --bt2-exe
  - id: bwa_exe
    type:
      - 'null'
      - File
    doc: Path to BWA-MEM aligner exe, "bwa"
    inputBinding:
      position: 101
      prefix: --bwa-exe
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: Remove redundant rows just before prediction. Usually not a net win.
    inputBinding:
      position: 101
      prefix: --collapse
  - id: index
    type:
      - 'null'
      - File
    doc: Index file to use; specify the appropriate prefix, e.g. Bowtie 2 index 
      file name without the .X.bt2 suffix.
    inputBinding:
      position: 101
      prefix: --index
  - id: input_model_size
    type:
      - 'null'
      - int
    doc: 'Maximum # templates to keep when building an input model. There are 4 separate
      models for each alignment category and this governs the maximum for all 4.'
    inputBinding:
      position: 101
      prefix: --input-model-size
  - id: keep_intermediates
    type:
      - 'null'
      - boolean
    doc: Keep intermediates in output directory; if False, intermediates are 
      written to a temporary directory then deleted
    inputBinding:
      position: 101
      prefix: --keep-intermediates
  - id: keep_ztz
    type:
      - 'null'
      - boolean
    doc: Don't remove ZT:Z field, with aligner-reported feature data, from the 
      final output SAM
    inputBinding:
      position: 101
      prefix: --keep-ztz
  - id: learning_rate
    type:
      - 'null'
      - string
    doc: learning rate to use when fitting; only relevant for GradientBoosting
    inputBinding:
      position: 101
      prefix: --learning-rate
  - id: mate1_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Mate 1 FASTQ file name, or many FASTQ file names separated by spaces; 
      must be specified in same order as --m2
    inputBinding:
      position: 101
      prefix: --m1
  - id: mate2_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Mate 2 FASTQ file name, or many FASTQ file names separated by spaces; 
      must be specified in same order as --m1
    inputBinding:
      position: 101
      prefix: --m2
  - id: max_allowed_fraglen
    type:
      - 'null'
      - int
    doc: When simulating fragments, longer fragments are truncated to this 
      length
    inputBinding:
      position: 101
      prefix: --max-allowed-fraglen
  - id: max_features
    type:
      - 'null'
      - string
    doc: maximum number of features to consider at each decision tree node; 
      relevant for RandomForest and ExtraTrees
    inputBinding:
      position: 101
      prefix: --max-features
  - id: max_leaf_nodes
    type:
      - 'null'
      - string
    doc: maximum number of leaf nodes to include in a decision tree; relevant 
      for RandomForest and ExtraTrees
    inputBinding:
      position: 101
      prefix: --max-leaf-nodes
  - id: max_rows
    type:
      - 'null'
      - int
    doc: Maximum number of rows (alignments) to feed at once to the prediction 
      function
    inputBinding:
      position: 101
      prefix: --max-rows
  - id: model_family
    type:
      - 'null'
      - string
    doc: '{RandomForest | ExtraTrees | GradientBoosting}'
    inputBinding:
      position: 101
      prefix: --model-family
  - id: no_oob
    type:
      - 'null'
      - boolean
    doc: Don't use out-of-bag score when fitting hyperparameters -- use cross 
      validation instead. No effect for models that don't calculate OOB score.
    inputBinding:
      position: 101
      prefix: --no-oob
  - id: num_trees
    type:
      - 'null'
      - string
    doc: number of decision trees to try; relevant for all model families
    inputBinding:
      position: 101
      prefix: --num-trees
  - id: optimization_tolerance
    type:
      - 'null'
      - float
    doc: When using hill climbing procedure to optimize hyperparamters,stop when
      OOB score can't be improved by this relative factor
    inputBinding:
      position: 101
      prefix: --optimization-tolerance
  - id: orig_mapq_flag
    type:
      - 'null'
      - string
    doc: If --write-orig-mapq is specified, store original MAPQ in this extra 
      SAM field
    inputBinding:
      position: 101
      prefix: --orig-mapq-flag
  - id: precise_mapq_flag
    type:
      - 'null'
      - string
    doc: If --write-precise-mapq is specified, store original MAPQ in this extra
      SAM field
    inputBinding:
      position: 101
      prefix: --precise-mapq-flag
  - id: predict_for_training
    type:
      - 'null'
      - boolean
    doc: Make predictions and produce associated plots/output files for training
      (tandem) data
    inputBinding:
      position: 101
      prefix: --predict-for-training
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Print profiling info
    inputBinding:
      position: 101
      prefix: --profile
  - id: profile_memory
    type:
      - 'null'
      - boolean
    doc: Use guppy/heapy to profile memory and periodically print heap usage
    inputBinding:
      position: 101
      prefix: --profile-memory
  - id: ref
    type:
      type: array
      items: File
    doc: FASTA file, or many FASTAs separated by spaces, containing reference 
      genome sequences
    inputBinding:
      position: 101
      prefix: --ref
  - id: reweight_mapq
    type:
      - 'null'
      - boolean
    doc: When fitting, reweigh samples according to initially-predicted mapq. 
      Higher predictions get more weight
    inputBinding:
      position: 101
      prefix: --reweight-mapq
  - id: reweight_mapq_offset
    type:
      - 'null'
      - float
    doc: Add this to every MAPQ before reweighting
    inputBinding:
      position: 101
      prefix: --reweight-mapq-offset
  - id: reweight_ratio
    type:
      - 'null'
      - float
    doc: When fitting, reweigh samples so weight of highest-mapq alignment has 
      this times as much weight as lowest-mapq.
    inputBinding:
      position: 101
      prefix: --reweight-ratio
  - id: seed
    type:
      - 'null'
      - int
    doc: Integer to initialize pseudo-random generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: sim_bad_end_min
    type:
      - 'null'
      - int
    doc: 'If predictions for ends with an unaligned mate are needed, simulate at least
      this # of pairs with a bad end.'
    inputBinding:
      position: 101
      prefix: --sim-bad-end-min
  - id: sim_conc_min
    type:
      - 'null'
      - int
    doc: 'If predictions for concordantly aligned reads are needed, simulate at least
      this # of concordant pairs.'
    inputBinding:
      position: 101
      prefix: --sim-conc-min
  - id: sim_disc_min
    type:
      - 'null'
      - int
    doc: 'If predictions for discordantly aligned reads are needed, simulate at least
      this # of discordant pairs.'
    inputBinding:
      position: 101
      prefix: --sim-disc-min
  - id: sim_factor
    type:
      - 'null'
      - float
    doc: 'This is multiplied with X (if --sim-function=linear) or with sqrt(X) (if
      --sim-function=sqrt) or with 1 (if --sim-function=const) to calculate # tandem
      reads to simulate in a given category, where X is # of input reads in that category.'
    inputBinding:
      position: 101
      prefix: --sim-factor
  - id: sim_function
    type:
      - 'null'
      - string
    doc: 'Function giving # of tandem reads to simulate in a category; parameter is
      the number of input reads. See also: --sim-factor.'
    inputBinding:
      position: 101
      prefix: --sim-function
  - id: sim_unp_min
    type:
      - 'null'
      - int
    doc: 'If predictions for unpaired reads are needed, simulate at least this # of
      unpaired reads.'
    inputBinding:
      position: 101
      prefix: --sim-unp-min
  - id: skip_rewrite
    type:
      - 'null'
      - boolean
    doc: Skip the final SAM rewriting step; other results, including any fit and
      prediction assessments requested, are still written.
    inputBinding:
      position: 101
      prefix: --skip-rewrite
  - id: snap_exe
    type:
      - 'null'
      - File
    doc: Path to SNAP aligner exe, "snap-aligner"
    inputBinding:
      position: 101
      prefix: --snap-exe
  - id: subsampling_series
    type:
      - 'null'
      - string
    doc: Comma separated list of subsampling fractions to try
    inputBinding:
      position: 101
      prefix: --subsampling-series
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: 'Write temporary files to this directory; when None: uses environment variables
      like TMPDIR, TEMP, etc'
    inputBinding:
      position: 101
      prefix: --temp-directory
  - id: trials
    type:
      - 'null'
      - int
    doc: Number of times to repeat fitting/prediction
    inputBinding:
      position: 101
      prefix: --trials
  - id: try_include_mapq
    type:
      - 'null'
      - boolean
    doc: 'Try both with and without including the tool-predicted MAPQ as a feature;
    inputBinding:
      position: 101
      prefix: --try-include-mapq
  - id: unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Unpaired read FASTQ file name, or many FASTQ file names separated by 
      spaces
    inputBinding:
      position: 101
      prefix: --U
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be talkative
    inputBinding:
      position: 101
      prefix: --verbose
  - id: wiggle
    type:
      - 'null'
      - int
    doc: Wiggle room to allow in starting position when determining whether 
      alignment is correct
    inputBinding:
      position: 101
      prefix: --wiggle
  - id: write_orig_mapq
    type:
      - 'null'
      - boolean
    doc: Write original MAPQ as an extra field in output SAM
    inputBinding:
      position: 101
      prefix: --write-orig-mapq
  - id: write_precise_mapq
    type:
      - 'null'
      - boolean
    doc: Write a more precise MAPQ prediction as an extra field in output SAM
    inputBinding:
      position: 101
      prefix: --write-precise-mapq
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Write outputs to this directory
    outputBinding:
      glob: $(inputs.output_directory)
  - id: vanilla_output
    type:
      - 'null'
      - File
    doc: Only write final SAM file; suppress all other output
    outputBinding:
      glob: $(inputs.vanilla_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qtip:1.6.2--py36_0
