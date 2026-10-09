# macsylib CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| macsylib_msl_data_available | PASS |  |
| macsylib_msl_data_check | PASS |  |
| macsylib_msl_data_definition | PASS |  |
| macsylib_msl_data_download | Failed | tool bug: msl_data download always crashes with AttributeError (code reads args.package, option is model_package) |
| macsylib_msl_data_freeze | Failed | tool bug: --models-dir is ignored, so freeze prints nothing for packages outside the default folder |
| macsylib_msl_data_info | PASS |  |
| macsylib_msl_data_init | PASS |  |
| macsylib_msl_data_install | PASS |  |
| macsylib_msl_data_list | PASS |  |
| macsylib_msl_data_search | PASS |  |
| macsylib_msl_data_show | PASS |  |
| macsylib_msl_data_uninstall | PASS |  |

## macsylib_msl_data_available

### Tool Description
List Models available on macsy-models

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data available [-h] [--org ORG]

options:
  -h, --help  show this help message and exit
  --org ORG   The name of Model organization(default 'macsy-models'))
```

## macsylib_msl_data_check

### Tool Description
check if the directory is ready to be publish as data package

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data check [-h] [--grammar {2.0,2.1}] [path]

positional arguments:
  path                 the path to root directory models to check

options:
  -h, --help           show this help message and exit
  --grammar {2.0,2.1}  The version of the target grammar. Note that for the
                       grammar '2.0' only basic checking is performed. For
                       thorough checking choose '2.1'. (default: '2.1')
```

## macsylib_msl_data_definition

### Tool Description
show a model definition

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data definition [-h] [--models-dir MODELS_DIR] model [model ...]

positional arguments:
  model                 the family and name(s) of a model(s) eg: TXSS T6SS
                        T4SS or TFF/bacterial T2SS

options:
  -h, --help            show this help message and exit
  --models-dir MODELS_DIR
                        the path to the alternative root directory containing
                        packages instead to the canonical locations
```

## macsylib_msl_data_download

### Tool Description
Download model packages.

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data download [-h] [-d DEST] [--org ORG] model_package

positional arguments:
  model_package    Model package name.

options:
  -h, --help       show this help message and exit
  -d, --dest DEST  Download model packages into <dir>.
  --org ORG        The name of Model organization(default 'macsy-models'))
```

## macsylib_msl_data_freeze

### Tool Description
List installed models in requirements format.

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data freeze [-h] [--models-dir MODELS_DIR]

options:
  -h, --help            show this help message and exit
  --models-dir MODELS_DIR
                        the path of the alternative root directory containing
                        package instead used canonical locations
```

## macsylib_msl_data_info

### Tool Description
Show information about packages.

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data info [-h] [--models-dir MODELS_DIR] model_package

positional arguments:
  model_package         Model Package name.

options:
  -h, --help            show this help message and exit
  --models-dir MODELS_DIR
                        the path of the alternative root directory containing
                        package instead used canonical locations
```

## macsylib_msl_data_init

### Tool Description
Create a template for a new data package (requires git/GitPython)

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data init [-h] --model-package MODEL_PACKAGE
                     --maintainer MAINTAINER --email EMAIL --authors AUTHORS
                     [--license {cc-by,cc-by-sa,cc-by-nc,cc-by-nc-sa,cc-by-nc-nd}]
                     [--holders HOLDERS] [--desc DESC]
                     [--models-dir MODELS_DIR]

options:
  -h, --help            show this help message and exit
  --model-package MODEL_PACKAGE
                        The name of the model data package.
  --maintainer MAINTAINER
                        The name of the model package maintainer.
  --email EMAIL         The email of the model package maintainer.
  --authors AUTHORS     The authors of the model package. Could be different
                        that the maintainer.Could be several persons. Surround
                        the names by quotes 'John Doe, Richard Miles'
  --license {cc-by,cc-by-sa,cc-by-nc,cc-by-nc-sa,cc-by-nc-nd}
                        The license under this work will be released. if the
                        license you choice is not in the list, you can do it
                        manually by adding the license file in package and add
                        suitable headers in model definitions.
  --holders HOLDERS     The holders of the copyright
  --desc DESC           A short description (one line) of the package
  --models-dir MODELS_DIR
                        The path of an alternative models directory by default
                        the package will be created here.
```

## macsylib_msl_data_install

### Tool Description
Install Model packages.

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data install [-h] [-f] [--org ORG] [-u | -t TARGET] [-U]
                        model_package

positional arguments:
  model_package         Model Package name.

options:
  -h, --help            show this help message and exit
  -f, --force           Reinstall Model package even if it is already up-to-
                        date.
  --org ORG             The name of Model organization(default 'macsy-
                        models'))
  -u, --user            Install for the user install directory for your
                        platform. Typically ~/.macsylib/data
  -t, --target, --models-dir TARGET
                        Install packages into <TARGET> dir instead in
                        canonical location
  -U, --upgrade         Upgrade specified package to the newest available
                        version.
```

## macsylib_msl_data_list

### Tool Description
List installed packages.

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data list [-h] [-o] [-u] [--org ORG] [--models-dir MODELS_DIR]
                     [--long] [-v]

options:
  -h, --help            show this help message and exit
  -o, --outdated        List outdated packages.
  -u, --uptodate        List uptodate packages
  --org ORG             The name of Model organization(default macsy-models))
  --models-dir MODELS_DIR
                        the path of the alternative root directory containing
                        package instead used canonical locations
  --long, -l            in addition displays the path where is store each
                        package
  -v                    alias for -l/--long option
```

## macsylib_msl_data_search

### Tool Description
Searches for model packages matching a pattern

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data search [-h] [--org ORG] [-S] [--match-case] pattern

positional arguments:
  pattern        Searches for packages matching the pattern.

options:
  -h, --help     show this help message and exit
  --org ORG      The name of Model organization(default macsy-models))
  -S, --careful
  --match-case
```

## macsylib_msl_data_show

### Tool Description
show the structure of model package

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data show [-h] [--models-dir MODELS_DIR] model

positional arguments:
  model                 a model package name eg: TXSScan or CasFinder

options:
  -h, --help            show this help message and exit
  --models-dir MODELS_DIR
                        the path to the alternative root directory containing
                        packages instead to the canonical locations
```

## macsylib_msl_data_uninstall

### Tool Description
Uninstall packages.

### Metadata
- **Docker Image**: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
- **Homepage**: https://github.com/gem-pasteur/macsylib
- **Package**: https://anaconda.org/channels/bioconda/packages/macsylib/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msl_data uninstall [-h] [--target, --models-dir MODELS_DIR]
                          model_package

positional arguments:
  model_package         ModelPackage name.

options:
  -h, --help            show this help message and exit
  --target, --models-dir MODELS_DIR
                        the path of the alternative root directory containing
                        package instead used canonical locations
```

