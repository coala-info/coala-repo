# reparation_blast CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| reparation_blast_reparation.pl | PASS | ran on real E. coli ribosome profiling reads (SRR9691487 subset) with the E. coli K-12 proteome; predicted 1430 ORFs |

## reparation_blast_reparation.pl

### Tool Description
Performs BLAST analysis for bacterial protein sequence identification and ORF prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/reparation_blast:1.0.9--pl526_0
- **Homepage**: https://github.com/RickGelhausen/REPARATION_blast
- **Package**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reparation_blast/overview
- **Total Downloads**: 47.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RickGelhausen/REPARATION_blast
- **Stars**: N/A
### Original Help Text
```text
Usage:
    reparation.pl [options] -bam riboseq_alignment_files_bam_format -g
    bacteria_genome_fasta_file -sdir scripts_directory -db
    curated_protein_db(fasta)

Options:
  Mandatory:
    -bam
        Ribosome alignment file (bam)

    -g  Genome fasta file. This should be the same genome fasta file used in
        the alignment of the Ribo-seq reads.

    -sdir
        The "scripts" directory (avialable within the REPARATION directory),
        defaults to directory of reparation.pl script

    -db fasta database of curated bacteria protein sequences

  Optional:
    -gtf
        GTF genome annotation file

    -wdir
        working directory (defaults to current directory)

    -en Experiment name

    -p  Ribosome profiling read p site assignment strategy, 1 = plastid
        P-site estimation ((default), 3 = 3 prime of read, 5 prime of the
        read

    -mn All ribosome profiling reads shorter than these values are
        eliminated from the ananlysis (default = 22)

    -mx All ribosome profiling reads longerer than these values are
        eliminated from the ananlysis (default = 40)

    -mo Minimum length of open reading frame considered for prediction
        (default = 30 value in nucleotides)

    -mr Open reading frames with less than these number of ribosome
        profiling reads are eliminated from analysis (default = 3)

    -ost
        Start region length in nucleotides (default = 45nts). This value is
        used to calculate features specific to the start region.

    -osp
        Stop region length in nucleotides (default = 21nts). This value is
        used to calculate features specific to the stop region.

    -osd
        Distance of Shine dalgarno sequence from start codon (defualt =
        5nts).

    -seed
        Shine dalgarno sequence (default = GGAGG). The shine dalgarno
        sequence used for Ribosome binind site energy calculation.

    -sd Use ribosome binding site (RBS) energy in the open reading frame
        prediction (Y = use RBS energy (default), N = donot use RBS engergy)

    -id Online-Ticket UNI STUTT Minimum identify score for BLAST protein
    sequence search (default = 0.75)
    -ev maximum e-vlaue for BLAST protein sequence search (default = 1e-5)

    -pg program for initial positive set generation (1 = prodigal (default),
        2 = glimmer)

    -cdn
        Comma separted list of start codons (default = ATG,GTG,TTG)

    -ncdn
        Start codon for negative set (default = CTG)

    -pcdn
        Start codon for positive set (default = ATG,GTG,TTG). Should be a
        subset of the standard genetic code for bacteria

    -gcode
        Genetic code to use for initail positive set generation. Valid when
        -pg is 1. (default = 11, takes value between 1-25)

    -by Flag to determine if prodigal should bypass Shine-Dalgarno trainer
        and force a full motif scan (default = N). (Y = yes, N = no) Valid
        only for -pg 1

    -score
        Random forest classification probability score threshold to define
        as ORF are protein coding, the minimum (defualt is 0.5)
```


## Metadata
- **Skill**: generated
