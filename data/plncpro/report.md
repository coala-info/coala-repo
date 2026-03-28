# plncpro CWL Generation Report

## plncpro_predict

### Tool Description
This script classifies transcripts as coding or non coding transcripts

### Metadata
- **Docker Image**: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
- **Homepage**: https://github.com/urmi-21/PLncPRO
- **Package**: https://anaconda.org/channels/bioconda/packages/plncpro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plncpro/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/urmi-21/PLncPRO
- **Stars**: N/A
### Original Help Text
```text
[91m
				  _____  _                  _____    _____     ____  
				 |  __ \| |                |  __ \  |  __ \   / __ \ 
				 | |__) | |  _ __     ___  | |__) | | |__) | | |  | |
				 |  ___/| | |  _ \   / __| |  ___/  |  _  /  | |  | |
				 | |    | | | | | | | (__  | |      | | \ \  | |__| |
				 |_|    |_| |_| |_|  \___| |_|      |_|  \_\  \____/ 
[0m
*********************************************Help*********************************************
DESCRIPTION
This script classifies transcripts as coding or non coding transcripts
Arguments:
-h     print this message
-p     output file name to store prediction results
-i     path to file containing input sequences
-m     path to the model file
-o     output directory name to store all results
-d     path to blast database
                   OPTIONAL
-t     number of threads[default: 4]
-l     path to the files containg labels(this outputs performance of the classifier)
-r     clean up intermediate files
-v     show more messages
--min_len     specifiy min_length to filter input files
--noblast     Don't use blast features
--no_ff     Don't use framefinder features
--qcov_hsp     specify qcov parameter for blast[default:30]
--blastres     path to blast output for input file
```


## plncpro_build

### Tool Description
This script generates classification model from codin and non coding transcripts

### Metadata
- **Docker Image**: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
- **Homepage**: https://github.com/urmi-21/PLncPRO
- **Package**: https://anaconda.org/channels/bioconda/packages/plncpro/overview
- **Validation**: PASS

### Original Help Text
```text
[91m
				  _____  _                  _____    _____     ____  
				 |  __ \| |                |  __ \  |  __ \   / __ \ 
				 | |__) | |  _ __     ___  | |__) | | |__) | | |  | |
				 |  ___/| | |  _ \   / __| |  ___/  |  _  /  | |  | |
				 | |    | | | | | | | (__  | |      | | \ \  | |__| |
				 |_|    |_| |_| |_|  \___| |_|      |_|  \_\  \____/ 
[0m
*********************************************Help*********************************************
                   DESCRIPTION
This script generates classification model from codin and non coding transcripts
Arguments:
-h     print this message
-p,--pos     path to file containing protein coding examples
-n,--neg     path to file containing non coding examples
-m,--model     output model name
-o,--outdir     output directory name to store all results
-d     path to blast database
                   OPTIONAL
-t     number of threads[default: 4]
-k     number of trees[default: 1000]
-r     clean up intermediate files
-v     show more messages
--min_len     specifiy min_length to filter input files
--noblast     Don't use blast features
--no_ff     Don't use framefinder features
--qcov_hsp     specify qcov parameter for blast[default:30]
--pos_blastres     path to blast output for positive input file
--neg_blastres     path to blast output for negative input file
```


## plncpro_predtoseq

### Tool Description
Use this to extract lncRNA or mRNA sequences, as predicted by PLNCPRO, from the input fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
- **Homepage**: https://github.com/urmi-21/PLncPRO
- **Package**: https://anaconda.org/channels/bioconda/packages/plncpro/overview
- **Validation**: PASS

### Original Help Text
```text
[91m
				  _____  _                  _____    _____     ____  
				 |  __ \| |                |  __ \  |  __ \   / __ \ 
				 | |__) | |  _ __     ___  | |__) | | |__) | | |  | |
				 |  ___/| | |  _ \   / __| |  ___/  |  _  /  | |  | |
				 | |    | | | | | | | (__  | |      | | \ \  | |__| |
				 |_|    |_| |_| |_|  \___| |_|      |_|  \_\  \____/ 
[0m
Use this to extract lncRNA or mRNA sequences, as predicted by PLNCPRO, from the input fasta file
Usage:
predstoseq.py -f <input fastafile> -o <outputfile> -p <predictionfile> -l <required label default:0> -s <class_prob_cutoff[range 0-1], default:0> -m <min_length, default:0> <max_length, default:inf>
```


## Metadata
- **Skill**: generated
