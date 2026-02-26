# eastr CWL Generation Report

## eastr

### Tool Description
Emending alignments of spuriously spliced transcript reads. The script takes GTF, BED, or BAM files as input and processes them using the provided reference genome and BowTie2 index. It identifies spurious junctions and filters the input data accordingly.

### Metadata
- **Docker Image**: quay.io/biocontainers/eastr:1.1.2--py311h2de2dd3_1
- **Homepage**: https://github.com/ishinder/EASTR
- **Package**: https://anaconda.org/channels/bioconda/packages/eastr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eastr/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ishinder/EASTR
- **Stars**: N/A
### Original Help Text
```text
usage: eastr [-h] (--gtf GTF | --bed BED | --bam BAM) -r REFERENCE -i
             BOWTIE2_INDEX [--bt2_k BT2_K] [-o O]
             [--min_duplicate_exon_length MIN_DUPLICATE_EXON_LENGTH] [-a A]
             [--min_junc_score MIN_JUNC_SCORE] [--trusted_bed TRUSTED_BED]
             [--verbose] [--removed_alignments_bam] [-A A] [-B B] [-O O O]
             [-E E E] [-k K] [--scoreN SCOREN] [-w W] [-m M]
             [--out_original_junctions OUT] [--out_removed_junctions OUT]
             [--out_filtered_bam OUT] [--filtered_bam_suffix STR] [-p P]

eastr: Emending alignments of spuriously spliced transcript reads. The script
takes GTF, BED, or BAM files as input and processes them using the provided
reference genome and BowTie2 index. It identifies spurious junctions and
filters the input data accordingly.

options:
  -h, --help            show this help message and exit
  --gtf GTF             Input GTF file containing transcript annotations
  --bed BED             Input BED file with intron coordinates
  --bam BAM             Input BAM file or a TXT file containing a list of BAM
                        files with read alignments
  -r REFERENCE, --reference REFERENCE
                        reference FASTA genome used in alignment
  -i BOWTIE2_INDEX, --bowtie2_index BOWTIE2_INDEX
                        Path to Bowtie2 index for the reference genome
  --bt2_k BT2_K         Minimum number of distinct alignments found by bowtie2
                        for a junction to be considered spurious. Default: 10
  -o O                  Length of the overhang on either side of the splice
                        junction. Default = 50
  --min_duplicate_exon_length MIN_DUPLICATE_EXON_LENGTH
                        Minimum length of the duplicated exon. Default = 27
  -a A                  Minimum required anchor length in each of the two
                        exons, default = 7
  --min_junc_score MIN_JUNC_SCORE
                        Minimum number of supporting spliced reads required
                        per junction. Junctions with fewer supporting reads in
                        all samples are filtered out if the flanking regions
                        are similar (based on mappy scoring matrix). Default:
                        1
  --trusted_bed TRUSTED_BED
                        Path to a BED file path with trusted junctions, which
                        will not be removed by EASTR.
  --verbose             Display additional information during BAM filtering,
                        including the count of total spliced alignments and
                        removed alignments
  --removed_alignments_bam
                        Write removed alignments to a BAM file
  -p P                  Number of parallel processes, default=1

Minimap2 parameters:
  -A A                  Matching score. Default = 3
  -B B                  Mismatching penalty. Default = 4
  -O O O                Gap open penalty. Default = [12, 32]
  -E E E                Gap extension penalty. A gap of length k costs
                        min(O1+k*E1, O2+k*E2). Default = [2, 1]
  -k K                  K-mer length for alignment. Default=3
  --scoreN SCOREN       Score of a mismatch involving ambiguous bases.
                        Default=1
  -w W                  Minimizer window size. Default=2
  -m M                  Discard chains with chaining score. Default=25.

Output:
  --out_original_junctions OUT
                        Write original junctions to the OUT file or directory
  --out_removed_junctions OUT
                        Write removed junctions to OUT file or directory; the
                        default output is to terminal
  --out_filtered_bam OUT
                        Write filtered bams to OUT file or directory
  --filtered_bam_suffix STR
                        Suffix added to the name of the output BAM files.
                        Default='_EASTR_filtered'
```

