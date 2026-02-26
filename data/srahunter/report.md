# srahunter CWL Generation Report

## srahunter_download

### Tool Description
Download SRA data and convert it to FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0
- **Homepage**: https://github.com/GitEnricoNeko/srahunter
- **Package**: https://anaconda.org/channels/bioconda/packages/srahunter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/srahunter/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/GitEnricoNeko/srahunter
- **Stars**: N/A
### Original Help Text
```text
_                 _            
 ___ _ __ __ _| |__  _   _ _ __ | |_ ___ _ __ 
/ __| '__/ _` | '_ \| | | | '_ \| __/ _ \ '__|
\__ \ | | (_| | | | | |_| | | | | ||  __/ |   
|___/_|  \__,_|_| |_|\__,_|_| |_|\__\___|_|   
                                              

usage: srahunter download [-h] --list LIST [-t T] [--path PATH]
                          [--maxsize MAXSIZE] [--outdir OUTDIR]

options:
  -h, --help            show this help message and exit
  --list, -i LIST       Accession list from SRA (file path)
  -t T                  Number of threads (default: 6)
  --path, -p PATH       Path to where to download .sra files (default: current
                        directory/tmp_srahunter)
  --maxsize, -ms MAXSIZE
                        Max size of each sra file (default: 50G)
  --outdir, -o OUTDIR   Path to where to download .fastq files (default:
                        current directory)
```


## srahunter_metadata

### Tool Description
Accession list from SRA (file path)

### Metadata
- **Docker Image**: quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0
- **Homepage**: https://github.com/GitEnricoNeko/srahunter
- **Package**: https://anaconda.org/channels/bioconda/packages/srahunter/overview
- **Validation**: PASS

### Original Help Text
```text
_                 _            
 ___ _ __ __ _| |__  _   _ _ __ | |_ ___ _ __ 
/ __| '__/ _` | '_ \| | | | '_ \| __/ _ \ '__|
\__ \ | | (_| | | | | |_| | | | | ||  __/ |   
|___/_|  \__,_|_| |_|\__,_|_| |_|\__\___|_|   
                                              

usage: srahunter metadata [-h] --list LIST [--no-html]

options:
  -h, --help       show this help message and exit
  --list, -i LIST  Accession list from SRA (file path)
  --no-html        Disable HTML table generation
```


## srahunter_fullmetadata

### Tool Description
Accession list from SRA (file path)

### Metadata
- **Docker Image**: quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0
- **Homepage**: https://github.com/GitEnricoNeko/srahunter
- **Package**: https://anaconda.org/channels/bioconda/packages/srahunter/overview
- **Validation**: PASS

### Original Help Text
```text
_                 _            
 ___ _ __ __ _| |__  _   _ _ __ | |_ ___ _ __ 
/ __| '__/ _` | '_ \| | | | '_ \| __/ _ \ '__|
\__ \ | | (_| | | | | |_| | | | | ||  __/ |   
|___/_|  \__,_|_| |_|\__,_|_| |_|\__\___|_|   
                                              

usage: srahunter fullmetadata [-h] --list LIST

options:
  -h, --help       show this help message and exit
  --list, -i LIST  Accession list from SRA (file path)
```

