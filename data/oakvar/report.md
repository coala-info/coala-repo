# oakvar CWL Generation Report

## oakvar_ov

### Tool Description
OakVar. Genomic variant analysis platform.

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Total Downloads**: 92.3K
- **Last updated**: 2026-02-13
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: ov [-h]
          {run,report,module,gui,config,new,store,util,test,version,issue,system,license,update}
          ...

OakVar. Genomic variant analysis platform.
https://github.com/rkimoakbioinformatics/oakvar

options:
  -h, --help            show this help message and exit

Commands:
  {run,report,module,gui,config,new,store,util,test,version,issue,system,license,update}
    run                 Run a job
    report              Generate a report from a job
    module              Manages OakVar modules
    gui                 Start the GUI
    config              Manages OakVar configurations
    new                 Create OakVar example input files and module templates
    store               Publish modules to the store
    util                OakVar utilities
    test                Run tests on OakVar modules. `def test` should be
                        defined in tested modules.
    version             Show version
    issue               Send an issue report
    system              Commands on OakVar system
    license             Shows license information.
    update              Updates OakVar to the latest version.
```


## oakvar_ov module search

### Tool Description
Manage ov modules

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ov module [-h] {install,pack,update,uninstall,info,ls,create} ...
ov module: error: argument {install,pack,update,uninstall,info,ls,create}: invalid choice: 'search' (choose from install, pack, update, uninstall, info, ls, create)
```


## oakvar_ov module install

### Tool Description
Installs OakVar modules.

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ov module install [-h] [-f] [--overwrite] [-d] [-y]
                         [--skip-dependencies] [--skip-data] [--no-fetch]
                         [--url URLS [URLS ...]] [--quiet] [--clean]
                         [--file FILE]
                         [module_names ...]

Installs OakVar modules.

positional arguments:
  module_names          Modules to install. May be regular expressions.

options:
  -h, --help            show this help message and exit
  -f, --force           Install module even if latest version is already
                        installed
  --overwrite           Install module even if latest version is already
                        installed
  -d, --force-data      Download data even if latest data is already installed
  -y, --yes             Proceed without prompt
  --skip-dependencies   Skip installing dependencies
  --skip-data           Skip installing data
  --no-fetch            Skip fetching the latest store
  --url URLS [URLS ...]
                        Install from URLs
  --quiet               suppress stdout output
  --clean               removes temporary installation directory
  --file FILE           Use a file with module names to install
```


## oakvar_ov module update

### Tool Description
updates modules.

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ov module update [-h] [-y] [--quiet] [module_name_patterns ...]

updates modules.

positional arguments:
  module_name_patterns  Modules to update.

options:
  -h, --help            show this help message and exit
  -y, --yes             Proceed without prompt
  --quiet               suppress stodout output
```


## oakvar_ov run

### Tool Description
Run OakVar on input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ov run input_file_path_1 input_file_path_2 ... [-h]
                                                      [-a ANNOTATORS [ANNOTATORS ...]]
                                                      [-A ANNOTATORS_REPLACE [ANNOTATORS_REPLACE ...]]
                                                      [-e EXCLUDES [EXCLUDES ...]]
                                                      [-n RUN_NAME [RUN_NAME ...]]
                                                      [-d OUTPUT_DIR [OUTPUT_DIR ...]]
                                                      [--startat {converter,preparer,mapper,annotator,aggregator,postaggregator,reporter}]
                                                      [--endat {converter,preparer,mapper,annotator,aggregator,postaggregator,reporter}]
                                                      [--skip {converter,preparer,mapper,annotator,aggregator,postaggregator,reporter} [{converter,preparer,mapper,annotator,aggregator,postaggregator,reporter} ...]]
                                                      [-c CONFPATH]
                                                      [-t REPORT_TYPES [REPORT_TYPES ...]]
                                                      [-l GENOME] [-x]
                                                      [--newlog] [--note NOTE]
                                                      [--mp MP]
                                                      [-i INPUT_FORMAT]
                                                      [--converter-module CONVERTER_MODULE]
                                                      [--keep-temp]
                                                      [--writeadmindb]
                                                      [-j JOB_NAME [JOB_NAME ...]]
                                                      [--separatesample]
                                                      [--primary-transcript PRIMARY_TRANSCRIPT [PRIMARY_TRANSCRIPT ...]]
                                                      [--cleanrun]
                                                      [--module-options [MODULE_OPTIONS ...]]
                                                      [--system-option [SYSTEM_OPTION ...]]
                                                      [--package PACKAGE]
                                                      [--filtersql FILTERSQL]
                                                      [--includesample INCLUDESAMPLE [INCLUDESAMPLE ...]]
                                                      [--excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]]
                                                      [--filter FILTER]
                                                      [-f FILTERPATH]
                                                      [--pp PREPARERS [PREPARERS ...]]
                                                      [-m MAPPER_NAME [MAPPER_NAME ...]]
                                                      [-p POSTAGGREGATORS [POSTAGGREGATORS ...]]
                                                      [--vcf2vcf] [--uid UID]
                                                      [--logtofile]
                                                      [--loglevel LOGLEVEL]
                                                      [--combine-input]
                                                      [--input-encoding INPUT_ENCODING]
                                                      [--ignore-sample]
                                                      [--skip-variant-deduplication]
                                                      [--keep-liftover-failed]
                                                      [--keep-ref]
                                                      [inputs ...]

