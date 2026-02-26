# bcbio-variation CWL Generation Report

## bcbio-variation

### Tool Description
The Genome Analysis Toolkit (GATK) v3.2-12-g034abb9

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-variation:0.2.6--2
- **Homepage**: https://github.com/chapmanb/bcbio.variation
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-variation/overview
- **Total Downloads**: 19.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chapmanb/bcbio.variation
- **Stars**: N/A
### Original Help Text
```text
---------------------------------------------------------------------------------
The Genome Analysis Toolkit (GATK) v3.2-12-g034abb9, Compiled 2014/07/16 15:53:02
Copyright (c) 2010 The Broad Institute
For support and documentation go to http://www.broadinstitute.org/gatk
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
usage: java -jar bcbio-variation-standalone.jar -T <analysis_type> [-args <arg_file>] [-I <input_file>] [-rbs 
       <read_buffer_size>] [-et <phone_home>] [-K <gatk_key>] [-tag <tag>] [-rf <read_filter>] [-L <intervals>] [-XL 
       <excludeIntervals>] [-isr <interval_set_rule>] [-im <interval_merging>] [-ip <interval_padding>] [-R 
       <reference_sequence>] [-ndrs] [-maxRuntime <maxRuntime>] [-maxRuntimeUnits <maxRuntimeUnits>] [-dt <downsampling_type>] 
       [-dfrac <downsample_to_fraction>] [-dcov <downsample_to_coverage>] [-baq <baq>] [-baqGOP <baqGapOpenPenalty>] [-fixNDN] 
       [-fixMisencodedQuals] [-allowPotentiallyMisencodedQuals] [-OQ] [-DBQ <defaultBaseQualities>] [-PF <performanceLog>] 
       [-BQSR <BQSR>] [-DIQ] [-EOQ] [-preserveQ <preserve_qscores_less_than>] [-globalQScorePrior <globalQScorePrior>] [-S 
       <validation_strictness>] [-rpr] [-kpr] [-sample_rename_mapping_file <sample_rename_mapping_file>] [-U <unsafe>] [-nt 
       <num_threads>] [-nct <num_cpu_threads_per_data_thread>] [-mte] [-bfh <num_bam_file_handles>] [-rgbl 
       <read_group_black_list>] [-ped <pedigree>] [-pedString <pedigreeString>] [-pedValidationType <pedigreeValidationType>] 
       [-variant_index_type <variant_index_type>] [-variant_index_parameter <variant_index_parameter>] [-l <logging_level>] 
       [-log <log_to_file>] [-h] [-version]

 -T,--analysis_type <analysis_type>                                                      Name of the tool to run
 -args,--arg_file <arg_file>                                                             Reads arguments from the 
                                                                                         specified file
 -I,--input_file <input_file>                                                            Input file containing sequence 
                                                                                         data (SAM or BAM)
 -rbs,--read_buffer_size <read_buffer_size>                                              Number of reads per SAM file to 
                                                                                         buffer in memory
 -et,--phone_home <phone_home>                                                           Run reporting mode (NO_ET|AWS|
                                                                                         STDOUT)
 -K,--gatk_key <gatk_key>                                                                GATK key file required to run 
                                                                                         with -et NO_ET
 -tag,--tag <tag>                                                                        Tag to identify this GATK run 
                                                                                         as part of a group of runs
 -rf,--read_filter <read_filter>                                                         Filters to apply to reads 
                                                                                         before analysis
 -L,--intervals <intervals>                                                              One or more genomic intervals 
                                                                                         over which to operate
 -XL,--excludeIntervals <excludeIntervals>                                               One or more genomic intervals 
                                                                                         to exclude from processing
 -isr,--interval_set_rule <interval_set_rule>                                            Set merging approach to use for 
                                                                                         combining interval inputs 
                                                                                         (UNION|INTERSECTION)
 -im,--interval_merging <interval_merging>                                               Interval merging rule for 
                                                                                         abutting intervals (ALL|
                                                                                         OVERLAPPING_ONLY)
 -ip,--interval_padding <interval_padding>                                               Amount of padding (in bp) to 
                                                                                         add to each interval
 -R,--reference_sequence <reference_sequence>                                            Reference sequence file
 -ndrs,--nonDeterministicRandomSeed                                                      Use a non-deterministic random 
                                                                                         seed
 -maxRuntime,--maxRuntime <maxRuntime>                                                   Stop execution cleanly as soon 
                                                                                         as maxRuntime has been reached
 -maxRuntimeUnits,--maxRuntimeUnits <maxRuntimeUnits>                                    Unit of time used by maxRuntime 
                                                                                         (NANOSECONDS|MICROSECONDS|
                                                                                         MILLISECONDS|SECONDS|MINUTES|
                                                                                         HOURS|DAYS)
 -dt,--downsampling_type <downsampling_type>                                             Type of read downsampling to 
                                                                                         employ at a given locus (NONE|
                                                                                         ALL_READS|BY_SAMPLE)
 -dfrac,--downsample_to_fraction <downsample_to_fraction>                                Fraction of reads to downsample 
                                                                                         to
 -dcov,--downsample_to_coverage <downsample_to_coverage>                                 Target coverage threshold for 
                                                                                         downsampling to coverage
 -baq,--baq <baq>                                                                        Type of BAQ calculation to 
                                                                                         apply in the engine (OFF|
                                                                                         CALCULATE_AS_NECESSARY|
                                                                                         RECALCULATE)
 -baqGOP,--baqGapOpenPenalty <baqGapOpenPenalty>                                         BAQ gap open penalty
 -fixNDN,--refactor_NDN_cigar_string                                                     refactor cigar string with NDN 
                                                                                         elements to one element
 -fixMisencodedQuals,--fix_misencoded_quality_scores                                     Fix mis-encoded base quality 
                                                                                         scores
 -allowPotentiallyMisencodedQuals,--allow_potentially_misencoded_quality_scores          Ignore warnings about base 
                                                                                         quality score encoding
 -OQ,--useOriginalQualities                                                              Use the base quality scores 
                                                                                         from the OQ tag
 -DBQ,--defaultBaseQualities <defaultBaseQualities>                                      Assign a default base quality
 -PF,--performanceLog <performanceLog>                                                   Write GATK runtime performance 
                                                                                         log to this file
 -BQSR,--BQSR <BQSR>                                                                     Input covariates table file for 
                                                                                         on-the-fly base quality score 
                                                                                         recalibration
 -DIQ,--disable_indel_quals                                                              Disable printing of base 
                                                                                         insertion and deletion tags 
                                                                                         (with -BQSR)
 -EOQ,--emit_original_quals                                                              Emit the OQ tag with the 
                                                                                         original base qualities (with 
                                                                                         -BQSR)
 -preserveQ,--preserve_qscores_less_than <preserve_qscores_less_than>                    Don't recalibrate bases with 
                                                                                         quality scores less than this 
                                                                                         threshold (with -BQSR)
 -globalQScorePrior,--globalQScorePrior <globalQScorePrior>                              Global Qscore Bayesian prior to 
                                                                                         use for BQSR
 -S,--validation_strictness <validation_strictness>                                      How strict should we be with 
                                                                                         validation (STRICT|LENIENT|
                                                                                         SILENT)
 -rpr,--remove_program_records                                                           Remove program records from the 
                                                                                         SAM header
 -kpr,--keep_program_records                                                             Keep program records in the SAM 
                                                                                         header
 -sample_rename_mapping_file,--sample_rename_mapping_file <sample_rename_mapping_file>   Rename sample IDs on-the-fly at 
                                                                                         runtime using the provided 
                                                                                         mapping file
 -U,--unsafe <unsafe>                                                                    Enable unsafe operations: 
                                                                                         nothing will be checked at 
                                                                                         runtime (ALLOW_N_CIGAR_READS|
                                                                                         ALLOW_UNINDEXED_BAM|
                                                                                         ALLOW_UNSET_BAM_SORT_ORDER|
                                                                                         NO_READ_ORDER_VERIFICATION|
                                                                                         ALLOW_SEQ_DICT_INCOMPATIBILITY|
                                                                                         LENIENT_VCF_PROCESSING|ALL)
 -nt,--num_threads <num_threads>                                                         Number of data threads to 
                                                                                         allocate to this analysis
 -nct,--num_cpu_threads_per_data_thread <num_cpu_threads_per_data_thread>                Number of CPU threads to 
                                                                                         allocate per data thread
 -mte,--monitorThreadEfficiency                                                          Enable threading efficiency 
                                                                                         monitoring
 -bfh,--num_bam_file_handles <num_bam_file_handles>                                      Total number of BAM file 
                                                                                         handles to keep open 
                                                                                         simultaneously
 -rgbl,--read_group_black_list <read_group_black_list>                                   Exclude read groups based on 
                                                                                         tags
 -ped,--pedigree <pedigree>                                                              Pedigree files for samples
 -pedString,--pedigreeString <pedigreeString>                                            Pedigree string for samples
 -pedValidationType,--pedigreeValidationType <pedigreeValidationType>                    Validation strictness for 
                                                                                         pedigree information (STRICT|
                                                                                         SILENT)
 -variant_index_type,--variant_index_type <variant_index_type>                           Type of IndexCreator to use for 
                                                                                         VCF/BCF indices (DYNAMIC_SEEK|
                                                                                         DYNAMIC_SIZE|LINEAR|INTERVAL)
 -variant_index_parameter,--variant_index_parameter <variant_index_parameter>            Parameter to pass to the 
                                                                                         VCF/BCF IndexCreator
 -l,--logging_level <logging_level>                                                      Set the minimum level of 
                                                                                         logging
 -log,--log_to_file <log_to_file>                                                        Set the logging location
 -h,--help                                                                               Generate the help message
 -version,--version                                                                      Output version information

 annotator                       
   VariantAnnotator              Annotates variant calls with context information.
                                 
 beagle                          
   BeagleOutputToVCF             Takes files produced by Beagle imputation engine and creates a vcf with modified 
                                 annotations.
   ProduceBeagleInput            Converts the input VCF into a format accepted by the Beagle imputation/analysis 
                                 program.
   VariantsToBeagleUnphased      Produces an input file to Beagle imputation engine, listing unphased, hard-called 
                                 genotypes for a single sample in input variant file.
                                 
 coverage                        
   CallableLoci                  Emits a data file containing information about callable, uncallable, poorly mapped, and 
                                 other parts of the genome <p/>
   CompareCallableLoci           Test routine for new VariantContext object
   DepthOfCoverage               Assess sequence coverage by a wide array of metrics, partitioned by sample, read group, 
                                 or library
   GCContentByInterval           Walks along reference and calculates the GC content for each interval.
                                 
 diagnostics                     
   CoveredByNSamplesSites        Print intervals file with all the variant sites for which most of the samples have good 
                                 coverage
   ErrorRatePerCycle             Compute the read error rate per position
   ReadGroupProperties           Emits a GATKReport containing read group, sample, library, platform, center, sequencing 
                                 data, paired end status, simple read type name (e.g.
   ReadLengthDistribution        Outputs the read lengths of all the reads in a file.
                                 
 diffengine                      
   DiffObjects                   A generic engine for comparing tree-structured objects
                                 
 examples                        
   GATKPaperGenotyper            A simple Bayesian genotyper, that outputs a text based call format.
                                 
 fasta                           
   FastaAlternateReferenceMaker  Generates an alternative reference sequence over the specified interval.
   FastaReferenceMaker           Renders a new reference in FASTA format consisting of only those loci provided in the 
                                 input data set.
   FastaStats                    Calculate basic statistics about the reference sequence itself
                                 
 filters                         
   VariantFiltration             Filters variant calls using a number of user-selectable, parameterizable criteria.
                                 
 qc                              
   CheckPileup                   Compare GATK's internal pileup to a reference Samtools pileup
   CountBases                    Walks over the input data set, calculating the number of bases seen for diagnostic 
                                 purposes.
   CountIntervals                Count contiguous regions in an interval list.
   CountLoci                     Walks over the input data set, calculating the total number of covered loci for 
                                 diagnostic purposes.
   CountMales                    Walks over the input data set, calculating the number of reads seen from male samples 
                                 for diagnostic purposes.
   CountReadEvents               Walks over the input data set, counting the number of read events (from the CIGAR 
                                 operator)
   CountReads                    Walks over the input data set, calculating the number of reads seen for diagnostic 
                                 purposes.
   CountRODs                     Prints out counts of the number of reference ordered data objects encountered.
   CountRODsByRef                Prints out counts of the number of reference ordered data objects encountered along the 
                                 reference.
   CountTerminusEvent            Walks over the input data set, counting the number of reads ending in 
                                 insertions/deletions or soft-clips
   ErrorThrowing                 A walker that simply throws errors.
   FlagStat                      A reimplementation of the 'samtools flagstat' subcommand in the GATK
   Pileup                        Emulates the samtools pileup command to print aligned reads
   PrintRODs                     Prints out all of the RODs in the input data set.
   QCRef                         Quality control for the reference fasta
   ReadClippingStats             Read clipping statistics for all reads.
                                 
 readutils                       
   ClipReads                     Read clipping based on quality, position or sequence matching
   PrintReads                    Renders, in SAM/BAM format, all reads from the input data set in the order in which 
                                 they appear in the input file.
   ReadAdaptorTrimmer            Utility tool to blindly strip base adaptors.
   SplitSamFile                  Divides the input data set into separate BAM files, one for each sample in the input 
                                 data set.
                                 
 varianteval                     
   VariantEval                   General-purpose tool for variant evaluation (% in dbSNP, genotype concordance, Ti/Tv 
                                 ratios, and a lot more)
                                 
 variantutils                    
   CombineVariants               Combines VCF records from different sources.
   FilterLiftedVariants          Filters a lifted-over VCF file for ref bases that have been changed.
   GenotypeConcordance           Genotype concordance (per-sample and aggregate counts and frequencies, NRD/NRS and site 
                                 allele overlaps) between two callsets
   LeftAlignAndTrimVariants      Left-aligns indels from a variants file.
   LiftoverVariants              Lifts a VCF file over from one build to another.
   RandomlySplitVariants         Takes a VCF file, randomly splits variants into two different sets, and outputs 2 new 
                                 VCFs with the results.
   SelectHeaders                 Selects headers from a VCF source.
   SelectVariants                Selects variants from a VCF source.
   ValidateVariants              Validates a VCF file with an extra strict set of criteria.
   VariantsToAllelicPrimitives   Takes alleles from a variants file and breaks them up (if possible) into more 
                                 basic/primitive alleles.
   VariantsToBinaryPed           Converts a VCF file to a binary plink Ped file (.bed/.bim/.fam)
   VariantsToTable               Emits specific fields from a VCF file to a tab-deliminated table
   VariantsToVCF                 Converts variants from other file formats to VCF format.
   VariantValidationAssessor     Annotates a validation (from Sequenom for example) VCF with QC metrics (HW-equilibrium, 
                                 % failed probes)
                                 
 vcfwalker                       
   VcfSimpleStatsWalker          
                                 
 walkers                         
   LeftAlignVariants
```

