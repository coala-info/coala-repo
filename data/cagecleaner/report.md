# cagecleaner CWL Generation Report

## cagecleaner

### Tool Description
CAGEcleaner: A tool to remove redundancy from cblaster hits. CAGEcleaner reduces redundancy in cblaster hit sets by dereplicating the genomes containing the hits. It can also recover hits that would have been omitted by this dereplication if they have a different gene cluster content or an outlier cblaster score.

### Metadata
- **Docker Image**: quay.io/biocontainers/cagecleaner:1.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/LucoDevro/CAGEcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/cagecleaner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cagecleaner/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/LucoDevro/CAGEcleaner
- **Stars**: N/A
### Original Help Text
```text
usage: cagecleaner [-c CORES] [-v] [-h] [--verbose] -s SESSION_FILE
                   [-g GENOME_DIR] [-o OUTPUT_DIR] [-t TEMP_DIR]
                   [--keep_downloads] [--keep_dereplication]
                   [--keep_intermediate] [-bys BYPASS_SCAFFOLDS]
                   [-byo BYPASS_ORGANISMS] [-exs EXCLUDED_SCAFFOLDS]
                   [-exo EXCLUDED_ORGANISMS] [--download_batch DOWNLOAD_BATCH]
                   [-a ANI] [--low_mem] [--no_recovery_content]
                   [--no_recovery_score]
                   [--min_z_score ZSCORE_OUTLIER_THRESHOLD]
                   [--min_score_diff MINIMAL_SCORE_DIFFERENCE]

                CAGEcleaner: A tool to remove redundancy from cblaster hits.
   
                CAGEcleaner reduces redundancy in cblaster hit sets by dereplicating the genomes containing the hits. 
                It can also recover hits that would have been omitted by this dereplication if they have a different gene cluster content
                or an outlier cblaster score.
                

General:
  -c CORES, --cores CORES
                        Number of cores to use (default: 1)
  -v, --version         show program's version number and exit
  -h, --help            Show this help message and exit
  --verbose             Enable verbose logging

File inputs and outputs:
  -s SESSION_FILE, --session SESSION_FILE
                        Path to cblaster session file
  -g GENOME_DIR, --genomes GENOME_DIR
                        [Only relevant for local cblaster sessions] Path to
                        local genome folder containing genome files. Accepted
                        formats are FASTA and GenBank [.fasta; .fna; .fa;
                        .gbff; .gbk; .gb]. Files can be gzipped. Folder can
                        contain other files. (default: current working
                        directory)
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Output directory (default: current working directory)
  -t TEMP_DIR, --temp TEMP_DIR
                        Path to store temporary files (default: your system's
                        default temporary directory).
  --keep_downloads      Keep downloaded genomes
  --keep_dereplication  Keep skDER output
  --keep_intermediate   Keep all intermediate data. This overrules other keep
                        flags.

Analysis inputs and outputs:
  For local cblaster sessions, duplicate scaffold IDs can be further specified using the following format: <organism_ID>:<scaffold_ID>. Discard any file extension.

  -bys BYPASS_SCAFFOLDS, --bypass_scaffolds BYPASS_SCAFFOLDS
                        Scaffold IDs in the binary table that should bypass
                        dereplication (comma-separated). These will end up in
                        the final output in any case.
  -byo BYPASS_ORGANISMS, --bypass_organisms BYPASS_ORGANISMS
                        Organisms in the binary table that should bypass
                        dereplication (comma-separated). These will end up in
                        the final output in any case.
  -exs EXCLUDED_SCAFFOLDS, --exclude_scaffolds EXCLUDED_SCAFFOLDS
                        Scaffolds IDs in the binary table to be excluded from
                        the hit set (comma-separated).
  -exo EXCLUDED_ORGANISMS, --exclude_organisms EXCLUDED_ORGANISMS
                        Organisms in the binary table to be excluded from the
                        hit set (comma-seperated).

Download:
  --download_batch DOWNLOAD_BATCH
                        Number of genomes to download in one batch (default:
                        300)

Dereplication:
  -a ANI, --ani ANI     ANI dereplication threshold (default: 99.0)
  --low_mem             Use skDER's low-memory mode. Lowers memory
                        requirements substantially at the cost of a slightly
                        lower representative quality.

Hit recovery:
  --no_recovery_content
                        Skip recovering hits by cluster content (default:
                        False)
  --no_recovery_score   Skip recovering hits by outlier scores (default:
                        False)
  --min_z_score ZSCORE_OUTLIER_THRESHOLD
                        z-score threshold to consider hits outliers (default:
                        2.0)
  --min_score_diff MINIMAL_SCORE_DIFFERENCE
                        minimum cblaster score difference between hits to be
                        considered different. Discards outlier hits with a
                        score difference below this threshold. (default: 0.1)

                Lucas De Vrieze, Miguel Biltjes
                (c) 2025 Masschelein lab, VIB
```


## Metadata
- **Skill**: generated
