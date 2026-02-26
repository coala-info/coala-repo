# mhg CWL Generation Report

## mhg_MHG

### Tool Description
Make blastn database & Build blastn queries

### Metadata
- **Docker Image**: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/NakhlehLab/Maximal-Homologous-Groups
- **Package**: https://anaconda.org/channels/bioconda/packages/mhg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mhg/overview
- **Total Downloads**: 16.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NakhlehLab/Maximal-Homologous-Groups
- **Stars**: N/A
### Original Help Text
```text
usage: MHG [-h] [-g GENOME] [-b BLAST] [-db DATABASE] [-q QUERY]
           [-w WORD_SIZE] [-T THREAD] [-go GAPOPEN] [-ge GAPEXTEND]
           [-o OUTPUT] [-t THRESHOLD]

Make blastn database & Build blastn queries

optional arguments:
  -h, --help            show this help message and exit
  -g GENOME, --genome GENOME
                        Genome nucleotide sequence directory (Required)
  -b BLAST, --blast BLAST
                        Blastn bin directory; try to call 'makeblastdb,
                        blastn' straightly if no path is inputted by
                        default(if blast folder is added as an environemnt
                        variable
  -db DATABASE, --database DATABASE
                        Directory to store blast nucleotide databases for each
                        sequence in genome directory. By default write to
                        current folder 'blastn_db'
  -q QUERY, --query QUERY
                        Output folder storing all blastn queries in xml
                        format. By defualt write to current folder
                        'blastn_against_bank'
  -w WORD_SIZE, --word_size WORD_SIZE
                        Blastn word size, default 28
  -T THREAD, --thread THREAD
                        Blastn thread number, default 1
  -go GAPOPEN, --gapopen GAPOPEN
                        Blastn gap open penalty, default 5
  -ge GAPEXTEND, --gapextend GAPEXTEND
                        Blastn gap extend penalty, default 2
  -o OUTPUT, --output OUTPUT
                        File containing the final partitioned MHGs, each line
                        represents a MHG containing different blocks
  -t THRESHOLD, --threshold THRESHOLD
                        Bitscore threshold for determining true homology
```


## mhg_genome-to-blast-db

### Tool Description
Make blastn database & Build blastn queries

### Metadata
- **Docker Image**: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/NakhlehLab/Maximal-Homologous-Groups
- **Package**: https://anaconda.org/channels/bioconda/packages/mhg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genome-to-blast-db [-h] [-g GENOME] [-b BLAST] [-db DATABASE]
                          [-q QUERY] [-w WORD_SIZE] [-T THREAD] [-go GAPOPEN]
                          [-ge GAPEXTEND]

Make blastn database & Build blastn queries

optional arguments:
  -h, --help            show this help message and exit
  -g GENOME, --genome GENOME
                        Genome nucleotide sequence directory (Required)
  -b BLAST, --blast BLAST
                        Blastn bin directory; try to call 'makeblastdb,
                        blastn' straightly if no path is inputted by
                        default(if blast folder is added as an environemnt
                        variable
  -db DATABASE, --database DATABASE
                        Directory to store blast nucleotide databases for each
                        sequence in genome directory. By default write to
                        current folder 'blastn_db'
  -q QUERY, --query QUERY
                        Output folder storing all blastn queries in xml
                        format. By defualt write to current folder
                        'blastn_against_bank'
  -w WORD_SIZE, --word_size WORD_SIZE
                        Blastn word size, default 28
  -T THREAD, --thread THREAD
                        Blastn thread number, default 1
  -go GAPOPEN, --gapopen GAPOPEN
                        Blastn gap open penalty, default 5
  -ge GAPEXTEND, --gapextend GAPEXTEND
                        Blastn gap extend penalty, default 2
```


## mhg_MHG-partition

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/NakhlehLab/Maximal-Homologous-Groups
- **Package**: https://anaconda.org/channels/bioconda/packages/mhg/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
2026-02-24 21:43:26,049 - root - INFO - start building dataframe containing pairwise blastn calls
Traceback (most recent call last):
  File "/usr/local/bin/MHG-partition", line 1516, in <module>
    blastDf = pd.concat(frames)
  File "/usr/local/lib/python3.8/site-packages/pandas/util/_decorators.py", line 311, in wrapper
    return func(*args, **kwargs)
  File "/usr/local/lib/python3.8/site-packages/pandas/core/reshape/concat.py", line 347, in concat
    op = _Concatenator(
  File "/usr/local/lib/python3.8/site-packages/pandas/core/reshape/concat.py", line 404, in __init__
    raise ValueError("No objects to concatenate")
ValueError: No objects to concatenate
```

