# isorefiner CWL Generation Report

## isorefiner_trans_struct_wf

### Tool Description
This tool refines transcript structures based on reads and reference annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Total Downloads**: 508
- **Last updated**: 2025-07-17
- **GitHub**: https://github.com/rkajitani/IsoRefiner
- **Stars**: N/A
### Original Help Text
```text
usage: isorefiner trans_struct_wf [-h] -r [READS ...] -g GENOME -a REF_GTF
                                  [-o OUT_GTF] [-d WORK_DIR] [-t THREADS]

options:
  -h, --help            show this help message and exit
  -r [READS ...], --reads [READS ...]
                        Reads (FASTQ or FASTA, gzip allowed, mandatory)
                        (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA, mandatory) (default: None)
  -a REF_GTF, --ref_gtf REF_GTF
                        Reference genome annotation (GTF, mandatory) (default:
                        None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_refined.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_trans_struct_wf_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
```


## isorefiner_trim

### Tool Description
Trim reads using Porechop_ABI

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner trim [-h] -r [READS ...] [-o OUT_PREFIX] [-d WORK_DIR]
                       [-t THREADS] [-p TOOL_OPTION]

options:
  -h, --help            show this help message and exit
  -r [READS ...], --reads [READS ...]
                        Reads (FASTQ or FASTA, gzip allowed, mandatory)
                        (default: None)
  -o OUT_PREFIX, --out_prefix OUT_PREFIX
                        Prefix of final output files (extentions are those of
                        input files) (default: isorefiner_trimmed)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_trim_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  -p TOOL_OPTION, --tool_option TOOL_OPTION
                        Option for Porechomp_ABI (quoted string) (default: )
```


## isorefiner_map

### Tool Description
Map reads to a reference genome using minimap2 and sort the output.

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner map [-h] -r [READS ...] -g GENOME [-o OUT_PREFIX]
                      [-d WORK_DIR] [-t THREADS] [-m MM2_OPTION]
                      [-s SORT_OPTION]

options:
  -h, --help            show this help message and exit
  -r [READS ...], --reads [READS ...]
                        Reads (FASTQ or FASTA, gzip allowed, mandatory)
                        (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA, mandatory) (default: None)
  -o OUT_PREFIX, --out_prefix OUT_PREFIX
                        Prefix of output BAM files (default:
                        isorefiner_mapped)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_map_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  -m MM2_OPTION, --mm2_option MM2_OPTION
                        Option for minimap2 (quoted string) (default: -x
                        splice -ub -k14 --secondary=no)
  -s SORT_OPTION, --sort_option SORT_OPTION
                        Option for samtools sort (quoted string) (default: -m
                        2G)
```


## isorefiner_run_bambu

### Tool Description
Run Bambu for isoform refinement

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner run_bambu [-h] -b [BAM ...] -g GENOME -a REF_GTF
                            [-o OUT_GTF] [-d WORK_DIR] [-t THREADS]

