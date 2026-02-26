# gmcloser CWL Generation Report

## gmcloser

### Tool Description
GMcloser ver. 1.5

### Metadata
- **Docker Image**: quay.io/biocontainers/gmcloser:1.6.2--0
- **Homepage**: https://sourceforge.net/projects/gmcloser/
- **Package**: https://anaconda.org/channels/bioconda/packages/gmcloser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gmcloser/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
      GMcloser ver. 1.5
  
      Options:
       --target_scaf or -t <STR>       input target scaffold fasta file (e.g., scaf.fa) [mandatory]
       --query_seq or -q <STR>         input query contig (or long-read) fasta file (e.g., contig.fa) (if long reads are used, -lr option must be specified) [mandatory]
       --prefix_out or -p <STR>        prefix name of output files [mandatory]
   
       --read_file or -r <STR>         space-separated list of fastq or fasta files (or gzip compressed files) of paired-end reads (e.g., -r read_pe1.fq read_pe2.fq)
       --read_len or -l <INT>          read length of paired-end reads specified with the -r, -st, -sq, or -sd option (mean read length if read lengths are variable) [mandatory]
       --insert or -i <INT>            average insert size of paired-end reads [>read_len <20001, default: 400]
       --sd_insert or -d <INT>         standard deviation of insert size of paired-end reads [default: 40]
       --read_format or -f <STR>       fastq or fasta [default: fastq]
       --sam_talign or -st <STR>       space-separated list of sam alignment file(s) for target scaffolds, created in a single-end read alignment mode for paired-end reads (e.g., -sa tPE1.sam tPE2.sam, for paired-end read files PE1.fq and PE2.fq)
       --sam_qalign or -sq <STR>       space-separated list of sam alignment file(s) for query contigs, created in a single-end read alignment mode for paired-end reads (e.g., -sa qPE1.sam qPE2.sam, for paired-end read files PE1.fq and PE2.fq)
       --sam_dir or -sd <STR>          path of directory (i.e., bowtie_align) containing sam alignment files generated from a previous job with GMcloser (this can be used in place of -st and -sq option)
       --align_file or -a <STR>        Nucmer alignment file for query against target [optional]

       --connect_subcon or -c          connect between gap-encompassing subcontig pairs with their original (not merged with query contigs) termini [default: false]
       --extend or -et                 extend scaffold temini with aligned query sequences [default: false] (When using long read query, this option is disabled in the current version)
       --blast or -b                   conduct alignment between target and query contigs with BLASTn [default: false] (Nucmer alignment by default)
   
       --min_match_len or -mm <INT>    minimum overlap length to be filtered for Nucmer alignments.
                                       Contig-alignments that satisfy both the values specified with -mm and -mi are selected, irrespective of any mapping rates of PE-reads. [>49, default: 300]
       --min_identity or -mi <INT>     minimum overlap identity (%) to be filtered for Nucmer alignments. Alignments are selected by combination with -mm option. [95~100, default: 99]
       --min_len_local or -ml <INT>    minimum overlap length for merging between neighbor subcontigs with YASS aligner [>14, default: 20]
       --min_subcon or -ms <INT>       minimum length of subcontigs, to be used for gapclosing [default: 100]
       --min_gap_size or -g <INT>      minimum length of gap, when spliting the target scaffold sequences into subcontigs  [>0, default: 1]
       --max_indel or -is <INT>        maximum length of indel, observed in alignments between target subcontigs and query contigs. The alignments separated by the indel will be merged. [default: 70]
       --max_qsc or -qsc <INT>         maximum alignment coverage (%) of query singletones for target subcontigs (query with >= INT is excluded from query singletone output) [default: 60]
       --base_qual or -bq <STR>        base call quality format of fastq read file; illumina (phred64) or sanger (phred33) [default: auto]
       --nuc_len or -nl <INT>          nucmer exact match length, a value specified with '-l' option of the Nucmer aligner [default: auto, increased from 30 to 50 depending on the total contig length]
       --ad_score or -as <FLOAT>       score to add to (subtract from) the standard threshold score for selection of correct contig-subcontig alignments (e.g., 1 or -1) [default: 0]
       --hetero or -ht                 heterozygosity factor (specify this if your sequenced genome is heterozygous (>0.2% difference of the haploid size)) [default: false]
       --thread or -n <INT>            number of threads (for machines with multiple processors), enabling all the alignment processes in parallel [default: 5]
       --thread_connect or -nc <INT>   number of threads (for machines with multiple processors), enabling the subcontig-connection process in parallel [default: number specified with --thread]
       --help or -h                    output help message
   
       [Options for long read query]
       --long_read or -LR              query sequence file is a fasta file of long reads (PacBio reads must be error-corrected) [default: false] (alignment is peformed with blast)
       --lr_cov or -lc <INT>           fold coverage of long reads for target scaffolds [default: auto ; automatically calculated by dividing a total length of query by a total length of target]
       --min_qalign or -mq <INT>       minimum number of queries that are aligned to either 5'- or 3'-terminus of a target subcontig [default: 1]
       --iterate or -it <INT>          number of iteration [default: 3]
       --alignq or -aq <STR>           BLASTn alignment file for query against query [optional]
```


## Metadata
- **Skill**: generated
