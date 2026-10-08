# hapcut2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hapcut2 | PASS |  |
| hapcut2_LinkFragments.py | Not completed | no 10X linked-read BAM (BX tags) with phased variants available as test data |
| hapcut2_calculate_haplotype_statistics.py | PASS |  |
| hapcut2_extractHAIRS | PASS |  |

## hapcut2

### Tool Description
robust and accurate haplotype assembly for diverse sequencing technologies

### Metadata
- **Docker Image**: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
- **Homepage**: https://github.com/vibansal/HapCUT2/
- **Package**: https://anaconda.org/channels/bioconda/packages/hapcut2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hapcut2/overview
- **Total Downloads**: 22.9K
- **Last updated**: 2025-08-01
- **GitHub**: https://github.com/vibansal/HapCUT2
- **Stars**: N/A
### Original Help Text
```text
HapCUT2: robust and accurate haplotype assembly for diverse sequencing technologies

USAGE : ./HAPCUT2 --fragments fragment_file --VCF variantcalls.vcf --output haplotype_output_file
```

## hapcut2_extractHAIRS

### Tool Description
Extract haplotype informative reads (HAIRS) from coordinate sorted BAM/CRAM files (for a single individual).

### Metadata
- **Docker Image**: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
- **Homepage**: https://github.com/vibansal/HapCUT2/
- **Package**: https://anaconda.org/channels/bioconda/packages/hapcut2/overview
- **Validation**: PASS

### Original Help Text
```text
Extract haplotype informative reads (HAIRS) from coordinate sorted BAM/CRAM files (for a single individual) 

./extractHAIRS [options] --bam reads.sorted.bam --VCF variants.VCF --out fragment_file 

Options:
--bam BAM/CRAM : sorted and indexed BAM/CRAM file; the option can be used more than once to specify multiple files for the same sample 
--qvoffset <33/64> : quality value offset, 33/64 depending on how quality values were encoded, default is 33 
--mbq <INT> : minimum base quality to consider a base for haplotype fragment, default 13
--mmq <INT> : minimum read mapping quality to consider a read for phasing, default 20
--realign_variants <0/1> : Perform sensitive realignment and scoring of variants.
--hic <0/1> : sets default maxIS to 40MB, prints matrix in new HiC format
--10X <0/1> : 10X reads. NOTE: Output fragments MUST be processed with LinkReads.py script after extractHAIRS to work with HapCUT2.
--pacbio <0/1> : Pacific Biosciences reads. Similar to --realign_variants, but with alignment parameters tuned for PacBio reads.
--ONT, --ont <0/1> : Oxford nanopore technology reads. Similar to --realign_variants, but with alignment parameters tuned for Oxford Nanopore Reads.
--new_format, --nf <0/1> : prints matrix in new format. Requires --new_format option when running HapCUT2.
--VCF <FILENAME> : variant file with genotypes for a single individual in VCF format (unzipped) 
--maxIS <INT> : maximum insert size for a paired-end read to be considered as a single fragment for phasing, default 1000
--minIS <INT> : minimum insert size for a paired-end read to be considered as single fragment for phasing, default 0
--PEonly <0/1> : do not use single end reads, default is 0 (use all reads)
--indels <0/1> : extract reads spanning INDELS, default is 0, variants need to specified in VCF format to use this option
--noquality <INTEGER> : if the bam file does not have quality string, this value will be used as the uniform quality value, default 0 
--triallelic <0/1> : include variants with genotype 1/2 for parsing, default 0 
--ref <FILENAME> : reference sequence file (in fasta format, gzipped is okay), optional but required for indels and CRAM files, should be indexed
--out <FILENAME> : output filename for haplotype fragments, if not provided, fragments will be output to stdout
--region <chr:start-end> : chromosome and region in BAM file, useful to process individual chromosomes or genomic regions 
--ep <0/1> : set to 1 to estimate HMM parameters from aligned reads (only with long reads), default = 1
--hom <0/1> : set to 1 to include homozygous variants for processing, default = 0 (only heterozygous)
```

