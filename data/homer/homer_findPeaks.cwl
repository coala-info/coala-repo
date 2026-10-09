cwlVersion: v1.2
class: CommandLineTool
baseCommand: findPeaks
label: homer_findPeaks
doc: "Find peaks (enriched regions) in a HOMER tag directory\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: tag_directory
    type: Directory
    doc: 'Tag directory made by makeTagDirectory'
    inputBinding:
      position: 1
      valueFrom: $(inputs.tag_directory.basename)
  - id: o
    type:
      - 'null'
      - string
    doc: 'file name for the peaks (default: standard output); auto writes peaks.txt, regions.txt or transcripts.txt into the tag directory depending on -style'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: style
    type:
      - 'null'
      - string
    doc: 'analysis strategy: factor (default), atac, histone, groseq, tsr, dnase, super, superhistone, mC, damid or clip'
    inputBinding:
      position: 103
      prefix: '-style'
  - id: i
    type:
      - 'null'
      - Directory
    doc: 'input tag directory (experiment to use as IgG/Input/Control)'
    inputBinding:
      position: 103
      prefix: '-i'
  - id: size
    type:
      - 'null'
      - int
    doc: 'peak size (default: auto)'
    inputBinding:
      position: 103
      prefix: '-size'
  - id: minDist
    type:
      - 'null'
      - int
    doc: 'minimum distance between peaks (default: peak size x2)'
    inputBinding:
      position: 103
      prefix: '-minDist'
  - id: gsize
    type:
      - 'null'
      - float
    doc: 'effective mappable genome size (default: 2e9)'
    inputBinding:
      position: 103
      prefix: '-gsize'
  - id: fragLength
    type:
      - 'null'
      - string
    doc: 'approximate fragment length: a number or auto (default: auto; 150 for groseq)'
    inputBinding:
      position: 103
      prefix: '-fragLength'
  - id: inputFragLength
    type:
      - 'null'
      - string
    doc: 'approximate fragment length of the input tags: a number or auto (default: auto)'
    inputBinding:
      position: 103
      prefix: '-inputFragLength'
  - id: tbp
    type:
      - 'null'
      - int
    doc: 'maximum tags per bp to count, 0 = no limit (default: auto)'
    inputBinding:
      position: 103
      prefix: '-tbp'
  - id: inputtbp
    type:
      - 'null'
      - int
    doc: 'maximum tags per bp to count in the input, 0 = no limit (default: auto)'
    inputBinding:
      position: 103
      prefix: '-inputtbp'
  - id: strand
    type:
      - 'null'
      - string
    doc: 'find peaks using tags on both strands or separate: both or separate (default: both)'
    inputBinding:
      position: 103
      prefix: '-strand'
  - id: norm
    type:
      - 'null'
      - float
    doc: 'tag count to normalize to (default: 10000000)'
    inputBinding:
      position: 103
      prefix: '-norm'
  - id: region
    type:
      - 'null'
      - boolean
    doc: 'extend start/stop coordinates to cover the full region considered enriched'
    inputBinding:
      position: 103
      prefix: '-region'
  - id: regionRes
    type:
      - 'null'
      - int
    doc: 'number of fractions peaks are divided in when extending regions (default: 4)'
    inputBinding:
      position: 103
      prefix: '-regionRes'
  - id: center
    type:
      - 'null'
      - boolean
    doc: 'center peaks on the maximum tag overlap and calculate focus ratios'
    inputBinding:
      position: 103
      prefix: '-center'
  - id: nfr
    type:
      - 'null'
      - boolean
    doc: 'center peaks on the most likely nucleosome free region (works best with mnase data)'
    inputBinding:
      position: 103
      prefix: '-nfr'
  - id: F
    type:
      - 'null'
      - float
    doc: 'fold enrichment over input tag count (default: 4.0; 0 skips)'
    inputBinding:
      position: 103
      prefix: '-F'
  - id: P
    type:
      - 'null'
      - float
    doc: 'poisson p-value threshold relative to the input tag count (default: 0.0001)'
    inputBinding:
      position: 103
      prefix: '-P'
  - id: L
    type:
      - 'null'
      - float
    doc: 'fold enrichment over local tag count (default: 4.0; 0 skips)'
    inputBinding:
      position: 103
      prefix: '-L'
  - id: LP
    type:
      - 'null'
      - float
    doc: 'poisson p-value threshold relative to the local tag count (default: 0.0001)'
    inputBinding:
      position: 103
      prefix: '-LP'
  - id: C
    type:
      - 'null'
      - float
    doc: 'fold enrichment limit of expected unique tag positions (default: 2.0; 0 skips)'
    inputBinding:
      position: 103
      prefix: '-C'
  - id: localSize
    type:
      - 'null'
      - int
    doc: 'region to check for local tag enrichment (default: 10000)'
    inputBinding:
      position: 103
      prefix: '-localSize'
  - id: inputSize
    type:
      - 'null'
      - int
    doc: 'size of the region to search for control tags (default: 2x peak size)'
    inputBinding:
      position: 103
      prefix: '-inputSize'
  - id: fdr
    type:
      - 'null'
      - float
    doc: 'false discovery rate (default: 0.001)'
    inputBinding:
      position: 103
      prefix: '-fdr'
  - id: poisson
    type:
      - 'null'
      - float
    doc: 'set the poisson p-value cutoff (default: uses fdr)'
    inputBinding:
      position: 103
      prefix: '-poisson'
  - id: tagThreshold
    type:
      - 'null'
      - float
    doc: 'number of tags to define a peak (default: 25)'
    inputBinding:
      position: 103
      prefix: '-tagThreshold'
  - id: ntagThreshold
    type:
      - 'null'
      - float
    doc: 'number of normalized tags to define a peak (default: uses 1e7 for normalization)'
    inputBinding:
      position: 103
      prefix: '-ntagThreshold'
  - id: minTagThreshold
    type:
      - 'null'
      - float
    doc: 'absolute minimum tags per peak (default: expected tags per peak)'
    inputBinding:
      position: 103
      prefix: '-minTagThreshold'
  - id: superSlope
    type:
      - 'null'
      - float
    doc: 'super enhancers: slope threshold to identify super vs. typical enhancers (default: 1.00)'
    inputBinding:
      position: 103
      prefix: '-superSlope'
  - id: superWindow
    type:
      - 'null'
      - int
    doc: 'super enhancers: moving window/number of peaks used to calculate the slope (default: 10)'
    inputBinding:
      position: 103
      prefix: '-superWindow'
  - id: typical
    type:
      - 'null'
      - string
    doc: 'super enhancers: output typical enhancers to this file'
    inputBinding:
      position: 103
      prefix: '-typical'
  - id: inputPeaks
    type:
      - 'null'
      - File
    doc: 'super enhancers: initial peaks to use for super enhancer merging/scoring'
    inputBinding:
      position: 103
      prefix: '-inputPeaks'
  - id: excludePeaks
    type:
      - 'null'
      - File
    doc: 'super enhancers: regions to exclude from the analysis, i.e. TSS regions for H3K27ac'
    inputBinding:
      position: 103
      prefix: '-excludePeaks'
  - id: unmethylC
    type:
      - 'null'
      - boolean
    doc: 'methylC: find unmethylated regions (default)'
    inputBinding:
      position: 103
      prefix: '-unmethylC'
  - id: methylC
    type:
      - 'null'
      - boolean
    doc: 'methylC: find methylated regions'
    inputBinding:
      position: 103
      prefix: '-methylC'
  - id: mCthresh
    type:
      - 'null'
      - float
    doc: 'methylC: methylation threshold of regions (default: average methylation/2)'
    inputBinding:
      position: 103
      prefix: '-mCthresh'
  - id: minNumC
    type:
      - 'null'
      - int
    doc: 'methylC: minimum number of cytosines per methylation peak (default: 6)'
    inputBinding:
      position: 103
      prefix: '-minNumC'
  - id: tsrSize
    type:
      - 'null'
      - int
    doc: 'groseq: size of the region for initiation detection/artifact size (default: 250)'
    inputBinding:
      position: 103
      prefix: '-tsrSize'
  - id: minBodySize
    type:
      - 'null'
      - int
    doc: 'groseq: size of the region for transcript body detection (default: 1000)'
    inputBinding:
      position: 103
      prefix: '-minBodySize'
  - id: tsrFold
    type:
      - 'null'
      - float
    doc: 'groseq: fold enrichment for new initiation detection (default: 4.0)'
    inputBinding:
      position: 103
      prefix: '-tsrFold'
  - id: bodyFold
    type:
      - 'null'
      - float
    doc: 'groseq: fold enrichment for new transcript detection (default: 4.0)'
    inputBinding:
      position: 103
      prefix: '-bodyFold'
  - id: endFold
    type:
      - 'null'
      - float
    doc: 'groseq: end the transcript when levels are this much less than the start (default: 10.0)'
    inputBinding:
      position: 103
      prefix: '-endFold'
  - id: method
    type:
      - 'null'
      - string
    doc: 'groseq: method used for identifying new transcripts: fold or level (default: fold)'
    inputBinding:
      position: 103
      prefix: '-method'
  - id: uniqmap
    type:
      - 'null'
      - Directory
    doc: 'groseq: directory of binary files specifying uniquely mappable locations'
    inputBinding:
      position: 103
      prefix: '-uniqmap'
  - id: confPvalue
    type:
      - 'null'
      - float
    doc: 'groseq: confidence p-value (default: 1.00e-05)'
    inputBinding:
      position: 103
      prefix: '-confPvalue'
  - id: minReadDepth
    type:
      - 'null'
      - float
    doc: 'groseq: minimum initial read depth for transcripts (default: auto)'
    inputBinding:
      position: 103
      prefix: '-minReadDepth'
  - id: pseudoCount
    type:
      - 'null'
      - float
    doc: 'groseq: pseudo tag count (default: 2.0)'
    inputBinding:
      position: 103
      prefix: '-pseudoCount'
  - id: rev
    type:
      - 'null'
      - boolean
    doc: 'groseq: reverse the strand of the reads (for first-strand rna-seq/gro-seq)'
    inputBinding:
      position: 103
      prefix: '-rev'
  - id: gtf
    type:
      - 'null'
      - string
    doc: 'groseq: output de novo transcripts in GTF format to this file'
    inputBinding:
      position: 103
      prefix: '-gtf'
outputs:
  - id: peaks_stdout
    type: stdout
    doc: 'Peak list (standard output, empty when -o is used)'
  - id: peaks_file
    type:
      - 'null'
      - File
    doc: 'Peak file written with -o'
    outputBinding:
      glob: $(inputs.o)
  - id: auto_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Result files written into the tag directory with -o auto (peaks.txt, regions.txt, transcripts.txt, transcripts.gtf, tsr.txt, superEnhancers.txt)'
    outputBinding:
      glob: ["$(inputs.tag_directory.basename)/peaks.txt", "$(inputs.tag_directory.basename)/regions.txt", "$(inputs.tag_directory.basename)/transcripts.txt", "$(inputs.tag_directory.basename)/transcripts.gtf", "$(inputs.tag_directory.basename)/tsr.txt", "$(inputs.tag_directory.basename)/superEnhancers.txt"]
  - id: typical_file
    type:
      - 'null'
      - File
    doc: 'Typical enhancers (-typical)'
    outputBinding:
      glob: $(inputs.typical)
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: 'De novo transcripts in GTF format (-gtf)'
    outputBinding:
      glob: $(inputs.gtf)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.tag_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_findPeaks.out
