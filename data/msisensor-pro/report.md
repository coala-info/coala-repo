# msisensor-pro CWL Generation Report

## msisensor-pro_scan

### Tool Description
This module scan the reference genome to get microsatellites information. You need to input (-d) a reference file (*.fa or *.fasta), and you will get a microsatellites file (-o) for following analysis. If you use GRCh38.d1.vd1 , you can download the file on out github directly.

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
- **Homepage**: https://github.com/xjtu-omics/msisensor-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Total Downloads**: 129.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xjtu-omics/msisensor-pro
- **Stars**: N/A
### Original Help Text
```text
Usage:  msisensor-pro scan [options] 

       -d   <string>   reference genome sequences file, *.fasta or *.fa format  [required]
       -o   <string>   output homopolymers and microsatellites file [required] 

       -l   <int>      minimal homopolymer(repeat unit length = 1) size, [default=8]
       -c   <int>      context length (5-32), [default=5]
       -m   <int>      maximal homopolymer size, [default=50]
       -s   <int>      maximal length of microsatellite (1-32) , [default=6]
       -r   <int>      minimal repeat times of microsatellite(repeat unit length>=2), [default=5]
       -p   <int>      output homopolymer only, 0: no; 1: yes, [default=0]
       -h   help
-----------------------------------------------------------------
Function: 
   This module scan the reference genome to get microsatellites information. You need to input (-d) a reference file (*.fa or *.fasta), and you will get a microsatellites file (-o) for following analysis. If you use GRCh38.d1.vd1 , you can download the file on out github directly. 

Example:
   msisensor-pro scan -d /path/to/reference.fa -o /path/to/reference.list

Note:
   This module inherits from msisensor. If you use it for your work, please cite:
   Beifang Niu*, Kai Ye*, Qunyuan Zhang, Charles Lu, Mingchao Xie, Michael D. McLellan, Michael C. Wendl and Li Ding#.MSIsensor: microsatellite instability detection using paired tumor-normal sequence data. Bioinformatics 30, 1015–1016 (2014).
```


## msisensor-pro_msi

### Tool Description
This module evaluate MSI using the difference between normal and tumor length distribution of microsatellites. You need to input (-d) microsatellites file and two bam files (-t, -n).

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
- **Homepage**: https://github.com/xjtu-omics/msisensor-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  msisensor-pro msi [options] 

       -d   <string>   homopolymers and microsatellites file [required]
       -n   <string>   normal bam file with index [required]
       -t   <string>   tumor  bam file with index [required]
       -g   <string>   reference file [required if *.cram for -t]
       -o   <string>   output path (Ending with a slash is not allowed.) [required] 

       -f   <double>   FDR threshold for somatic sites detection, [default=0.05]
       -c   <int>      coverage threshold for msi analysis, WXS: 20; WGS: 15, [default=15]
       -z   <int>      coverage normalization for paired tumor and normal data, 0: no; 1: yes, [default=0]
       -p   <int>      minimal homopolymer size for distribution analysis, [default=8]
       -m   <int>      maximal homopolymer size for distribution analysis, [default=50]
       -s   <int>      minimal microsatellite size for distribution analysis, [default=5]
       -w   <int>      maximal microsatellite size for distribution analysis, [default=40]
       -u   <int>      span size around window for extracting reads, [default=500]
       -b   <int>      threads number for parallel computing, [default=1]
       -x   <int>      output homopolymer only, 0: no; 1: yes, [default=0]
       -y   <int>      output microsatellites only, 0: no; 1: yes, [default=0]
       -0   <int>      output site have no read coverage, 1: no; 0: yes, [default=1]
       -h   help
-----------------------------------------------------------------
Function: 
   This module evaluate MSI using the difference between normal and tumor length distribution of microsatellites. You need to input (-d) microsatellites file and two bam files (-t, -n).

Example:
   msisensor-pro msi -d /path/to/reference.list -n /path/to/case1_normal_sorted.bam -t /path/to/case1_tumor_sorted.bam -o /path/to/case1_output

Note:
   This module inherits from msisensor. If you use it for your work, please cite:
   Beifang Niu*, Kai Ye*, Qunyuan Zhang, Charles Lu, Mingchao Xie, Michael D. McLellan, Michael C. Wendl and Li Ding#.MSIsensor: microsatellite instability detection using paired tumor-normal sequence data. Bioinformatics 30, 1015–1016 (2014).
```


## msisensor-pro_evaluate

### Tool Description
Microsatellite Instability (MSI) detection using high-throughput sequencing data. (Support tumor-normal paired samples and tumor-only samples)

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
- **Homepage**: https://github.com/xjtu-omics/msisensor-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Validation**: PASS

### Original Help Text
```text
msisensor-pro: Microsatellite Instability (MSI) detection using high-throughput sequencing data. 
         (Support tumor-normal paired samples and tumor-only samples) 

Version: v1.3.0

Usage: msisensor-pro <command> [options]

