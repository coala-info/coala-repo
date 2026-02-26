# dcc CWL Generation Report

## dcc_DCC

### Tool Description
Contact: tobias.jakobi@med.uni-heidelberg.de || s6juncheng@gmail.com

### Metadata
- **Docker Image**: quay.io/biocontainers/dcc:0.5.0--pyhca03a8a_0
- **Homepage**: https://github.com/dieterich-lab/DCC
- **Package**: https://anaconda.org/channels/bioconda/packages/dcc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dcc/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dieterich-lab/DCC
- **Stars**: N/A
### Original Help Text
```text
usage: DCC [-h] [--version] [-k] [-T CPU_THREADS] [-O OUT_DIR] [-t TMP_DIR]
           [-D] [-ss] [-N] [-E {0,1,2,3,4,5,6,7,8,9}] [-m MAX] [-n MIN]
           [-an ANNOTATE] [-Pi] [-mt1 MATE1 [MATE1 ...]]
           [-mt2 MATE2 [MATE2 ...]] [-F] [-f FILTERONLY FILTERONLY] [-M]
           [-R REP_FILE] [-L LENGTH] [-Nr countthreshold replicatethreshold]
           [-fg] [-G] [-C CIRC] [-B BAM [BAM ...]] [-A REFSEQ]
           Input [Input ...]

Contact: tobias.jakobi@med.uni-heidelberg.de || s6juncheng@gmail.com

positional arguments:
  Input                 Input of the Chimeric.out.junction file from STAR.
                        Alternatively, a sample sheet specifying where your
                        chimeric.out.junction files are, each sample per line,
                        provide with @ prefix (e.g. @samplesheet)

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -k, --keep-temp       Temporary files will not be deleted [default: False]
  -T CPU_THREADS, --threads CPU_THREADS
                        Number of CPU threads used for computation [default:
                        2]
  -O OUT_DIR, --output OUT_DIR
                        DCC output directory [default: .]
  -t TMP_DIR, --temp TMP_DIR
                        DCC temporary directory [default: _tmp_DCC/]

Find circRNA Options:
  Options to find circRNAs from STAR output

  -D, --detect          Enable circRNA detection from Chimeric.out.junction
                        files [default: False]
  -ss                   Must be enabled for stranded libraries, aka 'fr-
                        secondstrand' [default: False]
  -N, --nonstrand       The library is non-stranded [default stranded]
  -E {0,1,2,3,4,5,6,7,8,9}, --endTol {0,1,2,3,4,5,6,7,8,9}
                        Maximum base pair tolerance of reads extending over
                        junction sites [default: 5]
  -m MAX, --maximum MAX
                        The maximum length of candidate circRNAs (including
                        introns) [default: 1000000]
  -n MIN, --minimum MIN
                        The minimum length of candidate circRNAs (including
                        introns) [default 30]
  -an ANNOTATE, --annotation ANNOTATE
                        Gene annotation file in GTF/GFF3 format, to annotate
                        circRNAs by their host gene name/identifier
  -Pi, --PE-independent
                        Has to be specified if the paired end mates have also
                        been mapped separately.If specified, -mt1 and -mt2
                        must also be provided [default: False]
  -mt1 MATE1 [MATE1 ...], --mate1 MATE1 [MATE1 ...]
                        For paired end data, Chimeric.out.junction files from
                        mate1 independent mapping result
  -mt2 MATE2 [MATE2 ...], --mate2 MATE2 [MATE2 ...]
                        For paired end data, Chimeric.out.junction files from
                        mate2 independent mapping result

Filtering Options:
  Options to filter the circRNA candidates

  -F, --filter          If specified, the program will perform a recommended
                        filter step on the detection results
  -f FILTERONLY FILTERONLY, --filter-only FILTERONLY FILTERONLY
                        If specified, the program will only filter based on
                        two files provided: 1) a coordinates file [BED6
                        format] and 2) a count file. E.g.: -f example.bed
                        counts.txt
  -M, --chrM            If specified, circRNA candidates located on the
                        mitochondrial chromosome will be removed
  -R REP_FILE, --rep_file REP_FILE
                        Custom repetitive region file in GTF format to filter
                        out circRNA candidates in repetitive regions
  -L LENGTH, --Ln LENGTH
                        Minimum length in base pairs to check for repetitive
                        regions [default 50]
  -Nr countthreshold replicatethreshold
                        countthreshold replicatethreshold [default: 2,5]
  -fg, --filterbygene   If specified, filter also by gene annotation
                        (candidates are not allowed to span more than one
                        gene) default: False

Host gene count Options:
  Options to count host gene expression

  -G, --gene            If specified, the program will count host gene
                        expression given circRNA coordinates [default: False]
  -C CIRC, --circ CIRC  User specified circRNA coordinates, any tab delimited
                        file with first three columns as circRNA coordinates:
                        chr start end, which DCC will use to count host gene
                        expression
  -B BAM [BAM ...], --bam BAM [BAM ...]
                        A file specifying the mapped BAM files from which host
                        gene expression is computed; must have the same order
                        as input chimeric junction files
  -A REFSEQ, --refseq REFSEQ
                        Reference sequence FASTA file
```

