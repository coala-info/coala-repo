# gatk-framework CWL Generation Report

## gatk-framework

### Tool Description
The Genome Analysis Toolkit (GATK) v3.6-24-g59fd391

### Metadata
- **Docker Image**: quay.io/biocontainers/gatk-framework:3.6.24--4
- **Homepage**: https://gatk.broadinstitute.org/
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gatk-framework/overview
- **Total Downloads**: 27.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
---------------------------------------------------------------------------------
The Genome Analysis Toolkit (GATK) v3.6-24-g59fd391, Compiled 2016/06/06 17:53:29
Copyright (c) 2010-2016 The Broad Institute
For support and documentation go to https://www.broadinstitute.org/gatk
[Wed Feb 25 08:06:14 GMT 2026] Executing on Linux 6.8.0-100-generic amd64
OpenJDK 64-Bit Server VM 1.8.0_121-b15 JdkDeflater
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
usage: java -jar gatk-framework.jar -T <analysis_type> [-args <arg_file>] [-I <input_file>] [--showFullBamList] [-rbs 
       <read_buffer_size>] [-rf <read_filter>] [-drf <disable_read_filter>] [-L <intervals>] [-XL <excludeIntervals>] [-isr 
       <interval_set_rule>] [-im <interval_merging>] [-ip <interval_padding>] [-R <reference_sequence>] [-ndrs] [-maxRuntime 
       <maxRuntime>] [-maxRuntimeUnits <maxRuntimeUnits>] [-dt <downsampling_type>] [-dfrac <downsample_to_fraction>] [-dcov 
       <downsample_to_coverage>] [-baq <baq>] [-baqGOP <baqGapOpenPenalty>] [-fixNDN] [-fixMisencodedQuals] 
       [-allowPotentiallyMisencodedQuals] [-OQ] [-DBQ <defaultBaseQualities>] [-PF <performanceLog>] [-BQSR <BQSR>] [-qq 
       <quantize_quals>] [-SQQ <static_quantized_quals>] [-DIQ] [-EOQ] [-preserveQ <preserve_qscores_less_than>] 
       [-globalQScorePrior <globalQScorePrior>] [-S <validation_strictness>] [-rpr] [-kpr] [-sample_rename_mapping_file 
       <sample_rename_mapping_file>] [-U <unsafe>] [-disable_auto_index_creation_and_locking_when_reading_rods] [-sites_only] 
       [-writeFullFormat] [-compress <bam_compression>] [-simplifyBAM] [--disable_bam_indexing] [--generate_md5] [-nt 
       <num_threads>] [-nct <num_cpu_threads_per_data_thread>] [-mte] [-rgbl <read_group_black_list>] [-ped <pedigree>] 
       [-pedString <pedigreeString>] [-pedValidationType <pedigreeValidationType>] [-variant_index_type <variant_index_type>] 
       [-variant_index_parameter <variant_index_parameter>] [-ref_win_stop <reference_window_stop>] [-l <logging_level>] [-log 
       <log_to_file>] [-h] [-version]

 -T,--analysis_type <analysis_type>                                                       Name of the tool to run
 -args,--arg_file <arg_file>                                                              Reads arguments from the 
                                                                                          specified file
 -I,--input_file <input_file>                                                             Input file containing sequence 
                                                                                          data (BAM or CRAM)
 --showFullBamList                                                                        Emit list of input BAM/CRAM 
                                                                                          files to log
 -rbs,--read_buffer_size <read_buffer_size>                                               Number of reads per SAM file 
                                                                                          to buffer in memory
 -rf,--read_filter <read_filter>                                                          Filters to apply to reads 
                                                                                          before analysis
 -drf,--disable_read_filter <disable_read_filter>                                         Read filters to disable
 -L,--intervals <intervals>                                                               One or more genomic intervals 
                                                                                          over which to operate
 -XL,--excludeIntervals <excludeIntervals>                                                One or more genomic intervals 
                                                                                          to exclude from processing
 -isr,--interval_set_rule <interval_set_rule>                                             Set merging approach to use 
                                                                                          for combining interval inputs 
                                                                                          (UNION|INTERSECTION)
 -im,--interval_merging <interval_merging>                                                Interval merging rule for 
                                                                                          abutting intervals (ALL|
                                                                                          OVERLAPPING_ONLY)
 -ip,--interval_padding <interval_padding>                                                Amount of padding (in bp) to 
                                                                                          add to each interval
 -R,--reference_sequence <reference_sequence>                                             Reference sequence file
 -ndrs,--nonDeterministicRandomSeed                                                       Use a non-deterministic random 
                                                                                          seed
 -maxRuntime,--maxRuntime <maxRuntime>                                                    Stop execution cleanly as soon 
                                                                                          as maxRuntime has been reached
 -maxRuntimeUnits,--maxRuntimeUnits <maxRuntimeUnits>                                     Unit of time used by 
                                                                                          maxRuntime (NANOSECONDS|
                                                                                          MICROSECONDS|MILLISECONDS|
                                                                                          SECONDS|MINUTES|HOURS|DAYS)
 -dt,--downsampling_type <downsampling_type>                                              Type of read downsampling to 
                                                                                          employ at a given locus (NONE|
                                                                                          ALL_READS|BY_SAMPLE)
 -dfrac,--downsample_to_fraction <downsample_to_fraction>                                 Fraction of reads to 
                                                                                          downsample to
 -dcov,--downsample_to_coverage <downsample_to_coverage>                                  Target coverage threshold for 
                                                                                          downsampling to coverage
 -baq,--baq <baq>                                                                         Type of BAQ calculation to 
                                                                                          apply in the engine (OFF|
                                                                                          CALCULATE_AS_NECESSARY|
                                                                                          RECALCULATE)
 -baqGOP,--baqGapOpenPenalty <baqGapOpenPenalty>                                          BAQ gap open penalty
 -fixNDN,--refactor_NDN_cigar_string                                                      Reduce NDN elements in CIGAR 
                                                                                          string
 -fixMisencodedQuals,--fix_misencoded_quality_scores                                      Fix mis-encoded base quality 
                                                                                          scores
 -allowPotentiallyMisencodedQuals,--allow_potentially_misencoded_quality_scores           Ignore warnings about base 
                                                                                          quality score encoding
 -OQ,--useOriginalQualities                                                               Use the base quality scores 
                                                                                          from the OQ tag
 -DBQ,--defaultBaseQualities <defaultBaseQualities>                                       Assign a default base quality
 -PF,--performanceLog <performanceLog>                                                    Write GATK runtime performance 
                                                                                          log to this file
 -BQSR,--BQSR <BQSR>                                                                      Input covariates table file 
                                                                                          for on-the-fly base quality 
                                                                                          score recalibration
 -qq,--quantize_quals <quantize_quals>                                                    Quantize quality scores to a 
                                                                                          given number of levels (with 
                                                                                          -BQSR)
 -SQQ,--static_quantized_quals <static_quantized_quals>                                   Use static quantized quality 
                                                                                          scores to a given number of 
                                                                                          levels (with -BQSR)
 -DIQ,--disable_indel_quals                                                               Disable printing of base 
                                                                                          insertion and deletion tags 
                                                                                          (with -BQSR)
 -EOQ,--emit_original_quals                                                               Emit the OQ tag with the 
                                                                                          original base qualities (with 
                                                                                          -BQSR)
 -preserveQ,--preserve_qscores_less_than <preserve_qscores_less_than>                     Don't recalibrate bases with 
                                                                                          quality scores less than this 
                                                                                          threshold (with -BQSR)
 -globalQScorePrior,--globalQScorePrior <globalQScorePrior>                               Global Qscore Bayesian prior 
                                                                                          to use for BQSR
 -S,--validation_strictness <validation_strictness>                                       How strict should we be with 
                                                                                          validation (STRICT|LENIENT|
                                                                                          SILENT)
 -rpr,--remove_program_records                                                            Remove program records from 
                                                                                          the SAM header
 -kpr,--keep_program_records                                                              Keep program records in the 
                                                                                          SAM header
 -sample_rename_mapping_file,--sample_rename_mapping_file <sample_rename_mapping_file>    Rename sample IDs on-the-fly 
                                                                                          at runtime using the provided 
                                                                                          mapping file
 -U,--unsafe <unsafe>                                                                     Enable unsafe operations: 
                                                                                          nothing will be checked at 
                                                                                          runtime (ALLOW_N_CIGAR_READS|
                                                                                          ALLOW_UNINDEXED_BAM|
                                                                                          ALLOW_UNSET_BAM_SORT_ORDER|
                                                                                          NO_READ_ORDER_VERIFICATION|
                                                                                          ALLOW_SEQ_DICT_INCOMPATIBILITY|
                                                                                          LENIENT_VCF_PROCESSING|ALL)
