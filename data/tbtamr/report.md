# tbtamr CWL Generation Report

## tbtamr_search

### Tool Description
Search for variants in a catalog.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MDU-PHL/tbtamr
- **Stars**: N/A
### Original Help Text
```text
usage: tbtamr search [-h] [--catalog CATALOG]
                     [--catalog_config CATALOG_CONFIG]
                     --query QUERY [QUERY ...]

options:
  -h, --help            show this help message and exit
  --catalog, -c CATALOG
                        csv variant catalog (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/who_v2_catalog.csv)
  --catalog_config, -cfg CATALOG_CONFIG
                        json file indicating the relevant column settings for
                        interpretation of the catalog file. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/db_config.json)
  --query, -q QUERY [QUERY ...]
                        The variant to search for. Multiple allowed separated
                        by a space. (default: None)
```


## tbtamr_predict

### Tool Description
Predict resistance profiles and lineages from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tbtamr predict [-h] [--seq_id SEQ_ID] [--vcf VCF] [--catalog CATALOG]
                      [--catalog_config CATALOG_CONFIG]
                      [--interpretation_criteria INTERPRETATION_CRITERIA]
                      [--barcode BARCODE] [--reference_file REFERENCE_FILE]
                      [--classification_criteria CLASSIFICATION_CRITERIA]
                      [--force] [--call_lineage] [--cascade] [--tmp TMP]

options:
  -h, --help            show this help message and exit
  --seq_id, -s SEQ_ID   Sequence name. (default: tbtamr)
  --vcf VCF             VCF file generated using the H37rV v3 reference genome
                        (default: )
  --catalog, -c CATALOG
                        csv variant catalog (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/who_v2_catalog.csv)
  --catalog_config, -cfg CATALOG_CONFIG
                        json file indicating the relevant column settings for
                        interpretation of the catalog file. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/db_config.json)
  --interpretation_criteria, -r INTERPRETATION_CRITERIA
                        csv file with rules for predicting resistance profiles
                        from genomic data. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/interpretation_criteria.csv)
  --barcode, -b BARCODE
                        Barcode to use for lineage calling and speciation.
                        (default: /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/tbtamr.barcode.bed)
  --reference_file, -ref REFERENCE_FILE
                        Reference file to use for calling lineage. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/tbtamr.fasta)
  --classification_criteria, -cr CLASSIFICATION_CRITERIA
                        csv file with rules for predicting resistance profiles
                        from genomic data. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/classification_criteria.csv)
  --force, -f           Force replace an existing folder. (default: False)
  --call_lineage        Use pathogen profiler to call lineage (default: False)
  --cascade             If you would like to apply cascade reporting
                        structure. (default: False)
  --tmp TMP             temp directory to use (default: /tmp)
```


## tbtamr_annotate

### Tool Description
Annotate a BAM file with sequence ID and VCF information.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tbtamr annotate [-h] [--seq_id SEQ_ID] [--vcf VCF]

options:
  -h, --help           show this help message and exit
  --seq_id, -s SEQ_ID  Sequence name. (default: tbtamr)
  --vcf VCF            VCF file generated using the H37rV v3 reference genome
                       (default: )
```


## tbtamr_fq2vcf

