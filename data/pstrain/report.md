# pstrain CWL Generation Report

## pstrain

### Tool Description
PStrain: profile strains in shotgun metagenomic sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/pstrain:1.0.3--h9ee0642_0
- **Homepage**: https://github.com/wshuai294/PStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/pstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pstrain/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wshuai294/PStrain
- **Stars**: N/A
### Original Help Text
```text
usage: python3 PStrain.py [options] -c/--conf <config file> -o/--outdir <output directory> --bowtie2db <metaphlan database> -x <metaphlan db index>

    Example: python3 PStrain.py -c config.txt -o out --bowtie2db ../mpa_vOct22_CHOCOPhlAnSGB_202403/ -x mpa_vOct22_CHOCOPhlAnSGB_202403 # Metaphlan 4
             python3 PStrain.py --metaphlan_version 3  -c config.txt -o outdir/ --bowtie2db ../mpa_v31_CHOCOPhlAn_201901/ -x mpa_v31_CHOCOPhlAn_201901 # Metaphlan 3

    The config file should follow the format:

    //
    sample: [sample1_ID]
    fq1: [forward reads fastq]
    fq2: [reverse/mate reads fastq]
    //
    sample: [sample2_ID]
    fq1: [forward reads fastq]
    fq2: [reverse/mate reads fastq]
    ...

    Help information can be found by python3 PStrain.py -h/--help, config file format for single end reads , and additional information can be found    in README.MD or https://github.com/wshuai294/PStrain.
    

PStrain: profile strains in shotgun metagenomic sequencing reads.

required arguments:
  -c , --conf           The configuration file of the input samples. (default:
                        None)
  -o , --outdir         The output directory. (default: None)
  --bowtie2db           Path to metaphlan bowtie2db. (default:
                        /usr/local/bin/../mpa_vJun23_CHOCOPhlAnSGB_202403)
  -x , --metaphlan_index 
                        metaphlan bowtie2db index. (default:
                        mpa_vJun23_CHOCOPhlAnSGB_202403)

options:
  -h, --help            show this help message and exit
  --metaphlan_version   Metaphlan version [3 or 4]. Used to download the
                        corresponding database. If you build the metaphlan
                        database yourself, just ignore this. (default: 4)
  --bowtie2             Path to bowtie2 binary. (default: bowtie2)
  --bowtie2-build       Path to bowtie2 binary. (default: bowtie2-build)
  --samtools            Path to samtools binary. (default: samtools)
  --metaphlan           Path to metaphlan. (default: metaphlan)
  --metaphlan_output_files 
                        If you have run metaphlan already, give metaphlan
                        result file in each line, the order should be the same
                        with config file. In particular, '--tax_lev s' should
                        be added while running metaphlan. (default: )
  -p , --proc           The number of process to use for parallelizing the
                        whole pipeline, run a sample in each process.
                        (default: 1)
  -n , --nproc          The number of CPUs to use for parallelizing the
                        mapping with bowtie2. (default: 1)
  -w , --weight         The weight of genotype frequencies while computing
                        loss, then the weight of linked read type frequencies
                        is 1-w. The value is between 0~1. (default: 0.3)
  --lambda1             The weight of prior knowledge while rectifying
                        genotype frequencies. The value is between 0~1.
                        (default: 0.0)
  --lambda2             The weight of prior estimation while rectifying second
                        order genotype frequencies. The value is between 0~1.
                        (default: 0.0)
  --species_dp          The minimum depth of species to be considered in
                        strain profiling step (default is 5). (default: 5)
  --snp_ratio           The SNVs of which the depth are less than the specific
                        ratio of the species's mean depth would be removed.
                        (default: 0.45)
  --qual                The minimum quality score of SNVs to be considered in
                        strain profiling step. (default: 20)
  --similarity          The similarity cutoff of hierachical clustering in
                        merge step. (default: 0.95)
  --elbow               The cutoff of elbow method while identifying strains
                        number. If the loss reduction ratio is less than the
                        cutoff, then the strains number is determined.
                        (default: 0.24)
  --gatk                Path to gatk binary. (default:
                        /usr/local/bin//GenomeAnalysisTK.jar)
  --picard              Path to picard binary. (default:
                        /usr/local/bin//picard.jar)
  --prior               The file of prior knowledge of genotype frequencies in
                        the population. Not providing this is also ok.
                        (default: None)
```

