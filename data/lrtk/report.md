# lrtk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lrtk_ALIGN | Failed | image problem: the image has Java 8 but picard 3.0.0 needs Java 17, so the mark-duplicates step always fails after EMA/bwa alignment (real SARS-CoV-2 reads with barcodes). |
| lrtk_ASSEMBLY | Failed | tool bug: lrtk ASSEMBLY exits 0 without assembling (checkASSEMBLY never calls the assembly module); Pangaea also needs torch, which the image lacks. |
| lrtk_MKFQ | PASS | synthetic data: config and quality tables made by hand, real SARS-CoV-2 genome as template; all 674 simulated read pairs match the genome and all barcodes come from the pool. |
| lrtk_RLF | Failed | tool bug: the -D distance is ignored (the code hardcodes 200000); -D 1000 and -D 200000 give identical output, while the fragment table itself is valid. |
| lrtk_SNV | Failed | tool bug: FreeBayes mode crashes (vcfstreamsort in the image dies with illegal instruction), Samtools mode fails (bcftools filter needs the RPB tag the new bcftools no longer writes), GATK mode builds a broken command (missing spaces). |
| lrtk_SV | Failed | image problem: LinkedSV crashes because the Python module psutil is missing; Aquila and VALOR need human uniqueness and sonic databases. |
| lrtk_fqconver | PASS | synthetic data: real nf-core SARS-CoV-2 pairs with planted 10x barcodes; all 100 reads got the right BX:Z tag (1-mismatch barcodes corrected). Rewritten from the help (old file ran bare lrtk). |
| lrtk_mwgs | Not completed | pipeline, skipped (rewritten from the help to run lrtk MWGS; needs the LRTK database). |
| lrtk_phase | PASS | HapCUT2 phased 21 GIAB het SNVs from the nf-core NA12878 chr22 BAM into 6 blocks; -A WhatsHap fails because whatshap is missing from the image. Rewritten from the help. |

## lrtk_fqconver

### Tool Description
Convert raw 10x, stLFR or TELL-Seq linked-read FASTQ files to the unified linked-read format.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 FQCONVER [-h] -I1 INPUT_FASTQ1 -I2 INPUT_FASTQ2
                                 [-ID INDEX_FASTQ] [-IT {10x,stLFR,TELLSeq}]
                                 -O1 OUTPUT_FASTQ1 -O2 OUTPUT_FASTQ2
                                 [-BW BARCODES] [-HD HOST] [-F {Yes,No}]
                                 [-S {Yes,No}] [-T THREADS]
                                 [-G {human,metagenome}]

options:
  -h, --help            show this help message and exit
  -I1 INPUT_FASTQ1, --input_fastq1 INPUT_FASTQ1
                        Input fastq file (uncompressed FASTQ format), the
                        first read of paired linked-read sequencing data
  -I2 INPUT_FASTQ2, --input_fastq2 INPUT_FASTQ2
                        Input fastq file (uncompressed FASTQ format), the
                        second read of paired linked-read sequencing data
  -ID INDEX_FASTQ, --index_fastq INDEX_FASTQ
                        Input index file (uncompressed FASTQ format) for
                        paired linked-read sequencing data.
  -IT {10x,stLFR,TELLSeq}, --input_type {10x,stLFR,TELLSeq}
                        Input sequencing technology. Users can choose from
                        (10x,stLFR,TELLSeq).
  -O1 OUTPUT_FASTQ1, --output_fastq1 OUTPUT_FASTQ1
                        Output fastq file, the first read of paired linked-
                        read sequencing data
  -O2 OUTPUT_FASTQ2, --output_fastq2 OUTPUT_FASTQ2
                        Output fastq file, the second read of paired linked-
                        read sequencing data.
  -BW BARCODES, --barcodes BARCODES
                        The reference barcode whitelist files for 10x and
                        stLFR technologies
  -HD HOST, --host HOST
                        The host reference genome database, required for
                        metagenomic sequencing
  -F {Yes,No}, --filter {Yes,No}
                        Users can choose from (Yes, No). "Yes" indicates that
                        LRTK will use fastp to filter reads.
  -S {Yes,No}, --sort {Yes,No}
                        Users can choose from (Yes, No). "Yes" indicates that
                        LRTK will sort the reads based on barcodes.
  -T THREADS, --threads THREADS
                        Number of threads, this determines the number of
                        threads used for bwa and samtools
  -G {human,metagenome}, --genome {human,metagenome}
                        Indicator of the input organism
