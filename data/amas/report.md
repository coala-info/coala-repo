# amas CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| amas_concat | PASS |  |
| amas_convert | PASS |  |
| amas_remove | PASS |  |
| amas_replicate | PASS |  |
| amas_split | PASS |  |
| amas_summary | PASS |  |
| amas_translate | PASS |  |
| amas_trim | PASS |  |

## amas_concat

### Tool Description
Concatenate input alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] [-p CONCAT_PART] [-t CONCAT_OUT]
               [-u {fasta,phylip,nexus,phylip-int,nexus-int}]
               [-y {nexus,raxml,unspecified}] [-e] [-c CORES] -i IN_FILES
               [IN_FILES ...] -f {fasta,phylip,nexus,phylip-int,nexus-int} -d
               {aa,dna}

Concatenate input alignments

optional arguments:
  -h, --help            show this help message and exit
  -p CONCAT_PART, --concat-part CONCAT_PART
                        File name for the concatenated alignment partitions.
                        Default: 'partitions.txt'
  -t CONCAT_OUT, --concat-out CONCAT_OUT
                        File name for the concatenated alignment. Default:
                        'concatenated.out'
  -u {fasta,phylip,nexus,phylip-int,nexus-int}, --out-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        File format for the output alignment. Default: fasta
  -y {nexus,raxml,unspecified}, --part-format {nexus,raxml,unspecified}
                        Format of the partitions file. Default: 'unspecified'
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


## amas_convert

### Tool Description
Convert to other file format

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] [-u {fasta,phylip,nexus,phylip-int,nexus-int}] [-e]
               [-c CORES] -i IN_FILES [IN_FILES ...] -f
               {fasta,phylip,nexus,phylip-int,nexus-int} -d {aa,dna}

Convert to other file format

optional arguments:
  -h, --help            show this help message and exit
  -u {fasta,phylip,nexus,phylip-int,nexus-int}, --out-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        File format for the output alignment. Default: fasta
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


## amas_replicate

### Tool Description
Create replicate datasets for phylogenetic jackknife

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] -r REPLICATE_ARGS REPLICATE_ARGS
               [-u {fasta,phylip,nexus,phylip-int,nexus-int}] [-e] [-c CORES]
               -i IN_FILES [IN_FILES ...] -f
               {fasta,phylip,nexus,phylip-int,nexus-int} -d {aa,dna}

Create replicate datasets for phylogenetic jackknife

optional arguments:
  -h, --help            show this help message and exit
  -r REPLICATE_ARGS REPLICATE_ARGS, --rep-aln REPLICATE_ARGS REPLICATE_ARGS
                        Create replicate data sets for phylogenetic jackknife
                        [replicates, no alignments for each replicate]
  -u {fasta,phylip,nexus,phylip-int,nexus-int}, --out-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        File format for the output alignment. Default: fasta
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


## amas_split

### Tool Description
Split alignment according to a partitions file

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] -l SPLIT_BY [-j]
               [-u {fasta,phylip,nexus,phylip-int,nexus-int}] [-e] [-c CORES]
               -i IN_FILES [IN_FILES ...] -f
               {fasta,phylip,nexus,phylip-int,nexus-int} -d {aa,dna}

Split alignment according to a partitions file

optional arguments:
  -h, --help            show this help message and exit
  -l SPLIT_BY, --split-by SPLIT_BY
                        File name for partitions to be used for alignment
                        splitting.
  -j, --remove-empty    Remove taxa with sequences composed of only
                        undetermined characters? Default: Don't remove
  -u {fasta,phylip,nexus,phylip-int,nexus-int}, --out-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        File format for the output alignment. Default: fasta
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


## amas_summary

### Tool Description
Write alignment summary

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] [-o SUMMARY_OUT] [-s] [-e] [-c CORES] -i IN_FILES
               [IN_FILES ...] -f {fasta,phylip,nexus,phylip-int,nexus-int} -d
               {aa,dna}

Write alignment summary

optional arguments:
  -h, --help            show this help message and exit
  -o SUMMARY_OUT, --summary-out SUMMARY_OUT
                        File name for the alignment summary. Default:
                        'summary.txt'
  -s, --by-taxon        In addition to alignment summary, write by
                        sequence/taxon summaries. Default: Don't write
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


## amas_remove

### Tool Description
Remove taxa from alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] -x TAXA_TO_REMOVE [TAXA_TO_REMOVE ...]
               [-u {fasta,phylip,nexus,phylip-int,nexus-int}] [-g OUT_PREFIX]
               [-e] [-c CORES] -i IN_FILES [IN_FILES ...] -f
               {fasta,phylip,nexus,phylip-int,nexus-int} -d {aa,dna}

Remove taxa from alignment

