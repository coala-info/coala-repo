# art CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| art_454 | PASS |  |
| art_SOLiD | PASS |  |
| art_aln2bed | Failed | image problem: aln2bed.pl is a perl script and the image has no /usr/bin/perl (exit 127). |
| art_illumina | PASS |  |
| art_map2bed | Failed | image problem: map2bed.pl is a perl script and the image has no /usr/bin/perl (exit 127). |
| art_profiler_454 | Failed | image problem: art_profiler_454 is a perl script and the image has no /usr/bin/perl (exit 127). |
| art_profiler_illumina | Failed | image problem: the image has no perl, so the helper script fastqReadAvg.pl that art_profiler_illumina calls cannot run. |

## art_454

### Tool Description
Simulation of 454 Pyrosequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://www.niehs.nih.gov/research/resources/software/biostatistics/art
- **Package**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-04-22

### Original Help Text
```text
===================================================================
                      ART_454 (Version 2.6.0)                      
                   Simulation of 454 Pyrosequencing                
     Copyright (c) 2008-2015, Weichun Huang. All Rights Reserved.  
===================================================================

===== USAGE ===== 

SINGLE-END SIMULATION
	art_454 [-s] [-a ] [-t] [-r rand_seed] [ -p read_profile ] [ -c num_flow_cycles ] <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <FOLD_COVERAGE>

PAIRED-END SIMULATION
	art_454 [-s] [-a ] [-t] [-r rand_seed] [ -p read_profile ] [ -c num_flow_cycles ] <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <FOLD_COVERAGE> <MEAN_FRAG_LEN> <STD_DEV>

AMPLICON SEQUENCING SIMULATION
	art_454 [-s] [-a ] [-t] [-r rand_seed] [ -p read_profile ] [ -c num_flow_cycles ] <-A|-B> <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <#_READS/#_READ_PAIRS_PER_AMPLICON>

===== PARAMETERS =====

INPUT_SEQ_FILE           -  the filename of DNA/RNA reference sequences in FASTA format
OUTPUT_FILE_PREFIX       -  the prefix or directory of output read data file (*.fq) and read alignment file (*.aln)
FOLD_COVERAGE            -  the fold of read coverage over the reference sequences
MEAN_FRAG_LEN            -  the average DNA fragment size for paired-end read simulation
STD_DEV                  -  the standard deviation of the DNA fragment size for paired-end read simulation
#READS_PER_AMPLICON      -  number of reads per amplicon (for 5'end amplicon sequencing)
#READ_PAIRS_PER_AMPLICON -  number of read pairs per amplicon (for two-end amplicon sequencing)

===== OPTIONAL PARAMETERS =====

-A indicate to perform single-end amplicon sequencing simulation
-B indicate to perform paired-end amplicon sequencing simulation
-M indicate to use CIGAR 'M' instead of '=/X' for alignment match/mismatch
-a indicate to output the ALN alignment file
-s indicate to output the SAM alignment file
-d print out warning messages for debugging
-t indicate to simulate reads from the built-in GS FLX Titanium profile [default: GS FLX profile]
-r specify a fixed random seed for the simulation (to generate two identical datasets from two different runs)
-c specify the number of flow cycles by the sequencer [ default: 100 for GS-FLX, and 200 for GS-FLX Titanium ] 
-p specify user's own read profile for simulation
   NOTE: the name of a read profile is the directory containing read profile data files.
         please read the REAME file about the format of 454 read profile data files and.
         and the default filenames of these data files.

===== EXAMPLES =====

 1) singl-end simulation with 20X coverage
	art_454 -s seq_reference.fa ./outdir/single_dat 20
 2) paired-end simulation with the mean fragment size 1500 and STD 20 using GS FLX Titanium platform
	art_454 -s -t seq_reference.fa ./outdir/paired_dat 10 1500 20
 3) paired-end simulation with a fixed random seed
	art_454 -s -r 777 seq_reference.fa ./outdir/paired_fxSeed 10 2500 50
 4) single-end amplicon sequencing with 10 reads per amplicon
	art_454 -A -s amplicon_ref.fa ./outdir/amp_single 10
 5) paired-end amplicon sequencing with 10 read pairs per amplicon
	art_454 -B -s amplicon_ref.fa ./outdir/amp_paired 10
```

## art_SOLiD

### Tool Description
Simulation of Applied Biosystems' SOLiD Sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://www.niehs.nih.gov/research/resources/software/biostatistics/art
- **Package**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-04-22