## hapcut2_LinkFragments.py

### Tool Description
Link the fragments of 10X linked reads into molecules for HAPCUT2.

### Metadata
- **Docker Image**: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
- **Homepage**: https://github.com/vibansal/HapCUT2/
- **Package**: https://anaconda.org/channels/bioconda/packages/hapcut2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LinkFragments.py [-h] [-f [FRAGMENTS]] [-v [VCF]] [-b [BAM_FILE]]
                        [-o [OUTFILE]] [-d [DISTANCE]] [-m [MAXBQ]]
                        [--use-tag] [-s]

options:
  -h, --help            show this help message and exit
  -f, --fragments [FRAGMENTS]
                        file with unlinked hapcut2 fragments (generate using
                        --10X 1 option in extractHAIRS)
  -v, --VCF [VCF]       vcf file for phasing
  -b, --bam_file [BAM_FILE]
                        bam file with barcoded reads
  -o, --outfile [OUTFILE]
                        output file with linked fragments
  -d, --distance [DISTANCE]
                        distance in base pairs that delineates separate 10X
                        molecules, default=20kb
  -m, --maxbq [MAXBQ]   maximum base quality for an allele call, default=40
  --use-tag             use molecule tag (MI) to separate between molecules
  -s, --single_SNP_frags
                        whether to keep fragments overlapping only one SNP
```

## hapcut2_calculate_haplotype_statistics.py

### Tool Description
Calculate statistics on haplotypes assembled using HapCUT2 or similar tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
- **Homepage**: https://github.com/vibansal/HapCUT2/
- **Package**: https://anaconda.org/channels/bioconda/packages/hapcut2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: calculate_haplotype_statistics.py [-h] [-v1 VCF1 [VCF1 ...]]
                                         [-v2 VCF2 [VCF2 ...]]
                                         [-h1 HAPLOTYPE_BLOCKS1 [HAPLOTYPE_BLOCKS1 ...]]
                                         [-h2 HAPLOTYPE_BLOCKS2 [HAPLOTYPE_BLOCKS2 ...]]
                                         [-i]

Calculate statistics on haplotypes assembled using HapCUT2 or similar tools.
Error rates for an assembled haplotype (specified by -v1 and optionally -h1
arguments) are computed with respect to a "reference" haplotype (specified by
-v2 and optionally -h2 arguments). All files must contain information for one
chromosome only! To compute aggregate statistics across multiple chromosomes,
provide files for each chromosome/contig as an ordered list, using the same
chromosome order between flags. Note: Triallelic variants are supported, but
variants with more than 2 alternative alleles are currently NOT supported.
These variants are ignored. Also, variants where the ref and alt alleles
differ between the test haplotype and reference haplotype are skipped.

options:
  -h, --help            show this help message and exit
  -v1, --vcf1 VCF1 [VCF1 ...]
                        A phased, single sample VCF file to compute haplotype
                        statistics on.
  -v2, --vcf2 VCF2 [VCF2 ...]
                        A phased, single sample VCF file to use as the "ground
                        truth" haplotype.
  -h1, --haplotype_blocks1 HAPLOTYPE_BLOCKS1 [HAPLOTYPE_BLOCKS1 ...]
                        Override the haplotype information in "-v1" with the
                        information in this HapCUT2-format haplotype block
                        file. If this option is used, then the VCF specified
                        with -v1 MUST be the same VCF used with HapCUT2
                        (--vcf) to produce the haplotype block file!
  -h2, --haplotype_blocks2 HAPLOTYPE_BLOCKS2 [HAPLOTYPE_BLOCKS2 ...]
                        Override the haplotype information in "-v2" with the
                        information in this HapCUT2-format haplotype block
                        file. If this option is used, then the VCF specified
                        with -v2 MUST be the same VCF used with HapCUT2
                        (--vcf) to produce the haplotype block file!
  -i, --indels          Use this flag to consider indel variants. Default:
                        Indels ignored.
```
