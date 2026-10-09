# massiveqc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| massiveqc_IsoDetect | Not completed | needs the feature tables written by the MassiveQC pipeline (SRA download, Hisat2, Picard), which was skipped |
| massiveqc_MultiQC | Not completed | pipeline, skipped |
| massiveqc_SingleQC | Not completed | pipeline, skipped |

## massiveqc_MultiQC

### Tool Description
MultiQC is a modular tool to run multiple                       bioinformatics tools and aggregate their                       results into a single, interactive HTML report.

### Metadata
- **Docker Image**: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
- **Homepage**: https://github.com/shimw6828/MassiveQC
- **Package**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Total Downloads**: 9.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shimw6828/MassiveQC
- **Stars**: N/A
### Original Help Text
```text
usage: MultiQC [-h] [-c CONF] -i INPUT [-a ASCP_KEY] -f FASTQ_SCREEN_CONFIG -g
               GTF -x HT2_IDX [-k KNOWN_SPLICESITE_INFILE] -p PICARD -r
               REF_FLAT -o OUTDIR [-w WORKERS] [-t THREADS] [-d DOWNLOAD]
               [--only_download] [--skip_download] [--remove_fastq]
               [--remove_bam]

...

options:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF
  -i INPUT, --input INPUT
                        Input file, containing two columns srx and srr
  -a ASCP_KEY, --ascp_key ASCP_KEY
                        Locate aspera key. Default
                        $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh
  -f FASTQ_SCREEN_CONFIG, --fastq_screen_config FASTQ_SCREEN_CONFIG
                        Path to the fastq_screen conf file, can be download
                        from fastq_screen website
  -g GTF, --gtf GTF     Path to the GTF file with annotations
  -x HT2_IDX, --ht2-idx HT2_IDX
                        Hisat2 index filename prefix
  -k KNOWN_SPLICESITE_INFILE, --known-splicesite-infile KNOWN_SPLICESITE_INFILE
                        Hisat2 splicesite file, provide a list of known splice
                        sites
  -p PICARD, --picard PICARD
                        Path to picard.jar
  -r REF_FLAT, --ref_flat REF_FLAT
                        Path to refflat file
  -o OUTDIR, --outdir OUTDIR
                        Path to result output directory. If it doesn't exist,
                        it will be created automatically
  -w WORKERS, --workers WORKERS
                        The number of simultaneous tasks
  -t THREADS, --THREADS THREADS
                        The number of threads for tools like Hisat2 in one
                        task
  -d DOWNLOAD, --download DOWNLOAD
                        Path to SRA fastq files. The default is
                        $OUTDIR/download
  --only_download       Only run the download step
  --skip_download       Skip the download step
  --remove_fastq        Don't remain the fastq after running hisat2
  --remove_bam          Don't remain the bam after running FeatureCounts
```


## massiveqc_SingleQC

### Tool Description
Single-cell RNA-seq quality control tool

### Metadata
- **Docker Image**: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
- **Homepage**: https://github.com/shimw6828/MassiveQC
- **Package**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SingleQC [-h] [-c CONF] -s SRR [-a ASCP_KEY] -f FASTQ_SCREEN_CONFIG -g
                GTF -x HT2_IDX [-k KNOWN_SPLICESITE_INFILE] -p PICARD -r
                REF_FLAT -o OUTDIR [-t THREADS] [-d DOWNLOAD]
                [--only_download] [--skip_download] [--remove_fastq]
                [--remove_bam]

...

options:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF
  -s SRR, --srr SRR     SRR id
  -a ASCP_KEY, --ascp_key ASCP_KEY
                        Locate aspera key. Default=$HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh
  -f FASTQ_SCREEN_CONFIG, --fastq_screen_config FASTQ_SCREEN_CONFIG
                        Path to the fastq_screen conf file, can be download from fastq_screen website
  -g GTF, --gtf GTF     Path to the GTF file with annotations
  -x HT2_IDX, --ht2-idx HT2_IDX
                        Hisat2 index filename prefix
  -k KNOWN_SPLICESITE_INFILE, --known-splicesite-infile KNOWN_SPLICESITE_INFILE
                        Hisat2 splicesite file, provide a list of known splice sites
  -p PICARD, --picard PICARD
                        Path to picard.jar
  -r REF_FLAT, --ref_flat REF_FLAT
                        Path to refflat file
  -o OUTDIR, --outdir OUTDIR
                        Path to result output directory. If it doesn't exist, it will be created automatically
  -t THREADS, --THREADS THREADS
                        The number of threads for tools like Hisat2 in one task
  -d DOWNLOAD, --download DOWNLOAD
                        Path to SRA fastq files. The default is $OUTDIR/download
  --only_download       Only run the download step
  --skip_download       Skip the download step
  --remove_fastq        Don't remain the fastq after running hisat2
  --remove_bam          Don't remain the bam after running FeatureCounts
```


## massiveqc_IsoDetect

### Tool Description
Outlier filtering of the quality features that MassiveQC wrote to the results directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
- **Homepage**: https://github.com/shimw6828/MassiveQC
- **Package**: https://anaconda.org/channels/bioconda/packages/massiveqc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: IsoDetect [-h] -i INPUT -o OUTDIR

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input file, containing two columns srx and srr
  -o OUTDIR, --outdir OUTDIR
                        Path to result output directory of main process.
```

## Metadata
- **Skill**: generated
