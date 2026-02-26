# surpyvor CWL Generation Report

## surpyvor_merge

### Tool Description
Merge VCF files from multiple callers.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Total Downloads**: 20.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wdecoster/surpyvor
- **Stars**: N/A
### Original Help Text
```text
usage: surpyvor merge [-h] [--verbose] --variants VARIANTS [VARIANTS ...]
                      [-o OUTPUT] [-d DISTANCE] [-l MINLENGTH] [-c CALLERS]
                      [-i] [-s] [-e]

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  --variants VARIANTS [VARIANTS ...]
                        vcf files to merge

optional arguments:
  -o OUTPUT, --output OUTPUT
                        output file
  -d DISTANCE, --distance DISTANCE
                        distance between variants to merge
  -l MINLENGTH, --minlength MINLENGTH
                        Minimum length of variants to consider
  -c CALLERS, --callers CALLERS
                        Minimum number of callers to support a variant
  -i, --ignore_type     Ignore the type of the structural variant
  -s, --strand          Take strand into account
  -e, --estimate_distance
                        Estimate distance between calls
```


## surpyvor_highsens

### Tool Description
Merge variants from multiple VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor highsens [-h] [--verbose] --variants VARIANTS [VARIANTS ...]
                         [-o OUTPUT] [-d DISTANCE] [-l MINLENGTH]

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  --variants VARIANTS [VARIANTS ...]
                        vcf files to merge

optional arguments:
  -o OUTPUT, --output OUTPUT
                        output file
  -d DISTANCE, --distance DISTANCE
                        distance between variants to merge
  -l MINLENGTH, --minlength MINLENGTH
                        Minimum length of variants to consider
```


## surpyvor_highconf

### Tool Description
Merge variants from multiple VCF files, considering high confidence variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor highconf [-h] [--verbose] --variants VARIANTS [VARIANTS ...]
                         [-o OUTPUT] [-d DISTANCE] [-l MINLENGTH] [-s]

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  --variants VARIANTS [VARIANTS ...]
                        vcf files to merge

optional arguments:
  -o OUTPUT, --output OUTPUT
                        output file
  -d DISTANCE, --distance DISTANCE
                        distance between variants to merge
  -l MINLENGTH, --minlength MINLENGTH
                        Minimum length of variants to consider
  -s, --strand          Take strand into account
```


## surpyvor_prf

### Tool Description
Calculate performance metrics for structural variant calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor prf [-h] [--verbose] --truth TRUTH --test TEST [-d DISTANCE]
                    [--minlength MINLENGTH] [-i]
                    [--ignore_chroms [IGNORE_CHROMS ...]]
                    [--keepmerged KEEPMERGED] [--bar] [--matrix] [--venn]

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  --truth TRUTH         vcf containing truth set
  --test TEST           vcf containing test set

optional arguments:
  -d DISTANCE, --distance DISTANCE
                        maximum distance between test and truth call
  --minlength MINLENGTH
                        Minimum length of SVs to be taken into account
  -i, --ignore_type     Ignore the type of the structural variant
  --ignore_chroms [IGNORE_CHROMS ...]
                        Chromosomes to ignore for prf calculation.
  --keepmerged KEEPMERGED
                        Save merged vcf file.
  --bar                 Make stacked bar chart of SV lengths coloured by
                        validation status
  --matrix              Make a confusion matrix.
  --venn                Make a venn diagram.
```


## surpyvor_venn

### Tool Description
Generate Venn diagrams of structural variants from multiple VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor venn [-h] [--verbose] --variants [VARIANTS ...]
                     [--names [NAMES ...]] [-d DISTANCE]
                     [--minlength MINLENGTH] [-i] [--keepmerged KEEPMERGED]
                     [--plotout PLOTOUT]

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  --variants [VARIANTS ...]
                        vcfs containing structural variants

optional arguments:
  --names [NAMES ...]   Names of datasets in --variants
  -d DISTANCE, --distance DISTANCE
                        maximum distance between test and truth call
  --minlength MINLENGTH
                        Minimum length of SVs to be taken into account
  -i, --ignore_type     Ignore the type of the structural variant
  --keepmerged KEEPMERGED
                        Save merged vcf file
  --plotout PLOTOUT     Name of output plot
```


## surpyvor_upset

### Tool Description
Generate upset plots for structural variants

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor upset [-h] [--verbose] --variants [VARIANTS ...]
                      [--names [NAMES ...]] [-d DISTANCE]
                      [--minlength MINLENGTH] [-i] [--keepmerged KEEPMERGED]
                      [--plotout PLOTOUT]

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  --variants [VARIANTS ...]
                        vcfs containing structural variants

