cwlVersion: v1.2
class: CommandLineTool
baseCommand: [shasta]
label: shasta
doc: "Shasta de novo assembler for long reads (Oxford Nanopore). Runs the assembly pipeline from reads to a FASTA and GFA assembly.\n\nTool homepage: https://github.com/chanzuckerberg/shasta"
inputs:
  - id: input
    type: File[]
    doc: "Names of input files containing reads. Specify at least one."
    inputBinding:
      position: 1
      prefix: --input
  - id: config
    type: ['null', string, File]
    doc: "Configuration name. Can be the name of a built-in configuration (string) or a configuration file (File)."
    inputBinding:
      position: 2
      prefix: --config
  - id: anchors
    type: ['null', 'File[]']
    doc: "Names of input files containing anchors for mode 3 assembly."
    inputBinding:
      position: 101
      prefix: --anchors
  - id: command
    type: ['null', string]
    doc: "Command to run. Must be one of: assemble, saveBinaryData, cleanupBinaryData, explore, createBashCompletionScript"
    inputBinding:
      position: 101
      prefix: --command
  - id: memoryMode
    type: ['null', string]
    doc: "Specify whether allocated memory is anonymous or backed by a filesystem. Allowed values: anonymous, filesystem."
    inputBinding:
      position: 101
      prefix: --memoryMode
  - id: memoryBacking
    type: ['null', string]
    doc: "Specify the type of pages used to back memory. Allowed values: disk, 4K, 2M."
    inputBinding:
      position: 101
      prefix: --memoryBacking
  - id: threads
    type: ['null', int]
    doc: "Number of threads, or 0 to use one thread per virtual processor."
    inputBinding:
      position: 101
      prefix: --threads
  - id: suppressStdoutLog
    type: ['null', boolean]
    doc: "Suppress echoing stdout to stdout.log."
    inputBinding:
      position: 101
      prefix: --suppressStdoutLog
  - id: saveBinaryData
    type: ['null', boolean]
    doc: "Save binary data (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --saveBinaryData
  - id: Kmers_file
    type: ['null', File]
    doc: "File containing the k-mers to be used as markers, one per line. Only used if Kmers.generationMethod is 3."
    inputBinding:
      position: 101
      prefix: --Kmers.file
  - id: alignmentsPafFile
    type: ['null', File]
    doc: "A PAF file containing alignments of reads to a reference. Only used for --command explore. Experimental."
    inputBinding:
      position: 101
      prefix: --alignmentsPafFile
  - id: Reads_representation
    type: ['null', int]
    doc: "Read representation: 0 = raw sequence, 1 (default) = Run-Length Encoded (RLE) sequence. Experimental. Do not use."
    inputBinding:
      position: 101
      prefix: --Reads.representation
  - id: Reads_minReadLength
    type: ['null', int]
    doc: "Read length cutoff. Shorter reads are discarded."
    inputBinding:
      position: 101
      prefix: --Reads.minReadLength
  - id: Reads_desiredCoverage
    type: ['null', int]
    doc: "Reduce coverage to desired value. If not zero, specifies desired coverage (number of bases). The read length cutoff specified via --Reads.minReadLength is increased to reduce coverage to the specified value. Power of 10 multipliers can be used, for example 120Gb to request 120 Gb of coverage."
    inputBinding:
      position: 101
      prefix: --Reads.desiredCoverage
  - id: Reads_noCache
    type: ['null', boolean]
    doc: "If set, skip the Linux cache when loading reads. This is done by specifying the O_DIRECT flag when opening input files containing reads."
    inputBinding:
      position: 101
      prefix: --Reads.noCache
  - id: Reads_handleDuplicates
    type: ['null', string]
    doc: " Controls handling of reads with duplicate names. Can be one of: useAllCopies, useOneCopy, useNone, forbid."
    inputBinding:
      position: 101
      prefix: --Reads.handleDuplicates
  - id: Reads_palindromicReads_skipFlagging
    type: ['null', boolean]
    doc: " Skip flagging palindromic reads. Oxford Nanopore reads should be flagged for better results."
    inputBinding:
      position: 101
      prefix: --Reads.palindromicReads.skipFlagging
  - id: Reads_palindromicReads_maxSkip
    type: ['null', int]
    doc: " Used for palindromic read detection."
    inputBinding:
      position: 101
      prefix: --Reads.palindromicReads.maxSkip
  - id: Reads_palindromicReads_maxDrift
    type: ['null', int]
    doc: " Used for palindromic read detection."
    inputBinding:
      position: 101
      prefix: --Reads.palindromicReads.maxDrift
  - id: Reads_palindromicReads_maxMarkerFrequency
    type: ['null', int]
    doc: " Used for palindromic read detection."
    inputBinding:
      position: 101
      prefix: --Reads.palindromicReads.maxMarkerFrequency
  - id: Reads_palindromicReads_alignedFractionThreshold
    type: ['null', float]
    doc: " Used for palindromic read detection."
    inputBinding:
      position: 101
      prefix: --Reads.palindromicReads.alignedFractionThreshold
  - id: Reads_palindromicReads_nearDiagonalFractionThreshold
    type: ['null', float]
    doc: " Used for palindromic read detection."
    inputBinding:
      position: 101
      prefix: --Reads.palindromicReads.nearDiagonalFractionThreshold
  - id: Reads_palindromicReads_deltaThreshold
    type: ['null', int]
    doc: " Used for palindromic read detection."
    inputBinding:
      position: 101
      prefix: --Reads.palindromicReads.deltaThreshold
  - id: Kmers_generationMethod
    type: ['null', int]
    doc: "Method to generate marker k-mers: 0 = random, 1 = random, excluding globally overenriched k-mers,2 = random, excluding k-mers overenriched even in a single read,3 = read from file.4 = random, excluding k-mers appearing in two copies close to each other even in a single read."
    inputBinding:
      position: 101
      prefix: --Kmers.generationMethod
  - id: Kmers_k
    type: ['null', int]
    doc: "Length of marker k-mers (in run-length space)."
    inputBinding:
      position: 101
      prefix: --Kmers.k
  - id: Kmers_probability
    type: ['null', float]
    doc: "Fraction k-mers used as a marker."
    inputBinding:
      position: 101
      prefix: --Kmers.probability
  - id: Kmers_enrichmentThreshold
    type: ['null', float]
    doc: " Enrichment threshold for Kmers.generationMethod 1 and 2."
    inputBinding:
      position: 101
      prefix: --Kmers.enrichmentThreshold
  - id: Kmers_distanceThreshold
    type: ['null', int]
    doc: "Distance threshold, in RLE bases, for Kmers.generationMethod 4"
    inputBinding:
      position: 101
      prefix: --Kmers.distanceThreshold
  - id: Kmers_globalFrequencyOverrideDirectory
    type: ['null', string]
    doc: " The directory containing the hash table with marker k-mer global frequencies. Only used for Shasta development."
    inputBinding:
      position: 101
      prefix: --Kmers.globalFrequencyOverrideDirectory
  - id: MinHash_version
    type: ['null', int]
    doc: "Controls the version of the LowHash algorithm to use. Must be 0 (default)."
    inputBinding:
      position: 101
      prefix: --MinHash.version
  - id: MinHash_m
    type: ['null', int]
    doc: "The number of consecutive markers that define a MinHash/LowHash feature."
    inputBinding:
      position: 101
      prefix: --MinHash.m
  - id: MinHash_hashFraction
    type: ['null', float]
    doc: "Defines how low a hash has to be to be used with the LowHash algorithm."
    inputBinding:
      position: 101
      prefix: --MinHash.hashFraction
  - id: MinHash_minHashIterationCount
    type: ['null', int]
    doc: " The number of MinHash/LowHash iterations, or 0 to let --MinHash.alignmentCandidatesPerRead control the number of iterations."
    inputBinding:
      position: 101
      prefix: --MinHash.minHashIterationCount
  - id: MinHash_alignmentCandidatesPerRead
    type: ['null', int]
    doc: " If --MinHash.minHashIterationCount is 0, MinHash iteration is stopped when the average number of alignment candidates that each read is involved in reaches this value. If --MinHash.minHashIterationCount is not 0, this is not used."
    inputBinding:
      position: 101
      prefix: --MinHash.alignmentCandidatesPerRead
  - id: MinHash_minBucketSize
    type: ['null', int]
    doc: "The minimum bucket size to be used by the LowHash algorithm. If minBucketSize and maxBucketSize are both 0, they are adjusted automatically at each iteration using simple heuristics."
    inputBinding:
      position: 101
      prefix: --MinHash.minBucketSize
  - id: MinHash_maxBucketSize
    type: ['null', int]
    doc: "The maximum bucket size to be used by the LowHash algorithm. If minBucketSize and maxBucketSize are both 0, they are adjusted automatically at each iteration using simple heuristics."
    inputBinding:
      position: 101
      prefix: --MinHash.maxBucketSize
  - id: MinHash_minFrequency
    type: ['null', int]
    doc: "The minimum number of times a pair of reads must be found by the MinHash/LowHash algorithm in order to be considered a candidate alignment."
    inputBinding:
      position: 101
      prefix: --MinHash.minFrequency
  - id: MinHash_allPairs
    type: ['null', boolean]
    doc: "Skip the MinHash algorithm and mark all pairs of reads as alignmentcandidates with both orientation. This should only be used for experimentation on very small runs because it is very time consuming."
    inputBinding:
      position: 101
      prefix: --MinHash.allPairs
  - id: Align_alignMethod
    type: ['null', int]
    doc: "The alignment method to be used to create the read graph & the marker graph. 0 = old Shasta method, 1 = SeqAn (slow), 3 = banded SeqAn, 4, 5, 6 = experimental."
    inputBinding:
      position: 101
      prefix: --Align.alignMethod
  - id: Align_maxSkip
    type: ['null', int]
    doc: "The maximum number of markers that an alignment is allowed to skip."
    inputBinding:
      position: 101
      prefix: --Align.maxSkip
  - id: Align_maxDrift
    type: ['null', int]
    doc: "The maximum amount of marker drift that an alignment is allowed to tolerate between successive markers."
    inputBinding:
      position: 101
      prefix: --Align.maxDrift
  - id: Align_maxTrim
    type: ['null', int]
    doc: "The maximum number of unaligned markers tolerated at the beginning and end of an alignment."
    inputBinding:
      position: 101
      prefix: --Align.maxTrim
  - id: Align_maxMarkerFrequency
    type: ['null', int]
    doc: "Marker frequency threshold. Markers more frequent than this value in either of two oriented reads being aligned are discarded and not used to compute the alignment."
    inputBinding:
      position: 101
      prefix: --Align.maxMarkerFrequency
  - id: Align_minAlignedMarkerCount
    type: ['null', int]
    doc: " The minimum number of aligned markers for an alignment to be used."
    inputBinding:
      position: 101
      prefix: --Align.minAlignedMarkerCount
  - id: Align_minAlignedFraction
    type: ['null', int]
    doc: "The minimum fraction of aligned markers for an alignment to be used."
    inputBinding:
      position: 101
      prefix: --Align.minAlignedFraction
  - id: Align_matchScore
    type: ['null', int]
    doc: "Match score for marker alignments (only used for alignment methods 1 and 3)."
    inputBinding:
      position: 101
      prefix: --Align.matchScore
  - id: Align_mismatchScore
    type: ['null', int]
    doc: "Mismatch score for marker alignments (only used for alignment methods 1 and 3)."
    inputBinding:
      position: 101
      prefix: --Align.mismatchScore
  - id: Align_gapScore
    type: ['null', int]
    doc: "Gap score for marker alignments (only used for alignment methods 1 and 3)."
    inputBinding:
      position: 101
      prefix: --Align.gapScore
  - id: Align_downsamplingFactor
    type: ['null', float]
    doc: " Downsampling factor (only used for alignment method 3)."
    inputBinding:
      position: 101
      prefix: --Align.downsamplingFactor
  - id: Align_bandExtend
    type: ['null', int]
    doc: "Amount to extend the downsampled band (only used for alignment method 3)."
    inputBinding:
      position: 101
      prefix: --Align.bandExtend
  - id: Align_maxBand
    type: ['null', int]
    doc: "Maximum alignment band (only used for alignment method 3)."
    inputBinding:
      position: 101
      prefix: --Align.maxBand
  - id: Align_sameChannelReadAlignment_suppressDeltaThreshold
    type: ['null', int]
    doc: " If not zero, alignments between reads from the same nanopore channel and close in time are suppressed. The \"read\" meta data fields from the FASTA or FASTQ header are checked. If their difference, in absolute value, is less than the value of this option, the alignment is suppressed. This can help avoid assembly artifact. This check is only done if the two reads have identical meta data fields \"runid\", \"sampleid\", and \"ch\". If any of these meta data fields are missing, this check is suppressed and this option has no effect."
    inputBinding:
      position: 101
      prefix: --Align.sameChannelReadAlignment.suppressDeltaThreshold
  - id: Align_suppressContainments
    type: ['null', boolean]
    doc: "Suppress containment alignments, that is alignments in which one read is entirely contained in another read, except possibly for up to maxTrim markers at the beginning and end."
    inputBinding:
      position: 101
      prefix: --Align.suppressContainments
  - id: Align_align4_deltaX
    type: ['null', int]
    doc: "Only used for alignment method 4 (experimental)."
    inputBinding:
      position: 101
      prefix: --Align.align4.deltaX
  - id: Align_align4_deltaY
    type: ['null', int]
    doc: "Only used for alignment method 4 (experimental)."
    inputBinding:
      position: 101
      prefix: --Align.align4.deltaY
  - id: Align_align4_minEntryCountPerCell
    type: ['null', int]
    doc: " Only used for alignment method 4 (experimental)."
    inputBinding:
      position: 101
      prefix: --Align.align4.minEntryCountPerCell
  - id: Align_align4_maxDistanceFromBoundary
    type: ['null', int]
    doc: " Only used for alignment method 4 (experimental)."
    inputBinding:
      position: 101
      prefix: --Align.align4.maxDistanceFromBoundary
  - id: Align_align5_driftRateTolerance
    type: ['null', float]
    doc: " Maximum allowed drift rate for alignment method 5."
    inputBinding:
      position: 101
      prefix: --Align.align5.driftRateTolerance
  - id: Align_align5_minBandExtend
    type: ['null', int]
    doc: " Minimum band extension for alignment method 5."
    inputBinding:
      position: 101
      prefix: --Align.align5.minBandExtend
  - id: Align_align6_maxLocalFrequency
    type: ['null', int]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.maxLocalFrequency
  - id: Align_align6_minGlobalFrequency
    type: ['null', int]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.minGlobalFrequency
  - id: Align_align6_maxGlobalFrequency
    type: ['null', int]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.maxGlobalFrequency
  - id: Align_align6_maxGlobalFrequencyMultiplier
    type: ['null', int]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.maxGlobalFrequencyMultiplier
  - id: Align_align6_minLowFrequencyCount
    type: ['null', int]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.minLowFrequencyCount
  - id: Align_align6_driftRateTolerance
    type: ['null', float]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.driftRateTolerance
  - id: Align_align6_maxInBandCount
    type: ['null', int]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.maxInBandCount
  - id: Align_align6_maxInBandRatio
    type: ['null', int]
    doc: " Only used for alignment method 6."
    inputBinding:
      position: 101
      prefix: --Align.align6.maxInBandRatio
  - id: ReadGraph_creationMethod
    type: ['null', int]
    doc: "The method used to create the read graph (0 default, 1 or 2 experimental)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.creationMethod
  - id: ReadGraph_maxAlignmentCount
    type: ['null', int]
    doc: " The maximum number of alignments to be kept for each read."
    inputBinding:
      position: 101
      prefix: --ReadGraph.maxAlignmentCount
  - id: ReadGraph_preferAlignedFraction
    type: ['null', boolean]
    doc: "Prefer alignments with a higher aligned fraction, rather than higher number of aligned markers."
    inputBinding:
      position: 101
      prefix: --ReadGraph.preferAlignedFraction
  - id: ReadGraph_maxChimericReadDistance
    type: ['null', int]
    doc: " Used for chimeric read detection. Set to 0 to turn off chimera detection."
    inputBinding:
      position: 101
      prefix: --ReadGraph.maxChimericReadDistance
  - id: ReadGraph_strandSeparationMethod
    type: ['null', int]
    doc: " Strand separation method: 0 = no strand separation, 1 = limited strand separation, 2 = strict strand separation."
    inputBinding:
      position: 101
      prefix: --ReadGraph.strandSeparationMethod
  - id: ReadGraph_crossStrandMaxDistance
    type: ['null', int]
    doc: " Maximum distance (edges) for strand separation method 1."
    inputBinding:
      position: 101
      prefix: --ReadGraph.crossStrandMaxDistance
  - id: ReadGraph_removeConflicts
    type: ['null', boolean]
    doc: "Remove conflicts from the read graph. Experimental - do not use."
    inputBinding:
      position: 101
      prefix: --ReadGraph.removeConflicts
  - id: ReadGraph_markerCountPercentile
    type: ['null', float]
    doc: " Percentile for --ReadGraph.markerCount (only used when --ReadGraph.creationMet hod is 2)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.markerCountPercentile
  - id: ReadGraph_alignedFractionPercentile
    type: ['null', float]
    doc: " Percentile for adaptive selection of --ReadGraph.alignedFraction (only used when --ReadGraph.creationMethod is 2)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.alignedFractionPercentile
  - id: ReadGraph_maxSkipPercentile
    type: ['null', float]
    doc: " Percentile for adaptive selection of --ReadGraph.maxSkip (only used when --ReadGraph.creationMethod is 2)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.maxSkipPercentile
  - id: ReadGraph_maxDriftPercentile
    type: ['null', float]
    doc: " Percentile for adaptive selection of --ReadGraph.maxDrift (only used when --ReadGraph.creationMethod is 2)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.maxDriftPercentile
  - id: ReadGraph_maxTrimPercentile
    type: ['null', float]
    doc: " Percentile for adaptive selection of --ReadGraph.maxTrim (only used when --ReadGraph.creationMethod is 2)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.maxTrimPercentile
  - id: ReadGraph_flagInconsistentAlignments
    type: ['null', boolean]
    doc: " Flag inconsistent alignments. Experimental."
    inputBinding:
      position: 101
      prefix: --ReadGraph.flagInconsistentAlignments
  - id: ReadGraph_flagInconsistentAlignments_triangleErrorThreshold
    type: ['null', int]
    doc: " Triangle error threshold, in markers, for flagging inconsistent alignments. Only used if --ReadGraph.flagInconsiste ntAlignments is set. Experimental."
    inputBinding:
      position: 101
      prefix: --ReadGraph.flagInconsistentAlignments.triangleErrorThreshold
  - id: ReadGraph_flagInconsistentAlignments_leastSquareErrorThreshold
    type: ['null', int]
    doc: " Least square error threshold, in markers, for flagging inconsistent alignments. Only used if --ReadGraph.flagInconsistentAlignments is set. Experimental."
    inputBinding:
      position: 101
      prefix: --ReadGraph.flagInconsistentAlignments.leastSquareErrorThreshold
  - id: ReadGraph_flagInconsistentAlignments_leastSquareMaxDistance
    type: ['null', int]
    doc: " Least square max distance for flagging inconsistent alignments. Only used if --ReadGraph.flagInconsistentAlignments is set. Experimental."
    inputBinding:
      position: 101
      prefix: --ReadGraph.flagInconsistentAlignments.leastSquareMaxDistance
  - id: ReadGraph_epsilon
    type: ['null', float]
    doc: "Mismatch rate used for the Bayesian ranking of alignments. (only used when --ReadGraph.creationMethod is 4)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.epsilon
  - id: ReadGraph_delta
    type: ['null', float]
    doc: "Divergence rate \u03b4 (fraction of discordant bases) used for the Bayesian ranking of alignments. (only used when --ReadGraph.creationMethod is 4)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.delta
  - id: ReadGraph_WThreshold
    type: ['null', float]
    doc: "Logarithm of probability ratio used for the Bayesian ranking of alignments. (only used when --ReadGraph.creationMet hod is 4)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.WThreshold
  - id: ReadGraph_WThresholdForBreaks
    type: ['null', float]
    doc: " Logarithm of probability ratio used for the Bayesian ranking of alignments to detect breaks in the read graph. (only used when --ReadGraph.creationMethod is 4)."
    inputBinding:
      position: 101
      prefix: --ReadGraph.WThresholdForBreaks
  - id: MarkerGraph_minCoverage
    type: ['null', int]
    doc: "Minimum coverage (number of supporting oriented reads) for a marker graph vertex to be created.Specifying 0 causes a suitable value of this parameter to be selected automatically."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.minCoverage
  - id: MarkerGraph_maxCoverage
    type: ['null', int]
    doc: "Maximum coverage (number of supporting oriented reads) for a marker graph vertex."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.maxCoverage
  - id: MarkerGraph_minCoveragePerStrand
    type: ['null', int]
    doc: " Minimum coverage (number of supporting oriented reads) for each strand for a marker graph vertex."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.minCoveragePerStrand
  - id: MarkerGraph_minEdgeCoverage
    type: ['null', int]
    doc: " Minimum edge coverage (number of supporting oriented reads) for a marker graph edge to be created.Only used with --Assembly.mode 2."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.minEdgeCoverage
  - id: MarkerGraph_minEdgeCoveragePerStrand
    type: ['null', int]
    doc: " Minimum edge coverage (number of supporting oriented reads) on each strand for a marker graph edge to be created.Only used with --Assembly.mode 2."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.minEdgeCoveragePerStrand
  - id: MarkerGraph_allowDuplicateMarkers
    type: ['null', boolean]
    doc: "Specifies whether to allow more than one marker on the same oriented read on a single marker graph vertex. Experimental."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.allowDuplicateMarkers
  - id: MarkerGraph_cleanupDuplicateMarkers
    type: ['null', boolean]
    doc: " Specifies whether to clean up marker graph vertices with more than one marker on the same oriented read. Experimental."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.cleanupDuplicateMarkers
  - id: MarkerGraph_duplicateMarkersPattern1Threshold
    type: ['null', float]
    doc: " Used when cleaning up marker graph vertices with more than one marker on the same oriented read. Experimental."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.duplicateMarkersPattern1Threshold
  - id: MarkerGraph_lowCoverageThreshold
    type: ['null', int]
    doc: " Used during approximate transitive reduction. Marker graph edges with coverage lower than this value are always marked as removed regardless of reachability."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.lowCoverageThreshold
  - id: MarkerGraph_highCoverageThreshold
    type: ['null', int]
    doc: " Used during approximate transitive reduction. Marker graph edges with coverage higher than this value are never marked as removed regardless of reachability."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.highCoverageThreshold
  - id: MarkerGraph_maxDistance
    type: ['null', int]
    doc: "Used during approximate transitive reduction."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.maxDistance
  - id: MarkerGraph_edgeMarkerSkipThreshold
    type: ['null', int]
    doc: " Used during approximate transitive reduction."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.edgeMarkerSkipThreshold
  - id: MarkerGraph_pruneIterationCount
    type: ['null', int]
    doc: " Number of prune iterations."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.pruneIterationCount
  - id: MarkerGraph_simplifyMaxLength
    type: ['null', string]
    doc: " Maximum lengths (in markers) used at each iteration of simplifyMarkerGraph."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.simplifyMaxLength
  - id: MarkerGraph_crossEdgeCoverageThreshold
    type: ['null', int]
    doc: " Experimental. Cross edge coverage threshold. If this is not zero, assembly graph cross-edges with average edge coverage less than this value are removed, together with the corresponding marker graph edges. A cross edge is defined as an edge v0->v1 with out-degree(v0)>1, in-degree(v1)>1."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.crossEdgeCoverageThreshold
  - id: MarkerGraph_peakFinder_minAreaFraction
    type: ['null', float]
    doc: " Used in the automatic selection of --MarkerGraph.minCoverage when --MarkerGraph.minCoverage is set to 0."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.peakFinder.minAreaFraction
  - id: MarkerGraph_peakFinder_areaStartIndex
    type: ['null', int]
    doc: " Used in the automatic selection of --MarkerGraph.minCoverage when --MarkerGraph.minCoverage is set to 0."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.peakFinder.areaStartIndex
  - id: MarkerGraph_secondaryEdges_maxSkip
    type: ['null', int]
    doc: " Maximum number of markers skipped by a secondary edge (mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.secondaryEdges.maxSkip
  - id: MarkerGraph_secondaryEdges_split_errorRateThreshold
    type: ['null', float]
    doc: " Error rate threshold used for splitting secondary edges (mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.secondaryEdges.split.errorRateThreshold
  - id: MarkerGraph_secondaryEdges_split_minCoverage
    type: ['null', int]
    doc: " Minimum coverage for secondary edges generated during splitting (mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --MarkerGraph.secondaryEdges.split.minCoverage
  - id: Assembly_mode
    type: ['null', int]
    doc: "Assembly mode (0=default, 1=experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode
  - id: Assembly_crossEdgeCoverageThreshold
    type: ['null', int]
    doc: " Maximum average edge coverage for a cross edge of the assembly graph to be removed."
    inputBinding:
      position: 101
      prefix: --Assembly.crossEdgeCoverageThreshold
  - id: Assembly_markerGraphEdgeLengthThresholdForConsensus
    type: ['null', int]
    doc: " Controls assembly of long marker graph edges."
    inputBinding:
      position: 101
      prefix: --Assembly.markerGraphEdgeLengthThresholdForConsensus
  - id: Assembly_consensusCaller
    type: ['null', string]
    doc: " Selects the consensus caller for repeat counts. See the documentation for available choices."
    inputBinding:
      position: 101
      prefix: --Assembly.consensusCaller
  - id: Assembly_storeCoverageData
    type: ['null', boolean]
    doc: "Used to request storing coverage data in binary format."
    inputBinding:
      position: 101
      prefix: --Assembly.storeCoverageData
  - id: Assembly_storeCoverageDataCsvLengthThreshold
    type: ['null', int]
    doc: " Used to specify the minimum length of an assembled segment for which coverage data in csv format should be stored. If 0, no coverage data in csv format is stored."
    inputBinding:
      position: 101
      prefix: --Assembly.storeCoverageDataCsvLengthThreshold
  - id: Assembly_writeReadsByAssembledSegment
    type: ['null', boolean]
    doc: " Used to request writing the reads that contributed to assembling each segment."
    inputBinding:
      position: 101
      prefix: --Assembly.writeReadsByAssembledSegment
  - id: Assembly_pruneLength
    type: ['null', int]
    doc: "Prune length (in markers) for pruning of the assembly graph. Assembly graph leaves shorter than this number of markers are iteratively pruned. Set to zero to suppress pruning of the assembly graph. Assembly graph pruning takes place separately and in addition to marker graph pruning."
    inputBinding:
      position: 101
      prefix: --Assembly.pruneLength
  - id: Assembly_detangleMethod
    type: ['null', int]
    doc: "Specify the method used to detangle the assembly graph. 0 = no detangling, 1 = strict detangling, 2 = less strict detangling, controlled by Assembly.detangle.* options."
    inputBinding:
      position: 101
      prefix: --Assembly.detangleMethod
  - id: Assembly_detangle_diagonalReadCountMin
    type: ['null', int]
    doc: " Minimum number of reads on detangle matrix diagonal elements required for detangling."
    inputBinding:
      position: 101
      prefix: --Assembly.detangle.diagonalReadCountMin
  - id: Assembly_detangle_offDiagonalReadCountMax
    type: ['null', int]
    doc: " Maximum number of reads on detangle matrix off-diagonal elements allowed for detangling."
    inputBinding:
      position: 101
      prefix: --Assembly.detangle.offDiagonalReadCountMax
  - id: Assembly_detangle_offDiagonalRatio
    type: ['null', float]
    doc: " Maximum ratio of total off-diagonal elements over diagonal element allowed for detangling."
    inputBinding:
      position: 101
      prefix: --Assembly.detangle.offDiagonalRatio
  - id: Assembly_iterative
    type: ['null', boolean]
    doc: "Used to request iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative
  - id: Assembly_iterative_iterationCount
    type: ['null', int]
    doc: " Number of iterations for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.iterationCount
  - id: Assembly_iterative_pseudoPathAlignMatchScore
    type: ['null', int]
    doc: " Pseudopath alignment match score for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.pseudoPathAlignMatchScore
  - id: Assembly_iterative_pseudoPathAlignMismatchScore
    type: ['null', int]
    doc: " Pseudopath alignment mismatch score for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.pseudoPathAlignMismatchScore
  - id: Assembly_iterative_pseudoPathAlignGapScore
    type: ['null', int]
    doc: " Pseudopath alignment gap score for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.pseudoPathAlignGapScore
  - id: Assembly_iterative_mismatchSquareFactor
    type: ['null', int]
    doc: " Mismatch square factor for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.mismatchSquareFactor
  - id: Assembly_iterative_minScore
    type: ['null', int]
    doc: " Minimum pseudo-alignment score for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.minScore
  - id: Assembly_iterative_maxAlignmentCount
    type: ['null', int]
    doc: " Maximum number of read graph neighbors for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.maxAlignmentCount
  - id: Assembly_iterative_bridgeRemovalIterationCount
    type: ['null', int]
    doc: " Number of read graph bridge removal iterations for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.bridgeRemovalIterationCount
  - id: Assembly_iterative_bridgeRemovalMaxDistance
    type: ['null', int]
    doc: " Maximum distance for read graph bridge removal for iterative assembly (experimental)."
    inputBinding:
      position: 101
      prefix: --Assembly.iterative.bridgeRemovalMaxDistance
  - id: Assembly_mode2_strongBranchThreshold
    type: ['null', int]
    doc: " Minimum number of supporting reads required for a strong branch. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.strongBranchThreshold
  - id: Assembly_mode2_epsilon
    type: ['null', float]
    doc: " Epsilon for the Bayesian model used for phasing and for bubble removal.This is the probability that a read appears on the wrong branch of a diploid bubble. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.epsilon
  - id: Assembly_mode2_bubbleRemoval_minConcordantReadCount
    type: ['null', int]
    doc: " Minimum number of concordant reads for bubble removal. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.bubbleRemoval.minConcordantReadCount
  - id: Assembly_mode2_bubbleRemoval_maxDiscordantReadCount
    type: ['null', int]
    doc: " Maximum number of discordant reads for bubble removal. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.bubbleRemoval.maxDiscordantReadCount
  - id: Assembly_mode2_bubbleRemoval_minLogP
    type: ['null', int]
    doc: " Minimul log(P) (in decibels) for bubble removal. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.bubbleRemoval.minLogP
  - id: Assembly_mode2_bubbleRemoval_componentSizeThreshold
    type: ['null', int]
    doc: " Component size threshold for bubble removal. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.bubbleRemoval.componentSizeThreshold
  - id: Assembly_mode2_phasing_minConcordantReadCount
    type: ['null', int]
    doc: " Minimum number of concordant reads for phasing. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.phasing.minConcordantReadCount
  - id: Assembly_mode2_phasing_maxDiscordantReadCount
    type: ['null', int]
    doc: " Maximum number of discordant reads for phasing. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.phasing.maxDiscordantReadCount
  - id: Assembly_mode2_phasing_minLogP
    type: ['null', int]
    doc: " Minimul log(P) (in decibels) for phasing. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.phasing.minLogP
  - id: Assembly_mode2_superbubble_maxSize
    type: ['null', int]
    doc: " Maximum size (number of edges) of a superbubble to be processed. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.superbubble.maxSize
  - id: Assembly_mode2_superbubble_maxChunkSize
    type: ['null', int]
    doc: " Maximum size (numbef of edges) of a superbubble chunk to be processed. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.superbubble.maxChunkSize
  - id: Assembly_mode2_superbubble_maxChunkPathCount
    type: ['null', int]
    doc: " Maximum number of paths to be processed in a superbubble chunk. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.superbubble.maxChunkPathCount
  - id: Assembly_mode2_superbubble_edgeLengthThreshold
    type: ['null', int]
    doc: " Edge length threshold (in markers) for superbubble removal. Only used in Mode 2 assembly."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.superbubble.edgeLengthThreshold
  - id: Assembly_mode2_suppressGfaOutput
    type: ['null', boolean]
    doc: "Suppress all GFA output (Mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.suppressGfaOutput
  - id: Assembly_mode2_suppressFastaOutput
    type: ['null', boolean]
    doc: "Suppress all FASTA output (Mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.suppressFastaOutput
  - id: Assembly_mode2_suppressDetailedOutput
    type: ['null', boolean]
    doc: " Suppress output of detailed representation of the assembly (Mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.suppressDetailedOutput
  - id: Assembly_mode2_suppressPhasedOutput
    type: ['null', boolean]
    doc: " Suppress output of phased representation of the assembly (Mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.suppressPhasedOutput
  - id: Assembly_mode2_suppressHaploidOutput
    type: ['null', boolean]
    doc: " Suppress output of haploid representation of the assembly (Mode 2 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode2.suppressHaploidOutput
  - id: Assembly_mode3_anchorCreationMethod
    type: ['null', string]
    doc: " Selects the method used to create anchors for mode 3 assembly. Can be: FromMarkerGraphEdges, FromMarkerKmers, FromJson."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.anchorCreationMethod
  - id: Assembly_mode3_minAnchorCoverage
    type: ['null', int]
    doc: " Minimum anchor coverage. If minAnchorCoverage and maxAnchorCoverage are both 0, they are set automatically to appropriate values using a simple heuristic. Only used with --Assembly.mode 3."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.minAnchorCoverage
  - id: Assembly_mode3_maxAnchorCoverage
    type: ['null', int]
    doc: " Maximum anchor coverage. If minAnchorCoverage and maxAnchorCoverage are both 0, they are set automatically to appropriate values using a simple heuristic.Only used with --Assembly.mode 3."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.maxAnchorCoverage
  - id: Assembly_mode3_minAnchorCoverageMultiplier
    type: ['null', int]
    doc: " Multiplier applied to heuristically determined minimum anchor coverage if minAnchorCoverage and maxAnchorCoverage are both 0. Only used with --Assembly.mode 3."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.minAnchorCoverageMultiplier
  - id: Assembly_mode3_maxAnchorCoverageMultiplier
    type: ['null', int]
    doc: " Multiplier applied to heuristically determined maximum anchor coverage if minAnchorCoverage and maxAnchorCoverage are both 0. Only used with --Assembly.mode 3."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.maxAnchorCoverageMultiplier
  - id: Assembly_mode3_primaryGraph_maxLoss
    type: ['null', float]
    doc: " Use for weak edge removal in the primary graph. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.primaryGraph.maxLoss
  - id: Assembly_mode3_anchorGraph_crossEdgesLowCoverageThreshold
    type: ['null', int]
    doc: " Low coverage threshold for cross edge removal in the anchor graph. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.anchorGraph.crossEdgesLowCoverageThreshold
  - id: Assembly_mode3_anchorGraph_crossEdgesHighCoverageThreshold
    type: ['null', int]
    doc: " High coverage threshold for cross edge removal in the anchor graph. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.anchorGraph.crossEdgesHighCoverageThreshold
  - id: Assembly_mode3_assemblyGraph_detangleToleranceLow
    type: ['null', int]
    doc: " Used for detangling of the assembly graph (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.detangleToleranceLow
  - id: Assembly_mode3_assemblyGraph_detangleToleranceHigh
    type: ['null', int]
    doc: " Used for detangling of the assembly graph (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.detangleToleranceHigh
  - id: Assembly_mode3_assemblyGraph_epsilon
    type: ['null', float]
    doc: " Epsilon value for the Bayesian model used for detangling the assembly graph (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.epsilon
  - id: Assembly_mode3_assemblyGraph_minLogP
    type: ['null', int]
    doc: " MinLogP value (in dB) for the Bayesian model used for detangling the assembly graph (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.minLogP
  - id: Assembly_mode3_assemblyGraph_longBubbleThreshold
    type: ['null', int]
    doc: " Long bubble threshold (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.longBubbleThreshold
  - id: Assembly_mode3_assemblyGraph_phaseErrorThreshold
    type: ['null', float]
    doc: " Phase error threshold for phasing (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.phaseErrorThreshold
  - id: Assembly_mode3_assemblyGraph_bubbleErrorThreshold
    type: ['null', float]
    doc: " Bubble error threshold for bubble cleanup (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.bubbleErrorThreshold
  - id: Assembly_mode3_assemblyGraph_bubbleCleanupMaxOffset
    type: ['null', int]
    doc: " Maximum bubble offset for bubble cleanup (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.bubbleCleanupMaxOffset
  - id: Assembly_mode3_assemblyGraph_chainTerminalCommonThreshold
    type: ['null', int]
    doc: " Used for bubble cleanup (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.chainTerminalCommonThreshold
  - id: Assembly_mode3_assemblyGraph_superbubbleLengthThreshold1
    type: ['null', int]
    doc: " Length threshold used for superbubble cleanup (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold1
  - id: Assembly_mode3_assemblyGraph_superbubbleLengthThreshold2
    type: ['null', int]
    doc: " Low length threshold used for superbubble removal (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold2
  - id: Assembly_mode3_assemblyGraph_superbubbleLengthThreshold3
    type: ['null', int]
    doc: " High length threshold used for superbubble removal (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold3
  - id: Assembly_mode3_assemblyGraph_superbubbleLengthThreshold4
    type: ['null', int]
    doc: " Length threshold used for superbubble detangling (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold4
  - id: Assembly_mode3_assemblyGraph_pruneLength
    type: ['null', int]
    doc: " Length threshold used for pruning of the assembly graph.(Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.assemblyGraph.pruneLength
  - id: Assembly_mode3_localAssembly_estimatedOffsetRatio
    type: ['null', float]
    doc: " For local assembly, the estimated offset between edgeIdA and edgeIdB gets extended by this ratio to decide how much to extend reads that only appear in edgeIdA or edgeIdB. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.estimatedOffsetRatio
  - id: Assembly_mode3_localAssembly_vertexSamplingRate
    type: ['null', float]
    doc: " Vertex sampling rate for local assembly, used to set minVertexCoverage. Only used if minVertexCoverage is 0 on input to mode3::LocalAssembly constructor. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.vertexSamplingRate
  - id: Assembly_mode3_localAssembly_matchScore
    type: ['null', int]
    doc: " Match score for local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.matchScore
  - id: Assembly_mode3_localAssembly_mismatchScore
    type: ['null', int]
    doc: " Mismatch score for local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.mismatchScore
  - id: Assembly_mode3_localAssembly_gapScore
    type: ['null', int]
    doc: " Gap score for local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.gapScore
  - id: Assembly_mode3_localAssembly_maxSkipBases
    type: ['null', int]
    doc: " Number of bases (not markers) that can be skipped by an alignment in local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.maxSkipBases
  - id: Assembly_mode3_localAssembly_maxDrift
    type: ['null', float]
    doc: " The maximum tolerated length drift of each read. Used to compute the band for banded alignments in local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.maxDrift
  - id: Assembly_mode3_localAssembly_minHalfBand
    type: ['null', int]
    doc: " Minimum half band, in markers, for local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.minHalfBand
  - id: Assembly_mode3_localAssembly_minScoreRatio
    type: ['null', float]
    doc: " Score threshold for discarding alignments in for local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.minScoreRatio
  - id: Assembly_mode3_localAssembly_maxMsaLength
    type: ['null', int]
    doc: " Maximum length of a multiple sequence alignment for local assembly. (Mode 3 assembly only)."
    inputBinding:
      position: 101
      prefix: --Assembly.mode3.localAssembly.maxMsaLength
  - id: assembly_directory
    type: string
    doc: "Name of the output directory. If command is assemble, this directory must not exist."
    inputBinding:
      position: 3
      prefix: --assemblyDirectory
outputs:
  - id: assembly
    type: Directory
    doc: Assembly output directory (Assembly.fasta, Assembly.gfa, ReadSummary.csv, shasta.conf, stdout.log)
    outputBinding:
      glob: $(inputs.assembly_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shasta:0.14.0--h9948957_0
