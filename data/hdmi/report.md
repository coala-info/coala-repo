# hdmi CWL Generation Report

## hdmi_detect

### Tool Description
Directory containing genome FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/HaoranPeng21/HDMI
- **Package**: https://anaconda.org/channels/bioconda/packages/hdmi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hdmi/overview
- **Total Downloads**: 51
- **Last updated**: 2025-11-20
- **GitHub**: https://github.com/HaoranPeng21/HDMI
- **Stars**: N/A
### Original Help Text
```text
usage: HDMI detect [-h] -i GENOME_PATH [-o OUTPUT] -m GROUP_INFO
                   [-number TASK_NUMBER] [-total TOTAL_TASKS] [-t THREADS]
                   [--count-only]

options:
  -h, --help            show this help message and exit
  -i, --genome_path GENOME_PATH
                        Directory containing genome FASTA files
  -o, --output OUTPUT   Output directory for detection results (default:
                        result)
  -m, --group_info GROUP_INFO
                        Group info file (Group_info_test.txt format)
  -number, --task_number TASK_NUMBER
                        Task number for parallel processing (1-indexed,
                        default: 1)
  -total, --total_tasks TOTAL_TASKS
                        Total number of parallel tasks (default: 1)
  -t, --threads THREADS
                        Number of threads for parallel processing (default: 1)
  --count-only          Only count genome pairs and estimate performance
                        without running detection
```


## hdmi_index

### Tool Description
Index a genome for HDMI analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/HaoranPeng21/HDMI
- **Package**: https://anaconda.org/channels/bioconda/packages/hdmi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: HDMI index [-h] -g GENOME_PATH -m GROUP_INFO [-o OUTPUT] [-t THREADS]

options:
  -h, --help            show this help message and exit
  -g, --genome_path GENOME_PATH
                        Directory containing genome FASTA files
  -m, --group_info GROUP_INFO
                        Group info file
  -o, --output OUTPUT   Output directory (default: genome_folder
                        parent/intermediate/index)
  -t, --threads THREADS
                        Number of threads for bowtie2-build (default: 1)
```


## hdmi_profile

### Tool Description
Profile HDMI sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/HaoranPeng21/HDMI
- **Package**: https://anaconda.org/channels/bioconda/packages/hdmi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: HDMI profile [-h] -r1 READ1 -r2 READ2 [--prefix PREFIX] [-o OUTPUT]
                    -g GENOME_PATH [--hgt_table HGT_TABLE] -m GROUP_INFO
                    [-t THREADS] [--seed SEED] [--sth STH]

options:
  -h, --help            show this help message and exit
  -r1, --read1 READ1    Path to read1 FASTQ file
  -r2, --read2 READ2    Path to read2 FASTQ file
  --prefix, --sample_id PREFIX
                        Sample prefix (auto-extracted from read1 filename if
                        not provided)
  -o, --output OUTPUT   Output directory (default: result)
  -g, --genome_path GENOME_PATH
                        Directory containing genome FASTA files
  --hgt_table HGT_TABLE
                        HGT events table (auto-found in output directory if
                        not provided)
  -m, --group_info GROUP_INFO
                        Group info file
  -t, --threads THREADS
                        Number of threads (default: 1)
  --seed SEED           Random seed for reproducibility (default: 42)
  --sth STH             Read span threshold (default: 2)
```


## hdmi_summary

### Tool Description
Generates a summary of HDMI validation results.

### Metadata
- **Docker Image**: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/HaoranPeng21/HDMI
- **Package**: https://anaconda.org/channels/bioconda/packages/hdmi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: HDMI summary [-h] [-i SAMPLES_DIR] [-hgt HGT_EVENTS] -group GROUP_INFO
                    [-o OUTPUT] [--threshold THRESHOLD] [--temp_dir TEMP_DIR]

options:
  -h, --help            show this help message and exit
  -i, --samples_dir SAMPLES_DIR
                        Directory containing validation results (auto-found in
                        output/intermediate/02_validation if not provided)
  -hgt, --hgt_events HGT_EVENTS
                        HGT events file (auto-found in output directory if not
                        provided)
  -group, --group_info GROUP_INFO
                        Group info file
  -o, --output OUTPUT   Output directory (default: result)
  --threshold THRESHOLD
                        Abundance threshold (default: 1.0)
  --temp_dir TEMP_DIR   Temporary directory for merged files
```

