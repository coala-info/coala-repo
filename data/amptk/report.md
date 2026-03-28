# amptk CWL Generation Report

## amptk_illumina

### Tool Description
Script that takes De-mulitplexed Illumina data from a folder and processes it for amptk (merge PE reads, strip primers, trim/pad to set length.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Total Downloads**: 55.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nextgenusfs/amptk
- **Stars**: N/A
### Original Help Text
```text
usage: amptk-process_illumina_folder.py [options] -i folder

Script that takes De-mulitplexed Illumina data from a folder and processes it
for amptk (merge PE reads, strip primers, trim/pad to set length.

options:
  -h, --help                                    show this help message and
                                                exit
  -i INPUT, --input INPUT                       Folder of Illumina Data
                                                (default: None)
  -o OUT, --out OUT                             Name for output folder
                                                (default: amptk-illumina)
  -m MAPPING_FILE, --mapping_file MAPPING_FILE  Mapping file: QIIME format can
                                                have extra meta data columns
                                                (default: None)
  --reads {paired,forward}                      PE or forward reads (default:
                                                paired)
  --read_length READ_LENGTH                     Read length, i.e. 2 x 300 bp =
                                                300 (default: None)
  -f F_PRIMER, --fwd_primer F_PRIMER            Forward Primer (fITS7)
                                                (default: fITS7)
  -r R_PRIMER, --rev_primer R_PRIMER            Reverse Primer (ITS4)
                                                (default: ITS4)
  --require_primer {on,off}                     Require Fwd primer to be
                                                present (default: on)
  --primer_mismatch PRIMER_MISMATCH             Number of mis-matches in
                                                primer (default: 2)
  --barcode_mismatch BARCODE_MISMATCH           Number of mis-matches allowed
                                                in index (default: 1)
  --rescue_forward {on,off}                     Rescue Not-merged forward
                                                reads (default: on)
  --min_len MIN_LEN                             Minimum read length to keep
                                                (default: 100)
  --merge_method {usearch,vsearch}              Software to use for PE read
                                                merging (default: vsearch)
  -l TRIM_LEN, --trim_len TRIM_LEN              Trim length for reads
                                                (default: 300)
  --cpus CPUS                                   Number of CPUs. Default: auto
                                                (default: None)
  --full_length                                 Keep only full length reads
                                                (no trimming/padding)
                                                (default: False)
  -p {on,off}, --pad {on,off}                   Pad with Ns to a set length
                                                (default: off)
  -u USEARCH, --usearch USEARCH                 USEARCH executable (default:
                                                usearch9)
  --sra                                         Input files are from NCBI SRA
                                                not direct from illumina
                                                (default: False)
  --cleanup                                     Delete all intermediate files
                                                (default: False)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_illumina2

### Tool Description
Script finds barcodes, strips forward and reverse primers, relabels, and then trim/pads reads to a set length

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-process_ion.py [options] -i file.fastq
amptk-process_ion.py -h for help menu

Script finds barcodes, strips forward and reverse primers, relabels, and then
trim/pads reads to a set length

options:
  -h, --help                                    show this help message and
                                                exit
  -i FASTQ, --fastq FASTQ                       FASTQ R1 file (default: None)
  --reverse REVERSE                             Illumina R2 reverse reads
                                                (default: None)
  -o OUT, --out OUT                             Base name for output (default:
                                                illumina2)
  -f F_PRIMER, --fwd_primer F_PRIMER            Forward Primer (default:
                                                fITS7)
  -r R_PRIMER, --rev_primer R_PRIMER            Reverse Primer (default: ITS4)
  -m MAPPING_FILE, --mapping_file MAPPING_FILE  Mapping file: QIIME format can
                                                have extra meta data columns
                                                (default: None)
  -p {on,off}, --pad {on,off}                   Pad with Ns to a set length
                                                (default: off)
  --primer_mismatch PRIMER_MISMATCH             Number of mis-matches in
                                                primer (default: 2)
  --barcode_mismatch BARCODE_MISMATCH           Number of mis-matches in
                                                barcode (default: 0)
  --barcode_fasta BARCODE_FASTA                 FASTA file containing Barcodes
                                                (Names & Sequences) (default:
                                                None)
  --barcode_not_anchored                        Barcodes (indexes) are not at
                                                start of reads (default:
                                                False)
  --reverse_barcode REVERSE_BARCODE             FASTA file containing 3 prime
                                                Barocdes (default: None)
  --min_len MIN_LEN                             Minimum read length to keep
                                                (default: 100)
  -l TRIM_LEN, --trim_len TRIM_LEN              Trim length for reads
                                                (default: 300)
  --full_length                                 Keep only full length reads
                                                (no trimming/padding)
                                                (default: False)
  --merge_method {usearch,vsearch}              Software to use for PE read
                                                merging (default: vsearch)
  --cpus CPUS                                   Number of CPUs. Default: auto
                                                (default: None)
  -u USEARCH, --usearch USEARCH                 USEARCH EXE (default:
                                                usearch9)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_illumina3

### Tool Description
Script finds barcodes, strips forward and reverse primers, relabels, and then
trim/pads reads to a set length

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-process_illumina_raw.py [options] -i file.fastq
amptk-process_illumina_raw.py -h for help menu

Script finds barcodes, strips forward and reverse primers, relabels, and then
trim/pads reads to a set length

options:
  -h, --help                                    show this help message and
                                                exit
  -f FASTQ, --forward FASTQ                     Illumina FASTQ R1 reads
                                                (default: None)
  -r REVERSE, --reverse REVERSE                 Illumina FASTQ R2 reads
                                                (default: None)
  -i INDEX [INDEX ...], --index INDEX [INDEX ...]
                                                Illumina FASTQ index reads
                                                (default: None)
  -m MAPPING_FILE, --mapping_file MAPPING_FILE  QIIME-like mapping file
                                                (default: None)
  --read_length READ_LENGTH                     Read length, i.e. 2 x 300 bp =
                                                300 (default: None)
  -o OUT, --out OUT                             Base name for output (default:
                                                illumina_out)
  --fwd_primer F_PRIMER                         Forward Primer (default:
                                                515FB)
  --rev_primer R_PRIMER                         Reverse Primer (default:
                                                806RB)
  --primer_mismatch PRIMER_MISMATCH             Number of mis-matches in
                                                primer (default: 2)
  --barcode_mismatch BARCODE_MISMATCH           Number of mis-matches in
                                                barcode (default: 0)
  --barcode_fasta BARCODE_FASTA                 FASTA file containing Barcodes
                                                (Names & Sequences) (default:
                                                None)
  --rescue_forward {on,off}                     Rescue Not-merged forward
                                                reads (default: on)
  --barcode_rev_comp                            Reverse complement barcode
                                                sequences (default: False)
  --min_len MIN_LEN                             Minimum read length to keep
                                                (default: 100)
  -l TRIM_LEN, --trim_len TRIM_LEN              Trim length for reads
                                                (default: 300)
  -p {on,off}, --pad {on,off}                   Pad with Ns to a set length
                                                (default: off)
  --no-primer-trim                              Do not trim primers (default:
                                                True)
  --cpus CPUS                                   Number of CPUs. Default: auto
                                                (default: None)
  -u USEARCH, --usearch USEARCH                 USEARCH9 EXE (default:
                                                usearch9)
  --cleanup                                     remove intermediate files
                                                (default: False)
  --merge_method {usearch,vsearch}              Software to use for PE read
                                                merging (default: vsearch)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_pacbio

### Tool Description
Script to process pacbio CCS amplicon data

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-process_pacbio.py [-h] -i BAM -o OUT -b BARCODES [-f FWD_PRIMER]
                               [-r REV_PRIMER] [--int_primer INT_PRIMER]
                               [--primer_mismatch MISMATCH] [-m MIN_LEN]
                               [--cpus CPUS]

Script to process pacbio CCS amplicon data

options:
  -h, --help            show this help message and exit
  -i BAM, --bam BAM     Input directory containing Lima BAM files
  -o OUT, --out OUT     Output basename
  -b BARCODES, --barcodes BARCODES
                        Barcodes FASTA file
  -f FWD_PRIMER, --fwd_primer FWD_PRIMER
                        Forward Primer
  -r REV_PRIMER, --rev_primer REV_PRIMER
                        Reverse Primer
  --int_primer INT_PRIMER
                        Internal primer
  --primer_mismatch MISMATCH
                        Number of mis-matches in primer
  -m MIN_LEN, --min_len MIN_LEN
                        Minimum read length to keep
  --cpus CPUS           Number of CPUs. Default: auto

Written by Jon Palmer (2020) nextgenusfs@gmail.com
```


## amptk_454

### Tool Description
Script finds barcodes, strips forward and reverse primers, relabels, and then trim/pads reads to a set length

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-process_ion.py [options] -i file.fastq
amptk-process_ion.py -h for help menu

Script finds barcodes, strips forward and reverse primers, relabels, and then
trim/pads reads to a set length

options:
  -h, --help                                    show this help message and
                                                exit
  -i FASTQ, --fastq FASTQ, --sff FASTQ, --fasta FASTQ, --bam FASTQ
                                                BAM/FASTQ/SFF/FASTA file
                                                (default: None)
  -q QUAL, --qual QUAL                          QUAL file (if -i is FASTA)
                                                (default: None)
  -o OUT, --out OUT                             Base name for output (default:
                                                ion)
  -f F_PRIMER, --fwd_primer F_PRIMER            Forward Primer (default:
                                                fITS7-ion)
  -r R_PRIMER, --rev_primer R_PRIMER            Reverse Primer (default: ITS4)
  -m MAPPING_FILE, --mapping_file MAPPING_FILE  Mapping file: QIIME format can
                                                have extra meta data columns
                                                (default: None)
  -p {on,off}, --pad {on,off}                   Pad with Ns to a set length
                                                (default: off)
  --primer_mismatch PRIMER_MISMATCH             Number of mis-matches in
                                                primer (default: 2)
  --barcode_mismatch BARCODE_MISMATCH           Number of mis-matches in
                                                barcode (default: 0)
  --barcode_fasta BARCODE_FASTA                 FASTA file containing Barcodes
                                                (Names & Sequences) (default:
                                                ionxpress)
  --reverse_barcode REVERSE_BARCODE             FASTA file containing 3 prime
                                                Barocdes (default: None)
  -b BARCODES, --list_barcodes BARCODES         Enter Barcodes used separated
                                                by commas (default: all)
  --min_len MIN_LEN                             Minimum read length to keep
                                                (default: 100)
  -l TRIM_LEN, --trim_len TRIM_LEN              Trim length for reads
                                                (default: 300)
  --full_length                                 Keep only full length reads
                                                (no trimming/padding)
                                                (default: False)
  --mult_samples MULTI                          Combine multiple samples (i.e.
                                                FACE1) (default: False)
  --ion                                         Input data is Ion Torrent
                                                (default: False)
  --454                                         Input data is 454 (default:
                                                False)
  --cpus CPUS                                   Number of CPUs. Default: auto
                                                (default: None)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_SRA

### Tool Description
Script that takes De-mulitplexed Illumina data from a folder and processes it for amptk (merge PE reads, strip primers, trim/pad to set length.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-process_illumina_folder.py [options] -i folder

Script that takes De-mulitplexed Illumina data from a folder and processes it
for amptk (merge PE reads, strip primers, trim/pad to set length.

options:
  -h, --help                                    show this help message and
                                                exit
  -i INPUT, --input INPUT                       Folder of Illumina Data
                                                (default: None)
  -o OUT, --out OUT                             Name for output folder
                                                (default: amptk-illumina)
  -m MAPPING_FILE, --mapping_file MAPPING_FILE  Mapping file: QIIME format can
                                                have extra meta data columns
                                                (default: None)
  --reads {paired,forward}                      PE or forward reads (default:
                                                paired)
  --read_length READ_LENGTH                     Read length, i.e. 2 x 300 bp =
                                                300 (default: None)
  -f F_PRIMER, --fwd_primer F_PRIMER            Forward Primer (fITS7)
                                                (default: fITS7)
  -r R_PRIMER, --rev_primer R_PRIMER            Reverse Primer (ITS4)
                                                (default: ITS4)
  --require_primer {on,off}                     Require Fwd primer to be
                                                present (default: on)
  --primer_mismatch PRIMER_MISMATCH             Number of mis-matches in
                                                primer (default: 2)
  --barcode_mismatch BARCODE_MISMATCH           Number of mis-matches allowed
                                                in index (default: 1)
  --rescue_forward {on,off}                     Rescue Not-merged forward
                                                reads (default: on)
  --min_len MIN_LEN                             Minimum read length to keep
                                                (default: 100)
  --merge_method {usearch,vsearch}              Software to use for PE read
                                                merging (default: vsearch)
  -l TRIM_LEN, --trim_len TRIM_LEN              Trim length for reads
                                                (default: 300)
  --cpus CPUS                                   Number of CPUs. Default: auto
                                                (default: None)
  --full_length                                 Keep only full length reads
                                                (no trimming/padding)
                                                (default: False)
  -p {on,off}, --pad {on,off}                   Pad with Ns to a set length
                                                (default: off)
  -u USEARCH, --usearch USEARCH                 USEARCH executable (default:
                                                usearch9)
  --sra                                         Input files are from NCBI SRA
                                                not direct from illumina
                                                (default: False)
  --cleanup                                     Delete all intermediate files
                                                (default: False)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_dada2

### Tool Description
Script takes output from amptk pre-processing and runs DADA2

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-dada2.py [-h] -i FASTQ [-o OUT] [-m MIN_READS] [-l LENGTH]
                      [-e MAXEE] [-p PCT_OTU] [--platform {ion,illumina,454}]
                      [--chimera_method {consensus,pooled,per-sample}]
                      [--uchime_ref UCHIME_REF] [--pool] [--pseudopool]
                      [--debug] [-u USEARCH] [--cpus CPUS]

Script takes output from amptk pre-processing and runs DADA2

options:
  -h, --help                                      show this help message and
                                                  exit
  -i FASTQ, --fastq FASTQ                         Input Demuxed containing
                                                  FASTQ (default: None)
  -o OUT, --out OUT                               Output Basename (default:
                                                  None)
  -m MIN_READS, --min_reads MIN_READS             Minimum number of reads
                                                  after Q filtering to run
                                                  DADA2 on (default: 10)
  -l LENGTH, --length LENGTH                      Length to truncate reads
                                                  (default: None)
  -e MAXEE, --maxee MAXEE                         MaxEE quality filtering
                                                  (default: 1.0)
  -p PCT_OTU, --pct_otu PCT_OTU                   Biological OTU Clustering
                                                  Percent (default: 97)
  --platform {ion,illumina,454}                   Sequencing platform
                                                  (default: ion)
  --chimera_method {consensus,pooled,per-sample}  bimera removal method
                                                  (default: consensus)
  --uchime_ref UCHIME_REF                         Run UCHIME REF
                                                  [ITS,16S,LSU,COI,custom]
                                                  (default: None)
  --pool                                          Pool all sequences together
                                                  for DADA2 (default: False)
  --pseudopool                                    Use DADA2 pseudopooling
                                                  (default: False)
  --debug                                         Keep all intermediate files
                                                  (default: False)
  -u USEARCH, --usearch USEARCH                   USEARCH9 EXE (default:
                                                  usearch9)
  --cpus CPUS                                     Number of CPUs. Default:
                                                  auto (default: None)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_pb-dada2

### Tool Description
Script takes output from amptk pre-processing and runs pacbio DADA2

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-dada2.py [-h] -i FASTQ [-o OUT] [-m MIN_READS] [-q READ_QUAL]
                      [-b BARCODE_QUAL] [-p PCT_OTU] [--platform {pacbio}]
                      [--chimera_method {consensus,pooled,per-sample}]
                      [--uchime_ref UCHIME_REF] [--pool] [--pseudopool]
                      [--debug] [-u USEARCH] [--cpus CPUS]

Script takes output from amptk pre-processing and runs pacbio DADA2

options:
  -h, --help                                      show this help message and
                                                  exit
  -i FASTQ, --fastq FASTQ                         Input Demuxed containing
                                                  FASTQ (default: None)
  -o OUT, --out OUT                               Output Basename (default:
                                                  None)
  -m MIN_READS, --min_reads MIN_READS             Minimum number of reads
                                                  after Q filtering to run
                                                  DADA2 on (default: 10)
  -q READ_QUAL, --read_qual READ_QUAL             Read Quality threshold
                                                  (default: 0.98)
  -b BARCODE_QUAL, --barcode_qual BARCODE_QUAL    Barcode Quality threshold
                                                  (default: 80)
  -p PCT_OTU, --pct_otu PCT_OTU                   Biological OTU Clustering
                                                  Percent (default: 97)
  --platform {pacbio}                             Sequencing platform
                                                  (default: pacbio)
  --chimera_method {consensus,pooled,per-sample}  bimera removal method
                                                  (default: consensus)
  --uchime_ref UCHIME_REF                         Run UCHIME REF
                                                  [ITS,16S,LSU,COI,custom]
                                                  (default: None)
  --pool                                          Pool all sequences together
                                                  for DADA2 (default: False)
  --pseudopool                                    Use DADA2 pseudopooling
                                                  (default: False)
  --debug                                         Keep all intermediate files
                                                  (default: False)
  -u USEARCH, --usearch USEARCH                   USEARCH9 EXE (default:
                                                  usearch9)
  --cpus CPUS                                     Number of CPUs. Default:
                                                  auto (default: None)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_unoise2

### Tool Description
Script runs UNOISE2 algorithm. Requires USEARCH9 by Robert C. Edgar: http://drive5.com/usearch

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-unoise2.py [options] -i file.demux.fq
amptk-unoise2.py -h for help menu

Script runs UNOISE2 algorithm. Requires USEARCH9 by Robert C. Edgar:
http://drive5.com/usearch

options:
  -h, --help                     show this help message and exit
  -i FASTQ, --fastq FASTQ        FASTQ file (Required) (default: None)
  -o OUT, --out OUT              Base output name (default: None)
  -e MAXEE, --maxee MAXEE        Quality trim EE value (default: 1.0)
  -m MINSIZE, --minsize MINSIZE  Min size to keep for denoising (default: 8)
  -u USEARCH, --usearch USEARCH  USEARCH9 EXE (default: usearch9)
  -p PCT_OTU, --pct_otu PCT_OTU  Biological OTU Clustering Percent (default:
                                 97)
  --uchime_ref UCHIME_REF        Run UCHIME2 REF [ITS,16S,LSU,COI,custom]
                                 (default: None)
  --map_filtered                 map quality filtered reads back to OTUs
                                 (default: False)
  --debug                        Remove Intermediate Files (default: False)
  --cpus CPUS                    Number of CPUs. Default: auto (default: None)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_unoise3

### Tool Description
Script runs UNOISE3 algorithm. Requires USEARCH9 by Robert C. Edgar: http://drive5.com/usearch

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-unoise3.py [options] -i file.demux.fq
amptk-unoise3.py -h for help menu

Script runs UNOISE3 algorithm. Requires USEARCH9 by Robert C. Edgar:
http://drive5.com/usearch

options:
  -h, --help                     show this help message and exit
  -i FASTQ, --fastq FASTQ        FASTQ file (Required) (default: None)
  -o OUT, --out OUT              Base output name (default: None)
  --method {vsearch,usearch}     Program to use (default: vsearch)
  -e MAXEE, --maxee MAXEE        Quality trim EE value (default: 1.0)
  -m MINSIZE, --minsize MINSIZE  Min size to keep for denoising (default: 8)
  -u USEARCH, --usearch USEARCH  USEARCH10 EXE (default: usearch10)
  -p PCT_OTU, --pct_otu PCT_OTU  Biological OTU Clustering Percent (default:
                                 97)
  --uchime_ref UCHIME_REF        Run UCHIME2 REF [ITS,16S,LSU,COI,custom]
                                 (default: None)
  --map_filtered                 map quality filtered reads back to OTUs
                                 (default: False)
  --debug                        Remove Intermediate Files (default: False)
  --cpus CPUS                    Number of CPUs. Default: auto (default: None)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_cluster_ref

### Tool Description
Script runs UPARSE OTU clustering. Requires USEARCH by Robert C. Edgar: http://drive5.com/usearch

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-OTU_cluster_ref.py [options] -i file.demux.fq
amptk-OTU_cluster_ref.py -h for help menu

Script runs UPARSE OTU clustering. Requires USEARCH by Robert C. Edgar:
http://drive5.com/usearch

options:
  -h, --help                     show this help message and exit
  -i FASTQ, --fastq FASTQ        FASTQ file (Required) (default: None)
  -o OUT, --out OUT              Base output name (default: None)
  -e MAXEE, --maxee MAXEE        Quality trim EE value (default: 1.0)
  -p PCT_OTU, --pct_otu PCT_OTU  OTU Clustering Percent (default: 97)
  --id ID                        Threshold for alignment (default: 97)
  -m MINSIZE, --minsize MINSIZE  Min identical seqs to process (default: 2)
  -u USEARCH, --usearch USEARCH  USEARCH9 EXE (default: usearch9)
  --map_filtered                 map quality filtered reads back to OTUs
                                 (default: False)
  -d DB, --db DB                 Reference Database
                                 [ITS,ITS1,ITS2,16S,LSU,COI,custom] (default:
                                 None)
  --utax_db UTAX_DB              UTAX Reference Database (default: None)
  --utax_cutoff UTAX_CUTOFF      UTAX confidence value threshold. (default:
                                 0.8)
  --utax_level {k,p,c,o,f,g,s}   UTAX classification level to retain (default:
                                 k)
  --mock MOCK                    Spike-in mock community (fasta) (default:
                                 synmock)
  --debug                        Remove Intermediate Files (default: False)
  --closed_ref_only              Only run closed reference clustering
                                 (default: False)
  --cpus CPUS                    Number of CPUs. Default: auto (default: None)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_lulu

### Tool Description
Script runs OTU table post processing LULU to identify low abundance error OTUs

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-lulu.py [-h] -i OTU_TABLE -f FASTA [-o OUT]
                     [--min_ratio_type {min,avg}] [--min_ratio MIN_RATIO]
                     [--min_match MIN_MATCH]
                     [--min_relative_cooccurence MIN_RELATIVE_COOCCURENCE]
                     [--debug]

Script runs OTU table post processing LULU to identify low abundance error
OTUs

options:
  -h, --help                                      show this help message and
                                                  exit
  -i OTU_TABLE, --otu_table OTU_TABLE             Input OTU table (default:
                                                  None)
  -f FASTA, --fasta FASTA                         Input OTUs (multi-fasta)
                                                  (default: None)
  -o OUT, --out OUT                               Output folder basename
                                                  (default: None)
  --min_ratio_type {min,avg}                      LULU minimum ratio threshold
                                                  (default: min)
  --min_ratio MIN_RATIO                           LULU minimum ratio (default:
                                                  1)
  --min_match MIN_MATCH                           LULU minimum match percent
                                                  identity (default: 84)
  --min_relative_cooccurence MIN_RELATIVE_COOCCURENCE
                                                  LULU minimum relative
                                                  cooccurance (default: 95)
  --debug                                         Remove Intermediate Files
                                                  (default: False)

Written by Jon Palmer (2018) nextgenusfs@gmail.com
```


## amptk_taxonomy

### Tool Description
assign taxonomy to OTUs

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-assign_taxonomy.py [options] -f <FASTA File>

assign taxonomy to OTUs

options:
  -h, --help                                    show this help message and
                                                exit
  -i OTU_TABLE, --otu_table OTU_TABLE           Append Taxonomy to OTU table
                                                (default: None)
  -f FASTA, --fasta FASTA                       FASTA input (default: None)
  -o OUT, --out OUT                             Output file (FASTA) (default:
                                                None)
  -m MAPPING_FILE, --mapping_file MAPPING_FILE  Mapping file: QIIME format can
                                                have extra meta data columns
                                                (default: None)
  --method {utax,usearch,sintax,hybrid,rdp,blast}
                                                Taxonomy method (default:
                                                hybrid)
  -d DB, --db DB                                Pre-installed Databases:
                                                [ITS,ITS1,ITS2,16S,LSU,COI]
                                                (default: None)
  -t TAXONOMY, --taxonomy TAXONOMY              Incorporate taxonomy
                                                calculated elsewhere, 2 column
                                                file (default: None)
  --fasta_db FASTA_DB                           Alternative database of fasta
                                                sequences (default: None)
  --add2db ADD2DB                               Custom FASTA database to add
                                                to DB on the fly (default:
                                                None)
  --utax_db UTAX_DB                             UTAX Reference Database
                                                (default: None)
  --utax                                        Run UTAX (requires usearch9)
                                                (default: True)
  --utax_cutoff UTAX_CUTOFF                     UTAX confidence value
                                                threshold. (default: 0.8)
  --usearch_db USEARCH_DB                       VSEARCH Reference Database
                                                (default: None)
  --sintax_db SINTAX_DB                         VSEARCH SINTAX Reference
                                                Database (default: None)
  --usearch_cutoff USEARCH_CUTOFF               USEARCH percent ID threshold.
                                                (default: 0.7)
  -r RDP, --rdp RDP                             Path to RDP Classifier
                                                (default: /Users/jon/scripts/r
                                                dp_classifier_2.10.1/dist/clas
                                                sifier.jar)
  --rdp_db {16srrna,fungallsu,fungalits_warcup,fungalits_unite}
                                                Training set for RDP
                                                Classifier (default:
                                                fungalits_unite)
  --rdp_cutoff RDP_CUTOFF                       RDP confidence value threshold
                                                (default: 0.8)
  --local_blast LOCAL_BLAST                     Path to local Blast DB
                                                (default: None)
  -u USEARCH, --usearch USEARCH                 USEARCH8 EXE (default:
                                                usearch9)
  --tax_filter TAX_FILTER                       Retain only OTUs with match in
                                                OTU table (default: None)
  --sintax_cutoff SINTAX_CUTOFF                 SINTAX threshold. (default:
                                                0.8)
  --debug                                       Remove Intermediate Files
                                                (default: False)
  --cpus CPUS                                   Number of CPUs. Default: auto
                                                (default: None)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_show

### Tool Description
Script loops through demuxed fastq file counting occurances of barcodes, can optionally quality trim and recount.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-get_barcode_counts.py [-h] -i INPUT [--quality_trim] [-e MAXEE]
                                   [-l TRUNCLEN] [-o OUT]

Script loops through demuxed fastq file counting occurances of barcodes, can
optionally quality trim and recount.

options:
  -h, --help                        show this help message and exit
  -i INPUT, --input INPUT           Input demuxed FASTQ (default: None)
  --quality_trim                    Quality trim data (default: False)
  -e MAXEE, --maxee MAXEE           MaxEE Q-trim threshold (default: 1.0)
  -l TRUNCLEN, --trunclen TRUNCLEN  Read truncation length (default: 250)
  -o OUT, --out OUT                 Output for quality trimmed data (default:
                                    None)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_select

### Tool Description
Script parses AMPtk de-multiplexed FASTQ file and keeps those sequences with barcode names in list

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-keep_samples.py [-h] -i INPUT [-l LIST [LIST ...]] [-t THRESHOLD]
                             [-f FILE] -o OUT [--format {fastq,fasta}]

Script parses AMPtk de-multiplexed FASTQ file and keeps those sequences with
barocde names in list

options:
  -h, --help                                  show this help message and exit
  -i INPUT, --input INPUT                     Input AMPtk demux FASTQ
                                              (default: None)
  -l LIST [LIST ...], --list LIST [LIST ...]  Input list of (BC) names to keep
                                              (default: None)
  -t THRESHOLD, --threshold THRESHOLD         Keep samples with more reads
                                              than threshold (default: None)
  -f FILE, --file FILE                        File containing list of names to
                                              keep (default: None)
  -o OUT, --out OUT                           Output name (default: None)
  --format {fastq,fasta}                      format of output file (default:
                                              fastq)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_remove

### Tool Description
Script parses AMPtk de-multiplexed FASTQ file and keeps those sequences with barcode names in list

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-remove_samples.py [-h] -i INPUT [-l LIST [LIST ...]]
                               [-t THRESHOLD] [-f FILE] -o OUT
                               [--format {fastq,fasta}]

Script parses AMPtk de-multiplexed FASTQ file and keeps those sequences with
barocde names in list

options:
  -h, --help                                  show this help message and exit
  -i INPUT, --input INPUT                     Input AMPtk demux FASTQ
                                              (default: None)
  -l LIST [LIST ...], --list LIST [LIST ...]  Input list of (BC) names to
                                              remove (default: None)
  -t THRESHOLD, --threshold THRESHOLD         Keep samples with more reads
                                              than threshold (default: None)
  -f FILE, --file FILE                        File containing list of names to
                                              remove (default: None)
  -o OUT, --out OUT                           Output name (default: None)
  --format {fastq,fasta}                      format of output file (default:
                                              fastq)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_sample

### Tool Description
Script to sub-sample reads down to the same number for each sample (barcode)

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-barcode_rarify.py [-h] -i INPUT -n NUM_READS -o OUT

Script to sub-sample reads down to the same number for each sample (barcode)

options:
  -h, --help                           show this help message and exit
  -i INPUT, --input INPUT              Input FASTQ (default: None)
  -n NUM_READS, --num_reads NUM_READS  Number of reads to rarify down to
                                       (default: None)
  -o OUT, --out OUT                    Output name (default: None)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_drop

### Tool Description
Script that drops OTUs and then creates OTU table

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-drop.py [-h] -i INPUT -r READS [-o OUT] [-l LIST [LIST ...]]
                     [-f FILE]

Script that drops OTUs and then creates OTU table

options:
  -h, --help                                  show this help message and exit
  -i INPUT, --input INPUT                     OTUs in FASTA format (default:
                                              None)
  -r READS, --reads READS                     Demuxed reads FASTQ format
                                              (default: None)
  -o OUT, --out OUT                           Base output name (default: None)
  -l LIST [LIST ...], --list LIST [LIST ...]  Input list of (BC) names to
                                              remove (default: None)
  -f FILE, --file FILE                        File containing list of names to
                                              remove (default: None)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_stats

### Tool Description
Script takes BIOM as input and runs basic summary stats

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-stats.py [-h] -i BIOM -t TREE [-o OUT]
                      [-d {raupcrick,bray,unifrac,wunifrac,jaccard,aitchison,all}]
                      [--indicator_species]
                      [--ignore_otus IGNORE_OTUS [IGNORE_OTUS ...]]
                      [--ord_method {DCA,CCA,RDA,DPCoA,NMDS,MDS,PCoA}]
                      [--ord_ellipse]

Script takes BIOM as input and runs basic summary stats

options:
  -h, --help                                      show this help message and
                                                  exit
  -i BIOM, --biom BIOM                            Input BIOM file (OTU table +
                                                  metadata) (default: None)
  -t TREE, --tree TREE                            Phylogentic tree from AMPtk
                                                  taxonomy (default: None)
  -o OUT, --out OUT                               Output folder basename
                                                  (default: amptk_stats)
  -d {raupcrick,bray,unifrac,wunifrac,jaccard,aitchison,all}, --distance {raupcrick,bray,unifrac,wunifrac,jaccard,aitchison,all}
                                                  Distance metric (default:
                                                  raupcrick)
  --indicator_species                             Run indicator species
                                                  analysis (default: False)
  --ignore_otus IGNORE_OTUS [IGNORE_OTUS ...]     OTUs to drop from table and
                                                  run stats (default: None)
  --ord_method {DCA,CCA,RDA,DPCoA,NMDS,MDS,PCoA}  Ordination method (default:
                                                  NMDS)
  --ord_ellipse                                   Add ellipses on NMDS instead
                                                  of centroids & error bars
                                                  (default: False)

Written by Jon Palmer (2017) nextgenusfs@gmail.com
```


## amptk_summarize

### Tool Description
Summarize amplicon sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/amptk", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.10/site-packages/amptk/amptk.py", line 783, in main
    mod = importlib.import_module('amptk.{:}'.format(info[sys.argv[1]]['cmd']))
  File "/usr/local/lib/python3.10/importlib/__init__.py", line 126, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1050, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1027, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1006, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 688, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 883, in exec_module
  File "<frozen importlib._bootstrap>", line 241, in _call_with_frames_removed
  File "/usr/local/lib/python3.10/site-packages/amptk/summarize_taxonomy.py", line 21, in <module>
    from amptk import stackedBarGraph
  File "/usr/local/lib/python3.10/site-packages/amptk/stackedBarGraph.py", line 28, in <module>
    from past.utils import old_div
ModuleNotFoundError: No module named 'past'
```


## amptk_funguild

### Tool Description
Script takes OTU table as input and runs FUNGuild to assing functional annotation to an OTU
             based on the Guilds database. AMPtk runs method based off of script by Zewei Song (2015-2021).

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:       amptk funguild <arguments>
version:     1.6.0

Description: Script takes OTU table as input and runs FUNGuild to assing functional annotation to an OTU
             based on the Guilds database. AMPtk runs method based off of script by Zewei Song (2015-2021).

Options:     -i, --input        Input OTU table with Taxonomy (via amptk taxonomy)
             -o, --out          Output OTU table with Guild annotations
             -u, --url          URL to FUNGuild db. Default: https://mycoportal.org/fdex/services/api/db_return.php?dbReturn=Yes&pp=1
```


## amptk_meta

### Tool Description
Takes a meta data csv file and OTU table and makes transposed output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-merge_metadata.py [-h] -m META [--split_taxonomy {k,p,c,o,f,g}]
                               -i INPUT -o OUT

Takes a meta data csv file and OTU table and makes transposed output files.

options:
  -h, --help                      show this help message and exit
  -m META, --meta META            Meta data (csv format, e.g. from excel)
                                  (default: None)
  --split_taxonomy {k,p,c,o,f,g}  Split output files based on taxonomy levels
                                  (default: None)
  -i INPUT, --input INPUT         OTU table (default: None)
  -o OUT, --out OUT               Output name (default: None)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_heatmap

### Tool Description
Script that creates heatmap(s) from csv data, column 1 is the row name, csv file has headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: csv2heatmap.py [options] -i input.csv -o output.pdf

Script that creates heatmap(s) from csv data, column 1 is the row name, csv
file has headers.

options:
  -h, --help                                    show this help message and
                                                exit
  -i INPUT, --input INPUT                       Input file (csv) (default:
                                                None)
  -o OUTPUT, --output OUTPUT                    Output file (pdf) (default:
                                                None)
  -m {clustermap,heatmap}, --method {clustermap,heatmap}
                                                Type of heatmap (default:
                                                clustermap)
  --distance_metric DISTANCE_METRIC             Distance metric for clustermap
                                                (default: braycurtis)
  --cluster_method {single,complete,average,weighted}
                                                Clustering method for
                                                clustermap (default: single)
  -d {csv,tsv}, --delimiter {csv,tsv}           Input file (csv) (default:
                                                tsv)
  --cluster_columns {True,False}                Cluster columns (default:
                                                False)
  --yaxis_fontsize YAXIS_FONTSIZE               Font size for y-axis (default:
                                                6)
  --xaxis_fontsize XAXIS_FONTSIZE               Font size for x-axis (default:
                                                6)
  --font FONT                                   Font set (default: arial)
  --color COLOR                                 Color palette (default:
                                                gist_gray_r)
  --figsize FIGSIZE                             Figure size (3x5, 2x10, etc)
                                                (default: 2x8)
  --annotate                                    Annotate heatmap with values
                                                (default: False)
  --scaling {z_score,standard,None}             Scale the data by row
                                                (default: None)
  --debug                                       Print the data table to
                                                terminal (default: False)
  --normalize NORMALIZE                         Normalize data to pct of
                                                total, tsv sample ID<tab>reads
                                                (default: None)
  --normalize_counts NORMALIZE_COUNTS           Value to normalize read counts
                                                to (default: 100000)
  --vmax VMAX                                   Max value for heatmap
                                                (default: None)
  -f, {pdf,jpg,svg,png}, --format {pdf,jpg,svg,png}
                                                format to save image in
                                                (default: pdf)

Written by Jon Palmer (2016) nextgenusfs@gmail.com
```


## amptk_SRA-submit

### Tool Description
Script to split FASTQ file from Ion, 454, or Illumina by barcode sequence into separate files for submission to SRA. This script can take the BioSample worksheet from NCBI and create an SRA metadata file for submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-fastq2sra.py [options] -i folder

Script to split FASTQ file from Ion, 454, or Illumina by barcode sequence into
separate files for submission to SRA. This script can take the BioSample
worksheet from NCBI and create an SRA metadata file for submission.

options:
  -h, --help                                    show this help message and
                                                exit
  -i FASTQ, --input FASTQ                       Input FASTQ file or folder
                                                (default: None)
  -o OUT, --out OUT                             Basename for output
                                                folder/files (default: None)
  --min_len MIN_LEN                             Minimum length of read to keep
                                                (default: 50)
  -b BARCODE_FASTA, --barcode_fasta BARCODE_FASTA
                                                Multi-fasta file containing
                                                barcodes used (default: None)
  --reverse_barcode REVERSE_BARCODE             Reverse barcode fasta file
                                                (default: None)
  -s BIOSAMPLE, --biosample BIOSAMPLE           BioSample file from NCBI
                                                (default: None)
  -p {ion,illumina,454,illumina3}, --platform {ion,illumina,454,illumina3}
                                                Sequencing platform (default:
                                                ion)
  --reads-forward READS_FORWARD                 Illumina FASTQ R1 reads
                                                (default: None)
  --reads-reverse READS_REVERSE                 Illumina FASTQ R2 reads
                                                (default: None)
  --reads-index READS_INDEX                     Illumina FASTQ index reads
                                                (default: None)
  --barcode_rev_comp                            Reverse complement barcode
                                                sequences (default: False)
  -f F_PRIMER, --fwd_primer F_PRIMER            Forward Primer (fITS7)
                                                (default: fITS7)
  -r R_PRIMER, --rev_primer R_PRIMER            Reverse Primer (ITS4)
                                                (default: ITS4)
  -n NAMES, --names NAMES                       CSV mapping file BC,NewName
                                                (default: None)
  -d DESCRIPTION, --description DESCRIPTION     Paragraph description for SRA
                                                metadata (default: None)
  -t TITLE, --title TITLE                       Start of title for SRA
                                                submission, name it according
                                                to amplicon (default: Fungal
                                                ITS)
  -m MAPPING_FILE, --mapping_file MAPPING_FILE  Mapping file: QIIME format can
                                                have extra meta data columns
                                                (default: None)
  --primer_mismatch PRIMER_MISMATCH             Number of mis-matches in
                                                primer (default: 2)
  --barcode_mismatch BARCODE_MISMATCH           Number of mis-matches in
                                                barcode (default: 0)
  --require_primer {forward,both,off}           Require Primers to be present
                                                (default: off)
  --force                                       Overwrite existing directory
                                                (default: False)
  -a APPEND, --append APPEND                    Append a name to all sample
                                                names for a run, i.e. --append
                                                run1 would yield Sample_run1
                                                (default: None)

Written by Jon Palmer (2015) nextgenusfs@gmail.com
```


## amptk_database

### Tool Description
Script searches for primers and removes them if found. Useful for trimming a reference dataset for assigning taxonomy after OTU clustering. It is also capable of reformatting UNITE taxonomy fasta headers to be compatible with UTAX and creating USEARCH/UTAX UBD databases for assigning taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amptk-extract_region.py [options] -f <FASTA File>

Script searches for primers and removes them if found. Useful for trimming a
reference dataset for assigning taxonomy after OTU clustering. It is also
capable of reformatting UNITE taxonomy fasta headers to be compatible with
UTAX and creating USEARCH/UTAX UBD databases for assigning taxonomy.

options:
  -h, --help                                  show this help message and exit
  -i FASTA, --fasta FASTA                     FASTA input (default: None)
  -o OUT, --out OUT                           Base Name Output files (default:
                                              None)
  -f F_PRIMER, --fwd_primer F_PRIMER          Forward primer (fITS7) (default:
                                              fITS7)
  -r R_PRIMER, --rev_primer R_PRIMER          Reverse primer (ITS4) (default:
                                              ITS4)
  --skip_trimming                             Skip Primer trimming (not
                                              recommended) (default: False)
  --format {unite2utax,rdp2utax,pr2utax,off}  Reformat FASTA headers for UTAX
                                              (default: unite2utax)
  --lca                                       Run LCA (last common ancestor)
                                              for dereplicating taxonomy
                                              (default: False)
  --trunclen TRUNCLEN                         Truncate reads to length
                                              (default: None)
  --subsample SUBSAMPLE                       Random subsample (default: None)
  --min_len MIN_LEN                           Minimum read length to keep
                                              (default: 100)
  --max_len MAX_LEN                           Maximum read length to keep
                                              (default: 1200)
  --drop_ns DROP_NS                           Drop Seqeunces with more than X
                                              # of N's (default: 8)
  --create_db {utax,usearch,sintax}           Create USEARCH DB (default:
                                              None)
  --primer_required {none,for,rev}            Keep Seq if primer found
                                              Default: for (default: for)
  --derep_fulllength                          De-replicate sequences. Default:
                                              off (default: False)
  --primer_mismatch PRIMER_MISMATCH           Max Primer Mismatch (default: 2)
  --cpus CPUS                                 Number of CPUs. Default: auto
                                              (default: None)
  --install                                   Install into AMPtk database
                                              (default: False)
  --source SOURCE                             DB source and version separated
                                              by : (default: :)
  --utax_trainlevels UTAX_TRAINLEVELS         UTAX training parameters
                                              (default: kpcofgs)
  --utax_splitlevels UTAX_SPLITLEVELS         UTAX training parameters
                                              (default: NVkpcofgs)
  -u USEARCH, --usearch USEARCH               USEARCH9 EXE (default: usearch9)
  --debug                                     Remove Intermediate Files
                                              (default: False)

Written by Jon Palmer (2015-2017) nextgenusfs@gmail.com
```


## amptk_info

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
------------------------------
Running AMPtk v 1.6.0
------------------------------
Taxonomy Databases Installed: /usr/local/lib/python3.10/site-packages/amptk/DB
------------------------------
No DB configured, run 'amptk install' or 'amptk database' command.
------------------------------
```


## amptk_primers

### Tool Description
Primers hard-coded into AMPtk

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: PASS

### Original Help Text
```text
----------------------------------
Primers hard-coded into AMPtk:
----------------------------------
16S_V3       CCTACGGGNGGCWGCAG
16S_V4       GACTACHVGGGTATCTAATCC
515FB        GTGYCAGCMGCCGCGGTAA
616-f        TTAAARVGYTCGTAGTYG
806RB        GGACTACNVGGGTWTCTAAT
1132r        CCGTCAATTHCTTYAART
COI-F        GGTCAACAAATCATAAAGATATTGG
COI-R        GGWACTAATCAATTTCCAAATCC
ITS1         TCCGTAGGTGAACCTGCGG
ITS1-F       CTTGGTCATTTAGAGGAAGTAA
ITS2         GCTGCGTTCTTCATCGATGC
ITS3         GCATCGATGAAGAACGCAGC
ITS3_KYO2    GATGAAGAACGYAGYRAA
ITS4         TCCTCCGCTTATTGATATGC
ITS4-B       CAGGAGACTTGTACACGGTCCAG
ITS4-B21     CAGGAGACTTGTACACGGTCC
JH-LS-369rc  CTTCCCTTTCAACAATTTCAC
LCO1490      GGTCAACAAATCATAAAGATATTGG
LR0R         ACCCGCTGAACTTAAGC
LR2R         AAGAACTTTGAAAAGAG
LR3          CCGTGTTTCAAGACGGG
fITS7        GTGARTCATCGAATCTTTG
fITS7-ion    AGTGARTCATCGAATCTTTG
mlCOIintR    GGRGGRTASACSGTTCASCCSGTSCC
----------------------------------
```


## amptk_citation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/nextgenusfs/amptk
- **Package**: https://anaconda.org/channels/bioconda/packages/amptk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Palmer JM, Jusino MA, Banik MT, Lindner DL. 2018. Non-biological synthetic spike-in controls and the
	AMPtk software pipeline improve mycobiome data. PeerJ 6:e4925; DOI 10.7717/peerj.4925

*** Please also cite the specific tools that you used in AMPtk: ***
	USEARCH/UPARSE, VSEARCH, DADA2, LULU, etc.
```


## Metadata
- **Skill**: generated
