# ggd CWL Generation Report

## ggd_search

### Tool Description
Search for available ggd data packages. Results are filtered by match score from high to low. (Only 5 results will be reported unless the -dn flag is changed)

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gogetdata/ggd-cli
- **Stars**: N/A
### Original Help Text
```text
usage: ggd search [-h] [--search-type {both,combined-only,non-combined-only}]
                  [-g {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}]
                  [-s {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}]
                  [-dn DISPLAY_NUMBER] [-m MATCH_SCORE] [-c {genomics}]
                  search_term [search_term ...]

Search for available ggd data packages. Results are filtered by match score
from high to low. (Only 5 results will be reported unless the -dn flag is
changed)

positional arguments:
  search_term           **Required** The term(s) to search for. Multiple terms
                        can be used. Example: 'ggd search reference genome'

optional arguments:
  -h, --help            show this help message and exit
  --search-type {both,combined-only,non-combined-only}
                        (Optional) How to search for data packages with the
                        search terms provided. Options = 'combined-only',
                        'non-combined-only', and 'both'. 'combined-only' will
                        use the provided search terms as a single search term.
                        'non-combined-only' will use the provided search term
                        to search for data package that match each search term
                        separately. 'both' will use the search terms combined
                        and each search term separately to search for data
                        packages. Default = 'both'
  -g {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}, --genome-build {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}
                        (Optional) Filter results by the genome build of the
                        desired recipe
  -s {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}, --species {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}
                        (Optional) Filter results by the species for the
                        desired recipe
  -dn DISPLAY_NUMBER, --display-number DISPLAY_NUMBER
                        (Optional) The number of search results to display.
                        (Default = 5)
  -m MATCH_SCORE, --match-score MATCH_SCORE
                        (Optional) A score between 0 and 100 to use to filter
                        the results by. (Default = 90). The lower the number
                        the more results will be output
  -c {genomics}, --channel {genomics}
                        (Optional) The ggd channel to search. (Default =
                        genomics)
```


## ggd_predict-path

### Tool Description
Get a predicted install file path for a data package before it is installed. (Use for workflows, such as Snakemake)

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd predict-path [-h] [-c {genomics}] [--prefix PREFIX]
                        [--id meta-recipe ID] [--dir-path] [-fn FILE_NAME] -pn
                        PACKAGE_NAME

Get a predicted install file path for a data package before it is installed.
(Use for workflows, such as Snakemake)

optional arguments:
  -h, --help            show this help message and exit
  -c {genomics}, --channel {genomics}
                        The ggd channel of the recipe to find. (Default =
                        genomics)
  --prefix PREFIX       (Optional) The name or the full directory path to an
                        conda environment. The predicted path will be based on
                        this conda environment. When installing, the data
                        package should also be installed in this environment.
                        (Only needed if not predicting for a path in the
                        current conda environment)
  --id meta-recipe ID   (Optional) The ID to predict the path for if the
                        package is a meta-recipe. If it is not a meta-recipe
                        it will be ignored

One Argument Required:
  --dir-path            (Required if '--file-name' not used) Whether or not to
                        get the predicted directory path rather then the
                        predicted file path. If both --file-name and --dir-
                        path are provided the --file-name will be used and
                        --dir-path will be ignored
  -fn FILE_NAME, --file-name FILE_NAME
                        (Required if '--dir-path' not used) The name of the
                        file to predict that path for. It is best if you give
                        the full and correct name of the file to predict the
                        path for. If not, ggd will try to identify the right
                        file, but won't guarantee that it is the right file

Required Arguments:
  -pn PACKAGE_NAME, --package-name PACKAGE_NAME
                        (Required) The name of the data package to predict a
                        file path for
