# desman CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| desman | Failed | image problem: desman calls DataFrame.as_matrix, which the bundled pandas 2.2.3 no longer has, so every run crashes. |
| desman_CalcGeneCov.py | Failed | image problem: the script calls DataFrame.as_matrix, which the bundled pandas 2.2.3 no longer has, so it crashes on the DESMAN example COG0015.freq. |
| desman_ClassifyContigNR.py | Not completed | needs BLAST matches against NCBI NR plus multi-GB accession-to-taxid and lineage files. |
| desman_ExtractCogs.py | Not completed | needs RPS-BLAST output against the NCBI COG (CDD) database, which is not available here. |
| desman_ExtractCountFreqGenes.py | Failed | image problem: the script uses np.int, which the bundled numpy 2.0.2 no longer has, so it crashes on real SARS-CoV-2 bam-readcount files. |
| desman_ExtractGenes.py | PASS |  |
| desman_LengthFilter.py | PASS |  |
| desman_Lengths.py | PASS |  |
| desman_Variant_Filter.py | Failed | image problem: the script calls DataFrame.as_matrix, which the bundled pandas 2.2.3 no longer has, so it crashes on the DESMAN example COG0015.freq. |
| desman_contig_read_count_per_genome.py | PASS | synthetic data: real SARS-CoV-2 BAMs with read names relabelled to carry the source genome name; counts 300 reads = 200 + 100 aligned. |
| desman_extract_species_contigs.py | PASS |  |
| desman_gene_read_count_per_genome.py | PASS | synthetic data: real SARS-CoV-2 BAMs with read names relabelled to carry the source genome name; per-gene counts follow the GFF CDS coordinates. |
| desman_pileups_to_freq_table.py | PASS |  |

## desman

### Tool Description
DESMAN (Diploid Evolutionary Signature Model ANalysis) is a tool for inferring haplotype frequencies from SNP data.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: desman [-h] -g GENOMES [-f [FILTER_VARIANTS]] [-r [RANDOM_SELECT]]
              [-e ETA_FILE] [-a ASSIGN_FILE] [-o OUTPUT_DIR] [-p OPTIMISEP]
              [-i [NO_ITER]] [-m MIN_COVERAGE] [-q MAX_QVALUE]
              [-s RANDOM_SEED] [-v [MIN_VARIANT_FREQ]]
              variant_file

positional arguments:
  variant_file          input SNP frequencies

optional arguments:
  -h, --help            show this help message and exit
  -g GENOMES, --genomes GENOMES
                        specify the haplotype number
  -f [FILTER_VARIANTS], --filter_variants [FILTER_VARIANTS]
                        filters variants by negative binomial loge likelihood
                        defaults to 3.84
  -r [RANDOM_SELECT], --random_select [RANDOM_SELECT]
                        selects subset of variants passing filter to build
                        model and assigns others
  -e ETA_FILE, --eta_file ETA_FILE
                        reads initial eta matrix from file
  -a ASSIGN_FILE, --assign_file ASSIGN_FILE
                        calculates haplotype profiles for these SNPs using
                        fitted gamma, eta values
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        string specifying output directory and file stubs
  -p OPTIMISEP, --optimiseP OPTIMISEP
                        optimise proportions in likelihood ratio test
  -i [NO_ITER], --no_iter [NO_ITER]
                        Number of iterations of Gibbs sampler
  -m MIN_COVERAGE, --min_coverage MIN_COVERAGE
                        minimum coverage for sample to be included
  -q MAX_QVALUE, --max_qvalue MAX_QVALUE
                        specifies q value cut-off for variant detection
                        defaults 1.0e-3
  -s RANDOM_SEED, --random_seed RANDOM_SEED
                        specifies seed for numpy random number generator
                        defaults to 23724839 applied after random filtering
  -v [MIN_VARIANT_FREQ], --min_variant_freq [MIN_VARIANT_FREQ]
                        specifies minimum variant frequency defaults 0.01
