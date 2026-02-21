# pindel CWL Generation Report

## pindel

### Tool Description
Detection of indels and structural variations

### Metadata
- **Docker Image**: quay.io/biocontainers/pindel:0.2.5b9--h077b44d_12
- **Homepage**: http://gmt.genome.wustl.edu/packages/pindel/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pindel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pindel/overview
- **Total Downloads**: 68.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Initializing parameters...
Pindel version 0.2.5b9, 20160729.

Program:   pindel (detection of indels and structural variations)
Pindel version 0.2.5b9, 20160729.
Contact:   Kai Ye <kaiye@xjtu.edu.cn>

Usage:     pindel -f <reference.fa> -p <pindel_input>
           [and/or -i bam_configuration_file]
           -c <chromosome_name> -o <prefix_for_output_file>

Required parameters:
           -f/--fasta
           the reference genome sequences in fasta format 

           -p/--pindel-file
           the Pindel input file; either this, a pindel configuration file 
           (consisting of multiple pindel filenames) or a bam configuration file 
           is required 

           -i/--config-file
           the bam config file; either this, a pindel input file, or a pindel 
           config file is required. Per line: path and file name of bam, insert 
           size and sample tag.     For example: /data/tumour.bam  400  tumour 

           -o/--output-prefix
           Output prefix; 