d_locking_when_reading_rods,--disable_auto_index_creation_and_locking_when_reading_rods   Disable both auto-generation 
                                                                                          of index files and index file 
                                                                                          locking
 -sites_only,--sites_only                                                                 Output sites-only VCF
 -writeFullFormat,--never_trim_vcf_format_field                                           Always output all the records 
                                                                                          in VCF FORMAT fields, even if 
                                                                                          some are missing
 -compress,--bam_compression <bam_compression>                                            Compression level to use for 
                                                                                          writing BAM files (0 - 9, 
                                                                                          higher is more compressed)
 -simplifyBAM,--simplifyBAM                                                               Strip down read content and 
                                                                                          tags
 --disable_bam_indexing                                                                   Turn off on-the-fly creation 
                                                                                          of indices for output BAM/CRAM 
                                                                                          files
 --generate_md5                                                                           Enable on-the-fly creation of 
                                                                                          md5s for output BAM files.
 -nt,--num_threads <num_threads>                                                          Number of data threads to 
                                                                                          allocate to this analysis
 -nct,--num_cpu_threads_per_data_thread <num_cpu_threads_per_data_thread>                 Number of CPU threads to 
                                                                                          allocate per data thread
 -mte,--monitorThreadEfficiency                                                           Enable threading efficiency 
                                                                                          monitoring
 -rgbl,--read_group_black_list <read_group_black_list>                                    Exclude read groups based on 
                                                                                          tags
 -ped,--pedigree <pedigree>                                                               Pedigree files for samples
 -pedString,--pedigreeString <pedigreeString>                                             Pedigree string for samples
 -pedValidationType,--pedigreeValidationType <pedigreeValidationType>                     Validation strictness for 
                                                                                          pedigree (STRICT|SILENT)
 -variant_index_type,--variant_index_type <variant_index_type>                            Type of IndexCreator to use 
                                                                                          for VCF/BCF indices 
                                                                                          (DYNAMIC_SEEK|DYNAMIC_SIZE|
                                                                                          LINEAR|INTERVAL)
 -variant_index_parameter,--variant_index_parameter <variant_index_parameter>             Parameter to pass to the 
                                                                                          VCF/BCF IndexCreator
 -ref_win_stop,--reference_window_stop <reference_window_stop>                            Reference window stop
 -l,--logging_level <logging_level>                                                       Set the minimum level of 
                                                                                          logging
 -log,--log_to_file <log_to_file>                                                         Set the logging location
 -h,--help                                                                                Generate the help message
 -version,--version                                                                       Output version information

 annotator                       
   VariantAnnotator              Annotate variant calls with context information
                                 
 coverage                        
   CallableLoci                  Collect statistics on callable, uncallable, poorly mapped, and other parts of the 
                                 genome
   CompareCallableLoci           Compare callability statistics
   DepthOfCoverage               Assess sequence coverage by a wide array of metrics, partitioned by sample, read group, 
                                 or library
   GCContentByInterval           Calculates the GC content of the reference sequence for each interval
                                 
 dakl                            
   SomaticPindelFilter           Filters pindel output based on coverage and Fisher's exact test (BH corrected).
                                 
 diagnostics                     
   ErrorRatePerCycle             Compute the read error rate per position
   ReadGroupProperties           Collect statistics about read groups and their properties
   ReadLengthDistribution        Collect read length statistics
                                 
 diffengine                      
   DiffObjects                   A generic engine for comparing tree-structured objects
                                 
 examples                        
   GATKPaperGenotyper            Simple Bayesian genotyper used in the original GATK paper
                                 
 fasta                           
   FastaAlternateReferenceMaker  Generate an alternative reference sequence over the specified interval
   FastaReferenceMaker           Create a subset of a FASTA reference sequence
   FastaStats                    Calculate basic statistics about the reference sequence itself
                                 
 filters                         
   VariantFiltration             Filter variant calls based on INFO and FORMAT annotations
                                 
 indels                          
   IndelRealigner                Perform local realignment of reads around indels
   LeftAlignIndels               Left-align indels within reads in a bam file
   RealignerTargetCreator        Define intervals to target for local realignment
                                 
 qc                              
   CheckPileup                   Compare GATK's internal pileup to a reference Samtools pileup
   CountBases                    Count the number of bases in a set of reads
   CountIntervals                Count contiguous regions in an interval list
   CountLoci                     Count the total number of covered loci
   CountMales                    Count the number of reads seen from male samples
   CountReadEvents               Count the number of read events
   CountReads                    Count the number of reads
   CountRODs                     Count the number of ROD objects encountered
   CountRODsByRef                Count the number of ROD objects encountered along the reference
   CountTerminusEvent            Count the number of reads ending in insertions, deletions or soft-clips
   ErrorThrowing                 A walker that simply throws errors.
   FlagStat                      Collect statistics about sequence reads based on their SAM flags
   Pileup                        Print read alignments in Pileup-style format
   PrintRODs                     Print out all of the RODs in the input data set
   QCRef                         Quality control for the reference fasta
   ReadClippingStats             Collect read clipping statistics
                                 
 readutils                       
   ClipReads                     Read clipping based on quality, position or sequence matching
   PrintReads                    Write out sequence read data (for filtering, merging, subsetting etc)
   SplitSamFile                  Split a BAM file by sample
                                 
 rnaseq                          
   ASEReadCounter                Calculate read counts per allele for allele-specific expression analysis
                                 
 varianteval                     
   VariantEval                   General-purpose tool for variant evaluation (% in dbSNP, genotype concordance, Ti/Tv 
                                 ratios, and a lot more)
                                 
 variantutils                    
   CombineVariants               Combine variant records from different sources
   GenotypeConcordance           Genotype concordance between two callsets
   LeftAlignAndTrimVariants      Left-align indels in a variant callset
   RandomlySplitVariants         Randomly split variants into different sets
   SelectHeaders                 Selects headers from a VCF source
   SelectVariants                Select a subset of variants from a larger callset
   ValidateVariants              Validate a VCF file with an extra strict set of criteria
   VariantsToAllelicPrimitives   Simplify multi-nucleotide variants (MNPs) into more basic/primitive alleles.
   VariantsToBinaryPed           Convert VCF to binary pedigree file
   VariantsToTable               Extract specific fields from a VCF file to a tab-delimited table
   VariantsToVCF                 Convert variants from other file formats to VCF format
```

