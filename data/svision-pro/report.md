# svision-pro CWL Generation Report

## svision-pro_SVision-pro

### Tool Description
SVision-Pro 2.5

### Metadata
- **Docker Image**: quay.io/biocontainers/svision-pro:2.5--pyhdfd78af_0
- **Homepage**: https://github.com/songbowang125/SVision-pro
- **Package**: https://anaconda.org/channels/bioconda/packages/svision-pro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svision-pro/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/songbowang125/SVision-pro
- **Stars**: N/A
### Original Help Text
```text
usage: SVision-pro [-h] --out_path OUT_PATH --target_path TARGET_PATH
                   [--base_path IN [IN ...]] [--access_path ACCESS_PATH]
                   --model_path MODEL_PATH --genome_path GENOME_PATH
                   --sample_name SAMPLE_NAME --preset {hifi,error-prone,asm}
                   [--detect_mode {germline,denovo,somatic,genotype}]
                   [--bkp_mode {affected,extended}]
                   [--process_num PROCESS_NUM] [--min_supp MIN_SUPP]
                   [--min_mapq MIN_MAPQ] [--min_sv_size MIN_SV_SIZE]
                   [--max_sv_size MAX_SV_SIZE] [--max_coverage MAX_COVERAGE]
                   [--interval_size INTERVAL_SIZE] [--region REGION]
                   [--force_cluster] [--skip_coverage_filter]
                   [--enable_mismatch_filter] [--skip_nearby] [--skip_bnd]
                   [--rescue_large] [--img_size {256,512,1024}]
                   [--batch_size BATCH_SIZE] [--report_new_bkps]
                   [--device {cpu,gpu}] [--gpu_id GPU_ID]
                   [--unet_cpu_num UNET_CPU_NUM]

SVision-Pro 2.5 
 
Short Usage: SVision [parameters] -o <output path> -t <target bam path> (-b <base bam path>) -g <reference> -m <model path>

optional arguments:
  -h, --help            show this help message and exit

Input/Output parameters:
  --out_path OUT_PATH   Absolute path to output
  --target_path TARGET_PATH
                        Absolute path to target (tumor) bam file
  --base_path IN [IN ...]
                        Absolute path to base (normal) bam files, not required
  --access_path ACCESS_PATH
                        Absolute path to access file, not required
  --model_path MODEL_PATH
                        Absolute path to Unet predict model
  --genome_path GENOME_PATH
                        Absolute path to your reference genome (.fai required
                        in the directory)
  --sample_name SAMPLE_NAME
                        Name of the BAM sample name
  --preset {hifi,error-prone,asm}
                        Choose from hifi, error-prone (for ONT and other noisy
                        long reads) and asm

Optional parameters:
  --detect_mode {germline,denovo,somatic,genotype}
                        Choose from germline, denovo and somatic
  --bkp_mode {affected,extended}
                        Choose from affected and extended
  --process_num PROCESS_NUM
                        Thread numbers (default: 1)
  --min_supp MIN_SUPP   Minimum support read number required for SV calling
                        (default: 5)
  --min_mapq MIN_MAPQ   Minimum mapping quality of reads to consider (default:
                        20)
  --min_sv_size MIN_SV_SIZE
                        Minimum SV size to detect (default: 50)
  --max_sv_size MAX_SV_SIZE
                        Maximum SV size to detect (default: 50000)
  --max_coverage MAX_COVERAGE
                        Maximum read coverage to detect (default: 500)
  --interval_size INTERVAL_SIZE
                        The sliding interval/window size in segment collection
                        (default: 10000000)
  --region REGION       Specific region (chromosome:start-end) to detect
  --force_cluster       Force cluster uncovered events
  --skip_coverage_filter
                        SKip filtering reads by max read coverage threshold
  --enable_mismatch_filter
                        SKip filtering reads by mismatch ratio
  --skip_nearby         SKip merging nearby Is and Ds
  --skip_bnd            SKip calling BNDs
  --rescue_large        Report large SV/CSVs that are not fully covered by
                        reads

Lite-Unet parameters:
  --img_size {256,512,1024}
                        Image size for generating plots
  --batch_size BATCH_SIZE
                        Batch size for Unet predicting
  --report_new_bkps     Report new breakpoints when inherityping
  --device {cpu,gpu}    Utilizing CPU or GPU to run Unet genotype module
  --gpu_id GPU_ID       Specific GPU ID when activating GPU device
  --unet_cpu_num UNET_CPU_NUM
                        When using CPU, specific the process number for each
                        Unet task
```