optional arguments:
  -h, --help            show this help message and exit
  -x TAXA_TO_REMOVE [TAXA_TO_REMOVE ...], --taxa-to-remove TAXA_TO_REMOVE [TAXA_TO_REMOVE ...]
                        Taxon/sequence names to be removed.
  -u {fasta,phylip,nexus,phylip-int,nexus-int}, --out-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        File format for the output alignment. Default: fasta
  -g OUT_PREFIX, --out-prefix OUT_PREFIX
                        File name prefix for the concatenated alignment.
                        Default: 'reduced_'
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


## amas_translate

### Tool Description
Translate a protein-coding DNA alignment into amino acids

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] [-b {1,2,3,4,5,6,9,10,11,12,13,14,16,21,22,23,24,25,26}]
               [-k {1,2,3}] [-u {fasta,phylip,nexus,phylip-int,nexus-int}]
               [-e] [-c CORES] -i IN_FILES [IN_FILES ...] -f
               {fasta,phylip,nexus,phylip-int,nexus-int} -d {aa,dna}

Translate a protein-coding DNA alignment into amino acids

optional arguments:
  -h, --help            show this help message and exit
  -b {1,2,3,4,5,6,9,10,11,12,13,14,16,21,22,23,24,25,26}, --code {1,2,3,4,5,6,9,10,11,12,13,14,16,21,22,23,24,25,26}
                        NCBI genetic code to use: 1. The Standard Code, 2. The
                        Vertebrate Mitochondrial Code, 3. The Yeast
                        Mitochondrial Code, 4. The Mold, Protozoan, and
                        Coelenterate Mitochondrial Code and the
                        Mycoplasma/Spiroplasma Code, 5. The Invertebrate
                        Mitochondrial Code, 6. The Ciliate, Dasycladacean and
                        Hexamita Nuclear Code, 9. The Echinoderm and Flatworm
                        Mitochondrial Code, 10. The Euplotid Nuclear Code, 11.
                        The Bacterial, Archaeal and Plant Plastid Code, 12.
                        The Alternative Yeast Nuclear Code, 13. The Ascidian
                        Mitochondrial Code, 14. The Alternative Flatworm
                        Mitochondrial Code, 16. Chlorophycean Mitochondrial
                        Code, 21. Trematode Mitochondrial Code, 22.
                        Scenedesmus obliquus Mitochondrial Code, 23.
                        Thraustochytrium Mitochondrial Code, 24. Pterobranchia
                        Mitochondrial Code, 25. Candidate Division SR1 and
                        Gracilibacteria Code, 26. Pachysolen tannophilus
                        Nuclear Code. Default: 1.
  -k {1,2,3}, --reading-frame {1,2,3}
                        Number specifying reading frame; i.e. '2' means codons
                        start at the second character of the alignment.
                        Default: 1
  -u {fasta,phylip,nexus,phylip-int,nexus-int}, --out-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        File format for the output alignment. Default: fasta
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


## amas_trim

### Tool Description
Trim alignment by occupancy. Optionally removes sites that are not parsimony informative.

### Metadata
- **Docker Image**: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
- **Homepage**: https://github.com/marekborowiec/AMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amas/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marekborowiec/AMAS
- **Stars**: N/A
### Original Help Text
```text
usage: AMAS.py [-h] [-u {fasta,phylip,nexus,phylip-int,nexus-int}]
               [-o TRIM_OUT] [-t TRIM_FRACTION] [-p] [-e] [-c CORES] -i
               IN_FILES [IN_FILES ...] -f
               {fasta,phylip,nexus,phylip-int,nexus-int} -d {aa,dna}

Trim alignment by occupancy. Optionally removes sites that are not parsimony
informative. CAUTION: when running on amino acids stop codons marked with *
will be treated as missing data!

optional arguments:
  -h, --help            show this help message and exit
  -u {fasta,phylip,nexus,phylip-int,nexus-int}, --out-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        File format for the output alignment. Default: fasta
  -o TRIM_OUT, --trim-out TRIM_OUT
                        File name for the trimmed alignment when providing a
                        single file as input.
  -t TRIM_FRACTION, --trim-fraction TRIM_FRACTION
                        Columns in the alignments with occupancy lower than
                        this value will be removed. Default: 0.6
  -p, --retain-only-parsimony-sites
                        Only write parsimony informative columns in trimmed
                        alignment Default: write all columns
  -e, --check-align     Check if input sequences are aligned. Default: no
                        check
  -c CORES, --cores CORES
                        Number of cores used. Default: 1

required arguments:
  -i IN_FILES [IN_FILES ...], --in-files IN_FILES [IN_FILES ...]
                        Alignment files to be taken as input. You can specify
                        multiple files using wildcards (e.g. --in-files
                        *fasta)
  -f {fasta,phylip,nexus,phylip-int,nexus-int}, --in-format {fasta,phylip,nexus,phylip-int,nexus-int}
                        The format of input alignment
  -d {aa,dna}, --data-type {aa,dna}
                        Type of data
```