Run OakVar on input files.

positional arguments:
  inputs                Input file(s). One or more variant files in a
                        supported format like VCF. See the -i/--input-format
                        flag for supported formats. In the special case where
                        you want to add annotations to an existing OakVar
                        analysis, provide the output sqlite database from the
                        previous run as input instead of a variant input file.

options:
  -h, --help            show this help message and exit
  -a ANNOTATORS [ANNOTATORS ...]
                        Annotator module names or directories. If --package is
                        used also, annotator modules defined with -a will be
                        added. Use '-a all' to run all installed annotators.
  -A ANNOTATORS_REPLACE [ANNOTATORS_REPLACE ...]
                        Annotator module names or directories. If --package
                        option also is used, annotator modules defined with -A
                        will replace those defined with --package. -A has
                        priority over -a.
  -e EXCLUDES [EXCLUDES ...]
                        modules to exclude
  -n RUN_NAME [RUN_NAME ...]
                        name of oakvar run
  -d OUTPUT_DIR [OUTPUT_DIR ...]
                        directory for output files
  --startat {converter,preparer,mapper,annotator,aggregator,postaggregator,reporter}
                        starts at given stage
  --endat {converter,preparer,mapper,annotator,aggregator,postaggregator,reporter}
                        ends after given stage.
  --skip {converter,preparer,mapper,annotator,aggregator,postaggregator,reporter} [{converter,preparer,mapper,annotator,aggregator,postaggregator,reporter} ...]
                        skips given stage(s).
  -c CONFPATH, --confpath CONFPATH
                        path to a conf file
  -t REPORT_TYPES [REPORT_TYPES ...]
                        Reporter types or reporter module directories
  -l GENOME, --genome GENOME
                        reference genome of input. OakVar will lift over to
                        hg38 if needed.
  -x                    deletes the existing result database and creates a new
                        one.
  --newlog              deletes the existing log file and creates a new one.
  --note NOTE           note for the job
  --mp MP               number of processes to use to run annotators
  -i INPUT_FORMAT, --input-format INPUT_FORMAT
                        Force input format
  --converter-module CONVERTER_MODULE
                        Converter module
  --keep-temp           Leave temporary files after run is complete.
  --writeadmindb        Write job information to admin db after job completion
  -j JOB_NAME [JOB_NAME ...], --jobname JOB_NAME [JOB_NAME ...]
                        Job ID for server version
  --separatesample      Separate variant results by sample
  --primary-transcript PRIMARY_TRANSCRIPT [PRIMARY_TRANSCRIPT ...]
                        "mane" for MANE transcripts as primary transcripts, or
                        a path to a file of primary transcripts. MANE is
                        default.
  --cleanrun            Deletes all previous output files for the job and
                        generate new ones.
  --module-options [MODULE_OPTIONS ...]
                        Module-specific option in module_name.key=value
                        syntax. For example, --module-options
                        vcfreporter.type=separate
  --system-option [SYSTEM_OPTION ...]
                        System option in key=value syntax. For example,
                        --system-option modules_dir=/home/user/oakvar/modules
  --package PACKAGE     Use package
  --filtersql FILTERSQL
                        Filter SQL
  --includesample INCLUDESAMPLE [INCLUDESAMPLE ...]
                        Sample IDs to include
  --excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]
                        Sample IDs to exclude
  --filter FILTER
  -f FILTERPATH         Path to a filter file
  --pp PREPARERS [PREPARERS ...]
                        Names or directories of preparer modules, which will
                        be run in the given order.
  -m MAPPER_NAME [MAPPER_NAME ...]
                        Mapper module name or mapper module directory
  -p POSTAGGREGATORS [POSTAGGREGATORS ...]
                        Postaggregators to run. Additionally, tagsampler and
                        vcfinfo will automatically run depending on
                        conditions.
  --vcf2vcf             analyze with the vcf to vcf workflow. It is faster
                        than a normal run, but only if both input and output
                        formats are VCF.
  --uid UID             Optional UID of the job
  --logtofile           Path to a log file. If given without a path, the job's
                        run_name.log will be the log path.
  --loglevel LOGLEVEL   Logging level (DEBUG, INFO, WARN, ERROR)
  --combine-input       Combine input files into one result
  --input-encoding INPUT_ENCODING
                        Encoding of input files
  --ignore-sample       Ignore samples
  --skip-variant-deduplication
                        Skip de-duplication of variants
  --keep-liftover-failed
                        Keep variants that failed liftover
  --keep-ref            Keep reference variants

