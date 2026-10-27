# whatsgnu CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| whatsgnu_database_customizer | PASS | new CWL; concatenated 3 repo genomes (13353 proteins) with renamed locus tags |
| whatsgnu_main | PASS | new CWL; built a database from 3 repo test genomes and scored NCTC8325 and CT18 (GNU scores >= 1 for proteins present in the database) |
| whatsgnu_plotter | PASS | new CWL; GNU score histograms made from two real reports |

## whatsgnu_main

### Tool Description
WhatsGNU ranks protein sequences by the number of exact protein matches (GNU score) in all known genomes of a species.

### Metadata
- **Docker Image**: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
- **Homepage**: https://github.com/ahmedmagds/WhatsGNU
- **Package**: https://anaconda.org/channels/bioconda/packages/whatsgnu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: WhatsGNU_main.py [-h] [-m MKDATABASE | -d DATABASE] [-a] [-j]
                        [-r [ROARY_CLUSTERED_PROTEINS]] [-dm {ortholog,basic}]
                        [-ri [RARITY_INDEX]] [-o OUTPUT_FOLDER] [--force]
                        [-p PREFIX] [-t] [-tn TOPGENOMES_COUNT]
                        [-s STRAINHITS] [-e METADATA] [-i] [-f] [-b] [-op]
                        [-w [PERCENT_IDENTITY]] [-c [PERCENT_COVERAGE]] [-q]
                        [-v]
                        query_faa

WhatsGNU v1.4 utilizes the natural variation in public databases to rank
protein sequences based on the number of observed exact protein matches
(the GNU score) in all known genomes of a particular species. It generates a
report for all the proteins in your query in seconds.

positional arguments:
  query_faa             Query protein FASTA file/s to analyze (.faa)

options:
  -h, --help            show this help message and exit
  -m MKDATABASE, --mkdatabase MKDATABASE
                        you have to provide path to faa file or a folder of
                        multiple faa files for compression
  -d DATABASE, --database DATABASE
                        you have to provide path to your compressed database
  -a, --pickle          Save database in pickle format [Default only txt file]
  -j, --sql             Save database in SQL format for large Databases
                        [Default only txt file]
  -r [ROARY_CLUSTERED_PROTEINS], --roary_clustered_proteins [ROARY_CLUSTERED_PROTEINS]
                        clustered_proteins output file from roary to be used
                        with -m
  -dm {ortholog,basic}, --database_mode {ortholog,basic}
                        select a mode from 'ortholog' or 'basic' to be used
                        with -d
  -ri [RARITY_INDEX], --rarity_index [RARITY_INDEX]
                        select an ortholog variant rarity index (OVRI) cutoff
                        value in range (0-1)[0.045] for ortholog mode
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
                        Database output prefix to be created for results
                        (default: timestamped WhatsGNU_results in the current
                        directory)
  --force               Force overwriting existing results folder assigned
                        with -o (default: off)
  -p PREFIX, --prefix PREFIX
                        Prefix for output compressed database (default:
                        WhatsGNU_compressed_database)
  -t, --topgenomes      create a file of top N genomes with most number of
                        exact matches to query [Default top 10 genomes]
  -tn TOPGENOMES_COUNT, --topgenomes_count TOPGENOMES_COUNT
                        select number of closest top genomes to show [Default
                        top 10 genomes]
  -s STRAINHITS, --strainhits STRAINHITS
                        check how many hits you get from a particular
                        strain,it has to be used with -t
  -e METADATA, --metadata METADATA
                        get the metadata composition of your hits, use the
                        metadata_frequency.csv file produced by the WhatsGNU
                        customizer script
  -i, --ids_hits        create a file of each protein with locus_tags (ids) of
                        all hits from the database, large file (~ 1 Gb for
                        3000 pts)
  -f, --faa_GNU_0       get a fasta (.faa) file of all proteins with GNU score
                        of zero
  -b, --blastp          run blastp on the proteins with GNU score of zero and
                        modify the report with ortholog_info, blastp has to be
                        installed
  -op, --output_blastp  get the output report of blastp run, it has to be used
                        with -b
  -w [PERCENT_IDENTITY], --percent_identity [PERCENT_IDENTITY]
                        select a blastp percent identity cutoff value [80],
                        range(0,100)
  -c [PERCENT_COVERAGE], --percent_coverage [PERCENT_COVERAGE]
                        select a blastp percent coverage cutoff value [80],
                        range(0,100)
  -q, --quiet           No screen output [default OFF]
  -v, --version         print version and exit
