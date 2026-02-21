# craq CWL Generation Report

## craq

### Tool Description
Genome benchmarking using CRAQ

### Metadata
- **Docker Image**: quay.io/biocontainers/craq:1.10--hdfd78af_0
- **Homepage**: https://github.com/JiaoLaboratory/CRAQ
- **Package**: https://anaconda.org/channels/bioconda/packages/craq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/craq/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/JiaoLaboratory/CRAQ
- **Stars**: N/A
### Original Help Text
```text
CRAQ Version: 1.0.9-alpha 

Please provide appropriate parameters!

Usage:	 /usr/local/bin/craq  -g  genome_seq -sms lr_sort.bam -ngs  sr_sort.bam
 or	 /usr/local/bin/craq  -g  genome_seq -sms lr.fq.gz -ngs sr_pair1_fq.gz,sr_pair2_fq.gz 

Name:
            Genome benchmarking using CRAQ

Usage:
      craq [options] -g genome.fa -sms SMS_sort.bam -ngs NGS_sort.bam

     Options:

      ***Help
            --help|-h                       Print the help message and exit.

      ***Required parameters
            --genome|-g                     Assembly sequence file (.fa)
            --sms_input|-sms                SMS long-read alignment(.bam) or sequences(.fq.gz)
            --ngs_input|-ngs                NGS short-read alignment(.bam) or sequences(.fq.gz), separated with comma if paired
      ***Filter parameters
            --min_ngs_clip_num|-sn          Minimum number of NGS clipped-reads. Default: 2
            --ngs_clip_coverRate|-sf        Minimum proportion of NGS clipped-reads. Default: 0.75
            --min_sms_clip_num|-ln          Minimum number of SMS clipped-reads. Default: 2
            --sms_clip_coverRate|-lf        Minimum proportion of SMS clipped-reads. Default: 0.75
            --he_min|-hmin                  Lower clipping rate for heterozygous allele. Default: 0.4
            --he_max|-hmax                  Upper clipping rate for heterozygous allele. Default: 0.6
            --min_gap_size|-mgs             Gap[N] length greater than the threshold will be treated as breakage. Default: 10
            --sms_coverage|-avgl            Average SMS coverage. Default: 100
            --ngs_coverage|-avgs            Average NGS coverage. Default: 100
      ***Other parameters
            --error_region|-ser             Search noisy error region nearby an CSE breakpoint. Default: "T"
            --report_SNV|-snv               Report tiny Indel errors or heterozyous variants (<40bp). Default: "F" (resource consuming) 
            --gapmodel|-gm                  Gap[N] is treated as 1:CRE 2:CSE. Default: 1
            --break|-b                      Break chimera fragment. Default: F
            --map|-x                        Mapping use map-pb/map-hifi/map-ont for PacBio CLR/HiFi or Nanopore vs reference [ignored if .bam provided]. Default: map-hifi
            --mapq|-q                       Minimum reads mapping quality. Default: 20
            --norm_window|-nw               Window size for normalizing error count. Default: 0.0001*(total size)
            --regional_window|-rw           Regional quality benchmarking. Default:500000
            --plot|-pl                      Plotting CRAQ metrics. Default: F;  pycircos (python 3.7later) is required if "T"
            --plot_ids|-ids                 An file including selected assembly IDs for plotting. Default use all IDs.                           
            --thread|-t                     The number of thread used in alignment. Default: 10
            --output_dir|-D                 User-specified output directory. Default: ./output
```


## Metadata
- **Skill**: generated
