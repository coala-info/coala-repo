# variantbreak CWL Generation Report

## variantbreak

### Tool Description
VariantBreak is a structural variant (SV) breakend analyzer that intersects and merges SV breakends from NanoVar VCF files or variant BED files for visualization on VariantMap or summarized into a CSV file. It also annotates and filters all SVs across all samples according to user input GTF/GFF/BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/variantbreak:1.0.4--py_0
- **Homepage**: https://github.com/cytham/variantbreak
- **Package**: https://anaconda.org/channels/bioconda/packages/variantbreak/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/variantbreak/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cytham/variantbreak
- **Stars**: N/A
### Original Help Text
```text
usage: variantbreak [-h] [-a path] [-f path] [-d int] [-b int] [-p int]
                    [-m int] [--cluster_sample] [--auto_filter] [-s str]
                    [-n str] [-v] [-q]
                    [variant_path] [working_directory]

VariantBreak is a structural variant (SV) breakend analyzer that intersects and merges 
SV breakends from NanoVar VCF files or variant BED files for visualization on VariantMap 
or summarized into a CSV file. It also annotates and filters all SVs across all samples 
according to user input GTF/GFF/BED files.

positional arguments:
  [variant_path]        path to single variant file or directory containing variant files 
                        of VCF (NanoVar-v1.3.6 or above) or BED formats. Formats: .vcf/.bed
  [working_directory]   path to working directory. Directory will be created if it does not 
                        exist.

optional arguments:
  -h, --help            show this help message and exit
  -a path, --annotation_file_dir path
                        path to single annotation file or directory containing annotation 
                        files of GTF/GFF or BED formats. Formats: .gtf/.gff/.gff3/.bed
  -f path, --filter_file_dir path
                        path to single filter file or directory containing filter files of 
                        BED format. Format: .bed
  -d int, --del_annotate_size int
                        Deletions with sizes lower or equal to this value will have the 
                        entire deleted region annotated. Any genes that intersect with 
                        the deleted region will be included as annotation. On the contrary, 
                        if deletion size is greater than this value, only the deletion 
                        breakends will be annotated, omitting any annotation of the middle 
                        deleted region. In other words, only genes intersecting with the 
                        deletion breakends will be included as annotation. This is done to 
                        reduce false annotations due to false large deletions. Note that 
                        the value to be set is an absolute deletion size, do not use minus 
                        '-'. Use value '-1' to disable this threshold and annotate all 
                        deleted regions despite of size. [20000]
  -b int, --merge_buffer int
                        nucleotide length buffer for SV breakend clustering [400]
  -p int, --promoter_size int
                        length in base-pairs upstream of TSS to define promoter region 
                        [1000]
  -m int, --max_annotation int
                        maximum number of annotation entries to be recorded in the 
                        dataframe for each SV [3]
  --cluster_sample      performs hierarchical clustering on samples
  --auto_filter         automatically removes variants that intersected
                        with all filter BED files
  -s str, --sep str     single character field delimiter for output dataframe CSV file 
                        (e.g. '\t' for tab or ',' for comma) [,]
  -n str, --filename str
                        File name prefix of output files [output]
  -v, --version         show version and exit
  -q, --quiet           hide verbose
```