```


## lrtk_phase

### Tool Description
Phase germline variants from linked-read alignments with HapCUT2 or WhatsHap.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 PHASE [-h] -B BAM -V VCF -R REFERENCE
                              [-A {HapCUT2,WhatsHap}] [-N NUMBER] [-T THREADS]
                              -O OUTFILE [-G {human,metagenome}]

options:
  -h, --help            show this help message and exit
  -B BAM, --bam BAM     The alignment file (.bam).
  -V VCF, --vcf VCF     The detected variants to phase
  -R REFERENCE, --reference REFERENCE
                        The indexed human reference genome file.
  -A {HapCUT2,WhatsHap}, --application {HapCUT2,WhatsHap}
                        The variant phasing tool. Users can choose from
                        (HapCUT2, WhatsHap).
  -N NUMBER, --number NUMBER
                        The number of strains for each species, required for
                        metagenome phasing.
  -T THREADS, --threads THREADS
                        Number of threads, this determines the number of
                        threads used for phasing tools.
  -O OUTFILE, --outfile OUTFILE
                        The final phased VCF file to write.
  -G {human,metagenome}, --genome {human,metagenome}
                        genome pattern to process
```


## lrtk_mwgs

### Tool Description
Run the metagenome linked-read sequencing analysis pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 MWGS [-h] -SI SAMPLE_INFO [-MI MULTI_INFO] -OD OUTDIR
                             -DB DATABASE [-RG READ_GROUP] [-T THREADS]