```


## ggd_install

### Tool Description
Install a ggd data package into the current or specified conda environment

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd install [-h] [-c {genomics}] [-d] [--file FILE] [--prefix PREFIX]
                   [--id Meta-recipe ID]
                   [name [name ...]]

Install a ggd data package into the current or specified conda environment

positional arguments:
  name                  The data package name to install. Can use more than
                        once (e.g. ggd install <pkg 1> <pkg 2> <pkg 3> ).
                        (NOTE: No need to designate version as it is
                        implicated in the package name)

optional arguments:
  -h, --help            show this help message and exit
  -c {genomics}, --channel {genomics}
                        The ggd channel the desired recipe is stored in.
                        (Default = genomics)
  -d, --debug           (Optional) When the -d flag is set debug output will
                        be printed to stdout.
  --file FILE           A file with a list of ggd data packages to install.
                        One package per line. Can use more than one (e.g. ggd
                        install --file <file_1> --file <file_2> )
  --prefix PREFIX       (Optional) The name or the full directory path to an
                        existing conda environment where you want to install a
                        ggd data package. (Only needed if you want to install
                        the data package into a different conda environment
                        then the one you are currently in)
  --id Meta-recipe ID   The ID to use for the meta recipe being installed. For
                        example, if installing the GEO meta-recipe for GEO
                        Accession ID GSE123, use `--id GSE123` NOTE: GGD will
                        NOT try to correct the ID. The ID must be accurately
                        entered with case sensitive alphanumeric order
```


## ggd_uninstall

### Tool Description
Use ggd to uninstall a ggd data package installed in the current conda environment

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd uninstall [-h] [-c {genomics}] names [names ...]

Use ggd to uninstall a ggd data package installed in the current conda
environment

positional arguments:
  names                 the name(s) of the ggd package(s) to uninstall

optional arguments:
  -h, --help            show this help message and exit
  -c {genomics}, --channel {genomics}
                        The ggd channel of the recipe to uninstall. (Default =
                        genomics)
```


## ggd_list

### Tool Description
Get a list of ggd data packages installed in the current or specified conda prefix/environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd list [-h] [-p PATTERN] [--prefix PREFIX]

Get a list of ggd data packages installed in the current or specified conda
prefix/environment.

optional arguments:
  -h, --help            show this help message and exit
  -p PATTERN, --pattern PATTERN
                        (Optional) pattern to match the name of the ggd data
                        package.
  --prefix PREFIX       (Optional) The name or the full directory path to a
                        conda environment where a ggd recipe is stored. (Only
                        needed if listing data files not in the current
                        environment)
```


## ggd_get-files

### Tool Description
Get a list of file(s) for a specific installed ggd package

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd get-files [-h] [-c {genomics}]
                     [-s {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}]
                     [-g {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}]
                     [-v VERSION] [-p PATTERN] [--prefix PREFIX]
                     name

Get a list of file(s) for a specific installed ggd package

positional arguments:
  name                  recipe name

optional arguments:
  -h, --help            show this help message and exit
  -c {genomics}, --channel {genomics}
                        The ggd channel of the recipe to find. (Default =
                        genomics)
  -s {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}, --species {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}
                        (Optional) species recipe is for. Use '*' for any
                        species
  -g {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}, --genome-build {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}
                        (Optional) genome build the recipe is for. Use '*' for
                        any genome build.
  -v VERSION, --version VERSION
                        (Optional) pattern to match the version of the file
                        desired. Use '*' for any version
  -p PATTERN, --pattern PATTERN
                        (Optional) pattern to match the name of the file
                        desired. To list all files for a ggd package, do not
                        use the -p option
  --prefix PREFIX       (Optional) The name or the full directory path to an
                        conda environment where a ggd recipe is stored. (Only
                        needed if not getting file paths for files in the
                        current conda environment)
```


## ggd_pkg-info

### Tool Description
Get the information for a specific ggd data package installed in the current
conda environment

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd pkg-info [-h] [-c {genomics}] [-sr] [--prefix PREFIX] name

Get the information for a specific ggd data package installed in the current
conda environment

positional arguments:
  name                  the name of the recipe to get info about

optional arguments:
  -h, --help            show this help message and exit
  -c {genomics}, --channel {genomics}
                        The ggd channel of the recipe to list info about
                        (Default = genomics)
  -sr, --show_recipe    (Optional) When the flag is set, the recipe will be
                        printed to the stdout. This will provide info on where
                        the data is hosted and how it was processed. (NOTE:
                        -sr flag does not accept arguments)
  --prefix PREFIX       (Optional) The name or the full directory path to a
                        conda environment where a ggd recipe is stored. (Only
                        needed if listing pkg data info for a pkg not
                        installed in the current environment)
```


## ggd_show-env