inputs should be the first argument
```


## oakvar_ov report

### Tool Description
Generate reports from a job

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ov report [-h] [-t [REPORT_TYPES ...]] [-f FILTERPATH]
                 [--filtersql FILTERSQL] [-F FILTERNAME] [-s SAVEPATH]
                 [-c CONFPATH] [--reporter-paths [MODULE_PATHS ...]]
                 [--nogenelevelonvariantlevel]
                 [--inputfiles INPUTFILES [INPUTFILES ...]] [--separatesample]
                 [-d OUTPUT_DIR] [--quiet]
                 [--module-options [MODULE_OPTIONS ...]]
                 [--includesample INCLUDESAMPLE [INCLUDESAMPLE ...]]
                 [--excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]]
                 [--package PACKAGE] [--cols COLS [COLS ...]] [--level LEVEL]
                 [--user USER] [--no-summary] [--logtofile] [--head HEAD_N]
                 dbpath

Generate reports from a job

positional arguments:
  dbpath                Path to aggregator output

options:
  -h, --help            show this help message and exit
  -t [REPORT_TYPES ...]
                        report types
  -f FILTERPATH         Path to filter file
  --filtersql FILTERSQL
                        Filter SQL
  -F FILTERNAME         Name of filter (stored in aggregator output)
  -s SAVEPATH           Path to save file
  -c CONFPATH           path to a conf file
  --reporter-paths [MODULE_PATHS ...]
                        report module name
  --nogenelevelonvariantlevel
                        Use this option to prevent gene level result from
                        being added to variant level result.
  --inputfiles INPUTFILES [INPUTFILES ...]
                        Original input file path
  --separatesample      Write each variant-sample pair on a separate line
  -d OUTPUT_DIR         directory for output files
  --quiet               Suppress output to STDOUT
  --module-options [MODULE_OPTIONS ...]
                        Module-specific option in module_name.key=value
                        syntax. For example, --module-options
                        vcfreporter.type=separate
  --includesample INCLUDESAMPLE [INCLUDESAMPLE ...]
                        Sample IDs to include
  --excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]
                        Sample IDs to exclude
  --package PACKAGE     Use filters and report types in a package
  --cols COLS [COLS ...]
                        columns to include in reports
  --level LEVEL         Level to make a report for. 'all' to include all
                        levels. Other possible levels include 'variant' and
                        'gene'.
  --user USER           User who is creating this report. Default is default.
  --no-summary          Skip gene level summarization. This saves time.
  --logtofile           Use this option to prevent gene level result from
                        being added to variant level result.
  --head HEAD_N         Make reports with the first n number of variants.

dbpath must be the first argument
```


## oakvar_ov gui

### Tool Description
OakVar graphical user interface

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ov gui [-h] [--multiuser] [--headless] [--http-only] [--debug]
              [--webapp WEBAPP] [--port PORT] [--noguest] [--quiet]
              [result]

positional arguments:
  result           Path to a OakVar result SQLite file

options:
  -h, --help       show this help message and exit
  --multiuser      Runs in multiuser mode
  --headless       do not open the OakVar web page
  --http-only      Force not to accept https connection
  --debug          Console echoes exceptions written to log file.
  --webapp WEBAPP  Name of OakVar webapp module to run
  --port PORT      Port number for OakVar graphical user interface
  --noguest        Disables guest mode
  --quiet          run quietly
```


## oakvar_ov system setup

### Tool Description
OakVar system setup

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
==========================================================
 #######     ###    ##    ## ##     ##    ###    ########  
##     ##   ## ##   ##   ##  ##     ##   ## ##   ##     ## 
##     ##  ##   ##  ##  ##   ##     ##  ##   ##  ##     ## 
##     ## ##     ## #####    ##     ## ##     ## ########  
##     ## ######### ##  ##    ##   ##  ######### ##   ##   
##     ## ##     ## ##   ##    ## ##   ##     ## ##    ##  
 #######  ##     ## ##    ##    ###    ##     ## ##     ##
==========================================================
                                   Oak Bioinformatics, LLC
      Free with registration for personal and research use
            Commercial license required for commercial use
        Licensing and feedback: info@oakbioinformatics.com
                                        https://oakvar.com

Created /root/.oakvar/conf/system.yml.
System configuration file: /root/.oakvar/conf/system.yml
Created /root/.oakvar/modules.
Created /root/.oakvar/jobs.
Created /root/.oakvar/logs.
Created /root/.oakvar/conf/liftover.
Created: /root/.oakvar/oakvar.yml
User configuration file: /root/.oakvar/oakvar.yml.
Do you already have an OakVar store account? (y/N):
```


## oakvar_ov module info

### Tool Description
returns information of the queried module

### Metadata
- **Docker Image**: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
- **Homepage**: http://www.oakvar.com
- **Package**: https://anaconda.org/channels/bioconda/packages/oakvar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ov module info [-h] [-l] [--fmt FMT] module_name

positional arguments:
  module_name  Module to get info about

options:
  -h, --help   show this help message and exit
  -l, --local  Include local info
  --fmt FMT    format of module information data. json or yaml

returns information of the queried module
```


## Metadata
- **Skill**: not generated
