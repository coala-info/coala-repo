# makehub CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| makehub_make_hub.py | PASS |  |

## makehub_make_hub.py

### Tool Description
Generate UCSC assembly hub (e.g. from BRAKER or MAKER output).

### Metadata
- **Docker Image**: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
- **Homepage**: https://github.com/Gaius-Augustus/MakeHub
- **Package**: https://anaconda.org/channels/bioconda/packages/makehub/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/makehub/overview
- **Total Downloads**: 38.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Gaius-Augustus/MakeHub
- **Stars**: N/A
### Original Help Text
```text
usage: make_hub.py [-h] [-p] [-e EMAIL] [-g GENOME] [-L LONG_LABEL]
                   [-l SHORT_LABEL] [-b BAM [BAM ...]] [-c THREADS] [-d]
                   [-E GEMOMA_FILTERED_PREDICTIONS] [-X BRAKER_OUT_DIR]
                   [-M MAKER_GFF] [-I GLIMMER_GFF] [-S SNAP_GFF] [-a ANNOT]
                   [-G GENE_TRACK [GENE_TRACK ...]] [-A] [-o OUTDIR] [-n]
                   [-s SAMTOOLS_PATH] [-B BAM2WIG_PATH] [-i HINTS]
                   [-t TRAINGENES] [-m GENEMARK] [-w AUG_AB_INITIO]
                   [-x AUG_HINTS] [-y AUG_AB_INITIO_UTR] [-z AUG_HINTS_UTR]
                   [-U BRAKER_GENES] [-N LATIN_NAME] [-V ASSEMBLY_VERSION]
                   [-r] [-P] [-u VERBOSITY] [-v]

Generate UCSC assembly hub (e.g. from BRAKER or MAKER output).

options:
  -h, --help            show this help message and exit
  -p, --printUsageExamples
                        Print usage examples for make_hub.py
  -e EMAIL, --email EMAIL
                        Contact e-mail adress for assembly hub
  -g GENOME, --genome GENOME
                        Genome fasta file (possibly softmasked)
  -L LONG_LABEL, --long_label LONG_LABEL
                        Long label for hub, e.g. species name in english and
                        latin, pass in single quotation marks, e.g.
                        --long_label 'Dorosphila melanogster (fruit fly)'
  -l SHORT_LABEL, --short_label SHORT_LABEL
                        Short label for hub, will also be used as directory
                        name for hub, should not contain spaces or special
                        characters, e.g. --short_label fly
  -b BAM [BAM ...], --bam BAM [BAM ...]
                        BAM file(s) - space separated - with RNA-Seq
                        information, by default will be displayed as bigWig
  -c THREADS, --threads THREADS
                        Number of threads for samtools sort processes
  -d, --display_bam_as_bam
                        Display BAM file(s) as bam tracks
  -E GEMOMA_FILTERED_PREDICTIONS, --gemoma_filtered_predictions GEMOMA_FILTERED_PREDICTIONS
                        GFF3 output file of Gemoma
  -X BRAKER_OUT_DIR, --braker_out_dir BRAKER_OUT_DIR
                        BRAKER output directory with GTF files; works also for
                        GALBA, warnings are expected in case of GALBA as
                        input.
  -M MAKER_GFF, --maker_gff MAKER_GFF
                        MAKER2 output file in GFF3 format
  -I GLIMMER_GFF, --glimmer_gff GLIMMER_GFF
                        GFF3 output file of GlimmerHMM
  -S SNAP_GFF, --snap_gff SNAP_GFF
                        SNAP output file in GFF3 format
  -a ANNOT, --annot ANNOT
                        GTF file with reference annotation
  -G GENE_TRACK [GENE_TRACK ...], --gene_track GENE_TRACK [GENE_TRACK ...]
                        Gene track with user specified label, argument must be
                        formatted as follows: --gene_track file.gtf tracklabel
  -A, --add_track       Add track(s) to existing hub
  -o OUTDIR, --outdir OUTDIR
                        output directory to write hub to
  -n, --no_repeats      Disable repeat track generation from softmasked genome
                        sequence (saves time)
  -s SAMTOOLS_PATH, --SAMTOOLS_PATH SAMTOOLS_PATH
                        Path to samtools executable
  -B BAM2WIG_PATH, --BAM2WIG_PATH BAM2WIG_PATH
                        Path to bam2wig executable
  -i HINTS, --hints HINTS
                        GFF file with AUGUSTUS hints
  -t TRAINGENES, --traingenes TRAINGENES
                        GTF file with training genes
  -m GENEMARK, --genemark GENEMARK
                        GTF file with GeneMark predictions
  -w AUG_AB_INITIO, --aug_ab_initio AUG_AB_INITIO
                        GTF file with ab initio AUGUSTUS predictions
  -x AUG_HINTS, --aug_hints AUG_HINTS
                        GTF file with AUGUSTUS predictions with hints
  -y AUG_AB_INITIO_UTR, --aug_ab_initio_utr AUG_AB_INITIO_UTR
                        GTF file with ab initio AUGUSTUS predictions with UTRs
  -z AUG_HINTS_UTR, --aug_hints_utr AUG_HINTS_UTR
                        GTF file with AUGUSTUS predictions with hints with
                        UTRs
  -U BRAKER_GENES, --braker_genes BRAKER_GENES
                        GTF file with BRAKER genes (generated by TSEBRA).
  -N LATIN_NAME, --latin_name LATIN_NAME
                        Latin species name, e.g. "Drosophila melanogaster".
                        This argument must be provided if the hub is supposed
                        to be added to the public UCSC list.
  -V ASSEMBLY_VERSION, --assembly_version ASSEMBLY_VERSION
                        Assembly version, e.g. "BDGP R4/dm3". This argument
                        must be provided if the hub is supposed to be added to
                        the public UCSC list.
  -r, --no_tmp_rm       Do not delete temporary files
  -P, --no_genePredToBigGenePred
                        Option for the special case in which the precompiled
                        UCSC binaries are not working on your system, and you
                        installed kentutils from the older ENCODE github
                        repository; if activated, gene prediction tracks will
                        be output to bigBed instead of bigGenePred format and
                        amino acid display will not be possible in gene
                        tracks.
  -u VERBOSITY, --verbosity VERBOSITY
                        If INT>0 verbose output log is produced
  -v, --version         show program's version number and exit
```

## Metadata
- **Skill**: generated