Optional parameters:
           -P/--pindel-config-file
           the pindel config file, containing the names of all Pindel files that 
           need to be sampled; either this, a bam config file or a pindel input 
           file is required. Per line: path and file name of pindel input. 
           Example: /data/tumour.txt 

           -c/--chromosome
           Which chr/fragment. Pindel will process reads for one chromosome each 
           time. ChrName must be the same as in reference sequence and in read 
           file. '-c ALL' will make Pindel loop over all chromosomes. The search 
           for indels and SVs can also be limited to a specific region; -c 
           20:10,000,000 will only look for indels and SVs after position 
           10,000,000 = [10M, end], -c 20:5,000,000-15,000,000 will report 
           indels in the range between and including the bases at position 
           5,000,000 and 15,000,000 = [5M, 15M]. (default ALL) 

           -h/--help
           show the command line options of Pindel 

           -R/--RP
           search for discordant read-pair to improve sensitivity (default true) 

           -H/--min_distance_to_the_end
           the minimum number of bases required to match reference (default 8). 

           -T/--number_of_threads
           the number of threads Pindel will use (default 1). 

           -x/--max_range_index
           the maximum size of structural variations to be detected; the higher 
           this number, the greater the number of SVs reported, but the 
           computational cost and memory requirements increase, as does the rate 
           of false positives. 1=128, 2=512, 3=2,048, 4=8,092, 5=32,368, 
           6=129,472, 7=517,888, 8=2,071,552, 9=8,286,208. (maximum 9, default 
           2) 

           -w/--window_size
           for saving RAM, divides the reference in bins of X million bases and 
           only analyzes the reads that belong in the current bin, (default 5 
           (=5 million)) 

           -e/--sequencing_error_rate
           the expected fraction of sequencing errors (default 0.01) 

           -E/--sensitivity
           Pindel only reports reads if they can be fit around an event within a 
           certain number of mismatches. If the fraction of sequencing errors is 
           0.01, (so we'd expect a total error rate of 0.011 since on average 1 
           in 1000 bases is a SNP) and pindel calls a deletion, but there are 4 
           mismatched bases in the new fit of the pindel read (100 bases) to the 
           reference genome, Pindel would calculate that with an error rate of 
           0.01 (=0.011 including SNPs) the chance that there are 0, 1 or 2 
           mismatched bases in the reference genome is 90%. Setting -E to .90 
           (=90%) will thereforethrow away all reads with 3 or more mismatches, 
           even though that means that you throw away 1 in 10 valid reads. 
           Increasing this parameter to say 0.99 will increase the sensitivity 
           of pindel though you may get more false positives, decreasing the 
           parameter ensures you only get very good matches but pindel may not 
           find as many events. (default 0.95) 

           -u/--maximum_allowed_mismatch_rate
           Only reads with more than this fraction of mismatches than the 
           reference genome will be considered as harboring potential SVs. 
           (default 0.02) 

           -n/--NM
           the minimum number of edit distance between reads and reference 
           genome (default 2). reads at least NM edit distance (>= NM) will be 
           realigned 

           -r/--report_inversions
           report inversions (default true) 

           -t/--report_duplications
           report tandem duplications (default true) 

           -l/--report_long_insertions
           report insertions of which the full sequence cannot be deduced 
           because of their length (default false) 

           -k/--report_breakpoints
           report breakpoints (default false) 

           -s/--report_close_mapped_reads
           report reads of which only one end (the one closest to the mapped 
           read of the paired-end read) could be mapped. (default false) 

           -S/--report_only_close_mapped_reads
           do not search for SVs, only report reads of which only one end (the 
           one closest to the mapped read of the paired-end read) could be 
           mapped (the output file can then be used as an input file for another 
           run of pindel, which may save size if you need to transfer files). 
           (default false) 

           -I/--report_interchromosomal_events
           search for interchromosomal events. Note: will require the computer 
           to have at least 4 GB of memory (default false) 

           -C/--IndelCorrection
           search for consensus indels to corret contigs (default false) 

           -N/--NormalSamples
           Turn on germline filtering, less sensistive and you may miss somatic 
           calls (default false) 

           -b/--breakdancer
           Pindel is able to use calls from other SV methods such as BreakDancer 
           to further increase sensitivity and specificity.                    
           BreakDancer result or calls from any methods must in the format:   
           ChrA LocA stringA ChrB LocB stringB other 

           -j/--include
           If you want Pindel to process a set of regions, please provide a bed 
           file here: chr start end 

           -J/--exclude
           If you want Pindel to skip a set of regions, please provide a bed 
           file here: chr start end 

           -a/--additional_mismatch
           Pindel will only map part of a read to the reference genome if there 
           are no other candidate positions with no more than the specified 
           number of mismatches position. The bigger the value, the more 
           accurate but less sensitive. (minimum value 1, default value 1) 

           -m/--min_perfect_match_around_BP
           at the point where the read is split into two, there should at least 
           be this number of perfectly matching bases between read and reference 
           (default value 3) 

           -v/--min_inversion_size
           only report inversions greater than this number of bases (default 50) 

           -d/--min_num_matched_bases
           only consider reads as evidence if they map with more than X bases to 
           the reference. (default 30) 

           -B/--balance_cutoff
           the number of bases of a SV above which a more stringent filter is 
           applied which demands that both sides of the SV are mapped with 
           sufficiently long strings of bases (default 100) 

           -A/--anchor_quality
           the minimal mapping quality of the reads Pindel uses as anchor If you 
           only need high confident calls, set to 30 or higher(default 0) 

           -M/--minimum_support_for_event
           Pindel only calls events which have this number or more supporting 
           reads (default 1) 

           -z/--input_SV_Calls_for_assembly
           A filename of a list of SV calls for assembling breakpoints 
            Types: DEL, INS, DUP, INV, CTX and ITX 
            File format: Type chrA posA Confidence_Range_A chrB posB 
           Confidence_Range_B 
            Example: DEL chr1 10000 50 chr2 20000 100 

           -g/--genotyping
           gentype variants if -i is also used. 

           -Q/--output_of_breakdancer_events
           If breakdancer input is used, you can specify a filename here to 
           write the confirmed breakdancer events with their exact breakpoints 
           to The list of BreakDancer calls with Pindel support information. 
           Format: chr   Loc_left   Loc_right   size   type   index.             
           For example, "1	72766323 	72811840 	45516	D	11970" means the deletion 
           event chr1:72766323-72811840 of size 45516 is reported as an event 
           with index 11970 in Pindel report of deletion. 

           -L/--name_of_logfile
           Specifies a file to write Pindel's log to (default: no logfile, log 
           is written to the screen/stdout) 

           -Y/--Ploidy
           a file with Ploidy information per chr for genotype. per line: 
           ChrName Ploidy. For example, chr1 2 

           -q/--detect_DD
           Flag indicating whether to detect dispersed duplications. (default: 
           false) 

           /--MAX_DD_BREAKPOINT_DISTANCE
           Maximum distance between dispersed duplication breakpoints to assume 
           they refer to the same event. (default: 350) 

           /--MAX_DISTANCE_CLUSTER_READS
           Maximum distance between reads for them to provide evidence for a 
           single breakpoint for dispersed duplications. (default: 100) 

           /--MIN_DD_CLUSTER_SIZE
           Minimum number of reads needed for calling a breakpoint for dispersed 
           duplications. (default: 3) 

           /--MIN_DD_BREAKPOINT_SUPPORT
           Minimum number of split reads for calling an exact breakpoint for 
           dispersed duplications. (default: 3) 

           /--MIN_DD_MAP_DISTANCE
           Minimum mapping distance of read pairs for them to be considered 
           discordant. (default: 8000) 

           /--DD_REPORT_DUPLICATION_READS
           Report discordant sequences and positions for mates of reads mapping 
           inside dispersed duplications. (default: false)
```


## Metadata
- **Skill**: generated

## pindel_pindel2vcf

### Tool Description
conversion of Pindel output to VCF format

### Metadata
- **Docker Image**: quay.io/biocontainers/pindel:0.2.5b9--h077b44d_12
- **Homepage**: http://gmt.genome.wustl.edu/packages/pindel/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pindel/overview
- **Validation**: PASS
### Original Help Text
```text
Program:    pindel2vcf (conversion of Pindel output to VCF format)
Version:    0.6.3
Contact:    Eric-Wubbo Lameijer <e.m.w.lameijer@gmail.com>
Usage:      pindel2vcf -p <pindel_output_file> -r <reference_file>
              -R <name_and_version_of_reference_genome> -d <date_of_reference_genome_version>
              [-v <vcf_output_file>]

           the -v parameter is optional; when no output file name is given, output is written
           to a file with the name <pindel_output_file>.vcf.

