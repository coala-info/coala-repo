# groopm CWL Generation Report

## groopm_parse

### Tool Description
Parse raw data and save to disk

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-09-15
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: groopm parse [-h] [-t THREADS] [-f] [-c CUTOFF]
                    dbname reference bamfiles [bamfiles ...]

Parse raw data and save to disk

positional arguments:
  dbname                name of the database being created
  reference             fasta file containing bam reference sequences
  bamfiles              bam files to parse

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads to use during BAM parsing (default:
                        1)
  -f, --force           overwrite existing DB file without prompting (default:
                        False)
  -c CUTOFF, --cutoff CUTOFF
                        cutoff contig size during parsing (default: 500)
```


## groopm_core

### Tool Description
Load saved data and make bin cores

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm core [-h] [-c CUTOFF] [-s SIZE] [-b BP] [-f] [-g GRAPHFILE] [-p]
                   [-m MULTIPLOT]
                   dbname

Load saved data and make bin cores

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -c CUTOFF, --cutoff CUTOFF
                        cutoff contig size for core creation (default: 1500)
  -s SIZE, --size SIZE  minimum number of contigs which define a core
                        (default: 10)
  -b BP, --bp BP        cumulative size of contigs which define a core
                        regardless of number of contigs (default: 1000000)
  -f, --force           overwrite existing DB file without prompting (default:
                        False)
  -g GRAPHFILE, --graphfile GRAPHFILE
                        output graph of micro bin mergers (default: None)
  -p, --plot            create plots of bins after basic refinement (default:
                        False)
  -m MULTIPLOT, --multiplot MULTIPLOT
                        create plots during core creation - (0-3) MAKES MANY
                        IMAGES! (default: 0)
```


## groopm_refine

### Tool Description
Merge similar bins and split chimeric ones

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm refine [-h] [-a] [-r] [-p] dbname

Merge similar bins and split chimeric ones

positional arguments:
  dbname              name of the database to open

options:
  -h, --help          show this help message and exit
  -a, --auto          automatically refine bins (default: False)
  -r, --no_transform  skip data transformation (3 stoits only) (default:
                      False)
  -p, --plot          create plots of bins after refinement (default: False)
```


## groopm_recruit

### Tool Description
Recruit more contigs into existing bins

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm recruit [-h] [-c CUTOFF] [-f] [-s STEP] [-i INCLUSIVITY] dbname

Recruit more contigs into existing bins

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -c CUTOFF, --cutoff CUTOFF
                        cutoff contig size (default: 500)
  -f, --force           overwrite existing db file without prompting (default:
                        False)
  -s STEP, --step STEP  step size for iterative recruitment (default: 200)
  -i INCLUSIVITY, --inclusivity INCLUSIVITY
                        make recruitment more or less inclusive (default: 2.5)
```


## groopm_extract

### Tool Description
Extract contigs or reads based on bin affiliations

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm extract [-h] [-b BIDS [BIDS ...]] [-m MODE] [-o OUT_FOLDER]
                      [-p PREFIX] [-c CUTOFF] [--mix_bams] [--mix_groups]
                      [--mix_reads] [--interleave] [--headers_only]
                      [--no_gzip] [--mapping_quality MAPPING_QUALITY]
                      [--use_secondary] [--use_supplementary]
                      [--max_distance MAX_DISTANCE] [-v] [-t THREADS]
                      dbname data [data ...]

Extract contigs or reads based on bin affiliations

positional arguments:
  dbname                name of the database to open
  data                  data file(s) to extract from, bam or fasta