options:
  -h, --help            show this help message and exit
  -SI SAMPLE_INFO, --sample_info SAMPLE_INFO
                        The path to input sample information file.
                        (sample_info Format:"ID FQ1 FQ2 INDEX
                        Linked_read_technology")
  -MI MULTI_INFO, --multi_info MULTI_INFO
                        The path to multi sample information file.
  -OD OUTDIR, --outdir OUTDIR
                        The output directory
  -DB DATABASE, --database DATABASE
                        The default database containing reference genome and
                        barcode whitelist file
  -RG READ_GROUP, --read_group READ_GROUP
                        Full read group string (e.g. @RG ID:foo SM:bar).
  -T THREADS, --threads THREADS
                        Number of threads, this determines the number of
                        threads used for alignment and variats detection and
                        phasing.
```


## lrtk_MKFQ

### Tool Description
Simulate linked-read (10x or stLFR) sequencing reads from template genome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 MKFQ [-h] -CF CONFIG_FILE [-IT {10x,stLFR}]

options:
  -h, --help            show this help message and exit
  -CF CONFIG_FILE, --config_file CONFIG_FILE
                        The path to config_files for simulation
  -IT {10x,stLFR}, --input_type {10x,stLFR}
                        Input sequencing technology. Users can choose from
                        (10x,stLFR)
```

## lrtk_ALIGN

### Tool Description
Align linked-read FASTQ files to a reference genome with barcode-aware alignment, sort and mark duplicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 ALIGN [-h] [-FQ1 INPUT_FASTQ1] [-FQ2 INPUT_FASTQ2]
                              [-RG READ_GROUP] -R REFERENCE -O OUTFILE
                              [-S {Yes,No}] [-M {Yes,No}]
                              [-P {10x,stLFR,TELLSeq}] [-T THREADS]
                              [-G {human,metagenome}]

options:
  -h, --help            show this help message and exit
  -FQ1 INPUT_FASTQ1, --input_fastq1 INPUT_FASTQ1
                        Input fastq file (uncompressed FASTQ format), the
                        first read of paired linked-read sequencing data.
  -FQ2 INPUT_FASTQ2, --input_fastq2 INPUT_FASTQ2
                        Input fastq file (uncompressed FASTQ format), the
                        second read of paired linked-read sequencing data.
  -RG READ_GROUP, --read_group READ_GROUP
                        Full read group string (e.g. @RG ID:foo SM:bar)
  -R REFERENCE, --reference REFERENCE
                        The indexed human reference genome file
  -O OUTFILE, --outfile OUTFILE
                        The output alignment file.
  -S {Yes,No}, --sort {Yes,No}
                        Users can choose from (Yes, No). "Yes" means LRTK will
                        use samtools to sort alignment files based on genomic
                        coordinate.
  -M {Yes,No}, --mark_duplication {Yes,No}
                        Users can choose from (Yes, No). "Yes" means LRTK will
                        use picard to mark the duplicated reads using barcode
                        information
  -P {10x,stLFR,TELLSeq}, --platform {10x,stLFR,TELLSeq}
                        Input sequencing technology. Users can choose from
                        (10x,stLFR,TELLSeq).
  -T THREADS, --threads THREADS
                        Number of threads, this determines the number of
                        threads used for ema, bwa and samtools.
  -G {human,metagenome}, --genome {human,metagenome}
                        genome pattern to process
```

## lrtk_RLF

### Tool Description
Reconstruct long fragments from a barcode-aware linked-read alignment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 RLF [-h] -B BAM -D DISTANCE -O OUTFILE [-T THREADS]

options:
  -h, --help            show this help message and exit
  -B BAM, --bam BAM     The barcode aware alignment file (.bam).
  -D DISTANCE, --distance DISTANCE
                        the expected expanding distance.
  -O OUTFILE, --outfile OUTFILE
                        output path to the long fragments.
  -T THREADS, --threads THREADS
                        Number of threads.
```

## lrtk_SNV

### Tool Description
Call SNVs and small indels from an alignment file with FreeBayes, inStrain, Samtools or GATK.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 SNV [-h] -B BAM -R REFERENCE
                            [-A {FreeBayes,inStrain,Samtools,GATK}]
                            [-T THREADS] -O OUTFILE [-G {human,metagenome}]

options:
  -h, --help            show this help message and exit
  -B BAM, --bam BAM     The alignment file (.bam).
  -R REFERENCE, --reference REFERENCE
                        The indexed human reference genome file.
  -A {FreeBayes,inStrain,Samtools,GATK}, --application {FreeBayes,inStrain,Samtools,GATK}
                        The SNV/INDEL caller
  -T THREADS, --threads THREADS
                        Number of threads, this determines the number of
                        threads used for SNV/INDEL caller.
  -O OUTFILE, --outfile OUTFILE
                        The final VCF file to write.
  -G {human,metagenome}, --genome {human,metagenome}
                        genome pattern to process
```

## lrtk_SV

### Tool Description
Detect structural variations from a linked-read alignment file with Aquila, LinkedSV or VALOR.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 SV [-h] -B BAM [-V VCF] -R REFERENCE
                           [-A {Aquila,LinkedSV,VALOR}] [-T THREADS]
                           [-U UNIQNESS] [-S SONIC] -O OUTFILE
                           [-G {human,metagenome}]

options:
  -h, --help            show this help message and exit
  -B BAM, --bam BAM     The alignment file (.bam).
  -V VCF, --vcf VCF     The precalled SNV/INDEL variants required for Aquila
  -R REFERENCE, --reference REFERENCE
                        The indexed human reference genome file.
  -A {Aquila,LinkedSV,VALOR}, --application {Aquila,LinkedSV,VALOR}
                        The SV caller. Users can choose from (Aquila,
                        LinkedSV, VALOR).
  -T THREADS, --threads THREADS
                        Number of threads,this determines the number of
                        threads used for SV caller.
  -U UNIQNESS, --uniqness UNIQNESS
                        The uniqness database is required for Aquila.
  -S SONIC, --sonic SONIC
                        The sonic database is required for VALOR.
  -O OUTFILE, --outfile OUTFILE
                        The final VCF file to write.
  -G {human,metagenome}, --genome {human,metagenome}
                        genome pattern to process
```

## lrtk_ASSEMBLY

### Tool Description
Assemble metagenome-assembled genomes from linked-read metagenomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
- **Homepage**: https://github.com/ericcombiolab/LRTK
- **Package**: https://anaconda.org/channels/bioconda/packages/lrtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lrtk version 2.0 ASSEMBLY [-h] -FQ1 FQ1 -FQ2 FQ2 -MS METASPADES -AL
                                 ATHENA_L -AH ATHENA_H -LT LOW_ABD_CUT -O
                                 OUTFILE -T THREADS

options:
  -h, --help            show this help message and exit
  -FQ1 FQ1, --fq1 FQ1   Input fastq file (uncompressed FASTQ format), the
                        first read of paired linked-read sequencing data (with
                        barcode).
  -FQ2 FQ2, --fq2 FQ2   Input fastq file (uncompressed FASTQ format), the
                        first read of paired linked-read sequencing data (with
                        barcode).
  -MS METASPADES, --metaspades METASPADES
                        assembled contigs using metaspades.
  -AL ATHENA_L, --athena_l ATHENA_L
                        local assembled contigs from athena.
  -AH ATHENA_H, --athena_h ATHENA_H
                        hybrid assembled contigs from athena.
  -LT LOW_ABD_CUT, --low_abd_cut LOW_ABD_CUT
                        coverage for low abundance contigs.
  -O OUTFILE, --outfile OUTFILE
                        the final assembled contigs.
  -T THREADS, --threads THREADS
                        Number of threads.
```

## Metadata
- **Skill**: generated
