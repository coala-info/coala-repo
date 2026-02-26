# mdmcleaner CWL Generation Report

## mdmcleaner_clean

### Tool Description
Clean input fastas of genomes and/or bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/KIT-IBG-5/mdmcleaner
- **Stars**: N/A
### Original Help Text
```text
usage: mdmcleaner clean [-h] -i INPUT_FASTAS [INPUT_FASTAS ...]
                        [-o OUTPUT_FOLDER] [--outblacklist OUTBLACKLIST] [-v]
                        [-c CONFIGFILE] [-t THREADS] [-f]
                        [--overview_files_basename OVERVIEW_BASENAME]
                        [-b BLACKLISTFILE] [--no_filterfasta]
                        [--ignore_default_blacklist] [--fast_run]

options:
  -h, --help            show this help message and exit
  -i INPUT_FASTAS [INPUT_FASTAS ...], --input_fastas INPUT_FASTAS [INPUT_FASTAS ...]
                        input fastas of genomes and/or bins
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
                        output-folder for MDMcleaner results. Default =
                        'mdmcleaner_output'
  --outblacklist OUTBLACKLIST
                        Outputfile for new blacklist additions. If a
                        preexisting file is selected, additions will be
                        appended to end of that file
  -v, --version         show program's version number and exit
  -c CONFIGFILE, --config CONFIGFILE
                        provide a local config file with basic settings (such
                        as the location of database-files). default: looks for
                        config files named 'mdmcleaner.config' in current
                        working directory. settings in the local config file
                        will override settings in the global config file
                        '/usr/local/lib/python3.11/site-
                        packages/mdmcleaner/mdmcleaner.config'
  -t THREADS, --threads THREADS
                        Number of threads to use. (default = use setting from
                        config file)
  -f, --force           Force reclassification of pre-existing blast-results
  --overview_files_basename OVERVIEW_BASENAME
                        basename for overviewfiles (default="overview"
  -b BLACKLISTFILE, --blacklistfile BLACKLISTFILE
                        File listing reference-DB sequence-names that should
                        be ignored during blast-analyses (e.g. known refDB-
                        contaminations...
  --no_filterfasta      Do not write filtered contigs to final output fastas
                        (Default = False)
  --ignore_default_blacklist
                        Ignore the default blacklist (Default = False)
  --fast_run            skip detailed analyses of potential reference
                        ambiguities (runs may be faster but also
                        classification may be less exact, and potential
                        reference database contaminations will not be
                        verified)
```


## mdmcleaner_makedb

### Tool Description
Builds the reference database for MDMcleaner.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mdmcleaner makedb [-h] [-o OUTDIR] [-c CONFIGFILE] [--get_pub_data]
                         [--verbose] [--quiet]

options:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        target base directory for reference-data. may not be
                        the current working directory. Needs >100GB space!
                        Default = './db' (if downloading publication-dataset
                        or if not already specified in config file)
  -c CONFIGFILE, --config CONFIGFILE
                        provide a local config file with the target location
                        to store database-files. default: looks for config
                        files named 'mdmcleaner.config' in current working
                        directory. settings in the local config file will
                        override settings in the global config file
                        '/usr/local/lib/python3.11/site-
                        packages/mdmcleaner/mdmcleaner.config'
  --get_pub_data        simply download the reference dataset from the
                        MDMcleaner publication from zenodo (WARNING: this is
                        outdated and therefore NOT optimal! Only meant for
                        testing/verification purposes)
  --verbose             verbose output (download progress etc)
  --quiet               quiet mode (suppress any status messages except Errors
                        and Warnings)
