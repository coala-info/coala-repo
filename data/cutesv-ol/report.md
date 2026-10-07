# cutesv-ol CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cutesv-ol_cuteSV | PASS |  |
| cutesv-ol_cuteSV_ONLINE | PASS |  |

## cutesv-ol_cuteSV_ONLINE

### Tool Description
cuteSV-OL is a real-time SV detection tool based on cuteSV.

### Metadata
- **Docker Image**: quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0
- **Homepage**: https://github.com/120L022331/cuteSV-OL
- **Package**: https://anaconda.org/channels/bioconda/packages/cutesv-ol/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cutesv-ol/overview
- **Total Downloads**: 773
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/120L022331/cuteSV-OL
- **Stars**: N/A
### Original Help Text
```text
usage: cuteSV_ONLINE [-h] [--threads THREADS] [--mmi_path MMI_PATH]
                     [--monitor_fade MONITOR_FADE]
                     [--high_freq_file HIGH_FREQ_FILE]
                     [--target_set TARGET_SET] [--user_defined]
                     [--sv_freq SV_FREQ] [--pctsize PCTSIZE]
                     [--ref_dist REF_DIST] [--recall_file RECALL_FILE]
                     [--target_rate TARGET_RATE]
                     [--batch_interval BATCH_INTERVAL]
                     fastq_dir reference work_dir output_vcf

positional arguments:
  fastq_dir             The fastq folder monitored by cuteSV-OL.
  reference             The reference genome in fasta format.
  work_dir              Work diretory for cuteSV-OL.
  output_vcf            The vcf folder where cuteSV-OL outputs real-time test
                        results to.

options:
  -h, --help            show this help message and exit
  --threads THREADS     Number of threads to use.
  --mmi_path MMI_PATH   Minimizer index for the reference in minimap2.
  --monitor_fade MONITOR_FADE
                        Monitor will close if no new files are detected after
                        monitor_fade second.
  --high_freq_file HIGH_FREQ_FILE
                        high frequence SV file or user-defined recall set[vcf]
  --target_set TARGET_SET
                        high frequence SV file or user-defined recall set[vcf]
  --user_defined        The recall set[vcf] is user-defined
  --sv_freq SV_FREQ     Target SV frequence for detection
  --pctsize PCTSIZE     Min pct allele size similarity
  --ref_dist REF_DIST   Max reference location distance
  --recall_file RECALL_FILE
                        candidate SV mapping to the high frequence SV
  --target_rate TARGET_RATE
                        stop sequency if the detected rate is higher than
                        target_rate
  --batch_interval BATCH_INTERVAL
                        Real-time results are generated every batch_interval
                        batches
```


## cutesv-ol_cuteSV

### Tool Description
Two-step cuteSV shipped with cuteSV-OL (--mode 1 extracts SV signatures, --mode 2 clusters them into a VCF).

