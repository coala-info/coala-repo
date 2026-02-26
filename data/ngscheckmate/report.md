# ngscheckmate CWL Generation Report

## ngscheckmate_ncm.py

### Tool Description
Ensuring Sample Identity v1.0.1. Input = the absolute path list of vcf files (samtools mpileup and bcftools). Output = Matched samples List

### Metadata
- **Docker Image**: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
- **Homepage**: https://github.com/parklab/NGSCheckMate
- **Package**: https://anaconda.org/channels/bioconda/packages/ngscheckmate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngscheckmate/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2026-02-09
- **GitHub**: https://github.com/parklab/NGSCheckMate
- **Stars**: N/A
### Original Help Text
```text
Set the path to your reference file with the NCM_REF environment variable
eg. export NCM_REF=/<path>/<to>/<reference>

usage: ncm.py [-h] (-B | -V) [-f] (-l data_list | -d data_dir) -bed BED file
              [-t test_samplename] [-O output_dir] [-N output_filename] [-nz]

    Ensuring Sample Identity v1.0.1
    Usage:   NGSCheckmate

    Desc.:   Input = the absolute path list of vcf files (samtools mpileup and bcftools)
             Output = Matched samples List

    Eg.  :   ncm.py -V -l /data/vcf_list.txt -bed /data/SNP_hg19.bed -O /data/output/ -N Matched_list
             ncm.py -V -d /data/vcf/ -bed /data/SNP_hg19.bed -O /data/output -N Matched_list
             ncm.py -B -d /data/bam/ -bed /data/SNP_hg19.bed -O /data/output -N Matched_list
             ncm.py -B -l /data/bam_list.txt -bed /data/SNP_hg19.bed -O /data/output/ -N Matched_list

    Sejoon Lee, Soo Lee, Eunjung Lee, 2023
    

options:
  -h, --help            show this help message and exit
  -B, --BAM             BAM files to do NGS Checkmate
  -V, --VCF             VCF files to do NGS Checkmate
  -f, --family_cutoff   apply strict correlation threshold to remove family cases
  -l data_list, --list data_list
                        data list
  -d data_dir, --dir data_dir
                        data directory
  -bed BED file, --bedfile BED file
                        A bed file containing SNP polymorphisms
  -t test_samplename, --testsamplename test_samplename
                        file including test sample namses  with ":" delimeter (default : all combinations of samples), -t filename
  -O output_dir, --outdir output_dir
                        directory name for temp and output files
  -N output_filename, --outfilename output_filename
                        OutputFileName ( default : output ), -N filename
  -nz, --nonzero        Use non-zero mean depth of target loci as reference correlation. (default: Use mean depth of all target loci)
```


## ngscheckmate_ncm_fastq.py

### Tool Description
NGSCheckMate v1.0

### Metadata
- **Docker Image**: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
- **Homepage**: https://github.com/parklab/NGSCheckMate
- **Package**: https://anaconda.org/channels/bioconda/packages/ngscheckmate/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncm_fastq.py [-h] [-f] -pt feature pattern file [-s subsampling_rate]
                    [-d desired_depth] [-R reference_length]
                    [-L pattern_length] [-p maxthread] [-j nodeptherror]
                    [-O output_dir] [-N output_filename] -l input_file_list
                    [-nz] [-t test_samplename]

    NGSCheckMate v1.0
    Usage : python ncm_fastq.py -l INPUT_LIST_FILE -pt PT_FILE -O OUTPUT_DIR [options]
            python ncm_fastq.py -l FASTQ_list.txt -pt ./SNP/SNP.pt -O ./ncm_fastq_output -p 4 -f
            python ncm_fastq.py -l FASTQ_list.txt -pt ./SNP/SNP.pt -O ./ncm_fastq_output -p 4 -f -nz

        Input arguments (required)
          -l  FILE      A text file that lists input fastq (or fastq.gz) files and sample names (one per line; see Input file format)
          -pt FILE      A binary pattern file (.pt) that lists flanking sequences of selected SNPs (included in the package; SNP/SNP.pt)
          -O  DIR       An output directory

        Options
          -N PREFIX     A prefix for output files (default: "output")

          -f            Use strict VAF correlation cutoffs. Recommended when your data may include
                        related individuals (parents-child, siblings)

          -nz           Use the mean of non-zero depths across the SNPs as a reference depth
                        (default: Use the mean depth across all the SNPs)

          -s FLOAT      The read subsampling rate (default: 1.0)

          -d INT        The target depth for read subsampling. NGSCheckMate calculates a subsampling rate based on this target depth.

          -R INT        The length of the genomic region with read mapping (default: 3E9) used to compute subsampling rate.
                        If your data is NOT human WGS and you use the -d option,
                        it is highly recommended that you specify this value.

          -L INT        The length of the flanking sequences of the SNPs (default: 21bp).
                        It is not recommended that you change this value unless you create your own pattern file (.pt) with a different length.
                        See Supporting Scripts for how to generate your own pattern file.

          -p INT        The number of threads (default: 1)
            

options:
  -h, --help            show this help message and exit
  -f, --family_cutoff   apply strict correlation threshold to remove family cases
  -pt feature pattern file, --pt feature pattern file
                        pattern file
  -s subsampling_rate, --ss subsampling_rate
                        subsampling rate (default 1.0)
  -d desired_depth, --depth desired_depth
                        as an alternative to a user-defined subsampling rate, let the program compute the subsampling rate given a user-defined desired_depth and the data
  -R reference_length, --reference_length reference_length
                        The reference length (default : 3E9) to be used for computing subsampling rate.
  -L pattern_length, --pattern_length pattern_length
                        The length of the flanking sequences being used to identify SNV sites. Default is 21bp.
                        It is recommended not to change this value, unless you have created your own pattern file with a different pattern length.
  -p maxthread, --maxthread maxthread
                        number of threads to use (default : 1 )
  -j nodeptherror, --nodeptherror nodeptherror
                        in case estimated subsampling rate is larger than 1, do not stop but reset it to 1 and continue
  -O output_dir, --outdir output_dir
                        directory name for temp and output files
  -N output_filename, --outfilename output_filename
                        OutputFileName ( default : output ), -N filename
  -l input_file_list, --list input_file_list
                        Inputfile name that contains fastq file names, -I filename
  -nz, --nonzero        Use non-zero mean depth of target loci as reference correlation. (default: Use mean depth of all target loci)
  -t test_samplename, --testsamplename test_samplename
                        file including test sample namses  with ":" delimeter (default : all combinations of samples), -t filename.
                        -t option is for the previous NGSCheckMate version. No longer used.
```

