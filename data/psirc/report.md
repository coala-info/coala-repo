# psirc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| psirc_create_custom_transcriptome_fa.pl | Failed | image problem: the script starts with #!/usr/bin/perl but perl is only at /usr/local/bin/perl in the image, so it cannot execute. |
| psirc_h5dump | PASS | Plaintext abundance.tsv identical to the quant output. |
| psirc_index | PASS | Real SARS-CoV-2 transcriptome from nf-core; index used by quant and pseudo, inspect shows 11 targets. |
| psirc_inspect | PASS | GFA graph with 11 contigs written; BED has only a header because the GTF transcript IDs do not match the index. |
| psirc_pseudo | PASS | Equivalence class counts (sum 93) match quant; run_info.json reports 0 pseudoaligned, a cosmetic quirk. |
| psirc_quant | PASS | 100 real read pairs on the SARS-CoV-2 transcripts: 93 pseudoaligned, counts match the pseudo equivalence classes. |
| psirc_query | PASS | Unitig path of one transcript has 3792 k-mers for a 3822 nt transcript, as expected. |

## psirc_index

### Tool Description
Builds index

### Metadata
- **Docker Image**: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
- **Homepage**: https://github.com/nictru/psirc
- **Package**: https://anaconda.org/channels/bioconda/packages/psirc/overview
- **Validation**: PASS

### Original Help Text
```text
psirc-quant 1.0
Builds index

Usage: psirc-quant index [arguments] FASTA-files

Required argument:
-i, --index=STRING          Filename for the index to be constructed 

Optional argument:
-k, --kmer-size=INT         k-mer (odd) length (default: 31, max value: 31)
    --make-unique           Replace repeated target names with unique names
```


## psirc_quant

### Tool Description
Computes equivalence classes for reads and quantifies abundances

### Metadata
- **Docker Image**: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
- **Homepage**: https://github.com/nictru/psirc
- **Package**: https://anaconda.org/channels/bioconda/packages/psirc/overview
- **Validation**: PASS

### Original Help Text
```text
psirc-quant 1.0
Computes equivalence classes for reads and quantifies abundances

Usage: psirc-quant quant [arguments] FASTQ-files

Required arguments:
-i, --index=STRING            Filename for the index to be used for
                              quantification
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
    --bias                    Perform sequence based bias correction
-b, --bootstrap-samples=INT   Number of bootstrap samples (default: 0)
    --seed=INT                Seed for the bootstrap sampling (default: 42)
    --plaintext               Output plaintext instead of HDF5
    --fusion                  Search for fusions for Pizzly
    --single                  Quantify single-end reads
    --single-overhang         Include reads where unobserved rest of fragment is
                              predicted to lie outside a transcript
    --fr-stranded             Strand specific reads, first read forward
    --rf-stranded             Strand specific reads, first read reverse
-l, --fragment-length=DOUBLE  Estimated average fragment length
-s, --sd=DOUBLE               Estimated standard deviation of fragment length
-x, --min-fragment-length     Minimum length of a valid fragment
-X, --max-fragment-length     Maximum length of a valid fragment
                              (default: -l, -s values are estimated from paired
                               end data, but are required when using --single)
-t, --threads=INT             Number of threads to use (default: 1)
    --pseudobam               Save pseudoalignments to transcriptome to BAM file
    --genomebam               Project pseudoalignments to genome sorted BAM file
-g, --gtf                     GTF file for transcriptome information
                              (required for --genomebam)
-c, --chromosomes             Tab separated file with chrosome names and lengths
                              (optional for --genomebam, but recommended)
```


## psirc_pseudo

### Tool Description
Computes equivalence classes for reads (pseudoalignment step)

### Metadata
- **Docker Image**: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
- **Homepage**: https://github.com/nictru/psirc
- **Package**: https://anaconda.org/channels/bioconda/packages/psirc/overview
- **Validation**: PASS

### Original Help Text
```text
psirc-quant 1.0
Computes equivalence classes for reads and quantifies abundances

Usage: psirc-quant pseudo [arguments] FASTQ-files

Required arguments:
-i, --index=STRING            Filename for the index to be used for
                              pseudoalignment
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
-u  --umi                     First file in pair is a UMI file
-b  --batch=FILE              Process files listed in FILE
    --single                  Quantify single-end reads
-l, --fragment-length=DOUBLE  Estimated average fragment length
-s, --sd=DOUBLE               Estimated standard deviation of fragment length
-x, --min-fragment-length     Minimum length of a valid fragment
-X, --max-fragment-length     Maximum length of a valid fragment
                              (default: -l, -s values are estimated from paired
                               end data, but are required when using --single)
-t, --threads=INT             Number of threads to use (default: 1)
```


## psirc_query

### Tool Description
Queries for the representation of the specified transcript in the unitig graph

### Metadata
- **Docker Image**: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
- **Homepage**: https://github.com/nictru/psirc
- **Package**: https://anaconda.org/channels/bioconda/packages/psirc/overview
- **Validation**: PASS

### Original Help Text
```text
psirc-quant 1.0
Queries for the represenation of specified transcript in unitig graph

Usage: psirc-quant query [arguments]

Required arguments:
-i, --index=STRING            Filename for the index to be used for
                              pseudoalignment
-T, --transID                 Transcript ID to investigate
-o, --output=STRING           Output file
```


## psirc_h5dump

### Tool Description
Converts HDF5-formatted results to plaintext

### Metadata
- **Docker Image**: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
- **Homepage**: https://github.com/nictru/psirc
- **Package**: https://anaconda.org/channels/bioconda/packages/psirc/overview
- **Validation**: PASS

### Original Help Text
```text
psirc-quant 1.0
Converts HDF5-formatted results to plaintext

Usage:  psirc-quant h5dump [arguments] abundance.h5

Required argument:
-o, --output-dir=STRING       Directory to write output to
```


## psirc_inspect

### Tool Description
Inspects and gives information about an index

### Metadata
- **Docker Image**: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
- **Homepage**: https://github.com/nictru/psirc
- **Package**: https://anaconda.org/channels/bioconda/packages/psirc/overview
- **Validation**: PASS

### Original Help Text
```text
psirc-quant 1.0

Usage: psirc-quant inspect INDEX-file

Optional arguments:
-G, --gfa=STRING        Filename for GFA output of T-DBG
-g, --gtf=STRING        Filename for GTF file
-b, --bed=STRING        Filename for BED output (default: index + ".bed")
```


## psirc_create_custom_transcriptome_fa.pl

### Tool Description
Create a custom transcriptome FASTA from a reference genome FASTA and an annotation GTF

### Metadata
- **Docker Image**: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
- **Homepage**: https://github.com/nictru/psirc
- **Package**: https://anaconda.org/channels/bioconda/packages/psirc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: create_custom_transcriptome_fa.pl <reference genome fasta file> <annotation gtf file> <custom_transcriptome_fa output fasta file name>
```

