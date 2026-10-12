# open-cravat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| open-cravat_report | PASS | regenerated the text report from the result database; identical to the run output |
| open-cravat_run | PASS | ran 20 real hg38 chr21 variants with the built-in gene mapper and go annotator; text report has gene and consequence columns |
| open-cravat_vcfanno | PASS | annotated the 20 real variants; output VCF has OC_ gene and consequence INFO fields |

## open-cravat_run

### Tool Description
Run an Open-CRAVAT job: convert variants, map to genes, annotate and write reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
- **Homepage**: http://www.opencravat.org
- **Package**: https://anaconda.org/channels/bioconda/packages/open-cravat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cravat input_file_path_1 input_file_path_2 ... [-h]
                                                      [-a ANNOTATORS [ANNOTATORS ...]]
                                                      [-A ANNOTATORS_REPLACE [ANNOTATORS_REPLACE ...]]
                                                      [-e EXCLUDES [EXCLUDES ...]]
                                                      [-n RUN_NAME]
                                                      [-d OUTPUT_DIR]
                                                      [--startat {converter,mapper,annotator,aggregator,postaggregator,reporter}]
                                                      [--endat {converter,mapper,annotator,aggregator,postaggregator,reporter}]
                                                      [--skip {converter,mapper,annotator,aggregator,postaggregator,reporter} [{converter,mapper,annotator,aggregator,postaggregator,reporter} ...]]
                                                      [-c CONF] [--cs CONFS]
                                                      [-v]
                                                      [-t REPORTS [REPORTS ...]]
                                                      [-l {hg38,hg19,hg18}]
                                                      [-x] [--newlog]
                                                      [--note NOTE] [--mp MP]
                                                      [-i {cravat,hgvs,oldcravat,vcf,clingen}]
                                                      [--temp-files]
                                                      [--writeadmindb]
                                                      [--jobid JOBID]
                                                      [--version]
                                                      [--separatesample]
                                                      [--primary-transcript [PRIMARY_TRANSCRIPT ...]]
                                                      [--cleanrun]
                                                      [--do-not-change-status]
                                                      [--module-option [MODULE_OPTION ...]]
                                                      [--system-option [SYSTEM_OPTION ...]]
                                                      [--user-email USER_EMAIL]
                                                      [--user-email-opt-out]
                                                      [--silent]
                                                      [--concise-report]
                                                      [--package PACKAGE]
                                                      [--filtersql FILTERSQL]
                                                      [--includesample INCLUDESAMPLE [INCLUDESAMPLE ...]]
                                                      [--excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]]
                                                      [-f FILTERPATH]
                                                      [--md MD]
                                                      [-m MAPPER_NAME [MAPPER_NAME ...]]
                                                      [-p POSTAGGREGATORS [POSTAGGREGATORS ...]]
                                                      [inputs ...]

Open-CRAVAT genomic variant interpreter. https://github.com/KarchinLab/open-
cravat. Use input_file_path arguments before any option or define them in a
conf file (option -c).

positional arguments:
  inputs                Input file(s). One or more variant files in a
                        supported format like VCF. See the -i/--input-format
                        flag for supported formats. In the special case where
                        you want to add annotations to an existing open-cravat
                        analysis, provide the output sqlite database from the
                        previous run as input instead of a variant input file.

options:
  -h, --help            show this help message and exit
  -a ANNOTATORS [ANNOTATORS ...]
                        Annotator module names or directories. If --package is
                        used also, annotator modules defined with -a will be
                        added.
  -A ANNOTATORS_REPLACE [ANNOTATORS_REPLACE ...]
                        Annotator module names or directories. If --package is
                        used also, annotator modules defined with -A will
                        replace those defined with --package. -A has priority
                        over -a.
  -e EXCLUDES [EXCLUDES ...]
                        annotators to exclude
  -n RUN_NAME           name of cravat run
  -d OUTPUT_DIR         directory for output files
  --startat {converter,mapper,annotator,aggregator,postaggregator,reporter}
                        starts at given stage
  --endat {converter,mapper,annotator,aggregator,postaggregator,reporter}
                        ends after given stage.
  --skip {converter,mapper,annotator,aggregator,postaggregator,reporter} [{converter,mapper,annotator,aggregator,postaggregator,reporter} ...]
                        skips given stage(s).
  -c CONF               path to a conf file
  --cs CONFS            configuration string
  -v                    verbose
  -t REPORTS [REPORTS ...]
                        Reporter types or reporter module directories
  -l, --liftover {hg38,hg19,hg18}
                        reference genome of input. CRAVAT will lift over to
                        hg38 if needed.
  -x                    deletes the existing result database and creates a new
                        one.
  --newlog              deletes the existing log file and creates a new one.
  --note NOTE           note will be written to the run status file
                        (.status.json)
  --mp MP               number of processes to use to run annotators
  -i, --input-format {cravat,hgvs,oldcravat,vcf,clingen}
                        Force input format
  --temp-files          Leave temporary files after run is complete.
  --writeadmindb        Write job information to admin db after job completion
  --jobid JOBID         Job ID for server version
  --version             Shows open-cravat version.
  --separatesample      Separate variant results by sample
  --primary-transcript [PRIMARY_TRANSCRIPT ...]
                        "mane" for MANE transcripts as primary transcripts, or
                        a path to a file of primary transcripts. MANE is
                        default.
  --cleanrun            Deletes all previous output files for the job and
                        generate new ones.
  --do-not-change-status
                        Job status in status.json will not be changed
  --module-option [MODULE_OPTION ...]
                        Module-specific option in module_name.key=value
                        syntax. For example, --module-option
                        vcfreporter.type=separate
  --system-option [SYSTEM_OPTION ...]
                        System option in key=value syntax. For example,
                        --system-option modules_dir=/home/user/open-
                        cravat/modules
  --user-email USER_EMAIL
                        User email for OpenCravat metrics
  --user-email-opt-out  Opt out of providing an email for OpenCravat metrics
  --silent              Runs silently.
  --concise-report      Generate concise reports with default columns defined
                        by each annotation module
  --package PACKAGE     Use package
  --filtersql FILTERSQL
                        Filter SQL
  --includesample INCLUDESAMPLE [INCLUDESAMPLE ...]
                        Sample IDs to include
  --excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]
                        Sample IDs to exclude
  -f FILTERPATH         Path to a filter file
  --md MD               Specify the root directory of OpenCRAVAT modules
                        (annotators, etc)
  -m MAPPER_NAME [MAPPER_NAME ...]
                        Mapper module name or mapper module directory
  -p POSTAGGREGATORS [POSTAGGREGATORS ...]
                        Postaggregators to run. Additionally, tagsampler,
                        casecontrol, varmeta, and vcfinfo will automatically
                        run depending on conditions.

