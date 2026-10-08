# fusion-report CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fusion-report_download | PASS | ran with --no-cosmic --no-fusiongdb2: the Mitelman database was built (57,782 rows); the FusionGDB2 download returns an invalid file, so it was not used |
| fusion-report_run | Not completed | needs the COSMIC database (account) or FusionGDB2 (download fails); with Mitelman only the tool crashes with a division by zero, as the db flags are swapped in the code |
| fusion-report_sync | Not completed | needs COSMIC credentials (account) |

## fusion-report_run

### Tool Description
Run application: merge the outputs of several fusion detection tools, annotate them with fusion databases and write an HTML report.

### Metadata
- **Docker Image**: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
- **Homepage**: https://github.com/matq007/fusion-report
- **Package**: https://anaconda.org/channels/bioconda/packages/fusion-report/overview
- **Validation**: PASS

### Original Help Text
```text
[help] fusion_report run: ok via fusion_report run --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: fusion_report run [-h] [--ericscript ERICSCRIPT]
                         [--ericscript_weight ERICSCRIPT_WEIGHT]
                         [--fusioncatcher FUSIONCATCHER]
                         [--fusioncatcher_weight FUSIONCATCHER_WEIGHT]
                         [--starfusion STARFUSION]
                         [--starfusion_weight STARFUSION_WEIGHT]
                         [--pizzly PIZZLY] [--pizzly_weight PIZZLY_WEIGHT]
                         [--squid SQUID] [--squid_weight SQUID_WEIGHT]
                         [--dragen DRAGEN] [--dragen_weight DRAGEN_WEIGHT]
                         [--arriba ARRIBA] [--arriba_weight ARRIBA_WEIGHT]
                         [--jaffa JAFFA] [--jaffa_weight JAFFA_WEIGHT]
                         [--ctat_lr_fusion CTAT_LR_FUSION]
                         [--ctat_lr_fusion_weight CTAT_LR_FUSION_WEIGHT]
                         [--allow-multiple-gene-symbols] [-c CONFIG]
                         [-t TOOL_CUTOFF] [--export EXPORT] [--no-cosmic]
                         [--no-fusiongdb2] [--no-mitelman]
                         sample output db_path

options:
  -h, --help            show this help message and exit
  --no-cosmic           Do not download cosmic fusion database
  --no-fusiongdb2       Do not download fusiongdb2 fusion database
  --no-mitelman         Do not download mitelman fusion database

Mandatory arguments:
  Required arguments to run app.

  sample                Sample name
  output                Output directory
  db_path               Path to folder where all databases are stored.

Tools:
  List of all supported tools with their weights.

  --ericscript ERICSCRIPT
                        EricScript output file
  --ericscript_weight ERICSCRIPT_WEIGHT
                        EricScript output file
  --fusioncatcher FUSIONCATCHER
                        Fusioncatcher output file
  --fusioncatcher_weight FUSIONCATCHER_WEIGHT
                        Fusioncatcher output file
  --starfusion STARFUSION
                        STAR-Fusion output file
  --starfusion_weight STARFUSION_WEIGHT
                        STAR-Fusion output file
  --pizzly PIZZLY       Pizzly output file
  --pizzly_weight PIZZLY_WEIGHT
                        Pizzly output file
  --squid SQUID         Squid output file
  --squid_weight SQUID_WEIGHT
                        Squid output file
  --dragen DRAGEN       Illumina Dragen Bio-IT Platform output file
  --dragen_weight DRAGEN_WEIGHT
                        Illumina Dragen Bio-IT Platform output file
  --arriba ARRIBA       Arriba output file
  --arriba_weight ARRIBA_WEIGHT
                        Arriba output file
  --jaffa JAFFA         Jaffa output file
  --jaffa_weight JAFFA_WEIGHT
                        Jaffa output file
  --ctat_lr_fusion CTAT_LR_FUSION
                        CTAT-LR-Fusion output file
  --ctat_lr_fusion_weight CTAT_LR_FUSION_WEIGHT
                        CTAT-LR-Fusion output file

Optionals:
  List of optional configuration parameters.

  --allow-multiple-gene-symbols
                        Case when fusion gene symbol can't be determined and
                        multiple fusion options are provided. By default
                        provide the fist proposed fusion.
  -c, --config CONFIG   Input config file
  -t, --tool-cutoff TOOL_CUTOFF
                        Number of tools required to detect a fusion
  --export EXPORT       Export fusions in different formats. Currently
                        supported: json, csv.
```

## fusion-report_download

### Tool Description
Download required databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
- **Homepage**: https://github.com/matq007/fusion-report
- **Package**: https://anaconda.org/channels/bioconda/packages/fusion-report/overview
- **Validation**: PASS

### Original Help Text
```text
[help] fusion_report download: ok via fusion_report download --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: fusion_report download [-h] [--no-cosmic] [--no-fusiongdb2]
                              [--no-mitelman] [-no_ssl]
                              [--cosmic_usr COSMIC_USR]
                              [--cosmic_passwd COSMIC_PASSWD]
                              [--cosmic_token COSMIC_TOKEN] [--qiagen]
                              output

positional arguments:
  output                Output directory

options:
  -h, --help            show this help message and exit
  --no-cosmic           Do not download cosmic fusion database
  --no-fusiongdb2       Do not download fusiongdb2 fusion database
  --no-mitelman         Do not download mitelman fusion database
  -no_ssl               Turn off verification of SSL certificates when
                        downloading data.

COSMIC:
  Option credential parameters. You can either provide username and password
  which will be used to generate base64 token or the token itself.

  --cosmic_usr COSMIC_USR
                        COSMIC username
  --cosmic_passwd COSMIC_PASSWD
                        COSMIC password
  --cosmic_token COSMIC_TOKEN
                        COSMIC token
  --qiagen              Use QIAGEN to download COSMIC db (commercial usage)
```

## fusion-report_sync

### Tool Description
Synchronize databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
- **Homepage**: https://github.com/matq007/fusion-report
- **Package**: https://anaconda.org/channels/bioconda/packages/fusion-report/overview
- **Validation**: PASS

### Original Help Text
```text
[help] fusion_report sync: ok via fusion_report sync --help (--help=ok, -h=ok, -help=ok, (no args)=usage_only)
usage: fusion_report sync [-h] [--cosmic_usr COSMIC_USR]
                          [--cosmic_passwd COSMIC_PASSWD]
                          [--cosmic_token COSMIC_TOKEN] [--qiagen]
                          output

positional arguments:
  output                Output directory

options:
  -h, --help            show this help message and exit

COSMIC:
  Option credential parameters. You can either provide username and password
  which will be used to generate base64 token or the token itself.

  --cosmic_usr COSMIC_USR
                        COSMIC username
  --cosmic_passwd COSMIC_PASSWD
                        COSMIC password
  --cosmic_token COSMIC_TOKEN
                        COSMIC token
  --qiagen              Use QIAGEN to download COSMIC db (commercial usage)
```