```


## desman_Variant_Filter.py

### Tool Description
Filter variant positions in a DESMAN base frequency table with a binomial / likelihood-ratio test.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: Variant_Filter.py [-h] [-f [FILTER_VARIANTS]] [-q [MAX_QVALUE]]
                         [-v [MIN_VARIANT_FREQ]] [-m MIN_COVERAGE]
                         [-t OUTLIER_THRESH] [-sf SAMPLE_FRAC]
                         [-o OUTPUT_STUB] [-p] [-c] [-s RANDOM_SEED]
                         variant_file

positional arguments:
  variant_file          input SNP frequencies

optional arguments:
  -h, --help            show this help message and exit
  -f [FILTER_VARIANTS], --filter_variants [FILTER_VARIANTS]
                        binomial loge likelihood species p-value threshold for
                        initial filtering as chi2
  -q [MAX_QVALUE], --max_qvalue [MAX_QVALUE]
                        specifies q value cut-off for variant defaults 1.0e-3
  -v [MIN_VARIANT_FREQ], --min_variant_freq [MIN_VARIANT_FREQ]
                        specifies minimum variant frequency defaults 0.01
  -m MIN_COVERAGE, --min_coverage MIN_COVERAGE
                        minimum coverage for sample to be included defaults
                        5.0
  -t OUTLIER_THRESH, --outlier_thresh OUTLIER_THRESH
                        threshold for COG filtering on median coverage outlier
                        defaults to 2.0
  -sf SAMPLE_FRAC, --sample_frac SAMPLE_FRAC
                        fraction of samples with COG coverage exceeding median
                        outlier for removal
  -o OUTPUT_STUB, --output_stub OUTPUT_STUB
                        string specifying file stubs
  -p, --optimiseP       optimise proportions in likelihood ratio test default
                        false
  -c, --cog_filter      whether to apply COG filtering default false
  -s RANDOM_SEED, --random_seed RANDOM_SEED
                        specifies seed for numpy random number generator
                        defaults to 23724839
```

## desman_CalcGeneCov.py

### Tool Description
Calculate the mean coverage of each gene in each sample from a gene base frequency table.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: CalcGeneCov.py [-h] gene_freq_file

positional arguments:
  gene_freq_file  input gene base frequencies

optional arguments:
  -h, --help      show this help message and exit
```

## desman_ExtractCountFreqGenes.py

### Tool Description
Build a base frequency table for listed genes or COGs from per-sample bam-readcount files (*.cnt.gz).

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: ExtractCountFreqGenes.py [-h] [--output_file OUTPUT_FILE] [-g]
                                cog_file input_dir

positional arguments:
  cog_file              cogs and contig locations for frequencies to be called
                        on
  input_dir             input directory to glob *.cnt.gz from

optional arguments:
  -h, --help            show this help message and exit
  --output_file OUTPUT_FILE
  -g, --gene_file       alternate input format
```

## desman_pileups_to_freq_table.py

### Tool Description
Convert per-sample samtools mpileup files into a DESMAN variant frequency table.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
(The script has no help option; this is what it prints with no arguments.)
Error: need at least two pileup files as input


Usage (from the script source): pileups_to_freq_table.py <contigs.fa> <sample1.pileup> <sample2.pileup> [...] <output.csv>
```

## desman_Lengths.py

### Tool Description
Print the identifier and length of each FASTA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
Usage: Lengths.py [options]

Options:
  -h, --help            show this help message and exit
  -i FILE, --inputfile=FILE
                        fasta file
```

## desman_LengthFilter.py

### Tool Description
Keep FASTA sequences longer than a minimum length.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: LengthFilter.py [-h] [-m MINLENGTH] FILE

positional arguments:
  FILE                  fasta file

optional arguments:
  -h, --help            show this help message and exit
  -m MINLENGTH, --minlength MINLENGTH
                        minimum coverage for sample to be included
```

## desman_extract_species_contigs.py

### Tool Description
Print the FASTA records whose identifiers are in a contig list file.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
(The script has no help option; with no arguments it fails with an IndexError on sys.argv.)

Usage (from the script source): extract_species_contigs.py <assembly.fa> <contig_list.txt> > selected.fa
```

## desman_contig_read_count_per_genome.py

### Tool Description
Count reads per contig and source genome over indexed BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: contig_read_count_per_genome.py [-h] [-m MAX_N_PROCESSORS]
                                       contigfa reffa bamfiles [bamfiles ...]

positional arguments:
  contigfa              Contigs fasta file
  reffa                 Reference fasta file
  bamfiles              BAM files with mappings to contigs

optional arguments:
  -h, --help            show this help message and exit
  -m MAX_N_PROCESSORS, --max_n_processors MAX_N_PROCESSORS
                        Specify the maximum number of processors to use, if
                        absent, all present processors will be used.