optional arguments:
  --names [NAMES ...]   Names of datasets in --variants
  -d DISTANCE, --distance DISTANCE
                        maximum distance between test and truth call
  --minlength MINLENGTH
                        Minimum length of SVs to be taken into account
  -i, --ignore_type     Ignore the type of the structural variant
  --keepmerged KEEPMERGED
                        Save merged vcf file
  --plotout PLOTOUT     Name of output plot
```


## surpyvor_haplomerge

### Tool Description
Merge VCF files from multiple callers.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor haplomerge [-h] [--verbose] --variants [VARIANTS ...]
                           [-o OUTPUT] [-n NAME] [-d DISTANCE] [-l MINLENGTH]
                           [-c CALLERS] [-i] [-s] [-e]

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running. (default:
                        False)

required arguments:
  --variants [VARIANTS ...]
                        vcf files to merge (default: None)

optional arguments:
  -o OUTPUT, --output OUTPUT
                        output file (default: stdout)
  -n NAME, --name NAME  name of sample in output VCF (default: stdout)
  -d DISTANCE, --distance DISTANCE
                        distance between variants to merge (default: 200)
  -l MINLENGTH, --minlength MINLENGTH
                        Minimum length of variants to consider (default: 50)
  -c CALLERS, --callers CALLERS
                        Minimum number of callers to support a variant
                        (default: 1)
  -i, --ignore_type     Ignore the type of the structural variant (default:
                        False)
  -s, --strand          Take strand into account (default: False)
  -e, --estimate_distance
                        Estimate distance between calls (default: False)
```


## surpyvor_lengthplot

### Tool Description
Plot variant lengths from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor lengthplot [-h] [--verbose] [--plotout PLOTOUT] [-c COUNTS]
                           [--all]
                           vcf

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  vcf                   vcf file to parse

optional arguments:
  --plotout PLOTOUT     output file to write figure to
  -c COUNTS, --counts COUNTS
                        output file to write counts to
  --all                 Plot all variants and not just the first in the file
```


## surpyvor_minlen

### Tool Description
Filter SVs by minimum length

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor minlen [-h] [--verbose] [-l LENGTH] [-o OUTPUT] vcf

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  vcf                   vcf file to parse

optional arguments:
  -l LENGTH, --length LENGTH
                        minimal SV length
  -o OUTPUT, --output OUTPUT
                        vcf file to write to
```


## surpyvor_svlentruncate

### Tool Description
Truncates SVLEN in VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor svlentruncate [-h] [--verbose] [-l LENGTH] [-o OUTPUT] vcf

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  vcf                   vcf file to parse

optional arguments:
  -l LENGTH, --length LENGTH
                        maximal SVLEN, replace SVLEN by this value if larger
  -o OUTPUT, --output OUTPUT
                        vcf file to write to
```


## surpyvor_fixvcf

### Tool Description
Fix problems related to using jasmine

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor fixvcf [-h] [--verbose] --fai FAI [-o OUTPUT] [--jasmine] vcf

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  vcf                   vcf file to parse
  --fai FAI             index of corresponding fasta file

optional arguments:
  -o OUTPUT, --output OUTPUT
                        vcf file to write to
  --jasmine             Fix problems related to using jasmine
```


## surpyvor_purge2d

### Tool Description
Filter alignments from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor purge2d [-h] [--verbose] [-o OUTPUT] bam

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  bam                   bam file to filter

optional arguments:
  -o OUTPUT, --output OUTPUT
                        sam/bam file to write filtered alignments to [stdout]
```


## surpyvor_carrierplot

### Tool Description
Plot carrier plots from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor carrierplot [-h] [--verbose] [--plotout PLOTOUT] variants

options:
  -h, --help         show this help message and exit
  --verbose          Print out more information while running.

required arguments:
  variants           VCF to plot from

optional arguments:
  --plotout PLOTOUT  output file to write figure to
```


## surpyvor_varcount

### Tool Description
VCF to plot from

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor varcount [-h] [--verbose] [--plotout PLOTOUT]
                         [--countsout COUNTSOUT]
                         variants

options:
  -h, --help            show this help message and exit
  --verbose             Print out more information while running.

required arguments:
  variants              VCF to plot from

optional arguments:
  --plotout PLOTOUT     output file to write figure to
  --countsout COUNTSOUT
                        output file to write counts to
```


## surpyvor_fixref

### Tool Description
Fixes reference sequences in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/surpyvor
- **Package**: https://anaconda.org/channels/bioconda/packages/surpyvor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: surpyvor fixref [-h] [--verbose] --fasta FASTA variants

options:
  -h, --help     show this help message and exit
  --verbose      Print out more information while running.

required arguments:
  variants       VCF to fix
  --fasta FASTA  fasta file
```

