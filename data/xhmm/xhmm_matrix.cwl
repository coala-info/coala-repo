cwlVersion: v1.2
class: CommandLineTool
baseCommand: [xhmm]
label: xhmm_matrix
doc: "Process (filter, center, etc.) a read depth matrix and output the resulting matrix. Note that first all excluded samples and targets are removed. And, sample statistics used for filtering are calculated only after filtering out relevant targets.\n\nTool homepage: http://atgu.mgh.harvard.edu/xhmm/index.shtml"
inputs:
  - id: read_depths
    type: File
    doc: "Matrix of input read-depths, where rows (samples) and columns (targets) are labeled"
    inputBinding:
      position: 10
      prefix: --readDepths
  - id: exclude_targets
    type: ['null', {type: array, items: File, inputBinding: {prefix: --excludeTargets}}]
    doc: "File(s) of targets to exclude"
    inputBinding:
      position: 10
  - id: exclude_chromosome_targets
    type: ['null', {type: array, items: string, inputBinding: {prefix: --excludeChromosomeTargets}}]
    doc: "Target chromosome(s) to exclude"
    inputBinding:
      position: 10
  - id: exclude_samples
    type: ['null', {type: array, items: File, inputBinding: {prefix: --excludeSamples}}]
    doc: "File(s) of samples to exclude"
    inputBinding:
      position: 10
  - id: min_target_size
    type: ['null', int]
    doc: "Minimum size of target (in bp) to process (default 0)"
    inputBinding:
      position: 10
      prefix: --minTargetSize
  - id: max_target_size
    type: ['null', int]
    doc: "Maximum size of target (in bp) to process"
    inputBinding:
      position: 10
      prefix: --maxTargetSize
  - id: min_mean_target_rd
    type: ['null', double]
    doc: "Minimum per-target mean RD to require for target to be processed"
    inputBinding:
      position: 10
      prefix: --minMeanTargetRD
  - id: max_mean_target_rd
    type: ['null', double]
    doc: "Maximum per-target mean RD to require for target to be processed"
    inputBinding:
      position: 10
      prefix: --maxMeanTargetRD
  - id: min_sd_target_rd
    type: ['null', double]
    doc: "Minimum per-target standard deviation of RD to require for target to be processed (default 0)"
    inputBinding:
      position: 10
      prefix: --minSdTargetRD
  - id: max_sd_target_rd
    type: ['null', double]
    doc: "Maximum per-target standard deviation of RD to require for target to be processed"
    inputBinding:
      position: 10
      prefix: --maxSdTargetRD
  - id: min_mean_sample_rd
    type: ['null', double]
    doc: "Minimum per-sample mean RD to require for sample to be processed"
    inputBinding:
      position: 10
      prefix: --minMeanSampleRD
  - id: max_mean_sample_rd
    type: ['null', double]
    doc: "Maximum per-sample mean RD to require for sample to be processed"
    inputBinding:
      position: 10
      prefix: --maxMeanSampleRD
  - id: min_sd_sample_rd
    type: ['null', double]
    doc: "Minimum per-sample standard deviation of RD to require for sample to be processed (default 0)"
    inputBinding:
      position: 10
      prefix: --minSdSampleRD
  - id: max_sd_sample_rd
    type: ['null', double]
    doc: "Maximum per-sample standard deviation of RD to require for sample to be processed"
    inputBinding:
      position: 10
      prefix: --maxSdSampleRD
  - id: scale_data_by_sum
    type: ['null', boolean]
    doc: "After any filtering, scale read-depth matrix values by sample- or target- sums (as per --scaleDataBySumType), but multiply by factor specified by --scaleDataBySumFactor"
    inputBinding:
      position: 10
      prefix: --scaleDataBySum
  - id: scale_data_by_sum_type
    type: ['null', string]
    doc: "If --scaleDataBySum given, then scale the data within this dimension: target or sample"
    inputBinding:
      position: 10
      prefix: --scaleDataBySumType
  - id: scale_data_by_sum_factor
    type: ['null', double]
    doc: "If --scaleDataBySum given, then divide by appropriate sum (but multiply by this factor) (default 1e6)"
    inputBinding:
      position: 10
      prefix: --scaleDataBySumFactor
  - id: log10
    type: ['null', double]
    doc: "After any filtering and optional scaling steps (but before any optional centering steps), convert the matrix to log10 values using this pseudocount"
    inputBinding:
      position: 10
      prefix: --log10
  - id: center_data
    type: ['null', boolean]
    doc: "Output sample- or target- centered read-depth matrix (as per --centerType)"
    inputBinding:
      position: 10
      prefix: --centerData
  - id: center_type
    type: ['null', string]
    doc: "If --centerData given, then center the data around this dimension: target or sample"
    inputBinding:
      position: 10
      prefix: --centerType
  - id: z_score_data
    type: ['null', boolean]
    doc: "If --centerData given, then additionally normalize by standard deviation (outputting z-scores)"
    inputBinding:
      position: 10
      prefix: --zScoreData
  - id: output_excluded_targets
    type: ['null', string]
    doc: "File in which to output targets excluded by some criterion"
    inputBinding:
      position: 10
      prefix: --outputExcludedTargets
  - id: output_excluded_samples
    type: ['null', string]
    doc: "File in which to output samples excluded by some criterion"
    inputBinding:
      position: 10
      prefix: --outputExcludedSamples
  - id: output_matrix
    type: string
    default: output_matrix.RD.txt
    doc: "Read-depth matrix output file"
    inputBinding:
      position: 10
      prefix: --outputMatrix
outputs:
  - id: output_matrix_file
    type: ['null', File]
    doc: "Processed read-depth matrix"
    outputBinding:
      glob: $(inputs.output_matrix)
  - id: excluded_targets_file
    type: ['null', File]
    doc: "Targets excluded by some criterion"
    outputBinding:
      glob: $(inputs.output_excluded_targets)
  - id: excluded_samples_file
    type: ['null', File]
    doc: "Samples excluded by some criterion"
    outputBinding:
      glob: $(inputs.output_excluded_samples)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: --matrix
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3
stdout: xhmm_matrix.out