### Tool Description
Generates a VCF file from FASTQ reads using mutAMR.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
[38;21m[INFO:02/25/2026 09:28:44 PM] You have provided reads as input - will now use mutAMR to generate vcf - please be patient.[0m
[38;21m[INFO:02/25/2026 09:28:44 PM] Will now create directory for tbtamr[0m
[38;21m[INFO:02/25/2026 09:28:44 PM] Now running mkdir -p tbtamr[0m
[38;21m[INFO:02/25/2026 09:28:44 PM] [0m
[38;21m[INFO:02/25/2026 09:28:44 PM] Checking /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa exists[0m
[38;21m[INFO:02/25/2026 09:28:44 PM] Checking  exists[0m
[38;21m[INFO:02/25/2026 09:28:44 PM] Checking  exists[0m
[38;21m[INFO:02/25/2026 09:28:44 PM] Generating alignment using bwa mem.[0m
[38;21m[INFO:02/25/2026 09:28:44 PM] Now running bwa mem -T 50 -Y -M -R '@RG\tID:tbtamr\tSM:tbtamr' -t 8 /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa   | samclip --max 10 --ref /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai | samtools sort -n -l 0 -@ 8 -m 1000M -T /tmp | samtools fixmate -m - - | samtools sort -l 0 -@ 8 -m 1000M -T /tmp | samtools markdup -T /tmp -r -s - - > tbtamr/tbtamr.bam[0m
[33;21m[WARNING:02/25/2026 09:28:44 PM] bwa mem -T 50 -Y -M -R '@RG\tID:tbtamr\tSM:tbtamr' -t 8 /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa   | samclip --max 10 --ref /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai | samtools sort -n -l 0 -@ 8 -m 1000M -T /tmp | samtools fixmate -m - - | samtools sort -l 0 -@ 8 -m 1000M -T /tmp | samtools markdup -T /tmp -r -s - - > tbtamr/tbtamr.bam failed. The following error was encountered : 
Usage: bwa mem [options] <idxbase> <in1.fq> [in2.fq]

Algorithm options:

       -t INT        number of threads [8]
       -k INT        minimum seed length [19]
       -w INT        band width for banded alignment [100]
       -d INT        off-diagonal X-dropoff [100]
       -r FLOAT      look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
       -y INT        seed occurrence for the 3rd round seeding [20]
       -c INT        skip seeds with more than INT occurrences [500]
       -D FLOAT      drop chains shorter than FLOAT fraction of the longest overlapping chain [0.50]
       -W INT        discard a chain if seeded bases shorter than INT [0]
       -m INT        perform at most INT rounds of mate rescues for each read [50]
       -S            skip mate rescue
       -P            skip pairing; mate rescue performed unless -S also in use

Scoring options:

       -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]
       -B INT        penalty for a mismatch [4]
       -O INT[,INT]  gap open penalties for deletions and insertions [6,6]
       -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1]
       -L INT[,INT]  penalty for 5'- and 3'-end clipping [5,5]
       -U INT        penalty for an unpaired read pair [17]

       -x STR        read type. Setting -x changes multiple parameters unless overridden [null]
                     pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref)
                     ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref)
                     intractg: -B9 -O16 -L5  (intra-species contigs to ref)

Input/output options:

       -p            smart pairing (ignoring in2.fq)
       -R STR        read group header line such as '@RG\tID:foo\tSM:bar' [null]
       -H STR/FILE   insert STR to header if it starts with @; or insert lines in FILE [null]
       -o FILE       sam file to output results to [stdout]
       -j            treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file)
       -5            for split alignment, take the alignment with the smallest query (not genomic) coordinate as primary
       -q            don't modify mapQ of supplementary alignments
       -K INT        process INT input bases in each batch regardless of nThreads (for reproducibility) []

       -v INT        verbosity level: 1=error, 2=warning, 3=message, 4+=debugging [3]
       -T INT        minimum score to output [50]
       -h INT[,INT]  if there are <INT hits with score >80.00% of the max score, output all in XA [5,200]
                     A second value may be given for alternate sequences.
       -z FLOAT      The fraction of the max score to use with -h [0.800000].
                     specify the mean, standard deviation (10% of the mean if absent), max
       -a            output all alignments for SE or unpaired PE
       -C            append FASTA/FASTQ comment to SAM output
       -V            output the reference FASTA header in the XR tag
       -Y            use soft clipping for supplementary alignments
       -M            mark shorter split hits as secondary

       -I FLOAT[,FLOAT[,INT[,INT]]]
                     specify the mean, standard deviation (10% of the mean if absent), max
                     (4 sigma from the mean if absent) and min of the insert size distribution.
                     FR orientation only. [inferred]
       -u            output XB instead of XA; XB is XA with the alignment score and mapping quality added.

Note: Please read the man page for detailed description of the command line and options.

[samclip] samclip 0.4.0 by Torsten Seemann (@torstenseemann)
[samclip] Loading: /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai
[samclip] Found 1 sequences in /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai
[samclip] Total SAM records 0, removed 0, allowed 0, passed 0
[samclip] Header contained 0 lines
[samclip] Done.
[W::hts_set_opt] Cannot change block size for this format
samtools sort: failed to read header from "-"
[bam_mating_core] ERROR: Couldn't read header
[W::hts_set_opt] Cannot change block size for this format
samtools sort: failed to read header from "-"
samtools markdup: error reading header

 | [0m
```


## tbtamr_full

### Tool Description
Runs the full tbtamr pipeline, including mutAMR for VCF generation and BWA MEM for alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
[38;21m[INFO:02/25/2026 09:29:25 PM] You have provided reads as input - will now use mutAMR to generate vcf - please be patient.[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Will now create directory for tbtamr[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Now running mkdir -p tbtamr[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] [0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Checking /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa exists[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Checking  exists[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Checking  exists[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Generating alignment using bwa mem.[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Now running bwa mem -T 50 -Y -M -R '@RG\tID:tbtamr\tSM:tbtamr' -t 8 /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa   | samclip --max 10 --ref /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai | samtools sort -n -l 0 -@ 8 -m 1000M -T /tmp | samtools fixmate -m - - | samtools sort -l 0 -@ 8 -m 1000M -T /tmp | samtools markdup -T /tmp -r -s - - > tbtamr/tbtamr.bam[0m
[33;21m[WARNING:02/25/2026 09:29:25 PM] bwa mem -T 50 -Y -M -R '@RG\tID:tbtamr\tSM:tbtamr' -t 8 /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa   | samclip --max 10 --ref /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai | samtools sort -n -l 0 -@ 8 -m 1000M -T /tmp | samtools fixmate -m - - | samtools sort -l 0 -@ 8 -m 1000M -T /tmp | samtools markdup -T /tmp -r -s - - > tbtamr/tbtamr.bam failed. The following error was encountered : 
Usage: bwa mem [options] <idxbase> <in1.fq> [in2.fq]

Algorithm options:

       -t INT        number of threads [8]
       -k INT        minimum seed length [19]
       -w INT        band width for banded alignment [100]
       -d INT        off-diagonal X-dropoff [100]
       -r FLOAT      look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]
       -y INT        seed occurrence for the 3rd round seeding [20]
       -c INT        skip seeds with more than INT occurrences [500]
       -D FLOAT      drop chains shorter than FLOAT fraction of the longest overlapping chain [0.50]
       -W INT        discard a chain if seeded bases shorter than INT [0]
       -m INT        perform at most INT rounds of mate rescues for each read [50]
       -S            skip mate rescue
       -P            skip pairing; mate rescue performed unless -S also in use

Scoring options:

       -A INT        score for a sequence match, which scales options -TdBOELU unless overridden [1]
       -B INT        penalty for a mismatch [4]
       -O INT[,INT]  gap open penalties for deletions and insertions [6,6]
       -E INT[,INT]  gap extension penalty; a gap of size k cost '{-O} + {-E}*k' [1,1]
       -L INT[,INT]  penalty for 5'- and 3'-end clipping [5,5]
       -U INT        penalty for an unpaired read pair [17]

       -x STR        read type. Setting -x changes multiple parameters unless overridden [null]
                     pacbio: -k17 -W40 -r10 -A1 -B1 -O1 -E1 -L0  (PacBio reads to ref)
                     ont2d: -k14 -W20 -r10 -A1 -B1 -O1 -E1 -L0  (Oxford Nanopore 2D-reads to ref)
                     intractg: -B9 -O16 -L5  (intra-species contigs to ref)

Input/output options:

       -p            smart pairing (ignoring in2.fq)
       -R STR        read group header line such as '@RG\tID:foo\tSM:bar' [null]
       -H STR/FILE   insert STR to header if it starts with @; or insert lines in FILE [null]
       -o FILE       sam file to output results to [stdout]
       -j            treat ALT contigs as part of the primary assembly (i.e. ignore <idxbase>.alt file)
       -5            for split alignment, take the alignment with the smallest query (not genomic) coordinate as primary
       -q            don't modify mapQ of supplementary alignments
       -K INT        process INT input bases in each batch regardless of nThreads (for reproducibility) []

       -v INT        verbosity level: 1=error, 2=warning, 3=message, 4+=debugging [3]
       -T INT        minimum score to output [50]
       -h INT[,INT]  if there are <INT hits with score >80.00% of the max score, output all in XA [5,200]
                     A second value may be given for alternate sequences.
       -z FLOAT      The fraction of the max score to use with -h [0.800000].
                     specify the mean, standard deviation (10% of the mean if absent), max
       -a            output all alignments for SE or unpaired PE
       -C            append FASTA/FASTQ comment to SAM output
       -V            output the reference FASTA header in the XR tag
       -Y            use soft clipping for supplementary alignments
       -M            mark shorter split hits as secondary

       -I FLOAT[,FLOAT[,INT[,INT]]]
                     specify the mean, standard deviation (10% of the mean if absent), max
                     (4 sigma from the mean if absent) and min of the insert size distribution.
                     FR orientation only. [inferred]
       -u            output XB instead of XA; XB is XA with the alignment score and mapping quality added.

Note: Please read the man page for detailed description of the command line and options.

[samclip] samclip 0.4.0 by Torsten Seemann (@torstenseemann)
[samclip] Loading: /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai
[samclip] Found 1 sequences in /usr/local/lib/python3.13/site-packages/mutamr/references/Mtb_NC000962.3.fa.fai
[samclip] Total SAM records 0, removed 0, allowed 0, passed 0
[samclip] Header contained 0 lines
[samclip] Done.
[W::hts_set_opt] Cannot change block size for this format
samtools sort: failed to read header from "-"
[bam_mating_core] ERROR: Couldn't read header
[W::hts_set_opt] Cannot change block size for this format
samtools sort: failed to read header from "-"
samtools markdup: error reading header

 | [0m
[38;21m[INFO:02/25/2026 09:29:25 PM] /usr/local/lib/python3.13/site-packages/tbtamr/configs/db_config.json exists.[0m
[38;21m[INFO:02/25/2026 09:29:25 PM] Will now create directory for tbtamr[0m
Traceback (most recent call last):
  File "/usr/local/bin/tbtamr", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/site-packages/tbtamr/tbtamr.py", line 430, in main
    args.func(args)
    ~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.13/site-packages/tbtamr/tbtamr.py", line 87, in run_full
    variants = Prs.get_variant_data()
  File "/usr/local/lib/python3.13/site-packages/tbtamr/Parse.py", line 215, in get_variant_data
    if self.check_file(pth = self.vcf_file) and self.check_file(pth = self.catalog):
       ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/site-packages/tbtamr/Parse.py", line 50, in check_file
    if pth != "" and pathlib.Path(pth).exists():
                     ~~~~~~~~~~~~^^^^^
  File "/usr/local/lib/python3.13/pathlib/_local.py", line 503, in __init__
    super().__init__(*args)
    ~~~~~~~~~~~~~~~~^^^^^^^
  File "/usr/local/lib/python3.13/pathlib/_local.py", line 132, in __init__
    raise TypeError(
    ...<2 lines>...
        f"not {type(path).__name__!r}")
TypeError: argument should be a str or an os.PathLike object where __fspath__ returns a str, not 'NoneType'
```


## Metadata
- **Skill**: generated
