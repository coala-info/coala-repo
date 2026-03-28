# mkdesigner CWL Generation Report

## mkdesigner_mkvcf

### Tool Description
MKDesigner version 0.5.3

### Metadata
- **Docker Image**: quay.io/biocontainers/mkdesigner:0.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/KChigira/mkdesigner/
- **Package**: https://anaconda.org/channels/bioconda/packages/mkdesigner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mkdesigner/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/KChigira/mkdesigner
- **Stars**: N/A
### Original Help Text
```text
usage: mkvcf -r <FASTA> -b <BAM_1> -b <BAM_2>... -n <name_1> -n <name_2>... -O <STRING>

MKDesigner version 0.5.3

options:
  -h, --help     show this help message and exit
  -r, --ref      Reference fasta.
  -b, --bam      Bam files for variant calling.
                 e.g. -b bam1 -b bam2 ... 
                 You must use this option 2 times or more
                 to get markers in following analysis.
  -n, --name     Variety name of each bam file.
                 e.g. -n name_bam1 -n name_bam2 ... 
                 You must use this option same times
                 as -b.
  -O, --output   Identical name (must be unique).
                 This will be stem of output directory name.
  --cpu          Number of CPUs to use.
  -v, --version  show program's version number and exit
```


## mkdesigner_mkprimer

### Tool Description
MKDesigner version 0.5.3

### Metadata
- **Docker Image**: quay.io/biocontainers/mkdesigner:0.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/KChigira/mkdesigner/
- **Package**: https://anaconda.org/channels/bioconda/packages/mkdesigner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mkprimer -r <FASTA> -V <VCF> -n1 <name1> -n2 <name2>
         -O <output name> --type <SNP or INDEL>
         [--target <Target position>]
         [--limit <INT>]
         [--mindep <INT>] [--maxdep <INT>]
         [--min_prodlen <INT>] [--max_prodlen <INT>]
         [--margin <INT>] [--max_distance <INT>]

MKDesigner version 0.5.3

options:
  -h, --help            show this help message and exit
  -r, --ref             Reference fasta.
  -V, --vcf             VCF file without filtering.
                        Recommended to use VCF made by "mkvcf" command.
                        VCF must contain GT and DP field.
  -n1, --name1          Variety name 1.
                        Must match VCF column names.
                        This parameter can be specified multiple times to design common markers for multiple varieties.
  -n2, --name2          Variety name 2.
                        Must match VCF column names.
                        This parameter can be specified multiple times to design common markers for multiple varieties.
  -O, --output          Identical name (must be unique).
                        This will be stem of output directory name.
  -T, --type            Type of variants.
                        SNP or INDEL are supported.
  -t, --target          Target position where primers designed/
                        e.g. "chr01:1000000-3500000"
                        If not specified, the program process whole genome.
                        This parameter can be specified multiple times.
  -l, --limit           The upper limit of the number of primer design attempts.
                        A large number will take a long time to calculate,
                        but a small number may miss useful markers.
                        default: 10000
  --blast_timeout       If the process of primer specificity checking by BLAST
                        took time more than this parameter,
                        the variants considered to be non-specific.
                        default: 60.0 (sec)
  --mindep              Variants with more depth than this
                        are judged as valid mutations
                        default: 2
  --maxdep              Variants with less depth than this
                        are judged as valid mutations
                        default: 200
  --mismatch_allowed    Primers with more mismatch than this
                        are ignored in specificity check.
                        default: 5
  --mismatch_allowed_3_terminal 
                        Primers with more mismatch than this
                        in 5 bases of 3' terminal end
                        are ignored in specificity check.
                        default: 1
  --unintended_prod_size_allowed 
                        Primer pairs producing unintended PCR product which is shorter than this
                        are ignored in specificity check.
                        default: 4000
  --min_prodlen         Minimum PCR product length.default: 150
  --max_prodlen         Maximam PCR product length.
                        default: 280
  --opt_prodlen         Optical PCR product length.
                        default: 180
  --margin              Minimum distance from 3' terminal of primer to variant.
                        default: 5
  --search_span         Intervals to search for primers upstream and downstream variants.
                        default: 140
  --primer_num_consider 
                        Primer number considering in primer3 software.
                        default: 3
  --primer_min_size     Minimum primer size
                        default: 18
  --primer_max_size     Maximum primer size
                        default: 26
  --primer_opt_size     Optical primer size
                        default: 20
  --cpu                 Number of CPUs to use.
  -v, --version         show program's version number and exit
```


## mkdesigner_mkselect

### Tool Description
Selects markers based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/mkdesigner:0.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/KChigira/mkdesigner/
- **Package**: https://anaconda.org/channels/bioconda/packages/mkdesigner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mkselect -i <FASTA Index file>
         -V <VCF with Primer> -n <INT>
         -O <STRING>
         [-t <Target position>]
         [-d <TSV with marker density infomation>]
         [--avoid_lowercase]

MKDesigner version 0.5.3

options:
  -h, --help         show this help message and exit
  -i, --fai          Index file (.fai) of reference fasta.
  -V, --vcf          VCF file with primers.
                     This file must be made by "mkprimer" command.
  -n, --num_marker   Number of markers selected.
  -O, --output       Identical name (must be unique).
                     This will be stem of output directory name.
  -t, --target       Target position where primers designed
                     e.g. "chr01:1000000-3500000"
                     This parameter can be specified multiple times.
  -d, --density      TSV file with marker density infomation..
                     This file must be formatted as "test/density.tsv".
  --mindif           Set minimum differences
                     of PCR product length between alleles.
                     For SNP marker, this must be 0.
  --maxdif           For indel marker, set maximum differences
                     of PCR product length between alleles.
  --avoid_lowercase  Select only primers written by uppercase.
                     Lowercase may mean repeat sequence.
  -v, --version      show program's version number and exit
```


## Metadata
- **Skill**: generated