```

## desman_gene_read_count_per_genome.py

### Tool Description
Count reads per gene and source genome over indexed BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: gene_read_count_per_genome.py [-h] [-m MAX_N_PROCESSORS]
                                     genefile reffa bamfiles [bamfiles ...]

positional arguments:
  genefile              gene positions
  reffa                 Reference fasta file
  bamfiles              BAM files with mappings to contigs

optional arguments:
  -h, --help            show this help message and exit
  -m MAX_N_PROCESSORS, --max_n_processors MAX_N_PROCESSORS
                        Specify the maximum number of processors to use, if
                        absent, all present processors will be used.
```

## desman_ExtractGenes.py

### Tool Description
Write gene positions from a Prodigal or Prokka GFF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: Example usage:

	Step 1: Run PROKKA_XXXXXXXX.faa with rpsblast against the  Cog database
	with following format:
			rpsblast -query PROKKA_XXXXXXXX.faa -db Cog -evalue 0.00001
			-outfmt "6 qseqid sseqid evalue pident score qstart qend
			sstart send length slen" -out blast_output.out

	Step 2: Run this script to generate the table with marker gene abundance per cluster.:
			./COG_table.py -g PROKKA_XXXXXXXX.gff -b blast_output.out -e mail@example.com
			 -c clustering_gt1000.csv -m marker_genes.txt > scg_table.tsv

Refer to rpsblast tutorial: http://www2.warwick.ac.uk/fac/sci/moac/people/students/peter_cock/python/rpsblast/

optional arguments:
  -h, --help            show this help message and exit
  -g GFFFILE, --gfffile GFFFILE
                        GFF file generated by e.g. prodigal only needed if the
                        contig names are not recoverable from the blast output
                        file.
```

## desman_ExtractCogs.py

### Tool Description
Assign COGs to genes from tabular RPS-BLAST output against the COG database.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: ExtractCogs.py [-h] -b BLASTOUTFILE [-s SCOVS_THRESHOLD]
                      [-p PIDENT_THRESHOLD] [--cdd_cog_file CDD_COG_FILE]
                      [-g GFFFILE]

optional arguments:
  -h, --help            show this help message and exit
  -b BLASTOUTFILE, --blastoutfile BLASTOUTFILE
                        Output of rpsblast run, assumed to be in tabular
                        format whith columns: qseqid sseqid evalue pident
                        score qstart qend sstart send length slen. The contigs
                        ids are assumed to be recoverable by removing the last
                        underscore and the characters following it from the
                        qseqid column.
  -s SCOVS_THRESHOLD, --scovs-threshold SCOVS_THRESHOLD
                        Threshold covered in percent, default=50.0
  -p PIDENT_THRESHOLD, --pident-threshold PIDENT_THRESHOLD
                        Threshold identity in percent, default=0.0
  --cdd_cog_file CDD_COG_FILE
                        Supply a cdd to cog mapping file in a tsv format to
                        take precedence over eutils fetching of name. Useful
                        if running this script in parallel, since NCBI eutils
                        has a limit on the number of requests per time unit
                        you can make.
  -g GFFFILE, --gfffile GFFFILE
                        GFF file generated by e.g. prodigal only needed if the
                        contig names are not recoverable from the blast output
                        file.
```

## desman_ClassifyContigNR.py

### Tool Description
Classify genes and contigs taxonomically from BLAST matches against NCBI NR.

### Metadata
- **Docker Image**: quay.io/biocontainers/desman:2.1--py39h4747326_10
- **Homepage**: https://github.com/chrisquince/DESMAN
- **Package**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/desman/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisquince/DESMAN
- **Stars**: N/A
### Original Help Text
```text
usage: ClassifyContigNR.py [-h] [-g GID_TAXAID_MAPPING_FILE]
                           [-a ACC_TAXAID_MAPPING_FILE] [-l LINEAGE_FILE]
                           [-o OUTPUT_DIR]
                           blast_input_file query_length_file

positional arguments:
  blast_input_file      directory with blast 6 matches to taxaid database *.b6
  query_length_file     tab delimited file of query lengths

optional arguments:
  -h, --help            show this help message and exit
  -g GID_TAXAID_MAPPING_FILE, --gid_taxaid_mapping_file GID_TAXAID_MAPPING_FILE
                        mapping from gid to taxaid gzipped
  -a ACC_TAXAID_MAPPING_FILE, --acc_taxaid_mapping_file ACC_TAXAID_MAPPING_FILE
                        mapping from accession to taxaid gzipped
  -l LINEAGE_FILE, --lineage_file LINEAGE_FILE
                        text taxaid to lineage mapping
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        string specifying output directory and file stubs
```