```


## mdmcleaner_get_markers

### Tool Description
Extracts marker genes from input FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mdmcleaner get_markers [-h] -i INPUT_FASTAS [INPUT_FASTAS ...]
                              [-m {rrna,trna,totalprots,markerprots,all}]
                              [-o OUTDIR] [-c CONFIGFILE] [-t THREADS]
                              [-M MINCONTIGLENGTH]

options:
  -h, --help            show this help message and exit
  -i INPUT_FASTAS [INPUT_FASTAS ...], --input_fastas INPUT_FASTAS [INPUT_FASTAS ...]
                        input fasta(s). May be gzip-compressed
  -m {rrna,trna,totalprots,markerprots,all}, --markertype {rrna,trna,totalprots,markerprots,all}
                        type of marker gene that should be extracted (default
                        = 'all')
  -o OUTDIR, --outdir OUTDIR
                        Output directory (will be created if it does not
                        exist). Default = '.'
  -c CONFIGFILE, --config CONFIGFILE
                        provide a local config file with the target location
                        to store database-files. default: looks for config
                        files named 'mdmcleaner.config' in current working
                        directory. settings in the local config file will
                        override settings in the global config file
                        '/usr/local/lib/python3.11/site-
                        packages/mdmcleaner/mdmcleaner.config'
  -t THREADS, --threads THREADS
                        number of threads to use (default = use setting from
                        config file)
  -M MINCONTIGLENGTH, --mincontiglength MINCONTIGLENGTH
                        minimum contig length (contigs shorter than this will
                        be ignored)
```


## mdmcleaner_completeness

### Tool Description
Completeness analysis for mdmcleaner

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mdmcleaner completeness [-h] -i INPUT_FASTAS [INPUT_FASTAS ...]
                               [-c CONFIGFILE] [-t THREADS]
                               [-M MINCONTIGLENGTH]

options:
  -h, --help            show this help message and exit
  -i INPUT_FASTAS [INPUT_FASTAS ...], --input_fastas INPUT_FASTAS [INPUT_FASTAS ...]
                        input fasta(s). May be gzip-compressed
  -c CONFIGFILE, --config CONFIGFILE
                        provide a local config file with the target location
                        to store database-files. default: looks for config
                        files named 'mdmcleaner.config' in current working
                        directory. settings in the local config file will
                        override settings in the global config file
                        '/usr/local/lib/python3.11/site-
                        packages/mdmcleaner/mdmcleaner.config'
  -t THREADS, --threads THREADS
                        number of threads to use (default = use setting from
                        config file)
  -M MINCONTIGLENGTH, --mincontiglength MINCONTIGLENGTH
                        minimum contig length (contigs shorter than this will
                        be ignored)
```


## mdmcleaner_acc2taxpath

### Tool Description
Convert accessions to taxonomic paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mdmcleaner acc2taxpath [-h] [-c CONFIGFILE] accessions [accessions ...]

positional arguments:
  accessions            (space seperated list of) input accessions. Or just
                        pass "interactive" for interactive mode

options:
  -h, --help            show this help message and exit
  -c CONFIGFILE, --config CONFIGFILE
                        provide a local config file with the target location
                        to store database-files. default: looks for config
                        files named 'mdmcleaner.config' in current working
                        directory. settings in the local config file will
                        override settings in the global config file
                        '/usr/local/lib/python3.11/site-
                        packages/mdmcleaner/mdmcleaner.config'
```


## mdmcleaner_refdb_contams

### Tool Description
Analyze the ambiguity report file to identify and manage contaminants in a reference database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mdmcleaner refdb_contams [-h] [-c CONFIGFILE] [-t THREADS]
                                [-o OUTBLACKLIST]
                                ambiguity_report

positional arguments:
  ambiguity_report      The ambiguity report file to analyse (Usually
                        './overview_refdb_ambiguities.tsv')

options:
  -h, --help            show this help message and exit
  -c CONFIGFILE, --config CONFIGFILE
                        provide a local config file with the target location
                        to store database-files. default: looks for config
                        files named 'mdmcleaner.config' in current working
                        directory. settings in the local config file will
                        override settings in the global config file
                        '/usr/local/lib/python3.11/site-
                        packages/mdmcleaner/mdmcleaner.config'
  -t THREADS, --threads THREADS
                        number of threads to use (default = use setting from
                        config file)
  -o OUTBLACKLIST, --outblacklist OUTBLACKLIST
                        Outputfile for new blacklist additions. If a
                        preexisting file is selected, additions will be
                        appended to end of that file