### Tool Description
Display the environment variables for data packages installed in the current
conda environment

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd show-env [-h] [-p PATTERN]

Display the environment variables for data packages installed in the current
conda environment

optional arguments:
  -h, --help            show this help message and exit
  -p PATTERN, --pattern PATTERN
                        regular expression pattern to match the name of the
                        variable desired
```


## ggd_make-recipe

### Tool Description
Make a ggd data recipe from a bash script

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd make-recipe [-h] [-c {genomics}] [-d DEPENDENCY] [-e EXTRA_FILE]
                       [-p {noarch,none}] -s
                       {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}
                       -g
                       {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}
                       [--authors AUTHORS] -pv PACKAGE_VERSION -dv
                       DATA_VERSION -dp DATA_PROVIDER --summary SUMMARY -k
                       KEYWORD -cb
                       {0-based-inclusive,0-based-exclusive,1-based-inclusive,1-based-exclusive,NA}
                       -n NAME
                       script

Make a ggd data recipe from a bash script

optional arguments:
  -h, --help            show this help message and exit
  -c {genomics}, --channel {genomics}
                        the ggd channel to use. (Default = genomics)
  -d DEPENDENCY, --dependency DEPENDENCY
                        any software dependencies (in bioconda, conda-forge)
                        or data-dependency (in ggd). May be as many times as
                        needed.
  -e EXTRA_FILE, --extra-file EXTRA_FILE
                        any files that the recipe creates that are not a *.gz
                        and *.gz.tbi pair or *.fa and *.fai pair. May be used
                        more than once
  -p {noarch,none}, --platform {noarch,none}
                        Whether to use noarch as the platform or the system
                        platform. If set to 'none' the system platform will be
                        used. (Default = noarch. Noarch means no architecture
                        and is platform agnostic.)

required arguments:
  -s {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}, --species {Canis_familiaris,Danio_rerio,Drosophila_melanogaster,Homo_sapiens,Mus_musculus,meta-recipe}
                        The species recipe is for
  -g {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}, --genome-build {GRCh37,GRCh38,GRCz10,GRCz11,canFam3,danRer10,danRer11,dm3,dm6,hg19,hg38,meta-recipe,mm10,mm9}
                        The genome build the recipe is for
  --authors AUTHORS     The author(s) of the data recipe being created, (This
                        recipe)
  -pv PACKAGE_VERSION, --package-version PACKAGE_VERSION
                        The version of the ggd package. (First time package =
                        1, updated package > 1)
  -dv DATA_VERSION, --data-version DATA_VERSION
                        The version of the data (itself) being downloaded and
                        processed (EX: dbsnp-127) If there is no data version
                        apparent we recommend you use the date associated with
                        the files or something else that can uniquely identify
                        the 'version' of the data
  -dp DATA_PROVIDER, --data-provider DATA_PROVIDER
                        The data provider where the data was accessed.
                        (Example: UCSC, Ensembl, gnomAD, etc.)
  --summary SUMMARY     A detailed comment describing the recipe
  -k KEYWORD, --keyword KEYWORD
                        A keyword to associate with the recipe. May be
                        specified more that once. Please add enough keywords
                        to better describe and distinguish the recipe
  -cb {0-based-inclusive,0-based-exclusive,1-based-inclusive,1-based-exclusive,NA}, --coordinate-base {0-based-inclusive,0-based-exclusive,1-based-inclusive,1-based-exclusive,NA}
                        The genomic coordinate basing for the file(s) in the
                        recipe. That is, the coordinates start at genomic
                        coordinate 0 or 1, and the end coordinate is either
                        inclusive (everything up to and including the end
                        coordinate) or exclusive (everything up to but not
                        including the end coordinate) Files that do not have
                        coordinate basing, like fasta files, specify NA for
                        not applicable.
  -n NAME, --name NAME  The sub-name of the recipe being created. (e.g. cpg-
                        islands, pfam-domains, gaps, etc.) This will not be
                        the final name of the recipe, but will specific to the
                        data gathered and processed by the recipe
  script                bash script that contains the commands to obtain and
                        process the data
```


## ggd_make-meta-recipe