```

## whatsgnu_plotter

### Tool Description
WhatsGNU plotter: heatmaps, histograms, barplots and volcano plots from WhatsGNU reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
- **Homepage**: https://github.com/ahmedmagds/WhatsGNU
- **Package**: https://anaconda.org/channels/bioconda/packages/whatsgnu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: WhatsGNU_plotter.py [-h] [-hp {ortholog,basic}] [-l LIST_GENES]
                           [-q FASTA] [-op] [-d STRAINS_ORDER] [-r]
                           [-rc RARITY_COLOR] [-fs FIGURE_SIZE FIGURE_SIZE]
                           [-hc HEATMAP_COLOR] [-mc MASKED_COLOR]
                           [-f FONT_SIZE] [-t TITLE] [-mb {ortholog,basic}]
                           [-w] [-s SELECT_METADATA] [-x] [-e HISTOGRAM_COLOR]
                           [-b HISTOGRAM_BINS]
                           [-p NOVEL_CONSERVED NOVEL_CONSERVED]
                           [-st STRAINS_TAG_VOLCANO] [-c CUTOFF_VOLCANO]
                           [-cc CASE_CONTROL_NAME CASE_CONTROL_NAME]
                           prefix_name directory_path

WhatsGNU_plotter script for WhatsGNU v1.4.

positional arguments:
  prefix_name           prefix name for the the output folder and
                        heatmap/volcano output files
  directory_path        path to directory of WhatsGNU reports

options:
  -h, --help            show this help message and exit
  -hp {ortholog,basic}, --heatmap {ortholog,basic}
                        heatmap of GNU scores for orthologous genes in
                        multiple isolates
  -l LIST_GENES, --list_genes LIST_GENES
                        a txt file of ortholog group names from one of the
                        WhatsGNU reports for heatmap
  -q FASTA, --fasta FASTA
                        a FASTA file of sequences for the proteins of interest
                        for heatmap or metadata barplot
  -op, --output_blastp  get the output report of blastp run, it has to be used
                        with -q
  -d STRAINS_ORDER, --strains_order STRAINS_ORDER
                        list of strains order for heatmap
  -r, --rarity          Annotate heatmap cells with OVRI(default: off)
  -rc RARITY_COLOR, --rarity_color RARITY_COLOR
                        OVRI data text color in the heatmap
  -fs FIGURE_SIZE FIGURE_SIZE, --figure_size FIGURE_SIZE FIGURE_SIZE
                        heatmap width and height in inches w,h, respectively
  -hc HEATMAP_COLOR, --heatmap_color HEATMAP_COLOR
                        heatmap color
  -mc MASKED_COLOR, --masked_color MASKED_COLOR
                        missing data color in heatmap
  -f FONT_SIZE, --font_size FONT_SIZE
                        heatmap font size
  -t TITLE, --title TITLE
                        title for the heatmap [Default:WhatsGNU heatmap]
  -mb {ortholog,basic}, --metadata_barplot {ortholog,basic}
                        Metadata percentage distribution for proteins in a
                        FASTA file
  -w, --all_metadata    all metadata
  -s SELECT_METADATA, --select_metadata SELECT_METADATA
                        select some metadata
  -x, --histogram       histogram of GNU scores
  -e HISTOGRAM_COLOR, --histogram_color HISTOGRAM_COLOR
                        histogram color
  -b HISTOGRAM_BINS, --histogram_bins HISTOGRAM_BINS
                        number of bins for the histograms [10]
  -p NOVEL_CONSERVED NOVEL_CONSERVED, --novel_conserved NOVEL_CONSERVED NOVEL_CONSERVED
                        upper and lower GNU score limits for novel and
                        conserved proteins novel_GNU_upper_limit,
                        conserved_GNU_lower_limit, respectively [Default 10,
                        100]
  -st STRAINS_TAG_VOLCANO, --strains_tag_volcano STRAINS_TAG_VOLCANO
                        a csv file of the strains of the two groups to be
                        compared with (case/control) tag
  -c CUTOFF_VOLCANO, --cutoff_volcano CUTOFF_VOLCANO
                        a percentage of isolates a protein must be in
                        [Default: 100]
  -cc CASE_CONTROL_NAME CASE_CONTROL_NAME, --case_control_name CASE_CONTROL_NAME CASE_CONTROL_NAME
                        case and control groups' names [Default: case control]
```

## whatsgnu_database_customizer

### Tool Description
Database customizer: prepares faa, RAST or gff files for a WhatsGNU database.

### Metadata
- **Docker Image**: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
- **Homepage**: https://github.com/ahmedmagds/WhatsGNU
- **Package**: https://anaconda.org/channels/bioconda/packages/whatsgnu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: WhatsGNU_database_customizer.py [-h] [-g | -p | -r | -s] [-z]
                                       [-l LIST_CSV] [-i] [-c]
                                       prefix_name directory_path

Database_customizer script for WhatsGNU v1.4.

positional arguments:
  prefix_name           prefix name for the output folder and the one
                        concatenated modified file
  directory_path        path to directory of faa, RAST txt or gff files

options:
  -h, --help            show this help message and exit
  -g, --GenBank_RefSeq  faa files from GenBank or RefSeq
  -p, --prokka          faa files from Prokka
  -r, --RAST            spreadsheet tab-separated text files from RAST
  -s, --gff_file        gff file from prokka, needed if planning to run Roary
  -z, --gzipped         compressed file (.gz)
  -l LIST_CSV, --list_csv LIST_CSV
                        a file.csv of 3+ columns: file_name, old locustag, new
                        locustag and optionally metadata
  -i, --individual_files
                        individual modified files
  -c, --concatenated_file
                        one concatenated modified file of all input files
```

## Metadata
- **Skill**: generated