inputs should be the first option

No input file was given.
/usr/local/lib/python3.13/site-packages/cravat/store_utils.py:13: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  import pkg_resources[help] oc run: ok via oc run (--help=ok, -h=ok, -help=ok, (no args)=ok)
```

## open-cravat_report

### Tool Description
Generate a report from an Open-CRAVAT result database.

### Metadata
- **Docker Image**: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
- **Homepage**: http://www.opencravat.org
- **Package**: https://anaconda.org/channels/bioconda/packages/open-cravat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oc report [-h] [-t REPORTTYPES [REPORTTYPES ...]] [-f FILTERPATH]
                 [--filtersql FILTERSQL] [-F FILTERNAME] [-s SAVEPATH]
                 [-c CONFPATH] [--module-name MODULE_NAME]
                 [--nogenelevelonvariantlevel] [--confs CONFS]
                 [--inputfiles INPUTFILES [INPUTFILES ...]] [--separatesample]
                 [-d OUTPUT_DIR] [--do-not-change-status] [--silent]
                 [--system-option [SYSTEM_OPTION ...]]
                 [--module-option [MODULE_OPTION ...]] [--concise-report]
                 [--includesample INCLUDESAMPLE [INCLUDESAMPLE ...]]
                 [--excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]]
                 [--package PACKAGE] [--md MD]
                 dbpath

positional arguments:
  dbpath                Path to aggregator output

options:
  -h, --help            show this help message and exit
  -t REPORTTYPES [REPORTTYPES ...]
                        report types
  -f FILTERPATH         Path to filter file
  --filtersql FILTERSQL
                        Filter SQL
  -F FILTERNAME         Name of filter (stored in aggregator output)
  -s SAVEPATH           Path to save file
  -c CONFPATH           path to a conf file
  --module-name MODULE_NAME
                        report module name
  --nogenelevelonvariantlevel
                        Use this option to prevent gene level result from
                        being added to variant level result.
  --confs CONFS         Configuration string
  --inputfiles INPUTFILES [INPUTFILES ...]
                        Original input file path
  --separatesample      Write each variant-sample pair on a separate line
  -d OUTPUT_DIR         directory for output files
  --do-not-change-status
                        Job status in status.json will not be changed
  --silent              Suppress output to STDOUT
  --system-option [SYSTEM_OPTION ...]
                        System option in key=value syntax. For example,
                        --system-option modules_dir=/home/user/open-
                        cravat/modules
  --module-option [MODULE_OPTION ...]
                        Module-specific option in module_name.key=value
                        syntax. For example, --module-option
                        vcfreporter.type=separate
  --concise-report      Generate concise report with default columns defined
                        by annotation modules
  --includesample INCLUDESAMPLE [INCLUDESAMPLE ...]
                        Sample IDs to include
  --excludesample EXCLUDESAMPLE [EXCLUDESAMPLE ...]
                        Sample IDs to exclude
  --package PACKAGE     Use filters and report types in a package
  --md MD               Specify the root directory of OpenCRAVAT modules
                        (annotators, etc)

dbpath must be the first argument
/usr/local/lib/python3.13/site-packages/cravat/store_utils.py:13: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  import pkg_resources
```

## open-cravat_vcfanno

### Tool Description
Annotate a VCF file with Open-CRAVAT annotators.

### Metadata
- **Docker Image**: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
- **Homepage**: http://www.opencravat.org
- **Package**: https://anaconda.org/channels/bioconda/packages/open-cravat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: oc vcfanno [-h] [-a [ANNOTATORS ...]] [-t THREADS]
                  [--temp-dir TEMP_DIR] [-o OUTPUT_PATH]
                  [--chunk-size CHUNK_SIZE]
                  input_path

positional arguments:
  input_path

options:
  -h, --help            show this help message and exit
  -a, --annotators [ANNOTATORS ...]
  -t, --threads THREADS
                        Number of CPU threads to use
  --temp-dir TEMP_DIR   Temporary directory for working files
  -o, --output-path OUTPUT_PATH
                        Output vcf path (gzipped). Defaults to
                        input_path.oc.vcf.gz
  --chunk-size CHUNK_SIZE
                        Number of lines to annotate in each thread before
                        syncing to disk. Affects performance.
/usr/local/lib/python3.13/site-packages/cravat/store_utils.py:13: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  import pkg_resources
```