### Tool Description
Make a ggd data meta-recipe

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd make-meta-recipe [-h] [-c {genomics}] [-d DEPENDENCY]
                            [-p {noarch,none}] [-s SPECIES] [-g GENOME_BUILD]
                            [-dv DATA_VERSION]
                            [-cb {0-based-inclusive,0-based-exclusive,1-based-inclusive,1-based-exclusive,NA}]
                            [--extra-scripts [Extra Scripts [Extra Scripts ...]]]
                            [--authors AUTHORS] -pv PACKAGE_VERSION -dp
                            DATA_PROVIDER --summary SUMMARY -k KEYWORD -n NAME
                            script

Make a ggd data meta-recipe

optional arguments:
  -h, --help            show this help message and exit
  -c {genomics}, --channel {genomics}
                        the ggd channel to use. (Default = genomics)
  -d DEPENDENCY, --dependency DEPENDENCY
                        any software dependencies (in bioconda, conda-forge)
                        or data-dependency (in ggd). May be as many times as
                        needed.
  -p {noarch,none}, --platform {noarch,none}
                        Whether to use noarch as the platform or the system
                        platform. If set to 'none' the system platform will be
                        used. (Default = noarch. Noarch means no architecture
                        and is platform agnostic.)
  -s SPECIES, --species SPECIES
                        The species recipe is for. Use 'meta-recipe` for a
                        metarecipe file
  -g GENOME_BUILD, --genome-build GENOME_BUILD
                        The genome build the recipe is for. Use 'metarecipe'
                        for a metarecipe file
  -dv DATA_VERSION, --data-version DATA_VERSION
                        The version of the data (itself) being downloaded and
                        processed (EX: dbsnp-127). Use 'metarecipe' for a
                        metarecipe
  -cb {0-based-inclusive,0-based-exclusive,1-based-inclusive,1-based-exclusive,NA}, --coordinate-base {0-based-inclusive,0-based-exclusive,1-based-inclusive,1-based-exclusive,NA}
                        The genomic coordinate basing for the file(s) in the
                        recipe. Use 'NA' for a metarecipe
  --extra-scripts [Extra Scripts [Extra Scripts ...]]
                        Any additional scripts used for the metarecipe that
                        are not the main bash script

required arguments:
  --authors AUTHORS     The author(s) of the data metarecipe being created,
                        (This recipe)
  -pv PACKAGE_VERSION, --package-version PACKAGE_VERSION
                        The version of the ggd package. (First time package =
                        1, updated package > 1)
  -dp DATA_PROVIDER, --data-provider DATA_PROVIDER
                        The data provider where the data was accessed.
                        (Example: UCSC, Ensembl, gnomAD, etc.)
  --summary SUMMARY     A detailed comment describing the recipe
  -k KEYWORD, --keyword KEYWORD
                        A keyword to associate with the recipe. May be
                        specified more that once. Please add enough keywords
                        to better describe and distinguish the recipe
  -n NAME, --name NAME  The sub-name of the recipe being created. (e.g. cpg-
                        islands, pfam-domains, gaps, etc.) This will not be
                        the final name of the recipe, but will specific to the
                        data gathered and processed by the recipe
  script                bash script that contains the commands for the
                        metarecipe.
```


## ggd_check-recipe

### Tool Description
Convert a ggd recipe created from `ggd make-recipe` into a data package. Test both ggd data recipe and data package

### Metadata
- **Docker Image**: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
- **Homepage**: https://github.com/gogetdata/ggd-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ggd/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ggd check-recipe [-h] [-d] [-du] [--id Meta-recipe ID] recipe_path

Convert a ggd recipe created from `ggd make-recipe` into a data package. Test
both ggd data recipe and data package

positional arguments:
  recipe_path           path to recipe directory (can also be path to the
                        .bz2)

optional arguments:
  -h, --help            show this help message and exit
  -d, --debug           (Optional) Set the stdout log level to debug
  -du, --dont_uninstall
                        (Optional) By default the newly installed local ggd
                        data package is uninstalled after the check has
                        finished. To bypass this uninstall step (to keep the
                        local package installed) set this flag "--
                        dont_uninstall"
  --id Meta-recipe ID   If checking a meta-recipe the associated meta-recipe
                        id needs to be supplied. (Example: for a geo meta-
                        recipe use something like --id GSE123) NOTE: GGD does
                        not try to correct the ID. Please provide the correct
                        case sensitive ID.
```

