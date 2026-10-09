# kallisto CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kallisto_bus | PASS |  |
| kallisto_h5dump | PASS |  |
| kallisto_index | PASS |  |
| kallisto_inspect | PASS |  |
| kallisto_quant | PASS |  |
| kallisto_quant-tcc | PASS | input TCC matrix made with bustools from the real bus output (identity transcript-to-gene map) |

## kallisto_index

### Tool Description
Builds a kallisto index

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Total Downloads**: 287.8K
- **Last updated**: 2026-03-21
- **GitHub**: https://github.com/pachterlab/kallisto
- **Stars**: N/A
### Original Help Text
```text
kallisto 0.52.0
Builds a kallisto index

Usage: kallisto index [arguments] FASTA-files

Required argument:
-i, --index=STRING          Filename for the kallisto index to be constructed 

Optional argument:
-k, --kmer-size=INT         k-mer (odd) length (default: 31, max value: 63)
-t, --threads=INT           Number of threads to use (default: 1)
-d, --d-list=STRING         Path to a FASTA-file containing sequences to mask from quantification
    --make-unique           Replace repeated target names with unique names
    --aa                    Generate index from a FASTA-file containing amino acid sequences
    --distinguish           Generate index where sequences are distinguished by the sequence name
-T, --tmp=STRING            Temporary directory (default: tmp)
-m, --min-size=INT          Length of minimizers (default: automatically chosen)
-e, --ec-max-size=INT       Maximum number of targets in an equivalence class (default: no maximum)
```

## kallisto_quant

### Tool Description
Computes equivalence classes for reads and quantifies abundances

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0
Computes equivalence classes for reads and quantifies abundances

Usage: kallisto quant [arguments] FASTQ-files

Required arguments:
-i, --index=STRING            Filename for the kallisto index to be used for
                              quantification
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
-b, --bootstrap-samples=INT   Number of bootstrap samples (default: 0)
    --seed=INT                Seed for the bootstrap sampling (default: 42)
    --plaintext               Output plaintext instead of HDF5
    --single                  Quantify single-end reads
    --single-overhang         Include reads where unobserved rest of fragment is
                              predicted to lie outside a transcript
    --fr-stranded             Strand specific reads, first read forward
    --rf-stranded             Strand specific reads, first read reverse
-l, --fragment-length=DOUBLE  Estimated average fragment length
-s, --sd=DOUBLE               Estimated standard deviation of fragment length
                              (default: -l, -s values are estimated from paired
                               end data, but are required when using --single)
-p, --priors                  Priors for the EM algorithm, either as raw counts or as
                              probabilities. Pseudocounts are added to raw reads to
                              prevent zero valued priors. Supplied in the same order
                              as the transcripts in the transcriptome
    --pseudobam               Save pseudoalignments to transcriptome to BAM file
    --genomebam               Project pseudoalignments to genome sorted BAM file
-g, --gtf                     GTF file for transcriptome information
                              (required for --genomebam)
-c, --chromosomes             Tab separated file with chromosome names and lengths
                              (optional for --genomebam, but recommended)
-t, --threads=INT             Number of threads to use (default: 1)
    --verbose                 Print out progress information every 1M proccessed reads
```

## kallisto_quant-tcc

### Tool Description
Quantifies abundance from pre-computed transcript-compatibility counts

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0
Quantifies abundance from pre-computed transcript-compatibility counts

Usage: kallisto quant-tcc [arguments] transcript-compatibility-counts-file

Required arguments:
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
-i, --index=STRING            Filename for the kallisto index to be used
                              (required if file with names of transcripts not supplied)
-T, --txnames=STRING          File with names of transcripts
                              (required if index file not supplied)
-e, --ec-file=FILE            File containing equivalence classes
                              (default: equivalence classes are taken from the index)
-f, --fragment-file=FILE      File containing fragment length distribution
                              (default: effective length normalization is not performed)
--long                        Use version of EM for long reads 
-P, --platform.               [PacBio or ONT] used for sequencing 
-l, --fragment-length=DOUBLE  Estimated average fragment length
-s, --sd=DOUBLE               Estimated standard deviation of fragment length
                              (note: -l, -s values only should be supplied when
                               effective length normalization needs to be performed
                               but --fragment-file is not specified)
-p, --priors                  Priors for the EM algorithm, either as raw counts or as
                              probabilities. Pseudocounts are added to raw reads to
                              prevent zero valued priors. Supplied in the same order
                              as the transcripts in the transcriptome
-t, --threads=INT             Number of threads to use (default: 1)
-g, --genemap                 File for mapping transcripts to genes
                              (required for obtaining gene-level abundances)
-G, --gtf=FILE                GTF file for transcriptome information
                              (can be used instead of --genemap for obtaining gene-level abundances)
-b, --bootstrap-samples=INT   Number of bootstrap samples (default: 0)
    --matrix-to-files         Reorganize matrix output into abundance tsv files
    --matrix-to-directories   Reorganize matrix output into abundance tsv files across multiple directories
    --seed=INT                Seed for the bootstrap sampling (default: 42)
    --plaintext               Output plaintext only, not HDF5
```

## kallisto_bus

### Tool Description
Generates BUS files for single-cell sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0
Generates BUS files for single-cell sequencing

Usage: kallisto bus [arguments] FASTQ-files

Required arguments:
-i, --index=STRING            Filename for the kallisto index to be used for
                              pseudoalignment
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
-x, --technology=STRING       Single-cell technology used 
-l, --list                    List all single-cell technologies supported
-B, --batch=FILE              Process files listed in FILE
-t, --threads=INT             Number of threads to use (default: 1)
-b, --bam                     Input file is a BAM file
-n, --num                     Output number of read in flag column (incompatible with --bam)
-N, --numReads                Maximum number of reads to process from supplied input
-T, --tag=STRING              5′ tag sequence to identify UMI reads for certain technologies
    --fr-stranded             Strand specific reads for UMI-tagged reads, first read forward
    --rf-stranded             Strand specific reads for UMI-tagged reads, first read reverse
    --unstranded              Treat all read as non-strand-specific
    --paired                  Treat reads as paired
    --long                    Treat reads as long
    --threshold               Threshold for rate of unmapped kmers per read
    --aa                      Align to index generated from a FASTA-file containing amino acid sequences
    --inleaved                Specifies that input is an interleaved FASTQ file
    --batch-barcodes          Records both batch and extracted barcode in BUS file
    --genomebam               Project pseudoalignments to genome sorted BAM file
-g, --gtf                     GTF file for transcriptome information
                              (required for --genomebam)
-c, --chromosomes             Tab separated file with chromosome names and lengths
                              (optional for --genomebam, but recommended)
    --verbose                 Print out progress information every 1M proccessed reads
```

## kallisto_inspect

### Tool Description
Inspect a kallisto index file

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0

Usage: kallisto inspect INDEX-file

Optional arguments:
-t                      Number of threads
```

## kallisto_h5dump

### Tool Description
Converts HDF5-formatted results (abundance.h5) to plaintext.

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0
Converts HDF5-formatted results to plaintext

Usage:  kallisto h5dump [arguments] abundance.h5

Required argument:
-o, --output-dir=STRING       Directory to write output to
```

