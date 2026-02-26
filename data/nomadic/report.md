# nomadic CWL Generation Report

## nomadic_start

### Tool Description
Get started with nomadic.

This command will help you set up a new workspace for a specific organism.

Currently supported organisms:
- Plasmodium falciparum (pfalciparum)
- Anopheles gambiae (agambiae)

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Total Downloads**: 434
- **Last updated**: 2026-01-07
- **GitHub**: https://github.com/JasonAHendry/nomadic
- **Stars**: N/A
### Original Help Text
```text
Usage: nomadic start [OPTIONS] [[pfalciparum|agambiae]]

  Get started with nomadic.

  This command will help you set up a new workspace for a specific organism.

  Currently supported organisms:
  - Plasmodium falciparum (pfalciparum)
  - Anopheles gambiae (agambiae)

Options:
  -w, --workspace PATH  Path to workspace.  [required]
  --help                Show this message and exit.
```


## nomadic_download

### Tool Description
Download target reference genome by specifying a `reference_name`, or download all available genomes with the `--all` flag

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nomadic download [OPTIONS]

  Download target reference genome by specifying a `reference_name`, or
  download all available genomes with the `--all` flag

Options:
  -r, --reference_name [Pf3D7|PfDd2|Pv|Poc|Pm|AgPEST|AaDONGOLA2021|AcolN3|AfunGA1|AsUCISS2018|Hs]
                                  Choose a reference genome to download by
                                  name.
  --all                           Download all reference genomes available.
  --help                          Show this message and exit.
```


## nomadic_realtime

### Tool Description
Analyse data being produced by MinKNOW while sequencing is ongoing

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nomadic realtime [OPTIONS] EXPERIMENT_NAME

  Analyse data being produced by MinKNOW while sequencing is ongoing

Options:
  -w, --workspace DIRECTORY       Path of the workspace where all input/output
                                  files (beds, metadata, results) are stored.
                                  The workspace directory simplifies the use
                                  of nomadic in that many arguments don't need
                                  to be listed as they are predefined in the
                                  workspace config or can be loaded from the
                                  workspace  [default: (current directory)]
   TEXT
  -o, --output DIRECTORY          Path to the output directory where results
                                  of this experiment will be stored. Usually
                                  the default of storing it in the workspace
                                  should be enough.  [default:
                                  (<workspace>/results/<experiment_name>)]
  -k, --minknow_dir DIRECTORY     Path to the minknow output directory. Can be
                                  either the base directory, e.g.
                                  /var/lib/minknow/data, or the directory of
                                  the experiment, e.g.
                                  /var/lib/minknow/data/<experiment_name>.
                                  [default: /var/lib/minknow/data]
  -f, --fastq_dir DIRECTORY       Path or glob to the fastq files. This should
                                  only be used when the full minknow dir can
                                  not be provided, as some features likes
                                  backup will not work. Prefer using
                                  --minknow_dir. If --fastq_dir is provided,
                                  --minknow_dir is ignored.
  -m, --metadata_path FILE        Path to metadata file (CSV or XLSX (Excel))
                                  containing barcode and sample information.
                                  [default: (<workspace>/metadata/<experiment_
                                  name>.csv)]
  -b, --region_bed PATH           Path to BED file specifying genomic regions
                                  of interest or name of panel, e.g. 'nomads8'
                                  or 'nomadsMVP'.  [required]
  -r, --reference_name [Pf3D7|PfDd2|Pv|Poc|Pm|AgPEST|AaDONGOLA2021|AcolN3|AfunGA1|AsUCISS2018|Hs]
                                  Choose a reference genome to be used in
                                  real-time analysis.  [required]
  --call                          Perform preliminary variant calling of
                                  biallelic SNPs in real-time. (Deprecated,
                                  use --caller instead)
  -c, --caller [bcftools|delve]   Call biallelic SNPs in real-time with the
                                  indicated variant caller. If this flag is
                                  omitted, no variant calling is performed.
  --overwrite                     Overwrite existing output directory if it
                                  exists.
  --resume                        Resume a previous experiment run if the
                                  output directory already exists. Only use if
                                  you want to force resuming an already
                                  started experiment. Not needed in
                                  interactive mode as this will be prompted
  --dashboard / --no-dashboard    Whether to start the web dashboard to
                                  monitor the run.
  -v, --verbose                   Increase logging verbosity. Helpful for
                                  debugging.
  --help                          Show this message and exit.
```


## nomadic_process

### Tool Description
(Re)Process data that was produced by MinKNOW

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nomadic process [OPTIONS] EXPERIMENT_NAME

  (Re)Process data that was produced by MinKNOW

