# bionetcomp CWL Generation Report

## bionetcomp

### Tool Description
A tool for biological network comparison using gene lists and STRING database interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/bionetcomp:1.1--pyhfa5458b_0
- **Homepage**: https://github.com/lmigueel/bionetcomp/
- **Package**: https://anaconda.org/channels/bioconda/packages/bionetcomp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bionetcomp/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lmigueel/bionetcomp
- **Stars**: N/A
### Original Help Text
```text
██████╗ ██╗ ██████╗ ███╗   ██╗███████╗████████╗ ██████╗ ██████╗ ███╗   ███╗██████╗ 
	██╔══██╗██║██╔═══██╗████╗  ██║██╔════╝╚══██╔══╝██╔════╝██╔═══██╗████╗ ████║██╔══██╗
	██████╔╝██║██║   ██║██╔██╗ ██║█████╗     ██║   ██║     ██║   ██║██╔████╔██║██████╔╝
	██╔══██╗██║██║   ██║██║╚██╗██║██╔══╝     ██║   ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ 
	██████╔╝██║╚██████╔╝██║ ╚████║███████╗   ██║   ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     
	╚═════╝ ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     
                                                                                   
	version 1.1
	
usage: bionetcomp [-h] --in1 IN1 --in2 IN2 --taxid TAXID --output_folder
                  OUTPUT_FOLDER [--fdr FDR] [--threshold THRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  --in1 IN1             File containing a first gene list.
  --in2 IN2             File containing a second gene list.
  --taxid TAXID         STRING taxonomy ID. Ex: 9606
  --output_folder OUTPUT_FOLDER
                        Output folder
  --fdr FDR             FDR cutoff for enrichment analysis
  --threshold THRESHOLD
                        Threshold for STRING interaction score

example: python3 bionetcomp.py --in1 list1.txt --in2 list2.txt --output
output_folder --taxid 9606
```


## Metadata
- **Skill**: generated