options:
  -h, --help            show this help message and exit
  -b BIDS [BIDS ...], --bids BIDS [BIDS ...]
                        bin ids to use (None for all) (default: None)
  -m MODE, --mode MODE  what to extract [reads, contigs] (default: contigs)
  -o OUT_FOLDER, --out_folder OUT_FOLDER
                        write to this folder (None for current dir) (default:
                        )
  -p PREFIX, --prefix PREFIX
                        prefix to apply to output files (default: )
  -c CUTOFF, --cutoff CUTOFF
                        >>CONTIG MODE ONLY<< cutoff contig size (0 for no
                        cutoff) (default: 0)
  --mix_bams            >>READ MODE ONLY<< use the same file for multiple bam
                        files (default: False)
  --mix_groups          >>READ MODE ONLY<< use the same files for multiple
                        group groups (default: False)
  --mix_reads           >>READ MODE ONLY<< use the same files for
                        paired/unpaired reads (default: False)
  --interleave          >>READ MODE ONLY<< interleave paired reads in ouput
                        files (default: False)
  --headers_only        >>READ MODE ONLY<< extract only (unique) headers
                        (default: False)
  --no_gzip             do not gzip output files (default: False)
  --mapping_quality MAPPING_QUALITY
                        >>READ MODE ONLY<< mapping quality threshold (default:
                        0)
  --use_secondary       >>READ MODE ONLY<< use reads marked with the secondary
                        flag (default: False)
  --use_supplementary   >>READ MODE ONLY<< use reads marked with the
                        supplementary flag (default: False)
  --max_distance MAX_DISTANCE
                        >>READ MODE ONLY<< maximum allowable edit distance
                        from query to reference (default: 1000)
  -v, --verbose         >>READ MODE ONLY<< be verbose (default: False)
  -t THREADS, --threads THREADS
                        >>READ MODE ONLY<< maximum number of threads to use
                        (default: 1)
```


## groopm_merge

### Tool Description
Merge BAM files based on a database of alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/bamm/cWrapper.py:38: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import working_set, resource_filename
usage: groopm merge [-h] [-f] dbname bids [bids ...]
groopm merge: error: the following arguments are required: dbname, bids
```


## groopm_split

### Tool Description
Split a database into parts

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/bamm/cWrapper.py:38: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import working_set, resource_filename
usage: groopm split [-h] [-m MODE] [-f] dbname bid parts
groopm split: error: the following arguments are required: dbname, bid, parts
```


## groopm_delete

### Tool Description
Delete bins from a groopm database.

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm delete [-h] [-f] dbname bids [bids ...]

positional arguments:
  dbname       name of the database to open
  bids         bin ids to delete

options:
  -h, --help   show this help message and exit
  -f, --force  delete without prompting (default: False)
```


## groopm_explore

### Tool Description
Exploration mode [binpoints, binids, allcontigs, unbinnedcontigs, binnedcontigs, binassignments, compare, sidebyside, together]

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm explore [-h] [-b BIDS [BIDS ...]] [-c CUTOFF] [-m MODE] [-r]
                      [-k] [-p] [-C CM]
                      dbname

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -b BIDS [BIDS ...], --bids BIDS [BIDS ...]
                        bin ids to plot (None for all) (default: None)
  -c CUTOFF, --cutoff CUTOFF
                        cutoff contig size (default: 1000)
  -m MODE, --mode MODE  Exploration mode [binpoints, binids, allcontigs,
                        unbinnedcontigs, binnedcontigs, binassignments,
                        compare, sidebyside, together] (default: binids)
  -r, --no_transform    skip data transformation (3 stoits only) (default:
                        False)
  -k, --kmers           include kmers in figure [only used when mode ==
                        together] (default: False)
  -p, --points          ignore contig lengths when plotting (default: False)
  -C CM, --cm CM        set colormap [HSV, Accent, Blues, Spectral, Grayscale,
                        Discrete, DiscretePaired] (default: HSV)
```


## groopm_plot

### Tool Description
Plotting tool for groopm

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm plot [-h] [-b BIDS [BIDS ...]] [-t TAG] [-f FOLDER] [-p] [-C CM]
                   dbname

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -b BIDS [BIDS ...], --bids BIDS [BIDS ...]
                        bin ids to plot (None for all) (default: None)
  -t TAG, --tag TAG     tag to add to output filename (default: BIN)
  -f FOLDER, --folder FOLDER
                        save plots in folder (default: )
  -p, --points          ignore contig lengths when plotting (default: False)
  -C CM, --cm CM        set colormap [HSV, Accent, Blues, Spectral, Grayscale,
                        Discrete, DiscretePaired] (default: HSV)
```


## groopm_highlight

