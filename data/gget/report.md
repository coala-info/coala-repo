# gget CWL Generation Report

## gget_ref

### Tool Description
Fetch FTPs for reference genomes and annotations by species.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Total Downloads**: 50.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pachterlab/gget
- **Stars**: N/A
### Original Help Text
```text
usage: gget ref [-h] [-l] [-liv] [-w WHICH] [-r RELEASE] [-ftp] [-d]
                [-od OUT_DIR] [-o OUT] [-q] [-s SPECIES_DEPRECATED]
                [species]

Fetch FTPs for reference genomes and annotations by species.

positional arguments:
  species               Species or database to be searched. Species should be passed in the format 'genus_species', e.g. 'homo_sapiens'.
                        Supported shortcuts: 'human', 'mouse', 'human_grch37' (accesses the GRCh37 genome assembly)

optional arguments:
  -h, --help            show this help message and exit
  -l, --list_species    List all available vertebrate species from the Ensembl database.
                        (Combine with `--release` to get the available species from a specific Ensembl release.)
  -liv, --list_iv_species
                        List all available invertebrate species from the Ensembl database.
                        (Combine with `--release` to get the available species from a specific Ensembl release.)
  -w WHICH, --which WHICH
                        Defines which results to return.
                        Default: 'all' -> Returns all available results.
                        Possible entries are one or a combination (as a comma-separated list) of the following:
                        'gtf' - Returns the annotation (GTF).
                        'cdna' - Returns the trancriptome (cDNA).
                        'dna' - Returns the genome (DNA).
                        'cds - Returns the coding sequences corresponding to Ensembl genes. (Does not contain UTR or intronic sequence.)
                        'cdrna' - Returns transcript sequences corresponding to non-coding RNA genes (ncRNA).
                        'pep' - Returns the protein translations of Ensembl genes.
                        Example: '-w dna,gtf' (default: all)
  -r RELEASE, --release RELEASE
                        Ensembl release the FTPs will be fetched from, e.g. 104 (default: latest Ensembl release).
  -ftp, --ftp           Return only the FTP link(s).
  -d, --download        Download FTPs to the directory specified by --out_dir using curl.
  -od OUT_DIR, --out_dir OUT_DIR
                        Path to the directory the FTPs will be saved in, e.g. path/to/directory.
                        Default: Current working directory.
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -q, --quiet           Does not print progress information.
  -s SPECIES_DEPRECATED, --species SPECIES_DEPRECATED
                        DEPRECATED - use positional argument instead. Species for which the FTPs will be fetched, e.g. homo_sapiens.
```


## gget_search

### Tool Description
Fetch gene and transcript IDs from Ensembl using free-form search terms.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget search [-h] -s SPECIES [-r RELEASE] [-t {gene,transcript}]
                   [-ao {and,or}] [-l LIMIT] [-csv] [-o OUT] [-q]
                   [-sw [SW_DEPRECATED ...]] [--seqtype SEQTYPE] [-j]
                   searchwords [searchwords ...]

Fetch gene and transcript IDs from Ensembl using free-form search terms.

positional arguments:
  searchwords           One or more free form search words, e.g. gaba, nmda.

optional arguments:
  -h, --help            show this help message and exit
  -s SPECIES, --species SPECIES
                        Species or database to be queried, e.g. 'homo_sapiens' or 'arabidopsis_thaliana'.
                        To pass a specific database, pass the name of the CORE database, e.g. 'mus_musculus_dba2j_core_105_1'.
                        All available core databases can be found here:
                        Vertebrates: http://ftp.ensembl.org/pub/current/mysql/
                        Invertebrates: http://ftp.ensemblgenomes.org/pub/current/ + kingdom + mysql/
                        Supported shortcuts: 'human', 'mouse'.
  -r RELEASE, --release RELEASE
                        Defines the Ensembl release number from which the files are fetched, e.g. 104.
                        Note: Does not apply to invertebrate species (you can pass a specific core database (which include a release number) to the species argument instead).
                        This argument is overwritten if a specific database (which includes a release number) is passed to the species argument.
                        Default: None -> latest Ensembl release is used.
  -t {gene,transcript}, --id_type {gene,transcript}
                        'gene': Returns genes that match the searchwords. (default).
                        'transcript': Returns transcripts that match the searchwords. (default: gene)
  -ao {and,or}, --andor {and,or}
                        'or': Gene descriptions must include at least one of the searchwords (default).
                        'and': Only return genes whose descriptions include all searchwords. (default: or)
  -l LIMIT, --limit LIMIT
                        Limits the number of results, e.g. 10 (default: None).
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -q, --quiet           Does not print progress information.
  -sw [SW_DEPRECATED ...], --searchwords [SW_DEPRECATED ...]
                        DEPRECATED - use positional argument instead. One or more free form search words, e.g. gaba, nmda.
  --seqtype SEQTYPE     DEPRECATED - use argument 'id_type' instead.
  -j, --json            DEPRECATED - json is now the default output format (convert to csv using flag [--csv]).
```

