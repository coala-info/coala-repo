# shasta CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| shasta | PASS |  |

## shasta

### Tool Description
Shasta de novo assembler for long reads (Oxford Nanopore).

### Metadata
- **Docker Image**: quay.io/biocontainers/shasta:0.14.0--h9948957_0
- **Homepage**: https://github.com/chanzuckerberg/shasta
- **Package**: https://anaconda.org/channels/bioconda/packages/shasta/overview
- **Validation**: PASS

### Original Help Text
```text
Options allowed only on the command line:
  -h [ --help ]                         Write a help message.
  -v [ --version ]                      Identify the Shasta version.
  --config arg                          Configuration name. Can be the name of 
                                        a built-in configuration or the name of
                                        a configuration file.
  --input arg                           Names of input files containing reads. 
                                        Specify at least one.
  --anchors arg                         Names of input files containing anchors
                                        for mode 3 assembly.
  --assemblyDirectory arg (=ShastaRun)  Name of the output directory. If 
                                        command is assemble, this directory 
                                        must not exist.
  --command arg (=assemble)             Command to run. Must be one of: 
                                        assemble, saveBinaryData, 
                                        cleanupBinaryData, explore, 
                                        createBashCompletionScript
  --memoryMode arg (=anonymous)         Specify whether allocated memory is 
                                        anonymous or backed by a filesystem. 
                                        Allowed values: anonymous, filesystem.
  --memoryBacking arg (=4K)             Specify the type of pages used to back 
                                        memory.
                                        Allowed values: disk, 4K , 2M (for best
                                        performance). All combinations 
                                        (memoryMode, memoryBacking) are allowed
                                        except for (anonymous, disk).
                                        Some combinations require root 
                                        privilege, which is obtained using sudo
                                        and may result in a password prompting 
                                        depending on your sudo set up.
  --threads arg (=0)                    Number of threads, or 0 to use one 
                                        thread per virtual processor.
  --suppressStdoutLog                   Suppress echoing stdout to stdout.log.
  --exploreAccess arg (=user)           Specify allowed access for --command 
                                        explore. Allowed values: user, local, 
                                        unrestricted. DO NOT CHANGE FROM 
                                        DEFAULT VALUE WITHOUT UNDERSTANDING THE
                                        SECURITY IMPLICATIONS.
  --port arg (=17100)                   Port to be used by the http server 
                                        (command --explore).
  --alignmentsPafFile arg               The name of a PAF file containing 
                                        alignments of reads to a reference. 
                                        Only used for --command explore, for 
                                        display of the alignment candidate 
                                        graph. Experimental.
  --saveBinaryData                      Save binary data (Mode 3 assembly 
                                        only).

Options allowed on the command line and in the config file:
  --Reads.representation arg (=1)       Read representation: 0 = raw sequence, 
                                        1 (default) = Run-Length Encoded (RLE) 
                                        sequence. Experimental. Do not use.
  --Reads.minReadLength arg (=10000)    Read length cutoff. Shorter reads are 
                                        discarded.
  --Reads.desiredCoverage arg (=0)      Reduce coverage to desired value. If 
                                        not zero, specifies desired coverage 
                                        (number of bases). The read length 
                                        cutoff specified via 
                                        --Reads.minReadLength is increased to 
                                        reduce coverage to the specified value.
                                        Power of 10 multipliers can be used, 
                                        for example 120Gb to request 120 Gb of 
                                        coverage.
  --Reads.noCache                       If set, skip the Linux cache when 
                                        loading reads. This is done by 
                                        specifying the O_DIRECT flag when 
                                        opening input files containing reads.
  --Reads.handleDuplicates arg (=useOneCopy)
                                        Controls handling of reads with 
                                        duplicate names. Can be one of: 
                                        useAllCopies, useOneCopy, useNone, 
                                        forbid.
  --Reads.palindromicReads.skipFlagging 
                                        Skip flagging palindromic reads. Oxford
                                        Nanopore reads should be flagged for 
                                        better results.
  --Reads.palindromicReads.maxSkip arg (=100)
                                        Used for palindromic read detection.
  --Reads.palindromicReads.maxDrift arg (=100)
                                        Used for palindromic read detection.
  --Reads.palindromicReads.maxMarkerFrequency arg (=10)
                                        Used for palindromic read detection.
  --Reads.palindromicReads.alignedFractionThreshold arg (=0.1)
                                        Used for palindromic read detection.
  --Reads.palindromicReads.nearDiagonalFractionThreshold arg (=0.1)
                                        Used for palindromic read detection.
  --Reads.palindromicReads.deltaThreshold arg (=100)
                                        Used for palindromic read detection.
  --Kmers.generationMethod arg (=0)     Method to generate marker k-mers: 0 = 
                                        random, 1 = random, excluding globally 
                                        overenriched k-mers,2 = random, 
                                        excluding k-mers overenriched even in a
                                        single read,3 = read from file.4 = 
                                        random, excluding k-mers appearing in 
                                        two copies close to each other even in 
                                        a single read.
  --Kmers.k arg (=10)                   Length of marker k-mers (in run-length 
                                        space).
  --Kmers.probability arg (=0.1)        Fraction k-mers used as a marker.
  --Kmers.enrichmentThreshold arg (=100.)
                                        Enrichment threshold for 
                                        Kmers.generationMethod 1 and 2.
  --Kmers.distanceThreshold arg (=1000) Distance threshold, in RLE bases, for 
                                        Kmers.generationMethod 4
  --Kmers.file arg                      The absolute path of a file containing 
                                        the k-mers to be used as markers, one 
                                        per line. A relative path is not 
                                        accepted. Only used if 
                                        Kmers.generationMethod is 3.
  --Kmers.globalFrequencyOverrideDirectory arg
                                        The directory containing the hash table
                                        with marker k-mer global frequencies. 
                                        Only used for Shasta development.
  --MinHash.version arg (=0)            Controls the version of the LowHash 
                                        algorithm to use. Must be 0 (default).
  --MinHash.m arg (=4)                  The number of consecutive markers that 
                                        define a MinHash/LowHash feature.
  --MinHash.hashFraction arg (=0.01)    Defines how low a hash has to be to be 
                                        used with the LowHash algorithm.
  --MinHash.minHashIterationCount arg (=10)
                                        The number of MinHash/LowHash 
                                        iterations, or 0 to let 
                                        --MinHash.alignmentCandidatesPerRead 
                                        control the number of iterations.
  --MinHash.alignmentCandidatesPerRead arg (=20)
                                        If --MinHash.minHashIterationCount is 
                                        0, MinHash iteration is stopped when 
                                        the average number of alignment 
                                        candidates that each read is involved 
                                        in reaches this value. If 
                                        --MinHash.minHashIterationCount is not 
                                        0, this is not used.
  --MinHash.minBucketSize arg (=0)      The minimum bucket size to be used by 
                                        the LowHash algorithm. If minBucketSize
                                        and maxBucketSize are both 0, they are 
                                        adjusted automatically at each 
                                        iteration using simple heuristics.
  --MinHash.maxBucketSize arg (=10)     The maximum bucket size to be used by 
                                        the LowHash algorithm. If minBucketSize
                                        and maxBucketSize are both 0, they are 
                                        adjusted automatically at each 
                                        iteration using simple heuristics.
  --MinHash.minFrequency arg (=2)       The minimum number of times a pair of 
                                        reads must be found by the 
                                        MinHash/LowHash algorithm in order to 
                                        be considered a candidate alignment.
  --MinHash.allPairs                    Skip the MinHash algorithm and mark all
                                        pairs of reads as alignmentcandidates 
                                        with both orientation. This should only
                                        be used for experimentation on very 
                                        small runs because it is very time 
                                        consuming.
  --Align.alignMethod arg (=3)          The alignment method to be used to 
                                        create the read graph & the marker 
                                        graph. 0 = old Shasta method, 1 = SeqAn
                                        (slow), 3 = banded SeqAn, 4, 5, 6 = 
                                        experimental.
  --Align.maxSkip arg (=30)             The maximum number of markers that an 
                                        alignment is allowed to skip.
  --Align.maxDrift arg (=30)            The maximum amount of marker drift that
                                        an alignment is allowed to tolerate 
                                        between successive markers.
  --Align.maxTrim arg (=30)             The maximum number of unaligned markers
                                        tolerated at the beginning and end of 
                                        an alignment.
  --Align.maxMarkerFrequency arg (=10)  Marker frequency threshold. Markers 
                                        more frequent than this value in either
                                        of two oriented reads being aligned are
                                        discarded and not used to compute the 
                                        alignment.
  --Align.minAlignedMarkerCount arg (=100)
                                        The minimum number of aligned markers 
                                        for an alignment to be used.
  --Align.minAlignedFraction arg (=0)   The minimum fraction of aligned markers
                                        for an alignment to be used.
  --Align.matchScore arg (=6)           Match score for marker alignments (only
                                        used for alignment methods 1 and 3).
  --Align.mismatchScore arg (=-1)       Mismatch score for marker alignments 
                                        (only used for alignment methods 1 and 
                                        3).
  --Align.gapScore arg (=-1)            Gap score for marker alignments (only 
                                        used for alignment methods 1 and 3).
  --Align.downsamplingFactor arg (=0.10000000000000001)
                                        Downsampling factor (only used for 
                                        alignment method 3).
  --Align.bandExtend arg (=10)          Amount to extend the downsampled band 
                                        (only used for alignment method 3).
  --Align.maxBand arg (=1000)           Maximum alignment band (only used for 
                                        alignment method 3).
  --Align.sameChannelReadAlignment.suppressDeltaThreshold arg (=0)
                                        If not zero, alignments between reads 
                                        from the same nanopore channel and 
                                        close in time are suppressed. The 
                                        "read" meta data fields from the FASTA 
                                        or FASTQ header are checked. If their 
                                        difference, in absolute value, is less 
                                        than the value of this option, the 
                                        alignment is suppressed. This can help 
                                        avoid assembly artifact. This check is 
                                        only done if the two reads have 
                                        identical meta data fields "runid", 
                                        "sampleid", and "ch". If any of these 
                                        meta data fields are missing, this 
                                        check is suppressed and this option has
                                        no effect.
  --Align.suppressContainments          Suppress containment alignments, that 
                                        is alignments in which one read is 
                                        entirely contained in another read, 
                                        except possibly for up to maxTrim 
                                        markers at the beginning and end.
  --Align.align4.deltaX arg (=200)      Only used for alignment method 4 
                                        (experimental).
  --Align.align4.deltaY arg (=10)       Only used for alignment method 4 
                                        (experimental).
  --Align.align4.minEntryCountPerCell arg (=10)
                                        Only used for alignment method 4 
                                        (experimental).
  --Align.align4.maxDistanceFromBoundary arg (=100)
                                        Only used for alignment method 4 
                                        (experimental).
  --Align.align5.driftRateTolerance arg (=0.02)
                                        Maximum allowed drift rate for 
                                        alignment method 5.
  --Align.align5.minBandExtend arg (=10)
                                        Minimum band extension for alignment 
                                        method 5.
  --Align.align6.maxLocalFrequency arg (=100)
                                        Only used for alignment method 6.
  --Align.align6.minGlobalFrequency arg (=0)
                                        Only used for alignment method 6.
  --Align.align6.maxGlobalFrequency arg (=0)
                                        Only used for alignment method 6.
  --Align.align6.maxGlobalFrequencyMultiplier arg (=2)
                                        Only used for alignment method 6.
  --Align.align6.minLowFrequencyCount arg (=4)
                                        Only used for alignment method 6.
  --Align.align6.driftRateTolerance arg (=0.050000000000000003)
                                        Only used for alignment method 6.
  --Align.align6.maxInBandCount arg (=1000)
                                        Only used for alignment method 6.
  --Align.align6.maxInBandRatio arg (=100)
                                        Only used for alignment method 6.
  --ReadGraph.creationMethod arg (=0)   The method used to create the read 
                                        graph (0 default, 1 or 2 experimental).
  --ReadGraph.maxAlignmentCount arg (=6)
                                        The maximum number of alignments to be 
                                        kept for each read.
  --ReadGraph.preferAlignedFraction     Prefer alignments with a higher aligned
                                        fraction, rather than higher number of 
                                        aligned markers.
  --ReadGraph.maxChimericReadDistance arg (=2)
                                        Used for chimeric read detection. Set 
                                        to 0 to turn off chimera detection.
  --ReadGraph.strandSeparationMethod arg (=1)
                                        Strand separation method: 0 = no strand
                                        separation, 1 = limited strand 
                                        separation, 2 = strict strand 
                                        separation.
  --ReadGraph.crossStrandMaxDistance arg (=6)
                                        Maximum distance (edges) for strand 
                                        separation method 1.
  --ReadGraph.removeConflicts           Remove conflicts from the read graph. 
                                        Experimental - do not use.
  --ReadGraph.markerCountPercentile arg (=0.015)
                                        Percentile for --ReadGraph.markerCount 
                                        (only used when --ReadGraph.creationMet
                                        hod is 2).
  --ReadGraph.alignedFractionPercentile arg (=0.12)
                                        Percentile for adaptive selection of 
                                        --ReadGraph.alignedFraction (only used 
                                        when --ReadGraph.creationMethod is 2).
  --ReadGraph.maxSkipPercentile arg (=0.12)
                                        Percentile for adaptive selection of 
                                        --ReadGraph.maxSkip (only used when 
                                        --ReadGraph.creationMethod is 2).
  --ReadGraph.maxDriftPercentile arg (=0.12)
                                        Percentile for adaptive selection of 
                                        --ReadGraph.maxDrift (only used when 
                                        --ReadGraph.creationMethod is 2).
  --ReadGraph.maxTrimPercentile arg (=0.015)
                                        Percentile for adaptive selection of 
                                        --ReadGraph.maxTrim (only used when 
                                        --ReadGraph.creationMethod is 2).
  --ReadGraph.flagInconsistentAlignments 
                                        Flag inconsistent alignments. 
                                        Experimental.
  --ReadGraph.flagInconsistentAlignments.triangleErrorThreshold arg (=200)
                                        Triangle error threshold, in markers, 
                                        for flagging inconsistent alignments. 
                                        Only used if --ReadGraph.flagInconsiste
                                        ntAlignments is set. Experimental.
  --ReadGraph.flagInconsistentAlignments.leastSquareErrorThreshold arg (=200)
                                        Least square error threshold, in 
                                        markers, for flagging inconsistent 
                                        alignments. Only used if 
                                        --ReadGraph.flagInconsistentAlignments 
                                        is set. Experimental.
  --ReadGraph.flagInconsistentAlignments.leastSquareMaxDistance arg (=1)
                                        Least square max distance for flagging 
                                        inconsistent alignments. Only used if 
                                        --ReadGraph.flagInconsistentAlignments 
                                        is set. Experimental.
  --ReadGraph.epsilon arg (=1e-4)       Mismatch rate used for the Bayesian 
                                        ranking of alignments. (only used when 
                                        --ReadGraph.creationMethod is 4).
  --ReadGraph.delta arg (=5e-4)         Divergence rate δ (fraction of 
                                        discordant bases) used for the Bayesian
                                        ranking of alignments. (only used when 
                                        --ReadGraph.creationMethod is 4).
  --ReadGraph.WThreshold arg (=1e-8)    Logarithm of probability ratio used for
                                        the Bayesian ranking of alignments. 
                                        (only used when --ReadGraph.creationMet
                                        hod is 4).
  --ReadGraph.WThresholdForBreaks arg (=1e+15)
                                        Logarithm of probability ratio used for
                                        the Bayesian ranking of alignments to 
                                        detect breaks in the read graph. (only 
                                        used when --ReadGraph.creationMethod is
                                        4).
  --MarkerGraph.minCoverage arg (=10)   Minimum coverage (number of supporting 
                                        oriented reads) for a marker graph 
                                        vertex to be created.Specifying 0 
                                        causes a suitable value of this 
                                        parameter to be selected automatically.
  --MarkerGraph.maxCoverage arg (=100)  Maximum coverage (number of supporting 
                                        oriented reads) for a marker graph 
                                        vertex.
  --MarkerGraph.minCoveragePerStrand arg (=0)
                                        Minimum coverage (number of supporting 
                                        oriented reads) for each strand for a 
                                        marker graph vertex.
  --MarkerGraph.minEdgeCoverage arg (=6)
                                        Minimum edge coverage (number of 
                                        supporting oriented reads) for a marker
                                        graph edge to be created.Only used with
                                        --Assembly.mode 2.
  --MarkerGraph.minEdgeCoveragePerStrand arg (=2)
                                        Minimum edge coverage (number of 
                                        supporting oriented reads) on each 
                                        strand for a marker graph edge to be 
                                        created.Only used with --Assembly.mode 
                                        2.
  --MarkerGraph.allowDuplicateMarkers   Specifies whether to allow more than 
                                        one marker on the same oriented read on
                                        a single marker graph vertex. 
                                        Experimental.
  --MarkerGraph.cleanupDuplicateMarkers 
                                        Specifies whether to clean up marker 
                                        graph vertices with more than one 
                                        marker on the same oriented read. 
                                        Experimental.
  --MarkerGraph.duplicateMarkersPattern1Threshold arg (=0.5)
                                        Used when cleaning up marker graph 
                                        vertices with more than one marker on 
                                        the same oriented read. Experimental.
  --MarkerGraph.lowCoverageThreshold arg (=0)
                                        Used during approximate transitive 
                                        reduction. Marker graph edges with 
                                        coverage lower than this value are 
                                        always marked as removed regardless of 
                                        reachability.
  --MarkerGraph.highCoverageThreshold arg (=256)
                                        Used during approximate transitive 
                                        reduction. Marker graph edges with 
                                        coverage higher than this value are 
                                        never marked as removed regardless of 
                                        reachability.
  --MarkerGraph.maxDistance arg (=30)   Used during approximate transitive 
                                        reduction.
  --MarkerGraph.edgeMarkerSkipThreshold arg (=100)
                                        Used during approximate transitive 
                                        reduction.
  --MarkerGraph.pruneIterationCount arg (=6)
                                        Number of prune iterations.
  --MarkerGraph.simplifyMaxLength arg (=10,100,1000)
                                        Maximum lengths (in markers) used at 
                                        each iteration of simplifyMarkerGraph.
  --MarkerGraph.crossEdgeCoverageThreshold arg (=0)
                                        Experimental. Cross edge coverage 
                                        threshold. If this is not zero, 
                                        assembly graph cross-edges with average
                                        edge coverage less than this value are 
                                        removed, together with the 
                                        corresponding marker graph edges. A 
                                        cross edge is defined as an edge v0->v1
                                        with out-degree(v0)>1, in-degree(v1)>1.
  --MarkerGraph.peakFinder.minAreaFraction arg (=0.080000000000000002)
                                        Used in the automatic selection of 
                                        --MarkerGraph.minCoverage when 
                                        --MarkerGraph.minCoverage is set to 0.
  --MarkerGraph.peakFinder.areaStartIndex arg (=2)
                                        Used in the automatic selection of 
                                        --MarkerGraph.minCoverage when 
                                        --MarkerGraph.minCoverage is set to 0.
  --MarkerGraph.secondaryEdges.maxSkip arg (=1000000)
                                        Maximum number of markers skipped by a 
                                        secondary edge (mode 2 assembly only).
  --MarkerGraph.secondaryEdges.split.errorRateThreshold arg (=0.25)
                                        Error rate threshold used for splitting
                                        secondary edges (mode 2 assembly only).
  --MarkerGraph.secondaryEdges.split.minCoverage arg (=4)
                                        Minimum coverage for secondary edges 
                                        generated during splitting (mode 2 
                                        assembly only).
  --Assembly.mode arg (=0)              Assembly mode (0=default, 
                                        1=experimental).
  --Assembly.crossEdgeCoverageThreshold arg (=3)
                                        Maximum average edge coverage for a 
                                        cross edge of the assembly graph to be 
                                        removed.
  --Assembly.markerGraphEdgeLengthThresholdForConsensus arg (=1000)
                                        Controls assembly of long marker graph 
                                        edges.
  --Assembly.consensusCaller arg (=Modal)
                                        Selects the consensus caller for repeat
                                        counts. See the documentation for 
                                        available choices.
  --Assembly.storeCoverageData          Used to request storing coverage data 
                                        in binary format.
  --Assembly.storeCoverageDataCsvLengthThreshold arg (=0)
                                        Used to specify the minimum length of 
                                        an assembled segment for which coverage
                                        data in csv format should be stored. If
                                        0, no coverage data in csv format is 
                                        stored.
  --Assembly.writeReadsByAssembledSegment 
                                        Used to request writing the reads that 
                                        contributed to assembling each segment.
  --Assembly.pruneLength arg (=0)       Prune length (in markers) for pruning 
                                        of the assembly graph. Assembly graph 
                                        leaves shorter than this number of 
                                        markers are iteratively pruned. Set to 
                                        zero to suppress pruning of the 
                                        assembly graph. Assembly graph pruning 
                                        takes place separately and in addition 
                                        to marker graph pruning.
  --Assembly.detangleMethod arg (=0)    Specify the method used to detangle the
                                        assembly graph. 0 = no detangling, 1 = 
                                        strict detangling, 2 = less strict 
                                        detangling, controlled by 
                                        Assembly.detangle.* options.
  --Assembly.detangle.diagonalReadCountMin arg (=1)
                                        Minimum number of reads on detangle 
                                        matrix diagonal elements required for 
                                        detangling.
  --Assembly.detangle.offDiagonalReadCountMax arg (=2)
                                        Maximum number of reads on detangle 
                                        matrix off-diagonal elements allowed 
                                        for detangling.
  --Assembly.detangle.offDiagonalRatio arg (=0.29999999999999999)
                                        Maximum ratio of total off-diagonal 
                                        elements over diagonal element allowed 
                                        for detangling.
  --Assembly.iterative                  Used to request iterative assembly 
                                        (experimental).
  --Assembly.iterative.iterationCount arg (=3)
                                        Number of iterations for iterative 
                                        assembly (experimental).
  --Assembly.iterative.pseudoPathAlignMatchScore arg (=1)
                                        Pseudopath alignment match score for 
                                        iterative assembly (experimental).
  --Assembly.iterative.pseudoPathAlignMismatchScore arg (=-1)
                                        Pseudopath alignment mismatch score for
                                        iterative assembly (experimental).
  --Assembly.iterative.pseudoPathAlignGapScore arg (=-1)
                                        Pseudopath alignment gap score for 
                                        iterative assembly (experimental).
  --Assembly.iterative.mismatchSquareFactor arg (=3)
                                        Mismatch square factor for iterative 
                                        assembly (experimental).
  --Assembly.iterative.minScore arg (=0)
                                        Minimum pseudo-alignment score for 
                                        iterative assembly (experimental).
  --Assembly.iterative.maxAlignmentCount arg (=6)
                                        Maximum number of read graph neighbors 
                                        for iterative assembly (experimental).
  --Assembly.iterative.bridgeRemovalIterationCount arg (=3)
                                        Number of read graph bridge removal 
                                        iterations for iterative assembly 
                                        (experimental).
  --Assembly.iterative.bridgeRemovalMaxDistance arg (=2)
                                        Maximum distance for read graph bridge 
                                        removal for iterative assembly 
                                        (experimental).
  --Assembly.mode2.strongBranchThreshold arg (=2)
                                        Minimum number of supporting reads 
                                        required for a strong branch. Only used
                                        in Mode 2 assembly.
  --Assembly.mode2.epsilon arg (=0.10000000000000001)
                                        Epsilon for the Bayesian model used for
                                        phasing and for bubble removal.This is 
                                        the probability that a read appears on 
                                        the wrong branch of a diploid bubble. 
                                        Only used in Mode 2 assembly.
  --Assembly.mode2.bubbleRemoval.minConcordantReadCount arg (=3)
                                        Minimum number of concordant reads for 
                                        bubble removal. Only used in Mode 2 
                                        assembly.
  --Assembly.mode2.bubbleRemoval.maxDiscordantReadCount arg (=6)
                                        Maximum number of discordant reads for 
                                        bubble removal. Only used in Mode 2 
                                        assembly.
  --Assembly.mode2.bubbleRemoval.minLogP arg (=30)
                                        Minimul log(P) (in decibels) for bubble
                                        removal. Only used in Mode 2 assembly.
  --Assembly.mode2.bubbleRemoval.componentSizeThreshold arg (=10)
                                        Component size threshold for bubble 
                                        removal. Only used in Mode 2 assembly.
  --Assembly.mode2.phasing.minConcordantReadCount arg (=2)
                                        Minimum number of concordant reads for 
                                        phasing. Only used in Mode 2 assembly.
  --Assembly.mode2.phasing.maxDiscordantReadCount arg (=1)
                                        Maximum number of discordant reads for 
                                        phasing. Only used in Mode 2 assembly.
  --Assembly.mode2.phasing.minLogP arg (=10)
                                        Minimul log(P) (in decibels) for 
                                        phasing. Only used in Mode 2 assembly.
  --Assembly.mode2.superbubble.maxSize arg (=50)
                                        Maximum size (number of edges) of a 
                                        superbubble to be processed. Only used 
                                        in Mode 2 assembly.
  --Assembly.mode2.superbubble.maxChunkSize arg (=20)
                                        Maximum size (numbef of edges) of a 
                                        superbubble chunk to be processed. Only
                                        used in Mode 2 assembly.
  --Assembly.mode2.superbubble.maxChunkPathCount arg (=20)
                                        Maximum number of paths to be processed
                                        in a superbubble chunk. Only used in 
                                        Mode 2 assembly.
  --Assembly.mode2.superbubble.edgeLengthThreshold arg (=6)
                                        Edge length threshold (in markers) for 
                                        superbubble removal. Only used in Mode 
                                        2 assembly.
  --Assembly.mode2.suppressGfaOutput    Suppress all GFA output (Mode 2 
                                        assembly only).
  --Assembly.mode2.suppressFastaOutput  Suppress all FASTA output (Mode 2 
                                        assembly only).
  --Assembly.mode2.suppressDetailedOutput 
                                        Suppress output of detailed 
                                        representation of the assembly (Mode 2 
                                        assembly only).
  --Assembly.mode2.suppressPhasedOutput 
                                        Suppress output of phased 
                                        representation of the assembly (Mode 2 
                                        assembly only).
  --Assembly.mode2.suppressHaploidOutput 
                                        Suppress output of haploid 
                                        representation of the assembly (Mode 2 
                                        assembly only).
  --Assembly.mode3.anchorCreationMethod arg (=FromMarkerGraphEdges)
                                        Selects the method used to create 
                                        anchors for mode 3 assembly. Can be: 
                                        FromMarkerGraphEdges, FromMarkerKmers, 
                                        FromJson.
  --Assembly.mode3.minAnchorCoverage arg (=0)
                                        Minimum anchor coverage. If 
                                        minAnchorCoverage and maxAnchorCoverage
                                        are both 0, they are set automatically 
                                        to appropriate values using a simple 
                                        heuristic. Only used with 
                                        --Assembly.mode 3.
  --Assembly.mode3.maxAnchorCoverage arg (=0)
                                        Maximum anchor coverage. If 
                                        minAnchorCoverage and maxAnchorCoverage
                                        are both 0, they are set automatically 
                                        to appropriate values using a simple 
                                        heuristic.Only used with 
                                        --Assembly.mode 3.
  --Assembly.mode3.minAnchorCoverageMultiplier arg (=1)
                                        Multiplier applied to heuristically 
                                        determined minimum anchor coverage if 
                                        minAnchorCoverage and maxAnchorCoverage
                                        are both 0. Only used with 
                                        --Assembly.mode 3.
  --Assembly.mode3.maxAnchorCoverageMultiplier arg (=1)
                                        Multiplier applied to heuristically 
                                        determined maximum anchor coverage if 
                                        minAnchorCoverage and maxAnchorCoverage
                                        are both 0. Only used with 
                                        --Assembly.mode 3.
  --Assembly.mode3.primaryGraph.maxLoss arg (=0.10000000000000001)
                                        Use for weak edge removal in the 
                                        primary graph. (Mode 3 assembly only).
  --Assembly.mode3.anchorGraph.crossEdgesLowCoverageThreshold arg (=1)
                                        Low coverage threshold for cross edge 
                                        removal in the anchor graph. (Mode 3 
                                        assembly only).
  --Assembly.mode3.anchorGraph.crossEdgesHighCoverageThreshold arg (=3)
                                        High coverage threshold for cross edge 
                                        removal in the anchor graph. (Mode 3 
                                        assembly only).
  --Assembly.mode3.assemblyGraph.detangleToleranceLow arg (=0)
                                        Used for detangling of the assembly 
                                        graph (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.detangleToleranceHigh arg (=2)
                                        Used for detangling of the assembly 
                                        graph (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.epsilon arg (=0.10000000000000001)
                                        Epsilon value for the Bayesian model 
                                        used for detangling the assembly graph 
                                        (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.minLogP arg (=20)
                                        MinLogP value (in dB) for the Bayesian 
                                        model used for detangling the assembly 
                                        graph (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.longBubbleThreshold arg (=5000)
                                        Long bubble threshold (Mode 3 assembly 
                                        only).
  --Assembly.mode3.assemblyGraph.phaseErrorThreshold arg (=0.10000000000000001)
                                        Phase error threshold for phasing (Mode
                                        3 assembly only).
  --Assembly.mode3.assemblyGraph.bubbleErrorThreshold arg (=0.029999999999999999)
                                        Bubble error threshold for bubble 
                                        cleanup (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.bubbleCleanupMaxOffset arg (=1000)
                                        Maximum bubble offset for bubble 
                                        cleanup (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.chainTerminalCommonThreshold arg (=3)
                                        Used for bubble cleanup (Mode 3 
                                        assembly only).
  --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold1 arg (=30000)
                                        Length threshold used for superbubble 
                                        cleanup (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold2 arg (=10000)
                                        Low length threshold used for 
                                        superbubble removal (Mode 3 assembly 
                                        only).
  --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold3 arg (=30000)
                                        High length threshold used for 
                                        superbubble removal (Mode 3 assembly 
                                        only).
  --Assembly.mode3.assemblyGraph.superbubbleLengthThreshold4 arg (=30000)
                                        Length threshold used for superbubble 
                                        detangling (Mode 3 assembly only).
  --Assembly.mode3.assemblyGraph.pruneLength arg (=100000)
                                        Length threshold used for pruning of 
                                        the assembly graph.(Mode 3 assembly 
                                        only).
  --Assembly.mode3.localAssembly.estimatedOffsetRatio arg (=1.1000000000000001)
                                        For local assembly, the estimated 
                                        offset between edgeIdA and edgeIdB gets
                                        extended by this ratio to decide how 
                                        much to extend reads that only appear 
                                        in edgeIdA or edgeIdB. (Mode 3 assembly
                                        only).
  --Assembly.mode3.localAssembly.vertexSamplingRate arg (=0.80000000000000004)
                                        Vertex sampling rate for local 
                                        assembly, used to set 
                                        minVertexCoverage. Only used if 
                                        minVertexCoverage is 0 on input to 
                                        mode3::LocalAssembly constructor. (Mode
                                        3 assembly only).
  --Assembly.mode3.localAssembly.matchScore arg (=6)
                                        Match score for local assembly. (Mode 3
                                        assembly only).
  --Assembly.mode3.localAssembly.mismatchScore arg (=-1)
                                        Mismatch score for local assembly. 
                                        (Mode 3 assembly only).
  --Assembly.mode3.localAssembly.gapScore arg (=-1)
                                        Gap score for local assembly. (Mode 3 
                                        assembly only).
  --Assembly.mode3.localAssembly.maxSkipBases arg (=500)
                                        Number of bases (not markers) that can 
                                        be skipped by an alignment in local 
                                        assembly. (Mode 3 assembly only).
  --Assembly.mode3.localAssembly.maxDrift arg (=0.0050000000000000001)
                                        The maximum tolerated length drift of 
                                        each read. Used to compute the band for
                                        banded alignments in local assembly. 
                                        (Mode 3 assembly only).
  --Assembly.mode3.localAssembly.minHalfBand arg (=100)
                                        Minimum half band, in markers, for 
                                        local assembly. (Mode 3 assembly only).
  --Assembly.mode3.localAssembly.minScoreRatio arg (=0.69999999999999996)
                                        Score threshold for discarding 
                                        alignments in for local assembly. (Mode
                                        3 assembly only).
  --Assembly.mode3.localAssembly.maxMsaLength arg (=5000)
                                        Maximum length of a multiple sequence 
                                        alignment for local assembly. (Mode 3 
                                        assembly only).
```