### Tool Description
Highlight contigs in a groopm database.

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm highlight [-h] [-P] [-L BINLABELS] [-C CONTIGCOLORS] [-r]
                        [-c CUTOFF] [-e ELEVATION] [-a AZIMUTH] [-f FILE]
                        [-t FILETYPE] [-d DPI] [-s] [-p] [-b BIDS [BIDS ...]]
                        dbname

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -P, --place           use this to help work out azimuth/elevation parameters
                        (default: False)
  -L BINLABELS, --binlabels BINLABELS
                        replace bin IDs with user specified labels (use 'none'
                        to force no labels) (default: )
  -C CONTIGCOLORS, --contigcolors CONTIGCOLORS
                        specify contig colors (default: )
  -r, --radius          draw placement radius to help with label moving
                        (default: False)
  -c CUTOFF, --cutoff CUTOFF
                        cutoff contig size (default: 1000)
  -e ELEVATION, --elevation ELEVATION
                        elevation in printed image (default: 25.0)
  -a AZIMUTH, --azimuth AZIMUTH
                        azimuth in printed image (default: -45.0)
  -f FILE, --file FILE  name of image file to produce (default: gmview)
  -t FILETYPE, --filetype FILETYPE
                        Type of file to produce (default: jpg)
  -d DPI, --dpi DPI     Image resolution (default: 300)
  -s, --show            load image in viewer only (default: False)
  -p, --points          ignore contig lengths when plotting (default: False)
  -b BIDS [BIDS ...], --bids BIDS [BIDS ...]
                        bin ids to plot (None for all) (default: None)
```


## groopm_flyover

### Tool Description
Visualize the contig binning process.

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm flyover [-h] [-b BIDS [BIDS ...]] [-c CUTOFF] [-p] [-P PREFIX]
                      [-t TITLE] [-B] [-f FORMAT] [--fps FPS]
                      [--totalTime TOTALTIME] [--firstFade FIRSTFADE]
                      dbname

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -b BIDS [BIDS ...], --bids BIDS [BIDS ...]
                        bin ids to concentrate on (None for all) (default:
                        None)
  -c CUTOFF, --cutoff CUTOFF
                        cutoff contig size (default: 1000)
  -p, --points          ignore contig lengths when plotting (default: False)
  -P PREFIX, --prefix PREFIX
                        prefix to append to start of output files (default:
                        file)
  -t TITLE, --title TITLE
                        title to add to output images (default: )
  -B, --colorbar        show the colorbar (default: False)
  -f FORMAT, --format FORMAT
                        file format output images (default: jpeg)
  --fps FPS             frames per second (default: 10)
  --totalTime TOTALTIME
                        how long the movie should go for (seconds) (default:
                        120.0)
  --firstFade FIRSTFADE
                        what percentage of the movie is devoted to the
                        unbinned contigs (default: 0.05)
```


## groopm_print

### Tool Description
Print information from a groopm database.

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm print [-h] [-b BIDS [BIDS ...]] [-o OUTFILE] [-f FORMAT] [-u]
                    dbname

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -b BIDS [BIDS ...], --bids BIDS [BIDS ...]
                        bin ids to print (None for all) (default: None)
  -o OUTFILE, --outfile OUTFILE
                        print to file not STDOUT (default: )
  -f FORMAT, --format FORMAT
                        output format [bins, contigs] (default: bins)
  -u, --unbinned        print unbinned contig IDs too (default: False)
```


## groopm_dump

### Tool Description
Dump data from a groopm database.

### Metadata
- **Docker Image**: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
- **Homepage**: https://ecogenomics.github.io/GroopM/
- **Package**: https://anaconda.org/channels/bioconda/packages/groopm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: groopm dump [-h] [-f FIELDS] [-o OUTFILE] [-s SEPARATOR] [--no_headers]
                   dbname

positional arguments:
  dbname                name of the database to open

options:
  -h, --help            show this help message and exit
  -f FIELDS, --fields FIELDS
                        fields to extract: Build a comma separated list from
                        [names, mers, gc, coverage, tcoverage, ncoverage,
                        lengths, bins] or just use 'all'] (default:
                        names,bins)
  -o OUTFILE, --outfile OUTFILE
                        write data to this file (default: GMdump.csv)
  -s SEPARATOR, --separator SEPARATOR
                        data separator (default: ,)
  --no_headers          don't add headers (default: False)
```


## Metadata
- **Skill**: generated
