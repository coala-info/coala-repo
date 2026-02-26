# shigapass CWL Generation Report

## shigapass_ShigaPass.sh

### Tool Description
This tool is used to predict Shigella serotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/shigapass:1.5.0--hdfd78af_0
- **Homepage**: https://github.com/imanyass/ShigaPass/
- **Package**: https://anaconda.org/channels/bioconda/packages/shigapass/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shigapass/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/imanyass/ShigaPass
- **Stars**: N/A
### Original Help Text
```text
###### This tool is used to predict Shigella serotypes  #####
Usage : ShigaPass.sh [options]

options :
-l	List of input file(s) (FASTA) with their path(s) (mandatory)
-o	Output directory (mandatory)
-p	Path to databases directory (mandatory)
-t	Number of threads (optional, default: 2)
-u	Call the makeblastdb utility for databases initialisation (optional, but required when running the script for the first time)
-k	Do not remove subdirectories (optional)
-v	Display the version and exit
-h	Display this help and exit
Example: ShigaPass.sh -l list_of_fasta.txt -o ShigaPass_Results -p ShigaPass/ShigaPass_DataBases -t 4 -u -k
Please note that the -u option should be used when running the script for the first time and after databases updates
```

