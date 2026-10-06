# bttcmp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bttcmp | PASS |  |

## bttcmp

### Tool Description
Bacillus thuringiensis Toxin Classification and Mining Pipeline: predicts Bt toxin genes from reads, genomes, ORFs or proteins.

### Metadata
- **Docker Image**: quay.io/biocontainers/bttcmp:1.0.3--0
- **Homepage**: https://github.com/liaochenlanruo/BTTCMP/blob/master/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/bttcmp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bttcmp/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Options:
    [--help]                      Print the help message and exit

    [--version]                   Show version number of BTTCMP and exit

    [--threads (INT)]             Number of threads to be used ( Default 4 )

    [--SeqPath (PATH)]            [Required] The path of input sequences (
                                  Default "the current directory" )

    [--SequenceType (STRING)]     [Required] Sequence type for inputs.
                                  "reads", "nucl", "orfs", and "prot"
                                  avaliable ( Default nucl )

    [--platform (STRING)]         [Required] Sequencing Platform,
                                  "illumina", "pacbio", "oxford" and
                                  "hybrid" available ( Default illumina )

    [--assemble_only (STRING)]    Only perform genome assembly without
                                  predicting toxins.

    [--reads1 (STRING)]           [Required by "reads"] The suffix name of
                                  reads 1 ( for example: if the name of
                                  reads 1 is
                                  "YBT-1520_L1_I050.R1.clean.fastq.gz",
                                  "YBT-1520" is the strain same, so the
                                  suffix name should be ".R1.clean.fastq.gz"
                                  )

    [--reads2 (STRING)]           [Required by "reads"] The suffix name of
                                  reads 2( not required by "oxford" and
                                  "pacbio". For example: if the name of
                                  reads 2 is "YBT-1520_2.fq", the suffix
                                  name should be _2.fq" )

    [--suffix_len (INT)]          [Required by "reads"] (Strongly
                                  recommended) The suffix length of the
                                  reads file, that is the length of the
                                  reads name minus the length of the strain
                                  name. For example the --suffix_len of
                                  "YBT-1520_L1_I050.R1.clean.fastq.gz" is 26
                                  ( "YBT-1520" is the strain name ) (
                                  Default 0 )

    [--short1 (STRING)]           [Required] FASTQ file of first short reads
                                  in each pair. Needed by hybrid assembly (
                                  Default Unset )

    [--short2 (STRING)]           [Required] FASTQ file of second short
                                  reads in each pair. Needed by hybrid
                                  assembly ( Default Unset )

    [--long (STRING)]             [Required] FASTQ or FASTA file of long
                                  reads. Needed by hybrid assembly ( Default
                                  Unset )

    [--hout (STRING)]             [Required] Output directory for hybrid
                                  assembly ( Default
                                  ./Results/Assembles/Hybrid )

    [--genomeSize (STRING)]       [Required] An estimate of the size of the
                                  genome. Common suffixes are allowed, for
                                  example, 3.7m or 2.8g. Needed by PacBio
                                  data and Oxford data ( Default 6.07m )

    [--Scaf_suffix (STRING)]      The suffix of scaffolds or genomes (
                                  Default ".filtered.fas" )

    [--orfs_suffix (STRING)]      The suffix of orfs files ( Default ".ffn"
                                  )

    [--prot_suffix (STRING)]      The suffix of protein files ( Default
                                  ".faa" )

Usage:
      bttcmp [Options]

      The main usage is as follows:

      Example 1: Processing Illumina paired-end Reads

                 bttcmp --SeqPath <Illumina Reads PATH> --SequenceType reads --platform illumina --reads1 <suffix name of reads 1> -reads2 <suffix name of reads 2> --threads <INT> --suffix_len <INT>

      Example 2: Processing PacBio long Reads

                 bttcmp --SeqPath <PacBio Reads PATH> --SequenceType reads --platform pacbio --reads1 <suffix name of PacBio reads> --threads <INT> --suffix_len <INT>

      Example 3: Processing Oxford long Reads

                 bttcmp --SeqPath <Oxford Reads PATH> --SequenceType reads --platform oxford --reads1 <suffix name of Oxford reads> --threads <INT> --suffix_len <INT>

      Example 4: Processing Hybrid Reads (Long reads + illumina short reads)

                 bttcmp --SeqPath <Reads PATH> --SequenceType reads --platform hybrid --short1 <short reads 1> --short2 <short reads 2> --long <long reads> --threads <INT>

      Example 5: Processing assembled genomes

                 bttcmp --SeqPath <Assembled genome PATH> --SequenceType nucl --Scaf_suffix <suffix of genomes> --threads <INT>

      Example 6: Processing protein sequences

                 bttcmp --SeqPath <Protein file PATH> --SequenceType prot --prot_suffix <suffix of protein files> --threads <INT>

      Example 7: Processing orfs sequences

                 bttcmp --SeqPath <orfs file PATH> --SequenceType orfs --orfs_suffix <suffix of orfs files> --threads <INT>
```

