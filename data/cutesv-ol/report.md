# cutesv-ol CWL Generation Report

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


## cutesv-ol_minimap2

### Tool Description
Minimap2 is a versatile tool for sequence alignment. It can be used for various tasks including indexing reference genomes, mapping long reads (PacBio, Nanopore), short reads, and performing spliced alignments for RNA-seq data. It also supports read overlap detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0
- **Homepage**: https://github.com/120L022331/cuteSV-OL
- **Package**: https://anaconda.org/channels/bioconda/packages/cutesv-ol/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: minimap2 [options] <target.fa>|<target.idx> [query.fa] [...]
Options:
  Indexing:
    -H           use homopolymer-compressed k-mer (preferrable for PacBio)
    -k INT       k-mer size (no larger than 28) [15]
    -w INT       minimizer window size [10]
    -I NUM       split index for every ~NUM input bases [8G]
    -d FILE      dump index to FILE []
  Mapping:
    -f FLOAT     filter out top FLOAT fraction of repetitive minimizers [0.0002]
    -g NUM       stop chain enlongation if there are no minimizers in INT-bp [5000]
    -G NUM       max intron length (effective with -xsplice; changing -r) [200k]
    -F NUM       max fragment length (effective with -xsr or in the fragment mode) [800]
    -r NUM[,NUM] chaining/alignment bandwidth and long-join bandwidth [500,20000]
    -n INT       minimal number of minimizers on a chain [3]
    -m INT       minimal chaining score (matching bases minus log gap penalty) [40]
    -X           skip self and dual mappings (for the all-vs-all mode)
    -p FLOAT     min secondary-to-primary score ratio [0.8]
    -N INT       retain at most INT secondary alignments [5]
  Alignment:
    -A INT       matching score [2]
    -B INT       mismatch penalty (larger value for lower divergence) [4]
    -O INT[,INT] gap open penalty [4,24]
    -E INT[,INT] gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2} [2,1]
    -z INT[,INT] Z-drop score and inversion Z-drop score [400,200]
    -s INT       minimal peak DP alignment score [80]
    -u CHAR      how to find GT-AG. f:transcript strand, b:both strands, n:don't match GT-AG [n]
    -J INT       splice mode. 0: original minimap2 model; 1: miniprot model [1]
    -j FILE      junctions in BED12 to extend *short* RNA-seq alignment []
  Input/Output:
    -a           output in the SAM format (PAF by default)
    -o FILE      output alignments to FILE [stdout]
    -L           write CIGAR with >65535 ops at the CG tag
    -R STR       SAM read group line in a format like '@RG\tID:foo\tSM:bar' []
    -c           output CIGAR in PAF
    --cs[=STR]   output the cs tag; STR is 'short' (if absent) or 'long' [none]
    --ds         output the ds tag, which is an extension to cs
    --MD         output the MD tag
    --eqx        write =/X CIGAR operators
    -Y           use soft clipping for supplementary alignments
    -y           copy FASTA/Q comments to output SAM
    -t INT       number of threads [3]
    -K NUM       minibatch size for mapping [500M]
    --version    show version number
  Preset:
    -x STR       preset (always applied before other options; see minimap2.1 for details) []
                 - lr:hq - accurate long reads (error rate <1%) against a reference genome
                 - splice/splice:hq - spliced alignment for long reads/accurate long reads
                 - splice:sr - spliced alignment for short RNA-seq reads
                 - asm5/asm10/asm20 - asm-to-ref mapping, for ~0.1/1/5% sequence divergence
                 - sr - short reads against a reference
                 - map-pb/map-hifi/map-ont/map-iclr - CLR/HiFi/Nanopore/ICLR vs reference mapping
                 - ava-pb/ava-ont - PacBio CLR/Nanopore read overlap

See `man ./minimap2.1' for detailed description of these and other advanced command-line options.
```