Commands:

	 scan
	   scan the reference genome to get microsatellites information

	 msi
	   evaluate MSI using paired tumor-normal sequencing data

	 baseline
	   build baseline for tumor only detection

	 pro
	   evaluate MSI using single (tumor) sample sequencing data 


    If you have any questions, please open an issue on GitHub (https://github.com/xjtu-omics/msisensor-pro) or contact with Peng Jia (pengjia@xjtu.edu.cn) or Kai Ye (kaiye@xjtu.edu.cn) .
```


## msisensor-pro_baseline

### Tool Description
This module build baseline for MSI detection with pro module using only tumor sequencing data. To achieve it, you need sequencing data from normal samples(-i).

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
- **Homepage**: https://github.com/xjtu-omics/msisensor-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  msisensor-pro baseline [options] 

       -d   <string>   homopolymer and microsatellite file [required]
       -i   <string>   configure files for building baseline (text file) [required]
            you need to provide the output (*_all) from pro command 
            e.g.
             ----------------------------------
              case1	/path/to/case1_sorted_all 
              case2	/path/to/case2_sorted_all 
              case3	/path/to/case3-sorted_all 
             ----------------------------------
       -o   <string>   output path for baseline [required] 

       -s   <double>   microsatellite sites with support from fewer than -d samples will not pass quality control, [default=10]
       -h   help
-----------------------------------------------------------------
Function: 
   This module build baseline for MSI detection with pro module using only tumor sequencing data. To achieve it, you need sequencing data from normal samples(-i).

Example:
   msisensor-pro baseline -d /path/to/reference.list -i /path/to/configure.txt -o /path/to/baseline.tsv 

Note:

   If you have any questions, please contact with Peng Jia (pengjia@xjtu.edu.cn).
```


## msisensor-pro_build

### Tool Description
Microsatellite Instability (MSI) detection using high-throughput sequencing data. (Support tumor-normal paired samples and tumor-only samples)

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
- **Homepage**: https://github.com/xjtu-omics/msisensor-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Validation**: PASS

### Original Help Text
```text
msisensor-pro: Microsatellite Instability (MSI) detection using high-throughput sequencing data. 
         (Support tumor-normal paired samples and tumor-only samples) 

Version: v1.3.0

Usage: msisensor-pro <command> [options]

Commands:

	 scan
	   scan the reference genome to get microsatellites information

	 msi
	   evaluate MSI using paired tumor-normal sequencing data

	 baseline
	   build baseline for tumor only detection

	 pro
	   evaluate MSI using single (tumor) sample sequencing data 


    If you have any questions, please open an issue on GitHub (https://github.com/xjtu-omics/msisensor-pro) or contact with Peng Jia (pengjia@xjtu.edu.cn) or Kai Ye (kaiye@xjtu.edu.cn) .
```


## msisensor-pro_pro

### Tool Description
This module evaluate MSI using single (tumor) sample. You need to input (-d) microsatellites file and a bam files (-t) .

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
- **Homepage**: https://github.com/xjtu-omics/msisensor-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  msisensor-pro pro [options] 

       -d   <string>   homopolymers and microsatellites file [required] 
       -t   <string>   bam/cram file of tumor/normal(for baseline building) sample [required] 
       -g   <string>   reference file [required if *.cram for -t]
       -o   <string>   output path (Ending with a slash is not allowed.) [required]

       -i   <double>   minimal threshold for instable sites detection (just for tumor only data), [default=0.1]
       -c   <int>      coverage threshold for msi analysis, WXS: 20; WGS: 15, [default=15]
       -p   <int>      minimal homopolymer size for distribution analysis, [default=8]
       -m   <int>      maximal homopolymer size for distribution analysis, [default=50]
       -s   <int>      minimal microsatellite size for distribution analysis, [default=5]
       -w   <int>      maximal microsatellite size for distribution analysis, [default=40]
       -u   <int>      span size around window for extracting reads, [default=500]
       -b   <int>      threads number for parallel computing, [default=1]
       -x   <int>      output homopolymer only, 0: no; 1: yes, [default=0]
       -y   <int>      output microsatellite only, 0: no; 1: yes, [default=0[
       -0   <int>      output site have no read coverage, 1: no; 0: yes, [default=1]
       -h   help
-----------------------------------------------------------------
Function: 
   This module evaluate MSI using single (tumor) sample. You need to input (-d) microsatellites file and a bam files (-t) .

Example:
   1. msisensor-pro pro -d /path/to/reference.list -i 0.1 -t /path/to/case1_tumor_sorted.bam -o /path/to/case1_output

   2. msisensor-pro pro -d /path/to/reference.list_baseline -t /path/to/case1_tumor_sorted.bam -o /path/to/case1_output

Note:
   For diffferent requirements of users, we offer two choices.
      * If you have no normal sample to train a baseline, you can use hard threshold (-i option) to defined an unstable.
      * You can use also use soft threshold train by your self or download from the github page of msisensor-pro (GRCh38.d1.vd1).
```


## msisensor-pro_If

### Tool Description
Microsatellite Instability (MSI) detection using high-throughput sequencing data. (Support tumor-normal paired samples and tumor-only samples)

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-pro:1.3.0--hd979922_1
- **Homepage**: https://github.com/xjtu-omics/msisensor-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-pro/overview
- **Validation**: PASS

### Original Help Text
```text
msisensor-pro: Microsatellite Instability (MSI) detection using high-throughput sequencing data. 
         (Support tumor-normal paired samples and tumor-only samples) 

Version: v1.3.0

Usage: msisensor-pro <command> [options]

Commands:

	 scan
	   scan the reference genome to get microsatellites information

	 msi
	   evaluate MSI using paired tumor-normal sequencing data

	 baseline
	   build baseline for tumor only detection

	 pro
	   evaluate MSI using single (tumor) sample sequencing data 


    If you have any questions, please open an issue on GitHub (https://github.com/xjtu-omics/msisensor-pro) or contact with Peng Jia (pengjia@xjtu.edu.cn) or Kai Ye (kaiye@xjtu.edu.cn) .
```

