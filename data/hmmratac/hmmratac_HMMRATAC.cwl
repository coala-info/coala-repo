cwlVersion: v1.2
class: CommandLineTool
baseCommand: HMMRATAC
label: hmmratac_HMMRATAC
doc: "Hidden Markov ModeleR for ATAC-seq (HMMRATAC): calls open chromatin peaks from an ATAC-seq BAM file\n\nTool homepage: https://github.com/LiuLabUB/HMMRATAC"
inputs:
  - id: java_memory
    type: string
    doc: Java maximum heap size passed to the wrapper script (the default of the wrapper is -Xmx1g, too small for genome-wide pileup)
    default: -Xmx6g
    inputBinding:
      position: 0
  - id: bam
    type: File
    doc: Sorted BAM file containing the ATAC-seq reads
    inputBinding:
      position: 1
      prefix: --bam
  - id: index
    type: File
    doc: Index file for the sorted BAM File
    inputBinding:
      position: 1
      prefix: --index
  - id: genome
    type: File
    doc: Two column, tab delimited file containing genome size stats
    inputBinding:
      position: 1
      prefix: --genome
  - id: means
    type:
      - 'null'
      - string
    doc: 'Comma separated list of initial mean values for the fragment distribution. Default = 50,200,400,600'
    inputBinding:
      position: 1
      prefix: '--means'
  - id: stddev
    type:
      - 'null'
      - string
    doc: 'Comma separated list of initial standard deviation values for fragment distribution. Default = 20,20,20,20'
    inputBinding:
      position: 1
      prefix: '--stddev'
  - id: fragem
    type:
      - 'null'
      - string
    doc: 'Whether to perform EM training on the fragment distribution (true or false). Default = True'
    inputBinding:
      position: 1
      prefix: '--fragem'
  - id: minmapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality of reads to keep. Default = 30'
    inputBinding:
      position: 1
      prefix: '--minmapq'
  - id: upper
    type:
      - 'null'
      - int
    doc: 'Upper limit on fold change range for choosing training sites. Default = 20'
    inputBinding:
      position: 1
      prefix: '--upper'
  - id: lower
    type:
      - 'null'
      - int
    doc: 'Lower limit on fold change range for choosing training sites. Default = 10'
    inputBinding:
      position: 1
      prefix: '--lower'
  - id: zscore
    type:
      - 'null'
      - int
    doc: 'Zscored read depth to mask during Viterbi decoding. Default = 100'
    inputBinding:
      position: 1
      prefix: '--zscore'
  - id: output
    type:
      - 'null'
      - string
    doc: 'Name for output files. Default = NA'
    inputBinding:
      position: 1
      prefix: '--output'
  - id: blacklist
    type:
      - 'null'
      - File
    doc: 'bed file of blacklisted regions to exclude'
    inputBinding:
      position: 1
      prefix: '--blacklist'
  - id: peaks
    type:
      - 'null'
      - string
    doc: 'Whether to report peaks in bed format (true or false). Default = true'
    inputBinding:
      position: 1
      prefix: '--peaks'
  - id: kmeans
    type:
      - 'null'
      - int
    doc: 'Number of States in the model. Default = 3. If not k=3, recommend NOT calling peaks, use bedgraph'
    inputBinding:
      position: 1
      prefix: '--kmeans'
  - id: training
    type:
      - 'null'
      - File
    doc: 'BED file of training regions to use for training model, instead of foldchange settings'
    inputBinding:
      position: 1
      prefix: '--training'
  - id: bedgraph
    type:
      - 'null'
      - string
    doc: 'Whether to report whole genome bedgraph of all state anntations (true or false). Default = false'
    inputBinding:
      position: 1
      prefix: '--bedgraph'
  - id: minlen
    type:
      - 'null'
      - int
    doc: 'Minimum length of open region to call peak. Note: --peaks must be set. Default = 200'
    inputBinding:
      position: 1
      prefix: '--minlen'
  - id: score
    type:
      - 'null'
      - string
    doc: 'What type of score system to use for peaks: max, ave, med, fc, zscore or all. Default = max'
    inputBinding:
      position: 1
      prefix: '--score'
  - id: bgscore
    type:
      - 'null'
      - string
    doc: 'Whether to add the HMMR score to each state annotation in bedgraph (true or false). Default = False'
    inputBinding:
      position: 1
      prefix: '--bgscore'
  - id: trim
    type:
      - 'null'
      - int
    doc: 'How many signals from the end to trim off. Default = 0'
    inputBinding:
      position: 1
      prefix: '--trim'
  - id: window
    type:
      - 'null'
      - int
    doc: 'Size of the bins to split the genome into for Viterbi decoding. Default = 25000000'
    inputBinding:
      position: 1
      prefix: '--window'
  - id: model
    type:
      - 'null'
      - File
    doc: 'Binary model file (generated from previous HMMR run) to use instead of creating new one'
    inputBinding:
      position: 1
      prefix: '--model'
  - id: modelonly
    type:
      - 'null'
      - string
    doc: 'Whether or not to stop the program after generating model (true or false). Default = false'
    inputBinding:
      position: 1
      prefix: '--modelonly'
  - id: maxTrain
    type:
      - 'null'
      - int
    doc: 'Maximum number of training regions to use. Default = 1000'
    inputBinding:
      position: 1
      prefix: '--maxTrain'
  - id: removeDuplicates
    type:
      - 'null'
      - string
    doc: 'Whether or not to remove duplicate reads from analysis (true or false). Default = true'
    inputBinding:
      position: 1
      prefix: '--removeDuplicates'
  - id: printExclude
    type:
      - 'null'
      - string
    doc: 'Whether to output excluded regions into Output_exclude.bed (true or false). Default = false'
    inputBinding:
      position: 1
      prefix: '--printExclude'
  - id: printTrain
    type:
      - 'null'
      - string
    doc: 'Whether to output training regions into Output_training.bed (true or false). Default = true'
    inputBinding:
      position: 1
      prefix: '--printTrain'
  - id: randomSeed
    type:
      - 'null'
      - long
    doc: 'Seed to set for random sampling of training regions. Default is 10151'
    inputBinding:
      position: 1
      prefix: '--randomSeed'
  - id: threshold
    type:
      - 'null'
      - double
    doc: 'threshold for reporting peaks. Only peaks whose score is >= this value will be reported'
    inputBinding:
      position: 1
      prefix: '--threshold'
outputs:
  - id: gapped_peaks
    type:
      - 'null'
      - File
    doc: Peaks in gappedPeak format
    outputBinding:
      glob: $(inputs.output || 'NA')_peaks.gappedPeak
  - id: summits
    type:
      - 'null'
      - File
    doc: Peak summits in BED format
    outputBinding:
      glob: $(inputs.output || 'NA')_summits.bed
  - id: model_out
    type:
      - 'null'
      - File
    doc: Binary HMM model file
    outputBinding:
      glob: $(inputs.output || 'NA').model
  - id: log
    type:
      - 'null'
      - File
    doc: Run log
    outputBinding:
      glob: $(inputs.output || 'NA').log
  - id: training_regions
    type:
      - 'null'
      - File
    doc: Training regions
    outputBinding:
      glob: $(inputs.output || 'NA')_training.bed
  - id: bedgraph_out
    type:
      - 'null'
      - File
    doc: Whole genome bedgraph of state annotations
    outputBinding:
      glob: $(inputs.output || 'NA').bedgraph
  - id: excluded_regions
    type:
      - 'null'
      - File
    doc: Excluded regions
    outputBinding:
      glob: $(inputs.output || 'NA')_exclude.bed
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 7000
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmratac:1.2.10--hdfd78af_1