### Metadata
- **Docker Image**: quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0
- **Homepage**: https://github.com/120L022331/cuteSV-OL
- **Package**: https://anaconda.org/channels/bioconda/packages/cutesv-ol/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cutesv-ol/overview
- **Total Downloads**: 773
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/120L022331/cuteSV-OL
- **Stars**: N/A
### Original Help Text
```text
usage: cuteSV [-h] [--version] [--input [BAM]] [--reference REFERENCE]
              [--output OUTPUT] [--work_dir WORK_DIR] [--mode MODE]
              [--bam_name BAM_NAME] [-t THREADS] [-b BATCHES] [-S SAMPLE]
              [--retain_work_dir] [--write_old_sigs] [--report_readid]
              [--ignore_sequence] [-p MAX_SPLIT_PARTS] [-q MIN_MAPQ]
              [-r MIN_READ_LEN] [-md MERGE_DEL_THRESHOLD]
              [-mi MERGE_INS_THRESHOLD] [-include_bed INCLUDE_BED]
              [-s MIN_SUPPORT] [-l MIN_SIZE] [-L MAX_SIZE] [-sl MIN_SIGLENGTH]
              [--genotype] [--gt_round GT_ROUND] [--read_range READ_RANGE]
              [-Ivcf IVCF] [--max_cluster_bias_INS MAX_CLUSTER_BIAS_INS]
              [--diff_ratio_merging_INS DIFF_RATIO_MERGING_INS]
              [--max_cluster_bias_DEL MAX_CLUSTER_BIAS_DEL]
              [--diff_ratio_merging_DEL DIFF_RATIO_MERGING_DEL]
              [--max_cluster_bias_INV MAX_CLUSTER_BIAS_INV]
              [--max_cluster_bias_DUP MAX_CLUSTER_BIAS_DUP]
              [--max_cluster_bias_TRA MAX_CLUSTER_BIAS_TRA]
              [--diff_ratio_filtering_TRA DIFF_RATIO_FILTERING_TRA]
              [--remain_reads_ratio REMAIN_READS_RATIO]

		
	Current version: v2.1.2
	Author: Tao Jiang
	Contact: tjiang@hit.edu.cn

	If you use cuteSV in your work, please cite:
		Jiang T et al. Long-read-based human genomic structural variation detection with cuteSV. 
		Genome Biol 21,189(2020). https://doi.org/10.1186/s13059-020-02107-y

	Suggestions:

	For PacBio CLR data:
		--max_cluster_bias_INS		100
		--diff_ratio_merging_INS	0.3
		--max_cluster_bias_DEL	200
		--diff_ratio_merging_DEL	0.5

	For PacBio CCS(HIFI) data:
		--max_cluster_bias_INS		1000
		--diff_ratio_merging_INS	0.9
		--max_cluster_bias_DEL	1000
		--diff_ratio_merging_DEL	0.5

	For ONT data:
		--max_cluster_bias_INS		100
		--diff_ratio_merging_INS	0.3
		--max_cluster_bias_DEL	100
		--diff_ratio_merging_DEL	0.3

	

options:
  -h, --help            show this help message and exit
  --version, -v         show program's version number and exit
  --input [BAM]         Sorted .bam file from NGMLR or Minimap2.
  --reference REFERENCE
                        The reference genome in fasta format.
  --output OUTPUT       Output VCF format file.
  --work_dir WORK_DIR   Work-directory for distributed jobs
  --mode MODE           convert cutesv to two steps
  --bam_name BAM_NAME   bam_name
  -t THREADS, --threads THREADS
                        Number of threads to use.[16]
  -b BATCHES, --batches BATCHES
                        Batch of genome segmentation interval.[10000000]
  -S SAMPLE, --sample SAMPLE
                        Sample name/id
  --retain_work_dir     Enable to retain temporary folder and files.
  --write_old_sigs      Enable to write sigs file in temporary folder for
                        legacy compatibilities.
  --report_readid       Enable to report supporting read ids for each SV.
  --ignore_sequence     Do not output sequences for SVs.

Collection of SV signatures:
  -p MAX_SPLIT_PARTS, --max_split_parts MAX_SPLIT_PARTS
                        Maximum number of split segments a read may be aligned
                        before it is ignored. All split segments are
                        considered when using -1. (Recommand -1 when applying
                        assembly-based alignment.)[7]
  -q MIN_MAPQ, --min_mapq MIN_MAPQ
                        Minimum mapping quality value of alignment to be taken
                        into account.[20]
  -r MIN_READ_LEN, --min_read_len MIN_READ_LEN
                        Ignores reads that only report alignments with not
                        longer than bp.[500]
  -md MERGE_DEL_THRESHOLD, --merge_del_threshold MERGE_DEL_THRESHOLD
                        Maximum distance of deletion signals to be merged. In
                        our paper, I used -md 500 to process HG002 real human
                        sample data.[0]
  -mi MERGE_INS_THRESHOLD, --merge_ins_threshold MERGE_INS_THRESHOLD
                        Maximum distance of insertion signals to be merged. In
                        our paper, I used -mi 500 to process HG002 real human
                        sample data.[100]
  -include_bed INCLUDE_BED
                        Optional given bed file. Only detect SVs in regions in
                        the BED file. [NULL]

Generation of SV clusters:
  -s MIN_SUPPORT, --min_support MIN_SUPPORT
                        Minimum number of reads that support a SV to be
                        reported.[10]
  -l MIN_SIZE, --min_size MIN_SIZE
                        Minimum size of SV to be reported.[30]
  -L MAX_SIZE, --max_size MAX_SIZE
                        Maximum size of SV to be reported. All SVs are
                        reported when using -1. [100000]
  -sl MIN_SIGLENGTH, --min_siglength MIN_SIGLENGTH
                        Minimum length of SV signal to be extracted.[10]

Computing genotypes:
  --genotype            Enable to generate genotypes.
  --gt_round GT_ROUND   Maximum round of iteration for alignments searching if
                        perform genotyping.[500]
  --read_range READ_RANGE
                        The interval range for counting reads
                        distribution.[1000]

Force calling:
  -Ivcf IVCF            The force calling module was disabled in cuteSV,
                        please install cuteFC
                        (https://github.com/Meltpinkg/cuteFC) to achieve SV
                        force calling/regenotyping.

Advanced:
  --max_cluster_bias_INS MAX_CLUSTER_BIAS_INS
                        Maximum distance to cluster read together for
                        insertion.[100]
  --diff_ratio_merging_INS DIFF_RATIO_MERGING_INS
                        Do not merge breakpoints with basepair identity more
                        than [0.3] for insertion.
  --max_cluster_bias_DEL MAX_CLUSTER_BIAS_DEL
                        Maximum distance to cluster read together for
                        deletion.[200]
  --diff_ratio_merging_DEL DIFF_RATIO_MERGING_DEL
                        Do not merge breakpoints with basepair identity more
                        than [0.5] for deletion.
  --max_cluster_bias_INV MAX_CLUSTER_BIAS_INV
                        Maximum distance to cluster read together for
                        inversion.[500]
  --max_cluster_bias_DUP MAX_CLUSTER_BIAS_DUP
                        Maximum distance to cluster read together for
                        duplication.[500]
  --max_cluster_bias_TRA MAX_CLUSTER_BIAS_TRA
                        Maximum distance to cluster read together for
                        translocation.[50]
  --diff_ratio_filtering_TRA DIFF_RATIO_FILTERING_TRA
                        Filter breakpoints with basepair identity less than
                        [0.6] for translocation.
  --remain_reads_ratio REMAIN_READS_RATIO
                        The ratio of reads remained in cluster. Set lower when
                        the alignment data have high quality but recommand
                        over 0.5.[1.0]
```

## Metadata
- **Skill**: generated
