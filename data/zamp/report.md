# zamp CWL Generation Report

## zamp_db

### Tool Description
Prepare database files for zAMP

### Metadata
- **Docker Image**: quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/metagenlab/zAMP/
- **Package**: https://anaconda.org/channels/bioconda/packages/zamp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zamp/overview
- **Total Downloads**: 334
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/metagenlab/zAMP
- **Stars**: N/A
### Original Help Text
```text
Usage: zamp db [OPTIONS] [SNAKE_ARGS]...

  Prepare database files for zAMP

Options:
  --fasta PATH                    Path to database fasta file  [required]
  --taxonomy PATH                 Path to tab seperated taxonomy file in QIIME
                                  format  [required]
  --amplicon [16S|ITS]            Choose 16S or ITS for primer trimming
                                  [default: 16S]
  --name TEXT                     Comma seperated list of database names
                                  [required]
  --processing / --no-processing  Extract amplicon regions and merge taxonomy
                                  [default: processing]
  --tax-collapse TEXT             Dictionary of number of ranks to print limit
                                  when collapsing names   [default:
                                  {"Species": 5, "Genus": 6}]
  --fw-primer TEXT                Forward primer sequence to extract amplicon
                                  [required]
  --rv-primer TEXT                Reverse primer sequence to extract amplicon
                                  [required]
  --minlen INTEGER                Minimum amplicon length  [default: 300]
  --maxlen INTEGER                Maximum amplicon length  [default: 500]
  --ampcov FLOAT                  Minimum amplicon coverage  [default: 0.9]
  --errors FLOAT                  Maximum number of accepted primer
                                  mismatches, or float between 0 and 1
                                  [default: 0.1]
  --rdp-mem TEXT                  Maximum RAM for RDP training  [default: 30g]
  --classifier [rdp|qiimerdp|dada2rdp|decipher]
                                  Which classifiers to train on the database
                                  [default: rdp, qiimerdp, dada2rdp]
  -o, --output PATH               Output directory  [default: zamp_out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --use-singularity / --no-use-singularity
                                  Use singularity containers for Snakemake
                                  rules  [default: use-singularity]
  --singularity-prefix PATH       Custom singularity container directory
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default: no-
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args
  -h, --help                      Show this message and exit.
```


## zamp_run

### Tool Description
Run zAMP

### Metadata
- **Docker Image**: quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/metagenlab/zAMP/
- **Package**: https://anaconda.org/channels/bioconda/packages/zamp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: zamp run [OPTIONS] [SNAKE_ARGS]...

  Run zAMP

