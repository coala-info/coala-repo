☰
[ ]

[![Bin Chicken logo](/binchicken/binchicken_logo.png)](/binchicken/)

## [Bin Chicken](/binchicken/)

S

* [installation](/binchicken/installation)
* [setup](/binchicken/setup)
* [usage](/binchicken/usage)
* [demo](/binchicken/demo)
* [tools](/binchicken/tools)

+ [Bin Chicken coassemble](/binchicken/tools/coassemble)
+ [Bin Chicken single](/binchicken/tools/single)
+ [Bin Chicken update](/binchicken/tools/update)
+ [Bin Chicken iterate](/binchicken/tools/iterate)
+ [Bin Chicken evaluate](/binchicken/tools/evaluate)
+ [Bin Chicken build](/binchicken/tools/build)

# Environment setup

Bin Chicken uses separate conda environments for each subprocess.
Run `binchicken build` to create those subprocess conda environments and setup environment variables.
This can take upwards of 30 minutes to complete, depending on the speed of your internet connection.

Conda prefix is the directory you want to contain the subprocess conda environments.
SingleM metapackage is the metapackage downloaded by SingleM using `singlem data` (see <https://github.com/wwood/singlem>).

The latter databases are required only if you want to run Aviary directly using the `--run-aviary` argument.
GTDB-Tk database is the directory containing the GTDB-Tk release (see <https://github.com/Ecogenomics/GTDBTk>).
CheckM2 database is the directory containing the CheckM2 database (see <https://github.com/chklovski/CheckM2>).
These can also be downloaded automatically with `--download-databases` flag, which uses Aviary (`aviary configure --download gtdb singlem checkm2`, see <https://github.com/rhysnewell/aviary>).
If you use this flag, note that it will only download the databases if the provided path does *not* already exist.
Also note that the databases are very large.

Note that CheckM2 downloading is currently broken (see <https://github.com/chklovski/CheckM2/issues/134>), so it is recommended to download the CheckM2 database manually from <https://zenodo.org/record/14897628> and provide the path using `--checkm2-db` or the `CHECKM2DB` environment variable.

```
# CheckM2 database manual download example
mkdir -p /checkm2/db/
wget https://zenodo.org/api/records/14897628/files/checkm2_database.tar.gz/content -O /checkm2/db/checkm2_database.tar.gz
tar -xvzf /checkm2/db/checkm2_database.tar.gz -C /checkm2/db/

binchicken build \
  --singlem-metapackage /metapackage/dir \
  --checkm2-db /checkm2/db/CheckM2_database \
  # Optional: for use with Aviary comprehensive (`--aviary-speed comprehensive`)
  --gtdbtk-db /gtdb/release/dir \
  # Optional: for use with taxvamb extra binner (`--aviary-extra-binners taxvamb`)
  --metabuli-db /metabuli/db/dir
```

Alternatively, set directory to contain subprocess conda environments and environment variables manually.
Subprocess conda environments will be created when required.

```
conda env config vars set SINGLEM_METAPACKAGE_PATH="/metapackage/dir"
conda env config vars set CHECKM2DB="/checkm2/db/CheckM2_database"
# Optional: for use with Aviary comprehensive (`--aviary-speed comprehensive`)
conda env config vars set GTDBTK_DATA_PATH="/gtdb/release/dir"
# Optional: for use with taxvamb extra binner (`--aviary-extra-binners taxvamb`)
conda env config vars set METABULI_DB_PATH="/metabuli/db/dir"
```

## Common issues

### Too many open files (os error 24)

If you encounter "Too many open files" errors, you may need to increase the maximum number of open file descriptors.
Try running `ulimit -n 10000` before rerunning Bin Chicken.

On this page

* [Environment setup](#environment-setup)
* [Common issues](#common-issues)
* [Too many open files (os error 24)](#too-many-open-files-(os-error-24))

Powered by [Doctave](https://cli.doctave.com)