```


## mdmcleaner_set_configs

### Tool Description
Set mdmcleaner configuration options.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mdmcleaner set_configs [-h] [-s {local,global}] [--blastp BLASTP]
                              [--blastn BLASTN] [--diamond DIAMOND]
                              [--barrnap BARRNAP] [--hmmsearch HMMSEARCH]
                              [--aragorn ARAGORN] [--db_basedir DB_BASEDIR]
                              [--threads THREADS]

options:
  -h, --help            show this help message and exit
  -s {local,global}, --scope {local,global}
                        change settings in local or global config file.
                        'global' likely require admin privileges. 'local' will
                        modify or create a mdmcleaner.config file in the
                        current working directory. default = 'local'
  --blastp BLASTP       path to blastp binaries (if not in PATH)
  --blastn BLASTN       path to blastn binaries (if not in PATH)
  --diamond DIAMOND     path to diamond binaries (if not in PATH)
  --barrnap BARRNAP     path to barrnap binaries (if not in PATH)
  --hmmsearch HMMSEARCH
                        path to hmmsearch binaries (if not in PATH)
  --aragorn ARAGORN     path to aragorn binaries (if not in PATH)
  --db_basedir DB_BASEDIR
                        path to basedirectory for reference database
  --threads THREADS     threads to use by default
```


## mdmcleaner_show_configs

### Tool Description
Show MDMcleaner configurations

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
You are running the following MDMcleaner command:
	 '/usr/local/bin/mdmcleaner show_configs'
reading settings from configfile: "/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config"

	settings:
		threads = '1'
		db_type = '['gtdb']'
		blacklistfile = '['/usr/local/lib/python3.11/site-packages/mdmcleaner/blacklist.list']'
		blastn = 'blastn'
		blastp = 'blastp'
		makeblastdb = 'makeblastdb'
		blastdbcmd = 'blastdbcmd'
		diamond = 'diamond'
		barrnap = 'barrnap'
		hmmsearch = 'hmmsearch'
		aragorn = 'aragorn'
		prodigal = 'prodigal'

setting	value	source
blastpath	[]	default
diamondpath	[]	default
barrnappath	[]	default
hmmerpath	[]	default
aragornpath	[]	default
prodigalpath	[]	default
threads	1	/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config
db_basedir	[]	default
db_type	['gtdb']	/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config
blacklistfile	['/usr/local/lib/python3.11/site-packages/mdmcleaner/blacklist.list']	default
```


## mdmcleaner_check_dependencies

### Tool Description
Checks if all required dependencies for MDMcleaner are met.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: PASS

### Original Help Text
```text
You are running the following MDMcleaner command:
	 '/usr/local/bin/mdmcleaner check_dependencies'
reading settings from configfile: "/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config"

	settings:
		threads = '1'
		db_type = '['gtdb']'
		blacklistfile = '['/usr/local/lib/python3.11/site-packages/mdmcleaner/blacklist.list']'
		blastn = 'blastn'
		blastp = 'blastp'
		makeblastdb = 'makeblastdb'
		blastdbcmd = 'blastdbcmd'
		diamond = 'diamond'
		barrnap = 'barrnap'
		hmmsearch = 'hmmsearch'
		aragorn = 'aragorn'
		prodigal = 'prodigal'


	checking dependencies...
		wget...1.20.3 --> OK!
		blastn...2.13.0 --> OK!
		blastp...2.13.0 --> OK!
		makeblastdb...2.13.0 --> OK!
		blastdbcmd...2.13.0 --> OK!
		diamond...2.0.15 --> OK!
		hmmsearch...3.3.2 --> OK!
		barrnap...0.9 --> OK!
		aragorn...1.2.41 --> OK!
		prodigal...2.6.3 --> OK!
	-->OK! All dependencies are being met!

SUCCESS: all dependencies are being met
```


## mdmcleaner_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
- **Homepage**: https://github.com/KIT-IBG-5/mdmcleaner
- **Package**: https://anaconda.org/channels/bioconda/packages/mdmcleaner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: mdmcleaner version [-h]
mdmcleaner version: error: argument -h/--help: ignored explicit argument 'elp'
```

