# minys CWL Generation Report

## minys_MinYS.py

### Tool Description
MinYS: A pipeline for de novo assembly of circular DNA molecules

### Metadata
- **Docker Image**: quay.io/biocontainers/minys:1.1--hc9558a2_1
- **Homepage**: https://github.com/cguyomar/MinYS
- **Package**: https://anaconda.org/channels/bioconda/packages/minys/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minys/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cguyomar/MinYS
- **Stars**: N/A
### Original Help Text
```text
[main options]:
  -in                   (1 arg) :    Input reads file
  -1                    (1 arg) :    Input reads first file
  -2                    (1 arg) :    Input reads second file
  -fof                  (1 arg) :    Input file of read files (if paired files, 2 columns tab-separated)
  -out                  (1 arg) :    output directory for result files [Default: ./mtg_results]

[mapping options]:
  -ref                  (1 arg) :    Bwa index
  -mask                 (1 arg) :    Bed file for region removed from mapping

[assembly options]:
  -minia-bin            (1 arg) :    Path to Minia binary (if not in $PATH
  -assembly-kmer-size   (1 arg) :    Kmer size used for Minia assembly (should be given even if bypassing minia assembly step, usefull knowledge for gap-filling) [Default: 31]
  -assembly-abundance-min 
                        (1 arg) :    Minimal abundance of kmers used for assembly [Default: auto]
  -min-contig-size      (1 arg) :    Minimal size for a contig to be used in gap-filling [Default: 400]

[gapfilling options]:
  -mtg-dir              (1 arg) :    Path to MindTheGap build directory (if not in $PATH)
  -gapfilling-kmer-size 
                        (1 arg) :    Kmer size used for gap-filling [Default: 31]
  -gapfilling-abundance-min 
                        (1 arg) :    Minimal abundance of kmers used for gap-filling [Default: auto]
  -max-nodes            (1 arg) :    Maximum number of nodes in contig graph [Default: 300]
  -max-length           (1 arg) :    Maximum length of gap-filling (nt) [Default: 50000]

[simplification options]:
  -l                    (1 arg) :    Length of minimum prefix for node merging, default should work for most cases [Default: 100]

[continue options]:
  -contigs              (1 arg) :    Contigs in fasta format - override mapping and assembly
  -graph                (1 arg) :    Graph in h5 format - override graph creation

[core options]:
  -nb-cores             (1 arg) :    Number of cores [Default: 0]
```


## minys_filter_components.py

### Tool Description
Filters components based on minimum length.

### Metadata
- **Docker Image**: quay.io/biocontainers/minys:1.1--hc9558a2_1
- **Homepage**: https://github.com/cguyomar/MinYS
- **Package**: https://anaconda.org/channels/bioconda/packages/minys/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_components.py [-h] infile outfile minlength

positional arguments:
  infile
  outfile
  minlength

optional arguments:
  -h, --help  show this help message and exit
```


## minys_enumerate_paths.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/minys:1.1--hc9558a2_1
- **Homepage**: https://github.com/cguyomar/MinYS
- **Package**: https://anaconda.org/channels/bioconda/packages/minys/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/enumerate_paths.py", line 15, in <module>
    from progress.bar import Bar
ModuleNotFoundError: No module named 'progress'
```

