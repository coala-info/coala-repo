cwlVersion: v1.2
class: CommandLineTool
baseCommand: xhmm
label: xhmm_preparetargets
doc: "Uses principal component analysis (PCA) normalization and a hidden Markov model
  (HMM) to detect and genotype copy number variation (CNV) from normalized read-depth
  data from targeted sequencing experiments.\n\nTool homepage: http://atgu.mgh.harvard.edu/xhmm/index.shtml"
inputs:
  - id: aux_downstream_print_targs
    type:
      - 'null'
      - int
    doc: Number of targets to print downstream of CNV in 'auxOutput' file
    default: 2
    inputBinding:
      position: 101
      prefix: --auxDownstreamPrintTargs
  - id: aux_upstream_print_targs
    type:
      - 'null'
      - int
    doc: Number of targets to print upstream of CNV in 'auxOutput' file
    default: 2
    inputBinding:
      position: 101
      prefix: --auxUpstreamPrintTargs
  - id: aux_xcnv
    type:
      - 'null'
      - string
    doc: Auxiliary CNV output file (may be VERY LARGE in 'genotype' mode)
    inputBinding:
      position: 101
      prefix: --aux_xcnv
  - id: center_data
    type:
      - 'null'
      - boolean
    doc: Output sample- or target- centered read-depth matrix (as per 
      --centerType)
    default: off
    inputBinding:
      position: 101
      prefix: --centerData
  - id: center_type
    type:
      - 'null'
      - string
    doc: If --centerData given, then center the data around this dimension
    inputBinding:
      position: 101
      prefix: --centerType
  - id: column_suffix
    type:
      - 'null'
      - string
    doc: 'Suffix of columns to be used for merging [where columns are in the form:
      SAMPLE + columnSuffix]'
    default: _mean_cvg
    inputBinding:
      position: 101
      prefix: --columnSuffix
  - id: discover
    type:
      - 'null'
      - boolean
    doc: Discover CNVs from normalized read depth matrix. Matrix is read from 
      --readDepths argument
    inputBinding:
      position: 101
      prefix: --discover
  - id: discover_some_qual_thresh
    type:
      - 'null'
      - float
    doc: Quality threshold for discovering a CNV in a sample
    default: 30.0
    inputBinding:
      position: 101
      prefix: --discoverSomeQualThresh
  - id: exclude_chromosome_targets
    type:
      - 'null'
      - string
    doc: Target chromosome(s) to exclude
    inputBinding:
      position: 101
      prefix: --excludeChromosomeTargets
  - id: exclude_samples
    type:
      - 'null'
      - string
    doc: File(s) of samples to exclude
    inputBinding:
      position: 101
      prefix: --excludeSamples
  - id: exclude_targets
    type:
      - 'null'
      - string
    doc: File(s) of targets to exclude
    inputBinding:
      position: 101
      prefix: --excludeTargets
  - id: from_id
    type:
      - 'null'
      - int
    doc: Column number of OLD sample IDs to map
    default: 1
    inputBinding:
      position: 101
      prefix: --fromID
  - id: gatk_depths
    type:
      - 'null'
      - string
    doc: GATK sample_interval_summary output file(s) to be merged [must have 
      *IDENTICAL* target lists]
    inputBinding:
      position: 101
      prefix: --GATKdepths
  - id: gatk_depths_list
    type:
      - 'null'
      - string
    doc: A file containing a list of GATK sample_interval_summary output files 
      to be merged [must have *IDENTICAL* target lists]
    inputBinding:
      position: 101
      prefix: --GATKdepthsList
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: Genotype list of CNVs from normalized read depth matrix. Matrix is read
      from --readDepths argument
    inputBinding:
      position: 101
      prefix: --genotype
  - id: genotype_qual_threshold_when_no_exact
    type:
      - 'null'
      - float
    doc: Quality threshold for calling a genotype, used *ONLY* when 'gxcnv' does
      not contain the 'Q_EXACT' field for the interval being genotyped
    default: 20.0
    inputBinding:
      position: 101
      prefix: --genotypeQualThresholdWhenNoExact
  - id: gxcnv
    type:
      - 'null'
      - string
    doc: xhmm CNV input file to genotype in 'readDepths' sample
    inputBinding:
      position: 101
      prefix: --gxcnv
  - id: keep_sample_ids
    type:
      - 'null'
      - string
    doc: File containing a list of samples to be analyzed
    inputBinding:
      position: 101
      prefix: --keepSampleIDs
  - id: log10
    type:
      - 'null'
      - float
    doc: After any filtering and optional scaling steps (but before any optional
      centering steps), convert the matrix to log10 values. To deal with 
      non-positive and small positive values, a truncation and then pseudocount 
      approach is taken. Specifically, denote the original matrix value as x and
      this parameter's pseudocount value as v (say, 0.5). The matrix value used 
      is then log10(max(x, 0) + v)
    inputBinding:
      position: 101
      prefix: --log10
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: Process (filter, center, etc.) a read depth matrix and output the 
      resulting matrix. Note that first all excluded samples and targets are 
      removed. And, sample statistics used for filtering are calculated only 
      *after* filtering out relevant targets.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_mean_sample_rd
    type:
      - 'null'
      - float
    doc: Maximum per-sample mean RD to require for sample to be processed
    inputBinding:
      position: 101
      prefix: --maxMeanSampleRD
  - id: max_mean_target_rd
    type:
      - 'null'
      - float
    doc: Maximum per-target mean RD to require for target to be processed
    inputBinding:
      position: 101
      prefix: --maxMeanTargetRD
  - id: max_normalized_read_depth_val
    type:
      - 'null'
      - float
    doc: Value at which to cap the absolute value of *normalized* input read 
      depth values ('readDepths')
    default: 10.0
    inputBinding:
      position: 101
      prefix: --maxNormalizedReadDepthVal
  - id: max_qual_score
    type:
      - 'null'
      - float
    doc: Value at which to cap the calculated quality scores
    default: 99.0
    inputBinding:
      position: 101
      prefix: --maxQualScore
  - id: max_sd_sample_rd
    type:
      - 'null'
      - float
    doc: Maximum per-sample standard deviation of RD to require for sample to be
      processed
    inputBinding:
      position: 101
      prefix: --maxSdSampleRD
  - id: max_sd_target_rd
    type:
      - 'null'
      - float
    doc: Maximum per-target standard deviation of RD to require for target to be
      processed
    inputBinding:
      position: 101
      prefix: --maxSdTargetRD
  - id: max_target_size
    type:
      - 'null'
      - int
    doc: Maximum size of target (in bp) to process
    inputBinding:
      position: 101
      prefix: --maxTargetSize
  - id: max_targets_in_subsegment
    type:
      - 'null'
      - int
    doc: When genotyping sub-segments of input intervals, only consider 
      sub-segments consisting of this number of targets or fewer
    default: 30
    inputBinding:
      position: 101
      prefix: --maxTargetsInSubsegment
  - id: merge_gatk_depths
    type:
      - 'null'
      - boolean
    doc: Merge the output from GATK into a single read depth matrix of samples 
      (rows) by targets (columns)
    inputBinding:
      position: 101
      prefix: --mergeGATKdepths
  - id: merge_vcf
    type:
      - 'null'
      - string
    doc: VCF file(s) to be merged [must have *IDENTICAL* genotyped intervals]
    inputBinding:
      position: 101
      prefix: --mergeVCF
  - id: merge_vcf_list
    type:
      - 'null'
      - string
    doc: A file containing a list of VCF files to be merged [must have 
      *IDENTICAL* genotyped intervals]
    inputBinding:
      position: 101
      prefix: --mergeVCFlist
  - id: merge_vcfs
    type:
      - 'null'
      - boolean
    doc: Merge VCF files output by multiple runs of the 'genotype' command on 
      the same input intervals (.xcnv file), but for different samples
    inputBinding:
      position: 101
      prefix: --mergeVCFs
  - id: merged_targets
    type:
      - 'null'
      - string
    doc: Output targets list
    default: '`-`'
    inputBinding:
      position: 101
      prefix: --mergedTargets
  - id: min_mean_sample_rd
    type:
      - 'null'
      - float
    doc: Minimum per-sample mean RD to require for sample to be processed
    inputBinding:
      position: 101
      prefix: --minMeanSampleRD
  - id: min_mean_target_rd
    type:
      - 'null'
      - float
    doc: Minimum per-target mean RD to require for target to be processed
    inputBinding:
      position: 101
      prefix: --minMeanTargetRD
  - id: min_sd_sample_rd
    type:
      - 'null'
      - float
    doc: Minimum per-sample standard deviation of RD to require for sample to be
      processed
    default: 0
    inputBinding:
      position: 101
      prefix: --minSdSampleRD
  - id: min_sd_target_rd
    type:
      - 'null'
      - float
    doc: Minimum per-target standard deviation of RD to require for target to be
      processed
    default: 0
    inputBinding:
      position: 101
      prefix: --minSdTargetRD
  - id: min_target_size
    type:
      - 'null'
      - int
    doc: Minimum size of target (in bp) to process
    default: 0
    inputBinding:
      position: 101
      prefix: --minTargetSize
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Apply PCA factors in order to normalize read depth matrix. Matrix is 
      read from --readDepths argument; normalization factors read from 
      --PCAfiles argument
    inputBinding:
      position: 101
      prefix: --normalize
  - id: num_pc_to_remove
    type:
      - 'null'
      - int
    doc: Number of highest principal components to filter out
    default: 20
    inputBinding:
      position: 101
      prefix: --numPCtoRemove
  - id: orig_read_depths
    type:
      - 'null'
      - string
    doc: Matrix of unnormalized read-depths to use for CNV annotation, where 
      rows (samples) and columns (targets) are labeled
    inputBinding:
      position: 101
      prefix: --origReadDepths
  - id: output_excluded_samples
    type:
      - 'null'
      - string
    doc: File in which to output samples excluded by some criterion
    inputBinding:
      position: 101
      prefix: --outputExcludedSamples
  - id: output_excluded_targets
    type:
      - 'null'
      - string
    doc: File in which to output targets excluded by some criterion
    inputBinding:
      position: 101
      prefix: --outputExcludedTargets
  - id: output_targets_by_samples
    type:
      - 'null'
      - boolean
    doc: Output targets x samples (instead of samples x targets)
    default: off
    inputBinding:
      position: 101
      prefix: --outputTargetsBySamples
  - id: param_file
    type:
      - 'null'
      - string
    doc: (Initial) model parameters file
    inputBinding:
      position: 101
      prefix: --paramFile
  - id: pc_normalize_method
    type:
      - 'null'
      - string
    doc: Method to choose which principal components are removed for data 
      normalization
    default: PVE_mean
    inputBinding:
      position: 101
      prefix: --PCnormalizeMethod
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Run PCA to create normalization factors for read depth matrix. Matrix 
      is read from --readDepths argument; normalization factors sent to 
      --PCAfiles argument
    inputBinding:
      position: 101
      prefix: --PCA
  - id: pca_files
    type:
      - 'null'
      - string
    doc: Base file name for 'PCA' *output*, and 'normalize' *input*
    inputBinding:
      position: 101
      prefix: --PCAfiles
  - id: pca_save_memory
    type:
      - 'null'
      - string
    doc: Should XHMM save memory by storing some of the intermediate PCA 
      matrices as temporary files on disk?
    default: "''"
    inputBinding:
      position: 101
      prefix: --PCA_saveMemory
  - id: posterior_files
    type:
      - 'null'
      - string
    doc: Base file name for posterior probabilities output files; if not given, 
      and --xcnv is not '-', this will default to --xcnv argument
    inputBinding:
      position: 101
      prefix: --posteriorFiles
  - id: prepare_targets
    type:
      - 'null'
      - boolean
    doc: Sort all target intervals, merge overlapping ones, and print the 
      resulting interval list
    inputBinding:
      position: 101
      prefix: --prepareTargets
  - id: print_hmm
    type:
      - 'null'
      - boolean
    doc: Print HMM model parameters and exit
    inputBinding:
      position: 101
      prefix: --printHMM
  - id: pve_contrib
    type:
      - 'null'
      - float
    doc: Remove the smallest number of principal components that explain this 
      percent of the variance (in the original PCA-ed data)
    default: 50.0
    inputBinding:
      position: 101
      prefix: --PVE_contrib
  - id: pve_mean_factor
    type:
      - 'null'
      - float
    doc: Remove all principal components that individually explain more variance
      than this factor times the average (in the original PCA-ed data)
    default: 0.7
    inputBinding:
      position: 101
      prefix: --PVE_mean_factor
  - id: rd_precision
    type:
      - 'null'
      - int
    doc: Decimal precision of read depths output
    default: 2
    inputBinding:
      position: 101
      prefix: --rdPrecision
  - id: read_depths
    type:
      - 'null'
      - string
    doc: Matrix of *input* read-depths, where rows (samples) and columns 
      (targets) are labeled
    default: '`-`'
    inputBinding:
      position: 101
      prefix: --readDepths
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA file (MUST have .fai index file)
    inputBinding:
      position: 101
      prefix: --referenceFASTA
  - id: sample_id_map
    type:
      - 'null'
      - string
    doc: File containing mappings of sample names to new sample names (in 
      columns designated by fromID, toID)
    inputBinding:
      position: 101
      prefix: --sampleIDmap
  - id: scale_data_by_sum
    type:
      - 'null'
      - boolean
    doc: After any filtering, scale read-depth matrix values by sample- or 
      target- sums (as per --scaleDataBySumType) [i.e., divide by row or column 
      sums], but multiply by factor specificied by --scaleDataBySumFactor
    default: off
    inputBinding:
      position: 101
      prefix: --scaleDataBySum
  - id: scale_data_by_sum_factor
    type:
      - 'null'
      - float
    doc: If --scaleDataBySum given, then divide by appropriate sum (but multiply
      by this factor)
    default: 1000000.0
    inputBinding:
      position: 101
      prefix: --scaleDataBySumFactor
  - id: scale_data_by_sum_type
    type:
      - 'null'
      - string
    doc: If --scaleDataBySum given, then scale the data within this dimension
    inputBinding:
      position: 101
      prefix: --scaleDataBySumType
  - id: score_precision
    type:
      - 'null'
      - int
    doc: Decimal precision of quality scores
    default: 0
    inputBinding:
      position: 101
      prefix: --scorePrecision
  - id: subsegments
    type:
      - 'null'
      - boolean
    doc: In addition to genotyping the intervals specified in gxcnv, genotype 
      all sub-segments of these intervals (with maxTargetsInSubsegment or fewer 
      targets)
    default: off
    inputBinding:
      position: 101
      prefix: --subsegments
  - id: targets
    type:
      - 'null'
      - string
    doc: Input targets lists
    inputBinding:
      position: 101
      prefix: --targets
  - id: to_id
    type:
      - 'null'
      - int
    doc: Column number of NEW sample IDs to map
    default: 2
    inputBinding:
      position: 101
      prefix: --toID
  - id: transition
    type:
      - 'null'
      - boolean
    doc: Print HMM transition matrix for user-requested genomic distances
    inputBinding:
      position: 101
      prefix: --transition
  - id: z_score_data
    type:
      - 'null'
      - boolean
    doc: If --centerData given, then additionally normalize by standard 
      deviation (outputting z-scores)
    default: off
    inputBinding:
      position: 101
      prefix: --zScoreData
outputs:
  - id: output_matrix
    type:
      - 'null'
      - File
    doc: Read-depth matrix output file
    outputBinding:
      glob: $(inputs.output_matrix)
  - id: normalize_output
    type:
      - 'null'
      - File
    doc: Normalized read-depth matrix output file
    outputBinding:
      glob: $(inputs.normalize_output)
  - id: xcnv
    type:
      - 'null'
      - File
    doc: CNV output file
    outputBinding:
      glob: $(inputs.xcnv)
  - id: vcf
    type:
      - 'null'
      - File
    doc: Genotyped CNV output VCF file
    outputBinding:
      glob: $(inputs.vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3