options:
  -h, --help            show this help message and exit
  -b [BAM ...], --bam [BAM ...]
                        Mapped reads files (BAM, mandatory) (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA, mandatory) (default: None)
  -a REF_GTF, --ref_gtf REF_GTF
                        Reference genome annotation (GTF, mandatory) (default:
                        None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_bambu.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_bambu_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
```


## isorefiner_run_espresso

### Tool Description
Run ESPRESSO for transcript assembly and quantification.

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner run_espresso [-h] -b [BAM ...] -g GENOME -a REF_GTF
                               [-o OUT_GTF] [-d WORK_DIR] [-t THREADS]
                               [-s TOOL_S_OPTION] [-c TOOL_C_OPTION]
                               [-q TOOL_Q_OPTION]

options:
  -h, --help            show this help message and exit
  -b [BAM ...], --bam [BAM ...]
                        Mapped reads files (BAM, mandatory) (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA, mandatory) (default: None)
  -a REF_GTF, --ref_gtf REF_GTF
                        Reference genome annotation (GTF, mandatory) (default:
                        None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_espresso.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_espresso_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  -s TOOL_S_OPTION, --tool_s_option TOOL_S_OPTION
                        Option for ESPRESSO_S.pl (quoted string) (default: )
  -c TOOL_C_OPTION, --tool_c_option TOOL_C_OPTION
                        Option for ESPRESSO_C.pl (quoted string) (default: )
  -q TOOL_Q_OPTION, --tool_q_option TOOL_Q_OPTION
                        Option for ESPRESSO_Q.pl (quoted string) (default: )
```


## isorefiner_run_isoquant

### Tool Description
Run isoquant

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner run_isoquant [-h] -b [BAM ...] -g GENOME -a REF_GTF
                               [-o OUT_GTF] [-d WORK_DIR] [-t THREADS]
                               [-p TOOL_OPTION]

options:
  -h, --help            show this help message and exit
  -b [BAM ...], --bam [BAM ...]
                        Mapped reads files (BAM, mandatory) (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA, mandatory) (default: None)
  -a REF_GTF, --ref_gtf REF_GTF
                        Reference genome annotation (GTF, mandatory) (default:
                        None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_isoquant.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_isoquant_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  -p TOOL_OPTION, --tool_option TOOL_OPTION
                        Option for isoquant (quoted string) (default:
                        --complete_genedb --data_type nanopore --stranded none
                        --transcript_quantification unique_only
                        --gene_quantification unique_only --matching_strategy
                        default --splice_correction_strategy default_ont
                        --model_construction_strategy default_ont
                        --no_secondary --check_canonical --count_exons)
```


## isorefiner_run_stringtie

### Tool Description
Run StringTie to assemble transcripts

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner run_stringtie [-h] -b [BAM ...] [-g GENOME] -a REF_GTF
                                [-o OUT_GTF] [-d WORK_DIR] [-t THREADS]
                                [-p TOOL_OPTION]

options:
  -h, --help            show this help message and exit
  -b [BAM ...], --bam [BAM ...]
                        Mapped reads files (BAM, mandatory) (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA) (default: None)
  -a REF_GTF, --ref_gtf REF_GTF
                        Reference genome annotation (GTF, mandatory) (default:
                        None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_stringtie.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_stringtie_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  -p TOOL_OPTION, --tool_option TOOL_OPTION
                        Option for StringTie (quoted string) (default: )
```


## isorefiner_run_rnabloom

### Tool Description
Run RNA-Bloom for transcript assembly and quantification.

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner run_rnabloom [-h] -r [READS ...] [-g GENOME] [-o OUT_GTF]
                               [-d WORK_DIR] [-t THREADS] [--max_mem MAX_MEM]
                               [--rnabloom_option RNABLOOM_OPTION]
                               [--gmap_min_cov GMAP_MIN_COV]
                               [--gmap_min_idt GMAP_MIN_IDT]
                               [--gmap_max_intron GMAP_MAX_INTRON]
                               [--gmap_option GMAP_OPTION]

options:
  -h, --help            show this help message and exit
  -r [READS ...], --reads [READS ...]
                        Reads (FASTQ or FASTA, gzip allowed, mandatory)
                        (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA) (default: None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_rnabloom.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_rnabloom_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  --max_mem MAX_MEM     Max memory for RNA-Bloom (java -Xmx) (default: 400g)
  --rnabloom_option RNABLOOM_OPTION
                        Option for RNA-Bloom (quoted string) (default: )
  --gmap_min_cov GMAP_MIN_COV
                        Min alignment coverage for GMAP [0-1] (default: 0.5)
  --gmap_min_idt GMAP_MIN_IDT
                        Min identity for GMAP [0-1] (default: 0.95)
  --gmap_max_intron GMAP_MAX_INTRON
                        Max intron length for GMAP (bp) (default: 100000)
  --gmap_option GMAP_OPTION
                        Option for GMAP (quoted string) (default: -n 1 --no-
                        chimeras)
```


## isorefiner_filter

### Tool Description
Filter transcript structures based on read alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner filter [-h] -i INPUT_GTF -r [READS ...] -g GENOME
                         [-o OUT_GTF] [-d WORK_DIR] [-t THREADS]
                         [--max_indel MAX_INDEL] [--max_clip MAX_CLIP]
                         [--min_idt MIN_IDT] [--min_cov MIN_COV]
                         [--min_mean_depth MIN_MEAN_DEPTH]

options:
  -h, --help            show this help message and exit
  -i INPUT_GTF, --input_gtf INPUT_GTF
                        Input transcript isoform structures (GTF, mandatory)
                        (default: None)
  -r [READS ...], --reads [READS ...]
                        Reads (FASTQ or FASTA, gzip allowed, mandatory)
                        (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA, mandatory) (default: None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_filtered.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_filter_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  --max_indel MAX_INDEL
                        Max indel for read mapping (default: 20)
  --max_clip MAX_CLIP   Max clip (unaligned) length for read mapping (default:
                        200)
  --min_idt MIN_IDT     Min identity for read mapping [0-1] (default: 0.9)
  --min_cov MIN_COV     Min coverage for filtering [0-1] (default: 0.95)
  --min_mean_depth MIN_MEAN_DEPTH
                        Min mean coverage depth for filtering (default: 1.0)
```


## isorefiner_refine

### Tool Description
Refine transcript isoform structures based on reads and reference annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/rkajitani/IsoRefiner
- **Package**: https://anaconda.org/channels/bioconda/packages/isorefiner/overview
- **Validation**: PASS

### Original Help Text
```text
usage: isorefiner refine [-h] -i [INPUT_GTF ...] -r [READS ...] -g GENOME -a
                         REF_GTF [-o OUT_GTF] [-d WORK_DIR] [-t THREADS]
                         [--max_indel MAX_INDEL] [--max_clip MAX_CLIP]
                         [--min_idt MIN_IDT] [--intron_dist_th INTRON_DIST_TH]

options:
  -h, --help            show this help message and exit
  -i [INPUT_GTF ...], --input_gtf [INPUT_GTF ...]
                        Input transcript isoform structures (GTF, mandatory)
                        (default: None)
  -r [READS ...], --reads [READS ...]
                        Reads (FASTQ or FASTA, gzip allowed, mandatory)
                        (default: None)
  -g GENOME, --genome GENOME
                        Reference genome (FASTA, mandatory) (default: None)
  -a REF_GTF, --ref_gtf REF_GTF
                        Reference genome annotation (GTF, mandatory) (default:
                        None)
  -o OUT_GTF, --out_gtf OUT_GTF
                        Final output file name (GTF) (default:
                        isorefiner_refined.gtf)
  -d WORK_DIR, --work_dir WORK_DIR
                        Working directory containing intermediate and log
                        files (default: isorefiner_refine_work)
  -t THREADS, --threads THREADS
                        Number of threads (default: 1)
  --max_indel MAX_INDEL
                        Max indel for read mapping (default: 20)
  --max_clip MAX_CLIP   Max clip (unaligned) length for read mapping (default:
                        200)
  --min_idt MIN_IDT     Min identity for read mapping [0-1] (default: 0.9)
  --intron_dist_th INTRON_DIST_TH
                        Intron distance threshold to exclude erroneous
                        isoforms (default: 20)
```


## Metadata
- **Skill**: generated