### Original Help Text
```text
=================================================================
                    ART_SOLiD (Version 1.3.3)                    
         Simulation of Applied Biosystems' SOLiD Sequencing       
   Copyright (c) 2008-2015, Weichun Huang. All Rights Reserved.  
=================================================================

===== USAGES =====

SINGLE-END (F3 READ) SIMULATION
	art_SOLiD [ options ] <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <LEN_READ> <FOLD_COVERAGE>

MATE-PAIR READS (F3-R3 PAIR) SIMULATION
	art_SOLiD [ options ] <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <LEN_READ> <FOLD_COVERAGE> <MEAN_FRAG_LEN> <STD_DEV>

PAIRED-END READS (F3-F5 PAIR) SIMULATION
	art_SOLiD [ options ] <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <LEN_READ_F3> <LEN_READ_F5> <FOLD_COVERAGE> <MEAN_FRAG_LEN> <STD_DEV>

AMPLICON SEQUENCING SIMULATION
	art_SOLiD [ options ] -A s <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <LEN_READ> <READS_PER_AMPLICON>
	art_SOLiD [ options ] -A m <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <LEN_READ> <READ_PAIRS_PER_AMPLICON>
	art_SOLiD [ options ] -A p <INPUT_SEQ_FILE> <OUTPUT_FILE_PREFIX> <LEN_READ_F3> <LEN_READ_F5> <READ_PAIRS_PER_AMPLICON>

===== PARAMETERS =====

INPUT_SEQ_FILE            -  filename of DNA/RNA reference sequences in FASTA format
OUTPUT_FILE_PREFIX        -  prefix or directory for all output read data files
FOLD_COVERAGE             -  fold of read coverage over the reference sequences 
LEN_READ                  -  length of F3/R3 reads
LEN_READ_F3               -  length of F3 reads for paired-end read simulation
LEN_READ_F5               -  length of F5 reads for paired-end read simulation
READS_PER_AMPLICON        -  number of reads per amplicon
READ_PAIRS_PER_AMPLICON   -  number of read pairs per amplicon
MEAN_FRAG_LEN             -  mean DNA/RNA fragment size for matepair/paired-end read simulation
STD_DEV                   -  standard deviation of the DNA/RNA fragment sizes for matepair/paired-end read simulation

===== OPTIONAL PARAMETERS =====

-A specify the read type for amplicon sequencing simulation (s:single-end, m: matepair, p: paired-end)
-M indicate to use CIGAR 'M' instead of '=/X' for alignment match/mismatch
-s indicate to generate a SAM alignment file
-r specify the random seed for the simulation
-f specify the scale factor adjusting error rate (e.g., -f 0 for zero-error rate simulation)
-p specify user's own read profile for simulation

===== EXAMPLES =====

 1) singl-end 25bp reads simulation at 10X coverage
	art_SOLiD -s seq_reference.fa ./outdir/single_dat 25 10
 2) singl-end 75bp reads simulation at 20X coverage with user's error profile
	art_SOLiD -s -p ../SOLiD_profiles/profile_pseudo ./seq_reference.fa ./dat_userProfile 75 20
 3) matepair 35bp (F3-R3) reads simulation at 20X coverage with DNA/RNA MEAN fragment size 2000bp and STD 50
	art_SOLiD -s seq_reference.fa ./outdir/matepair_dat 35 20 2000 50
 4) matepair reads simulation with a fixed random seed
	art_SOLiD -r 777 -s seq_reference.fa ./outdir/matepair_fs 50 10 1500 50
 5) paired-end reads (75bp F3, 35bp F5) simulation with the MEAN fragment size 250 and STD 10 at 20X coverage
	art_SOLiD -s seq_reference.fa ./outdir/paired_dat 75 35 50 250 10
 6) amplicon sequencing with 25bp single-end reads at 100 reads per amplicon
	art_SOLiD -A s -s amp_reference.fa ./outdir/amp_single 25 100
 7) amplicon sequencing with 50bp matepair reads at 80 read pairs per amplicon
	art_SOLiD -A m -s amp_reference.fa ./outdir/amp_matepair 50 80
 8) amplicon sequencing with paired-end reads (35bp F3, 25bp F5 reads) at 50 pairs per amplicon
	art_SOLiD -A p -s amp_reference.fa ./outdir/amp_pair 35 25 50
```

## art_profiler_illumina

### Tool Description
This tool is to create an Illumina read quality profile from multiple fastq or gzipped fastq files

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://www.niehs.nih.gov/research/resources/software/biostatistics/art
- **Package**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-04-22

