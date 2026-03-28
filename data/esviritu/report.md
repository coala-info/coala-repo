# esviritu CWL Generation Report

## esviritu_EsViritu

### Tool Description
EsViritu is a read mapping pipeline for detection and measurement of human, animal, and plat virus pathogens from short read libraries. It is useful for clinical and environmental samples. Version 1.1.6

### Metadata
- **Docker Image**: quay.io/biocontainers/esviritu:1.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/cmmr/EsViritu
- **Package**: https://anaconda.org/channels/bioconda/packages/esviritu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/esviritu/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/cmmr/EsViritu
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python3.13/site-packages/EsViritu
usage: EsViritu [-h] -r READS [READS ...] -s SAMPLE -o OUTPUT_DIR [--version]
                [-t CPU] [-q QUAL] [-f FILTER_SEQS] [--filter_dir FILTER_DIR]
                [--temp TEMP_DIR] [--keep KEEP] [-p READ_FMT] [--db DB]
                [-wd C_WORKDIR] [-mmK MMK] [--species-threshold SPTHRESH]
                [--subspecies-threshold SUBSPTHRESH] [--dedup DEDUP]

EsViritu is a read mapping pipeline for detection and measurement of human,
animal, and plat virus pathogens from short read libraries. It is useful for
clinical and environmental samples. Version 1.1.6

options:
  -h, --help            show this help message and exit

 REQUIRED ARGUMENTS for EsViritu :
  -r, --reads READS [READS ...]
                        read file(s) in .fastq format. You can specify more
                        than one separated by a space
  -s, --sample SAMPLE   Sample name. No space characters, please.
  -o, --output_dir OUTPUT_DIR
                        Output directory name (not a path). Will be created if
                        it does not exist. Can be shared with other samples.
                        No space characters, please. See also
                        --working_directory to create at another path.

 OPTIONAL ARGUMENTS for EsViritu.:
  --version             show program's version number and exit
  -t, --cpu CPU         Example: 32 -- Number of CPUs available for EsViritu.
                        Default = all available CPUs
  -q, --qual QUAL       True or False. Remove low-quality reads with fastp?
  -f, --filter_seqs FILTER_SEQS
                        True or False. Remove reads aligning to sequences at
                        filter_seqs/filter_seqs.fna ?
  --filter_dir FILTER_DIR
                        path to directory of sequences to filter. If not set,
                        EsViritu looks for environmental variable
                        ESVIRITU_FILTER. Then, if this variable is unset, it
                        this is unset, DB path is assumed to be
                        /usr/local/lib/python3.13/site-packages/EsViritu
  --temp TEMP_DIR       path of temporary directory. Default is
                        {OUTPUT_DIR}/{SAMPLE}_temp/
  --keep KEEP           True of False. Keep the intermediate files located in
                        the temporary directory? These can add up, so it is
                        not recommended if space is a concern.
  -p, --read_format READ_FMT
                        unpaired or paired. Format of input reads. If paired,
                        must provide 2 files (R1, then R2) after -r argument.
  --db DB               path to sequence database. If not set, EsViritu looks
                        for environmental variable ESVIRITU_DB. Then, if this
                        variable is unset, it this is unset, DB path is
                        assumed to be /usr/local/lib/python3.13/site-
                        packages/EsViritu
  -wd, --working_directory C_WORKDIR
                        Default: / -- Set working directory with absolute or
                        relative path. Run directory will be created within.
  -mmK, --minimap2-K MMK
                        Default: 500M -- minimap2 K parameter for Number of
                        bases loaded into memory to process in a mini-batch.
                        Reducing this value lowers memory consumption
  --species-threshold SPTHRESH
                        Default: 0.90 -- minimum ANI of reads to reference to
                        classify record at species level. There is no perfect
                        metric for this.
  --subspecies-threshold SUBSPTHRESH
                        Default: 0.95 -- minimum ANI of reads to reference to
                        classify record at subspecies level. There is no
                        perfect metric for this.
  --dedup DEDUP         True or False. Remove PCR duplicates during fastp
                        preprocessing? This can reduce processing time and
                        provide more accurate abundance estimates.
```


## esviritu_summarize_esv_runs

### Tool Description
Summarize EsViritu run outputs across a directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/esviritu:1.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/cmmr/EsViritu
- **Package**: https://anaconda.org/channels/bioconda/packages/esviritu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: summarize_esv_runs [-h] [--outdir OUTDIR] directory

Summarize EsViritu run outputs across a directory.

positional arguments:
  directory        Directory containing EsViritu .tsv outputs

options:
  -h, --help       show this help message and exit
  --outdir OUTDIR  Directory to save output files (default: current working
                   directory)
```


## Metadata
- **Skill**: generated