Options:
  -w, --workspace DIRECTORY       Path of the workspace where all input/output
                                  files (beds, metadata, results) are stored.
                                  The workspace directory simplifies the use
                                  of nomadic in that many arguments don't need
                                  to be listed as they are predefined in the
                                  workspace config or can be loaded from the
                                  workspace  [default: (current directory)]
   TEXT
  -o, --output DIRECTORY          Path to the output directory where results
                                  of this experiment will be stored. Usually
                                  the default of storing it in the workspace
                                  should be enough.  [default:
                                  (<workspace>/results/<experiment_name>)]
  -k, --minknow_dir DIRECTORY     Path to the minknow output directory. Can be
                                  either the base directory, e.g.
                                  /var/lib/minknow/data, or the directory of
                                  the experiment, e.g.
                                  /var/lib/minknow/data/<experiment_name>.
                                  [default: /var/lib/minknow/data]
  -f, --fastq_dir DIRECTORY       Path or glob to the fastq files. This should
                                  only be used when the full minknow dir can
                                  not be provided, as some features likes
                                  backup will not work. Prefer using
                                  --minknow_dir. If --fastq_dir is provided,
                                  --minknow_dir is ignored.
  -m, --metadata_csv FILE         Path to metadata CSV file containing barcode
                                  and sample information.  [default: (<workspa
                                  ce>/metadata/<experiment_name>.csv)]
  -b, --region_bed PATH           Path to BED file specifying genomic regions
                                  of interest or name of panel, e.g. 'nomads8'
                                  or 'nomadsMVP'.  [required]
  -r, --reference_name [Pf3D7|PfDd2|Pv|Poc|Pm|AgPEST|AaDONGOLA2021|AcolN3|AfunGA1|AsUCISS2018|Hs]
                                  Choose a reference genome to be used in
                                  real-time analysis.  [required]
  -c, --caller [bcftools|delve]   Call biallelic SNPs in real-time with the
                                  indicated variant caller. If this flag is
                                  omitted, no variant calling is performed.
  --overwrite                     Overwrite existing output directory if it
                                  exists.
  --resume                        Resume processing a previous experiment if
                                  the output directory already exists. This is
                                  necessary to pick of processing of an
                                  experiment that was aborted.
  -v, --verbose                   Increase logging verbosity. Helpful for
                                  debugging.
  --help                          Show this message and exit.
```


## nomadic_dashboard

### Tool Description
Launch the dashboard without performing real-time analysis, used to view results of a previous experiment.

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nomadic dashboard [OPTIONS] EXPERIMENT

  Launch the dashboard without performing real-time analysis, used to view
  results of a previous experiment.

  EXPERIMENT can be the name of an previous experiment, located in
  <workspace>/results/<experiment_name>, or a path to a directory containing
  the results of a previous experiment.

Options:
  -w, --workspace DIRECTORY  Path of the workspace where all input/output
                             files (beds, metadata, results) are stored. The
                             workspace directory simplifies the use of nomadic
                             in that many arguments don't need to be listed as
                             they are predefined in the workspace config or
                             can be loaded from the workspace  [default:
                             (current directory)]
  --help                     Show this message and exit.
```


## nomadic_share

### Tool Description
Share summary nomadic workspace and associated minknow data to another folder e.g. a cloud synchronised folder for sharing.

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nomadic share [OPTIONS]

  Share summary nomadic workspace and associated minknow data to another
  folder e.g. a cloud synchronised folder for sharing.

Options:
  -w, --workspace DIRECTORY       Path of the workspace where all input/output
                                  files (beds, metadata, results) are stored.
                                  The workspace directory simplifies the use
                                  of nomadic in that many arguments don't need
                                  to be listed as they are predefined in the
                                  workspace config or can be loaded from the
                                  workspace  [default: (current directory)]
   TEXT
  -t, --target_dir DIRECTORY      Path to target folder, local or an SSH
                                  target like user@host:/path. The shared
                                  files will go inside of that folder into a
                                  folder with the name of the workspace.
                                  [required]
  -k, --minknow_dir DIRECTORY     Path to minknow output directory (default it
                                  usually sufficient)  [default:
                                  (/var/lib/minknow/data)]
  --include-minknow / --exclude-minknow
                                  Include/exclude minknow data  [default:
                                  include-minknow]
  -v, --verbose                   Increase logging verbosity, will show files
                                  that are copied.
  -c, --checksum                  Use checksum check instead of file size and
                                  modification time.
  --update / --overwrite          Update will not overwrite files that are
                                  newer.  [default: update]
  --help                          Show this message and exit.
```


## nomadic_backup

### Tool Description
Backup entire nomadic workspace and associated minknow data to a different folder e.g. on a local hard disk drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nomadic backup [OPTIONS]

  Backup entire nomadic workspace and associated minknow data to a different
  folder e.g. on a local hard disk drive.

Options:
  -w, --workspace DIRECTORY       Path of the workspace where all input/output
                                  files (beds, metadata, results) are stored.
                                  The workspace directory simplifies the use
                                  of nomadic in that many arguments don't need
                                  to be listed as they are predefined in the
                                  workspace config or can be loaded from the
                                  workspace  [default: (current directory)]
   TEXT
  -t, --target_dir DIRECTORY      Path to root target backup folder, local or
                                  an SSH target like user@host:/path. The
                                  backup will go into
                                  <target>/<workspace_name>.  [required]
  -k, --minknow_dir DIRECTORY     Path to the base minknow output directory.
                                  Only needed if the files were moved.
                                  [default: /var/lib/minknow/data]
  --include-minknow / --exclude-minknow
                                  Include/exclude minknow data in the backup.
                                  [default: include-minknow]
  -v, --verbose                   Increase logging verbosity, will show files
                                  that are copied.
  -c, --checksum                  Use checksum check instead of file size and
                                  modification time.
  --help                          Show this message and exit.
```


## nomadic_configure

### Tool Description
Configure different nomadics functionality. This mostly sets standard
  options in '.config.yaml' that can be overwritten from the command line.

### Metadata
- **Docker Image**: quay.io/biocontainers/nomadic:0.7.2--pyhdfd78af_0
- **Homepage**: https://jasonahendry.github.io/nomadic/
- **Package**: https://anaconda.org/channels/bioconda/packages/nomadic/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nomadic configure [OPTIONS] COMMAND [ARGS]...

  Configure different nomadics functionality. This mostly sets standard
  options in '.config.yaml' that can be overwritten from the command line.

Options:
  --help  Show this message and exit.

Commands:
  backup  Configure the nomadic backup command.
  share   Configure the nomadic share command.
```