### Original Help Text
```text
This tool is to create an Illumina read quality profile from multiple fastq or gzipped fastq files

USAGE:
	./art_profiler_illumina output_profile_name input_fastq_dir fastq_filename_extension [max_number_threads]

PARAMETERS:
	output_profile_name:  the name of read quality profile to be generated
	input_fastq_dir:   the directory of input fastq or zipped fastq files
	fastq_filename_extension: fastq or gzipped fastq filename extension
	max_number_threads:: maximum number of threads/cores to be used for the run (default: all cores)

EXAMPLES:
	1) create hiseq2k profiles from all *.fq.gz in the directory fastq_dat_dir
		./art_profiler_illumina hiseq2k fastq_dat_dir fq.gz
	2) create miseq2500 profiles from all *.fq in the directory fastq_dat_dir
		./art_profiler_illumina miseq250 fastq_dat_dir fq
	3) create hiseq1k profiles from all *.fq in the directory fastq_dat_dir using 20 threads
		./art_profiler_illumina hiseq1k fastq_dat_dir fq 20

NOTES: For paired-end fastq files, e.g., *.fq or *.fq.gz,
       the filenames of the 1st reads must be *_1.fq/*_1.fq.gz, or *.1.fq/*.1.fq.gz
       and those of the 2nd reads must be *_2.fq./*_2.fq.gz, or *.2.fq or *.2.fq.gz

CONTACT: Weichun Huang at whduke@gmail.com
```

## art_profiler_454

### Tool Description
art_profiler_454 is a program for generating empirical 454 read profiles for ART 454 simulator from 454 read data files (usage text read from the script source, because the script cannot run in this image)

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://www.niehs.nih.gov/research/resources/software/biostatistics/art
- **Package**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-04-22

### Original Help Text
```text
DESCRIPTION:
	art_profiler_454 is a program for generating empirical 454 read profiles
	for ART 454 simulator from 454 read data files
	Version: 0.9.1, Copyright (c) Weichun Huang 2012 (whduke@gamil.com)
USAGE:
	art_profiler_454 input_fastq_files_dir output_profile_dir [fastq_filename_extension]
Examples:
	art_profiler_454 454_dat_dir 454_profile_dir
	art_profiler_454 454_dat_dir 454_profile_dir fastq
NOTES:
	1)the default filename extension for fastq files is fq
	2)the program can read gzipped fastq data files with filename extension fq.gz
```

## art_aln2bed

### Tool Description
aln2bed converts ALN files to a BED file (usage text read from the script source, because the script cannot run in this image)

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://www.niehs.nih.gov/research/resources/software/biostatistics/art
- **Package**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-04-22

### Original Help Text
```text
aln2bed converts ALN files to a BED file

USAGE: aln2bed out_bed_file.bed in_aln_file_1 [ in_aln_file_2 ...]
```

## art_map2bed

### Tool Description
map2bed converts ART's map files to a BED file (usage text read from the script source, because the script cannot run in this image)

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://www.niehs.nih.gov/research/resources/software/biostatistics/art
- **Package**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-04-22

### Original Help Text
```text
map2bed converts ART's map files to a BED file

USAGE: map2bed.pl out_bed_file.bed in_map_file_1 [ in_map_file_2 ...]
```

## Metadata
- **Skill**: generated

## art_illumina

### Tool Description
Simulation of Illumina next-generation sequencing reads

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
====================ART====================
             ART_Illumina (2008-2016)          
          Q Version 2.5.8 (June 6, 2016)       
     Contact: Weichun Huang <whduke@gmail.com> 
    -------------------------------------------

===== USAGE =====

art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -o <outfile_prefix>
art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -c <num_reads_per_sequence> -o <outfile_prefix>
art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -m <mean_fragsize> -s <std_fragsize> -o <outfile_prefix>
art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -c <num_reads_per_sequence> -m <mean_fragsize> -s <std_fragsize> -o <outfile_prefix>

