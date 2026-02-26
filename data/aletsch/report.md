# aletsch CWL Generation Report

## aletsch

### Tool Description
Aletsch is a tool for assembling transcripts from multiple RNA-seq samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/aletsch:1.1.3--h503566f_1
- **Homepage**: https://github.com/Shao-Group/aletsch
- **Package**: https://anaconda.org/channels/bioconda/packages/aletsch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aletsch/overview
- **Total Downloads**: 18.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Shao-Group/aletsch
- **Stars**: N/A
### Original Help Text
```text
Aletsch 1.1.2 (c) 2024 Qian Shi, Qimin Zhang, Mingfu Shao, The Pennsylvania State University

Usage: aletsch -i <input-bam-list> -o <output.gtf> [options]

Options:
 --help                                          print usage of aletsch and exit
 --version                                       print current version of aletsch and exit
 --profile                                       profiling individual samples and exit (will write to files if -p provided)
 --boost_precision                               reduce false positives, default: not to do so
 --output_single_exon_transcripts                assemble single-exon transcripts, default: not to do so
 -l/--chrm_list_string <string>                  list of chromosomes that will be assembled, default: N/A (i.e., assemble all)
 -L/--chrm_list_file <string>                    file with chromosomes that will be assembled, default: N/A (i.e., assemble all)
 -d/--output_gtf_dir <string>                    existing directory for individual transcripts, default: N/A
 -p/--profile_dir <string>                       existing directory for saving/loading profiles of each samples, default: N/A
 -t/--max_threads <integer>                      maximized number of threads, default: 10
 -c/--max_group_size <integer>                   the maximized number of splice graphs that will be combined, default: 200
 -b/--batch_partition_size <integer>             the number of partitions loaded each time, default: 3
 -g/--region_partition_length <integer>          the length of a partition , default: 1000000
 -s/--min_grouping_similarity <float>            the minimized similarity for two graphs to be combined, default: 0.2
 --min_bridging_score <float>                    the minimum score for bridging a paired-end reads, default: 1.5
 --min_splice_bundary_hits <integer>             the minimum number of spliced reads required to support a junction, default: 1
 --min_transcript_coverage <float>               minimum coverage required for a multi-exon transcript, default: 2.0
 --min_transcript_length_base <integer>          default: 100
 --min_transcript_length_increase <integer>      default: 20, minimum length of a transcript: base + #exons * increase
 --min_single_exon_coverage <float>              minimum coverage required for a single-exon transcript, default: 20
 --min_single_exon_transcript_length <integer>   minimum length of single-exon transcript, default: 250
 --min_single_exon_clustering_overlap <float>    minimum overlaping ratio to merge two single-exon transcripts, default: 0.8
 --min_mapping_quality <integer>                 ignore reads with mapping quality less than this value, default: 1
 --max_num_cigar <integer>                       ignore reads with CIGAR size larger than this value, default: 1000
 --min_bundle_gap <integer>                      minimum distances required to start a new bundle, default: 50
 --min_num_hits_in_bundle <integer>              minimum number of reads required in a bundle, default: 20
 --min_flank_length <integer>                    minimum match length in each side for a spliced read, default: 3
 --min_boundary_log_ratio <float>                minimum log-ratio to identify a new boundary, default: 2.0
```

