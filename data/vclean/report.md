# vclean CWL Generation Report

## vclean_run

### Tool Description
Run vClean

### Metadata
- **Docker Image**: quay.io/biocontainers/vclean:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/TsumaR/vclean
- **Package**: https://anaconda.org/channels/bioconda/packages/vclean/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vclean/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TsumaR/vclean
- **Stars**: N/A
### Original Help Text
```text
Run vClean

usage: vclean <input> <output> [options]

positional arguments:
  input                 Put the input fasta directory
  output                Put the output directory

optional arguments:
  -h, --help            show this help message and exit
  -d DB, --db DB        Set the database directory path. By default the
                        VCLEANDB environment vairable is used
  -tmp TMP              Set the path of temporary file directory
  -t THREADS, --threads THREADS
                        Put the number of CPU to use. default=1
  -p PROTEIN, --protein PROTEIN
                        Not nessesary. you can input protein fasta file if you
                        have. In default, vDeteCon predict CDS using prodigal
                        from nucleotide fasta file.
  -n GENE, --nucleotide GENE
  --translate_table T_TABLE
                        put the translate table, default=11
  -m MODE, --mode MODE  True or False. If you want to calculate contamination
                        value of simulation data, set this value True
  --skip_feature_table SKIP_FEATURE_TABLE
                        If you set True, skip features prediction step.
  --skip_lgb_step SKIP_LGB_STEP
                        If you set True, skip contamination prediction step.
  --f_table F_TABLE     You want to only run lgb model, you have to input the
                        features table path.
  -pr THRESHOLD, --threshold THRESHOLD
                        Put the threshold for the Contamination probability
                        rate value. default=0.6. if the contamination
                        probability value is over the set score, the input
                        fasta are assigned as CONTAMINATION.
```


## vclean_download_database

### Tool Description
Download the latest version of vClean's database

### Metadata
- **Docker Image**: quay.io/biocontainers/vclean:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/TsumaR/vclean
- **Package**: https://anaconda.org/channels/bioconda/packages/vclean/overview
- **Validation**: PASS

### Original Help Text
```text
Download the latest version of vClean's databasen
        
usage: vclean download_database <destination>

positional arguments:
  destination  Directory where the database will be downloaded to.

optional arguments:
  -h, --help   show this help message and exit
```


## Metadata
- **Skill**: generated