===== PARAMETERS =====

  -1   --qprof1   the first-read quality profile
  -2   --qprof2   the second-read quality profile
  -amp --amplicon amplicon sequencing simulation
  -c   --rcount   number of reads/read pairs to be generated per sequence/amplicon (not be used together with -f/--fcov)
  -d   --id       the prefix identification tag for read ID
  -ef  --errfree  indicate to generate the zero sequencing errors SAM file as well the regular one
                  NOTE: the reads in the zero-error SAM file have the same alignment positions
                  as those in the regular SAM file, but have no sequencing errors
  -f   --fcov     the fold of read coverage to be simulated or number of reads/read pairs generated for each amplicon
  -h   --help     print out usage information
  -i   --in       the filename of input DNA/RNA reference
  -ir  --insRate  the first-read insertion rate (default: 0.00009)
  -ir2 --insRate2 the second-read insertion rate (default: 0.00015)
  -dr  --delRate  the first-read deletion rate (default:  0.00011)
  -dr2 --delRate2 the second-read deletion rate (default: 0.00023)
  -k   --maxIndel the maximum total number of insertion and deletion per read (default: up to read length)
  -l   --len      the length of reads to be simulated
  -m   --mflen    the mean size of DNA/RNA fragments for paired-end simulations
  -mp  --matepair indicate a mate-pair read simulation
  -M  --cigarM    indicate to use CIGAR 'M' instead of '=/X' for alignment match/mismatch
  -nf  --maskN    the cutoff frequency of 'N' in a window size of the read length for masking genomic regions
                  NOTE: default: '-nf 1' to mask all regions with 'N'. Use '-nf 0' to turn off masking
  -na  --noALN    do not output ALN alignment file
  -o   --out      the prefix of output filename
  -p   --paired   indicate a paired-end read simulation or to generate reads from both ends of amplicons
                  NOTE: art will automatically switch to a mate-pair simulation if the given mean fragment size >= 2000
  -q   --quiet    turn off end of run summary
  -qL  --minQ     the minimum base quality score
  -qU  --maxQ     the maxiumum base quality score
  -qs  --qShift   the amount to shift every first-read quality score by 
  -qs2 --qShift2  the amount to shift every second-read quality score by
                  NOTE: For -qs/-qs2 option, a positive number will shift up quality scores (the max is 93) 
                  that reduce substitution sequencing errors and a negative number will shift down 
                  quality scores that increase sequencing errors. If shifting scores by x, the error
                  rate will be 1/(10^(x/10)) of the default profile.
  -rs  --rndSeed  the seed for random number generator (default: system time in second)
                  NOTE: using a fixed seed to generate two identical datasets from different runs
  -s   --sdev     the standard deviation of DNA/RNA fragment size for paired-end simulations.
  -sam --samout   indicate to generate SAM alignment file
  -sp  --sepProf  indicate to use separate quality profiles for different bases (ATGC)
  -ss  --seqSys   The name of Illumina sequencing system of the built-in profile used for simulation
       NOTE: sequencing system ID names are:
            GA1 - GenomeAnalyzer I (36bp,44bp), GA2 - GenomeAnalyzer II (50bp, 75bp)
           HS10 - HiSeq 1000 (100bp),          HS20 - HiSeq 2000 (100bp),      HS25 - HiSeq 2500 (125bp, 150bp)
           HSXn - HiSeqX PCR free (150bp),     HSXt - HiSeqX TruSeq (150bp),   MinS - MiniSeq TruSeq (50bp)
           MSv1 - MiSeq v1 (250bp),            MSv3 - MiSeq v3 (250bp),        NS50 - NextSeq500 v2 (75bp)
===== NOTES =====

* ART by default selects a built-in quality score profile according to the read length specified for the run.

* For single-end simulation, ART requires input sequence file, output file prefix, read length, and read count/fold coverage.

* For paired-end simulation (except for amplicon sequencing), ART also requires the parameter values of
  the mean and standard deviation of DNA/RNA fragment lengths

===== EXAMPLES =====

 1) single-end read simulation
 	art_illumina -ss HS25 -sam -i reference.fa -l 150 -f 10 -o single_dat

 2) paired-end read simulation
       art_illumina -ss HS25 -sam -i reference.fa -p -l 150 -f 20 -m 200 -s 10 -o paired_dat

 3) mate-pair read simulation
       art_illumina -ss HS10 -sam -i reference.fa -mp -l 100 -f 20 -m 2500 -s 50 -o matepair_dat

 4) amplicon sequencing simulation with 5' end single-end reads 
 	art_illumina -ss GA2 -amp -sam -na -i amp_reference.fa -l 50 -f 10 -o amplicon_5end_dat

 5) amplicon sequencing simulation with paired-end reads
       art_illumina -ss GA2 -amp -p -sam -na -i amp_reference.fa -l 50 -f 10 -o amplicon_pair_dat

 6) amplicon sequencing simulation with matepair reads
       art_illumina -ss MSv1 -amp -mp -sam -na -i amp_reference.fa -l 150 -f 10 -o amplicon_mate_dat

 7) generate an extra SAM file with zero-sequencing errors for a paired-end read simulation
       art_illumina -ss HSXn -ef -i reference.fa -p -l 150 -f 20 -m 200 -s 10 -o paired_twosam_dat

 8) reduce the substitution error rate to one 10th of the default profile
       art_illumina -i reference.fa -qs 10 -qs2 10 -l 50 -f 10 -p -m 500 -s 10 -sam -o reduce_error

 9) turn off the masking of genomic regions with unknown nucleotides 'N'
       art_illumina -ss HS20 -nf 0  -sam -i reference.fa -p -l 100 -f 20 -m 200 -s 10 -o paired_nomask

 10) masking genomic regions with >=5 'N's within the read length 50
       art_illumina -ss HSXt -nf 5 -sam -i reference.fa -p -l 150 -f 20 -m 200 -s 10 -o paired_maskN5

Fatal Error: -help, is not a valid parameter.
```
