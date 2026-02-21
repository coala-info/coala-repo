# amaranth-assembler CWL Generation Report

## amaranth-assembler

### Tool Description
FAIL to generate CWL: amaranth-assembler not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/amaranth-assembler:0.1.0--h5ca1c30_0
- **Homepage**: https://github.com/Shao-Group/amaranth
- **Package**: https://anaconda.org/channels/bioconda/packages/amaranth-assembler/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/amaranth-assembler/overview
- **Total Downloads**: 665
- **Last updated**: 2025-12-03
- **GitHub**: https://github.com/Shao-Group/amaranth
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: amaranth-assembler not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: amaranth-assembler not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## amaranth-assembler_amaranth

### Tool Description
Amaranth assembler for transcript assembly from BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/amaranth-assembler:0.1.0--h5ca1c30_0
- **Homepage**: https://github.com/Shao-Group/amaranth
- **Package**: https://anaconda.org/channels/bioconda/packages/amaranth-assembler/overview
- **Validation**: PASS
### Original Help Text
```text
Amaranth assembler v0.1.0 (c) 2025 Xiaofei Carl Zang, and Mingfu Shao, The Pennsylvania State University

Usage: amaranth -i <bam-file> -o <gtf-file> [options]

Options:
 --help                                      print usage of Amaranth and exit
 --version                                   print current version of Amaranth and exit
 --preview                                   determine fragment-length-range and library-type and exit
 --verbose <0, 1, 2>                         0: quiet; 1: one line for each graph; 2: with details, default: 1
 -f/--transcript_fragments <filename>        file to which the assembled non-full-length transcripts will be written to
 --library_type <first, second, unstranded>  library type of the sample, default: unstranded
 --min_transcript_coverage <float>           minimum coverage required for a multi-exon transcript, default: 1.5
 --min_single_exon_coverage <float>          minimum coverage required for a single-exon transcript, default: 20
 --min_transcript_length_increase <integer>  default: 50
 --min_transcript_length_base <integer>      default: 150, minimum length of a transcript would be
                                             --min_transcript_length_base + --min_transcript_length_increase * num-of-exons
 --min_mapping_quality <integer>             ignore reads with mapping quality less than this value, default: 1
 --max_num_cigar <integer>                   ignore reads with CIGAR size larger than this value, default: 1000
 --min_bundle_gap <integer>                  minimum distances required to start a new bundle, default: 100
 --min_num_hits_in_bundle <integer>          minimum number of reads required in a gene locus, default: 5
 --min_flank_length <integer>                minimum match length in each side for a spliced read, default: 3
 --use-filter                                use filtering to select subpaths before final assembly, default: use-filter
 --no-filter                                 disable filtering, use all subpaths in final assembly,  default: use-filter
 --remove-pcr-duplicates <int>               remove PCR duplicates using strategy: 0,1, or 2, default: 1
 --no-remove-pcr-duplicates                  not remove PCR duplicates in the input bam file, default: not-remove
 --min-umi-reads-bundle <integer>            minimum number of UMI reads required in a bundle, default: 1
 --min-umi-ratio-bundle <float>              minimum ratio of UMI reads required in a bundle, default: 0
 --both-umi-support <true|false>             require satisfactory UMI support for [both/either] condition, default: false(either)
 --min-umi-reads-start-exon <integer>        minimum number of UMI reads supporting the first exon, default: 1
 --remove-retained-intron                    remove retained introns, default: used
 --no-remove-retained-intron                 do not remove retained introns
 --max-ir-umi-support-full <integer>         max UMI reads to support full intron retention, default: 3
 --max-ir-umi-support-part <integer>         max UMI reads to support partial intron retention, default: 5
 --max-ir-part-ratio-v <float>               ratio threshold of retained node to skip edge (partial), default: 0.5
 --max-ir-part-ratio-e <float>               ratio threshold of retained edge to skip edge (partial), default: 0.5
 --max-ir-full-ratio-v <float>               ratio threshold of retained node to skip edge (full), default: 1.0
 --max-ir-full-ratio-e <float>               ratio threshold of retained edge to skip edge (full), default: 0.5
 --max-ir-full-ratio-i <float>               ratio threshold of retained node to its own edge (full), default: 10.0
 --meta                                      enable meta-assembly mode for multiple cells
 --min-cb-ratio <float>                      minimum ratio of exons supported by cell barcode, default: 0.3
 --gene_name_prefix <string>                 prefix to add to gene names in output GTF
```