Example:    pindel2vcf -p sample3chr20_D -r human_g1k_v36.fasta -R 1000GenomesPilot-NCBI36
              -d 20101123 -v sample3chr20_D.vcf

or (with -P): pindel2vcf -P sample3chr20 -r human_g1k_v36.fasta -R 1000GenomesPilot-NCBI36
              -d 20101123 -v sample3chr20_all.vcf

Note:      -is only guaranteed to work correctly on output files produced by pindel version 0.2.3 and above.
           -LI and BP files (long insertion and break point files) have a different type of header and
            are not supported yet.

-r/--reference  The name of the file containing the reference genome: required parameter
-R/--reference_name  The name and version of the reference genome: required parameter
-d/--reference_date  The date of the version of the reference genome used: required parameter
-p/--pindel_output  The name of the pindel output file containing the SVs
-P/--pindel_output_root  The root-name of the pindel output file; this will result in
one big output file containing deletions, short and long insertions, tandem duplications and inversions.
For example, if the pindel output files are called sample1_D, sample1_SI, sample1_TD etc. then -P sample1 would combine the
information in all those sample files into one big vcf file.
-v/--vcf  The name of the output vcf-file (default: name of pindel output file +".vcf"
-c/--chromosome  The name of the chromosome (default: SVs on all chromosomes are processed)
-w/--window_size  Memory saving option: the size of the genomic region in a chromosome of which structural variants are calculated separately, in millions of bases (default 300, for memory saving 100 or 50 recommended)
-mc/--min_coverage  The minimum number of reads to provide a genotype (default 10)
-he/--het_cutoff  The propertion of reads to call het (default 0.2)
-ho/--hom_cutoff  The propertion of reads to call het (default 0.8)
-is/--min_size  The minimum size of events to be reported (default 1)
-as/--max_size  The maximum size of events to be reported (default infinite)
-b/--both_strands_supported  Only report events that are detected on both strands (default false)
-m/--min_supporting_samples  The minimum number of samples an event needs to occur in with sufficient support to be reported (default 0)
-e/--min_supporting_reads  The minimum number of supporting reads required for an event to be reported (default 1)
-f/--max_supporting_reads  The maximum number of supporting reads allowed for an event to be reported, allows protection against miscalls in due to segmental duplications or poorly mapped regions (default infinite)
-sr/--region_start  The start of the region of which events are to be reported (default 0)
-er/--region_end  The end of the region of which events are to be reported (default infinite)
-ir/--max_internal_repeats  Filters out all indels where the inserted/deleted sequence is a homopolymer/microsatellite of more than X repetitions (default infinite). For example: T->TCACACA has CACACA as insertion, which is a microsattelite of 3 repeats; this would be filtered out by setting -ir to 2
-co/--compact_output_limit  Puts all structural variations of which either the ref allele or the alt allele exceeds the specified size (say 10 in '-co 10') in the format 'chrom pos first_base <SVType>'
-il/--max_internal_repeatlength  Filters out all indels where the inserted/deleted sequence is a homopolymers/microsatellite with an unit size of more than Y, combine with the option -ir. Default value of -il is infinite. For example: T->TCAGCAG has CAGCAG as insertion, which has the fundamental repetitive unit CAG of length 3. This would be filtered out if -il has been set to 3 or above, but would be deemed 'sufficiently unrepetitive' if -il is 2
-pr/--max_postindel_repeats  Filters out all indels where the inserted/deleted sequence is followed by a repetition (of over X times) of the fundamental repeat unit of the inserted/deleted sequence. For example, T->TCACA would usually be a normal insertion, which is not filtered out, but if the real sequence change is TCACACA->TCACACACACA, it will be filtered out by -pr of 1 or above, as the fundamental repeat unit of the inserted sequence (CA) is repeated more than one time in the postindel sequence [indel sequence CACA, postindel sequence CACACA]. Note: when CAC is inserted next to ACACAC, the repeat sequence is recognized as CA, even though the 'postrepeat' sequence is ACACAC
-pl/--max_postindel_repeatlength  Filters out all indels where the inserted/deleted sequence is followed by a repetition of  the fundamental repeat unit of the inserted/deleted sequence; the maximum size of that 'fundamental unit' given by the value of -pl (default infinite) For example: TCAG->TCAGCAG has insertion CAG and post-insertion sequence CAG. This insertion would be filtered out if -pl has been set to 3 or above, but would be deemed 'sufficiently unrepetitive' if -pl is 2
-sb/--only_balanced_samples  Only count a sample as supporting an event if it is supported by reads on both strands, minimum reads per strand given by the -ss parameter. (default false)
-ss/--minimum_strand_support  Only count a sample as supporting an event if at least one of its strands is supported by X reads (default 1)
-G/--gatk_compatible  calls genotypes which could either be homozygous or heterozygous not as ./1 but as 0/1, to ensure compatibility with GATK
-h/--help  Print the help of this converter
```

