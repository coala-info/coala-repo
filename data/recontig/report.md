# recontig CWL Generation Report

## recontig_build-help

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/recontig
- **Package**: https://anaconda.org/channels/bioconda/packages/recontig/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/recontig/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/blachlylab/recontig
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Valid builds: ["BDGP6", "CanFam3", "GRCh37", "GRCh38", "GRCm37", "GRCm38", "GRCz10", "GRCz11", "JGI_4.2", "MEDAKA1", "R64-1-1", "Rnor_6.0", "WBcel235", "Xenopus_laevis_v2", "Xenopus_tropicalis_v9.1", "Zv9", "dm3", "galGal4", "galGal6", "rn5"]
```


## recontig_conversion-help

### Tool Description
check availiable conversions for a specified build from dpryan79's github

### Metadata
- **Docker Image**: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/recontig
- **Package**: https://anaconda.org/channels/bioconda/packages/recontig/overview
- **Validation**: PASS

### Original Help Text
```text
recontig conversion-help: check availiable conversions for a specified build from dpryan79's github

usage: recontig conversion-help -b build 

-b   --build Genome build i.e GRCh37 for using dpryan79's files
-q   --quiet silence warnings
-v --verbose print extra information
     --debug print extra debug information
-h    --help This help information.
```


## recontig_convert

### Tool Description
remap contig names for different bioinformatics file types.

### Metadata
- **Docker Image**: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/recontig
- **Package**: https://anaconda.org/channels/bioconda/packages/recontig/overview
- **Validation**: PASS

### Original Help Text
```text
recontig convert: remap contig names for different bioinformatics file types.

usage: recontig convert [-e ejected.txt] [-o output] [-m mapping.txt | -b build -c conversion] [-f filetype | --col 1 --delimiter ','] <in.file>

Input can be any of the following formats: vcf, bcf, bam, sam, bed, gff
Input can also be a delimited record based file 
Input can be compressed with gzip or bgzf and can be accessed remotely via https or s3 (see htslib for details).

-b          --build Genome build i.e GRCh37 for using dpryan79's files
-c     --conversion Conversion string i.e UCSC2ensembl for using dpryan79's files
-e --ejected-output File to write ejected records to (records with unmapped contigs)
-f      --file-type Type of file to convert (vcf, bcf, bam, sam, bed, gff)
-m        --mapping If want to use your own remapping file instead of dpryan79's
-o         --output name of file out (default is - for stdout)
-q          --quiet silence warnings
-v        --verbose print extra information
              --col if converting a generic file you can specify a column
          --comment if converting a generic file you can specify what a comment line starts with (default: '#')
            --debug print extra debug information
        --delimiter if converting a generic file you can specify a delimiter (default: '\t')
-h           --help This help information.
```


## recontig_make-mapping

### Tool Description
make a contig conversion file from two fasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
- **Homepage**: https://github.com/blachlylab/recontig
- **Package**: https://anaconda.org/channels/bioconda/packages/recontig/overview
- **Validation**: PASS

### Original Help Text
```text
recontig make-mapping: make a contig conversion file from two fasta files
Makes a mapping file for two fasta files that have been faidx'd (samtools faidx)
Fastas can be compressed with bgzf and can be accessed remotely via https or s3 (see htslib for details).

usage: recontig make-mapping [-o output] <from.fa> <to.fa>

-o             --output name of file out (default is - for stdout)
   --no-enforce-md5sums contigs mapping may be output to mapping file even if md5sums do not match
-q              --quiet silence warnings
-v            --verbose print extra information
                --debug print extra debug information
-h               --help This help information.
```