Options:
  -i, --input PATH                Input file/directory for fastq path
                                  [required]
  --local / --sra                 Whether reads are local or to be downloaded
                                  from NCBI SRA  [default: local]
  -m, --metadata PATH             Path to tab seperated metadata file
  -db, --database PATH            Path to Database directory  [required]
  --name TEXT                     Comma seperated list of database names
  --denoiser [DADA2|vsearch]      Choose dada2 or vsearch for denoising reads
                                  [default: DADA2]
  --classifier [RDP|qiimerdp|dada2rdp|decipher]
                                  Which classifiers to use for taxonomic
                                  assignment  [default: RDP]
  --trim / --no-trim              Trim primers or not  [default: trim]
  --amplicon [16S|ITS]            Choose 16S or ITS for primer trimming
                                  [default: 16S]
  --min-overlap INTEGER           Minimum R1 and R2 overlap for reads merging
                                  [default: 10]
  --fw-primer TEXT                Forward primer sequence to extract amplicon
                                  from reads  [required]
  --rv-primer TEXT                Reverse primer sequence to extract amplicon
                                  from reads  [required]
  --minlen INTEGER                Minimum read length for merged reads
                                  [default: 390]
  --maxlen INTEGER                Maximum read length for merged reads
                                  [default: 480]
  --fw-trim INTEGER               Minimum read length to trim low quality ends
                                  of R1 for DADA2 denoising  [default: 280]
  --rv-trim INTEGER               Minimum read length to trim low quality ends
                                  of R2 for DADA2 denoising  [default: 255]
  --fw-errors INTEGER             Maximum expected errors in R1 for DADA2
                                  denoising  [default: 10]
  --rv-errors INTEGER             Maximum expected errors in R2 for DADA2
                                  denoising  [default: 10]
  --rarefaction TEXT              Comma seperated list of number of reads for
                                  rarefaction  [default: 50000]
  --min-prev FLOAT                Proporition (in %) of samples in which the
                                  feature has to be found to be kept
                                  [default: 0]
  --min-count INTEGER             Minimal reads to be kept  [default: 0]
  --normalization TEXT            Comma seperated list of values for counts
                                  normalization  [default: NONE]
  --replace-empty / --no-replace-empty
                                  Replace empty taxa by placeholders
                                  [default: no-replace-empty]
  --keep-rank [Kingdom|Phylum|Class|Order|Family|Genus|Species]
                                  Rank to keep taxon  [default: Kingdom]
  --keep-taxa TEXT                Comma seperated list of taxa to keep
                                  [default: Bacteria]
  --exclude-rank TEXT             Comma seperated list of ranks to exclude
                                  [default: Phylum]
  --exclude-taxa TEXT             Comma seperated list of taxa to exclude
                                  [default: Bacteria_phy]
  --melted / --no-melted          Generate melted phyloseq table  [default:
                                  no-melted]
  --physeq-rank TEXT              Comma seperated list of ranks to collapse on
                                  in phyloseq output  [default: OTU]
  --transposed / --no-transposed  Transposed count table  [default: no-
                                  transposed]
  --qiime-viz BOOLEAN             Output QIIME visualisation  [default: True]
  -o, --output PATH               Output directory  [default: zamp_out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --use-singularity / --no-use-singularity
                                  Use singularity containers for Snakemake
                                  rules  [default: use-singularity]
  --singularity-prefix PATH       Custom singularity container directory
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default: no-
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args
  -h, --help                      Show this message and exit.
```


## zamp_insilico

### Tool Description
Run the in-silico module for zAMP

### Metadata
- **Docker Image**: quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/metagenlab/zAMP/
- **Package**: https://anaconda.org/channels/bioconda/packages/zamp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: zamp insilico [OPTIONS] [SNAKE_ARGS]...

  Run the in-silico module for zAMP

Options:
  -i, --input-tax TEXT            Input taxa/accessions for in-silico
                                  validation  [required]
  --taxon / --accession           Are queries taxa or accessions  [default:
                                  taxon]
  -nb, --limit TEXT               Limit number of genomes per query
  --assembly TEXT                 Comma seperated list of assembly level:
                                  complete,chromosome,scaffold,contig
  --only-ref / --not-only-ref     Limit to reference and representative
                                  genomes  [default: only-ref]
  --rank [superkingdom|phylum|class|order|family|genus|species]
                                  taxonomic rank to filter by assemblies
  --nrank INTEGER                 Number of genomes per taxonomic rank
  -db, --database PATH            Path to Database directory  [required]
  --name TEXT                     Comma seperated list of database names
  --pcr-tool [simulate|in-silico]
                                  Tool for in silico PCR  [default: in-silico]
  --amplicon [16S|ITS]            Choose 16S or ITS for primer trimming
                                  [default: 16S]
  --af-args TEXT                  Assembly_finder arguments
  --mismatch INTEGER              Number of mismatches for simulate_PCR
                                  [default: 3]
  --threeprime INTEGER            Number of match at the 3' end for a hit to
                                  be considered for simulate_PCR  [default: 2]
  --fw-primer TEXT                Forward primer sequence to extract amplicon
                                  from reads  [required]
  --rv-primer TEXT                Reverse primer sequence to extract amplicon
                                  from reads  [required]
  --minlen INTEGER                Minimum amplicon length  [default: 300]
  --maxlen INTEGER                Maximum amplicon length  [default: 500]
  --ampcov FLOAT                  Minimum amplicon coverage  [default: 0.9]
  --errors FLOAT                  Maximum number of accepted primer
                                  mismatches, or float between 0 and 1
                                  [default: 0.1]
  --classifier [RDP|qiimerdp|dada2rdp|decipher]
                                  Which classifiers to use for taxonomic
                                  assignment  [default: RDP]
  --denoiser [DADA2|vsearch]      Choose dada2 or vsearch for denoising reads
                                  [default: DADA2]
  --replace-empty / --no-replace-empty
                                  Replace empty taxa by placeholders
                                  [default: no-replace-empty]
  -o, --output PATH               Output directory  [default: zamp_out]
  --configfile TEXT               Custom config file [default:
                                  (outputDir)/config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --use-singularity / --no-use-singularity
                                  Use singularity containers for Snakemake
                                  rules  [default: use-singularity]
  --singularity-prefix PATH       Custom singularity container directory
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default: no-
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args
  -h, --help                      Show this message and exit.
```


## zamp_citation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/metagenlab/zAMP/
- **Package**: https://anaconda.org/channels/bioconda/packages/zamp/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Please consider also citing Snaketool:
https://doi.org/10.1371/journal.pcbi.1010705

and Snakemake:
https://doi.org/10.12688/f1000research.29032.1
```


## Metadata
- **Skill**: generated
