# gunc CWL Generation Report

## gunc_run

### Tool Description
Run GUNC analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
- **Homepage**: https://github.com/grp-bork/gunc
- **Package**: https://anaconda.org/channels/bioconda/packages/gunc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gunc/overview
- **Total Downloads**: 19.4K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/grp-bork/gunc
- **Stars**: N/A
### Original Help Text
```text
usage: gunc run [-h] [-r ] (-i  | -f  | -d ) [-e ] [-g] [-t ] [-o ]
                [--temp_dir ] [--sensitive] [--detailed_output]
                [--contig_taxonomy_output] [--use_species_level]
                [--min_mapped_genes ] [-v]

options:
  -h, --help            show this help message and exit
  -r, --db_file         DiamondDB reference file. Default: GUNC_DB envvar
  -i, --input_fasta     Input file in FASTA format.
  -f, --input_file      File with paths to FASTA format files.
  -d, --input_dir       Input dir with files in FASTA format.
  -e, --file_suffix     Suffix of files in input_dir. Default: .fa
  -g, --gene_calls      Input files are FASTA faa format. Default: False
  -t, --threads         number of CPU threads. Default: 4
  -o, --out_dir         Output dir. Default: cwd
  --temp_dir            Directory to store temp files. Default: cwd
  --sensitive           Run with high sensitivity. Default: False
  --detailed_output     Output scores for every taxlevel. Default: False
  --contig_taxonomy_output
                        Output assignments for each contig. Default: False
  --use_species_level   Allow species level to be picked as maxCSS. Default:
                        False
  --min_mapped_genes    Dont calculate GUNC score if number of mapped genes is
                        below this value. Default: 11
  -v, --verbose         Verbose output for debugging
```


## gunc_download_db

### Tool Description
Download the GUNC database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
- **Homepage**: https://github.com/grp-bork/gunc
- **Package**: https://anaconda.org/channels/bioconda/packages/gunc/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.14/site-packages/gunc/get_scores.py:9: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import resource_filename
usage: gunc download_db [-h] [-db ] [-v] dest_path
gunc download_db: error: the following arguments are required: dest_path
```


## gunc_merge_checkm

### Tool Description
Merge GUNC and CheckM results

### Metadata
- **Docker Image**: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
- **Homepage**: https://github.com/grp-bork/gunc
- **Package**: https://anaconda.org/channels/bioconda/packages/gunc/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.14/site-packages/gunc/get_scores.py:9: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import resource_filename
usage: gunc merge_checkm [-h] -g  -c  [-o ] [-v]
gunc merge_checkm: error: the following arguments are required: -g/--gunc_file, -c/--checkm_file
```


## gunc_plot

### Tool Description
Plotting tool for GUNC results.

### Metadata
- **Docker Image**: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
- **Homepage**: https://github.com/grp-bork/gunc
- **Package**: https://anaconda.org/channels/bioconda/packages/gunc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gunc plot [-h] -d  [-g ] [-o ] [-t ] [-r ] [-c ] [-l ] [-v]

options:
  -h, --help            show this help message and exit
  -d, --diamond_file    GUNC diamond outputfile.
  -g, --gunc_gene_count_file 
                        GUNC gene_counts.json file.
  -o, --out_dir         Output directory.
  -t, --tax_levels      Tax levels to display (comma-seperated).
  -r, --remove_minor_clade_level 
                        Tax level at which to remove minor clades.
  -c, --contig_display_num 
                        Number of contigs to visualise. [0 plots all contigs]
  -l, --contig_display_list 
                        Comma seperated list of contig names to plot
  -v, --verbose         Verbose output for debugging
```


## gunc_summarise

### Tool Description
Summarize GUNC results.

### Metadata
- **Docker Image**: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
- **Homepage**: https://github.com/grp-bork/gunc
- **Package**: https://anaconda.org/channels/bioconda/packages/gunc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gunc summarise [-h] -m  -d  [-c ] -o  [-v]

options:
  -h, --help            show this help message and exit
  -m, --max_csslevel_file 
                        MaxCSS output file from GUNC (e.g.
                        GUNC.progenomes_2.1.maxCSS_level.tsv).
  -d, --gunc_detailed_output_dir 
                        GUNC detailed output dir (e.g. gunc_output).
  -c, --contamination_cutoff 
                        Alternatite cutoff to use.
  -o, --output_file    File in which to write outputfile with added score.
  -v, --verbose         Verbose output for debugging
```


## Metadata
- **Skill**: generated
