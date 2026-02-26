# megadepth CWL Generation Report

## megadepth

### Tool Description
BAM and BigWig utility.

### Metadata
- **Docker Image**: quay.io/biocontainers/megadepth:1.2.0--h5ca1c30_7
- **Homepage**: https://github.com/ChristopherWilks/megadepth
- **Package**: https://anaconda.org/channels/bioconda/packages/megadepth/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/megadepth/overview
- **Total Downloads**: 20.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ChristopherWilks/megadepth
- **Stars**: N/A
### Original Help Text
```text
megadepth 1.2.0

BAM and BigWig utility.

Usage:
  megadepth <bam|bw|-> [options]

Options:
  -h --help                Show this screen.
  --version                Show version.
  --threads                # of threads to do: BAM decompression OR compute sums over multiple BigWigs in parallel
                            if the 2nd is intended then a TXT file listing the paths to the BigWigs to process in parallel
                            should be passed in as the main input file instead of a single BigWig file (EXPERIMENTAL).
  --prefix                 String to use to prefix all output files.
  --no-auc-stdout          Force all AUC(s) to be written to <prefix>.auc.tsv rather than STDOUT
  --no-annotation-stdout   Force summarized annotation regions to be written to <prefix>.annotation.tsv rather than STDOUT
  --no-coverage-stdout     Force covered regions to be written to <prefix>.coverage.tsv rather than STDOUT
  --keep-order             Output annotation coverage in the order chromosomes appear in the BAM/BigWig file
                           The default is to output annotation coverage in the order chromosomes appear in the annotation BED file.
                           This is only applicable if --annotation is used for either BAM or BigWig input.

BigWig Input:
Extract regions and their counts from a BigWig outputting BED format if a BigWig file is detected as input (exclusive of the other BAM modes):
                                          Extracts all reads from the passed in BigWig and output as BED format.
                                           This will also report the AUC over the annotated regions to STDOUT.
                                           If only the name of the BigWig file is passed in with no other args, it will *only* report total AUC to STDOUT.
  --annotation <bed>                      Only output the regions in this BED applying the argument to --op to them.
  --op <sum[default], mean, min, max>     Statistic to run on the intervals provided by --annotation
  --sums-only                             Discard coordinates from output of summarized regions
  --distance (2200[default])              Number of base pairs between end of last annotation and start of new to consider in the same BigWig query window (a form of binning) for performance.  This determines the number of times the BigWig index is queried.
  --unsorted (off[default])               There's a performance improvement *if* BED file passed to --annotation is 1) sorted by sort -k1,1 -k2,2n (default is to assume sorted and check for unsorted positions, if unsorted positions are found, will fall back to slower version)
  --bwbuffer <1GB[default]>               Size of buffer for reading BigWig files, critical to use a large value (~1GB) for remote BigWigs.
                                          Default setting should be fine for most uses, but raise if very slow on a remote BigWig.


BAM Input:
Extract basic junction information from the BAM, including co-occurrence
If only the name of the BAM file is passed in with no other args, it will *only* report total AUC to STDOUT.
  --fasta              Path to the reference FASTA file if a CRAM file is passed as the input file (ignored otherwise)
                       If not passed, references will be downloaded using the CRAM header.
  --junctions          Extract co-occurring jx coordinates, strand, and anchor length, per read
                       writes to a TSV file <prefix>.jxs.tsv
  --all-junctions      Extract all jx coordinates, strand, and anchor length, per read for any jx
                       writes to a TSV file <prefix>.all_jxs.tsv
  --longreads          Modifies certain buffer sizes to accommodate longer reads such as PB/Oxford.
  --filter-in          Integer bitmask, any bits of which alignments need to have to be kept (similar to samtools view -f).
  --filter-out         Integer bitmask, any bits of which alignments need to have to be skipped (similar to samtools view -F).
  --add-chr-prefix     Adds "chr" prefix to relevant chromosomes for BAMs w/o it, pass "human" or "mouse".
                       Only works for human/mouse references (default: off).

Non-reference summaries:
  --alts                       Print differing from ref per-base coverages
                               Writes to a CSV file <prefix>.alts.tsv
  --include-softclip           Print a record to the alts CSV for soft-clipped bases
                               Writes total counts to a separate TSV file <prefix>.softclip.tsv
  --only-polya                 If --include-softclip, only print softclips which are mostly A's or T's
  --include-n                  Print mismatch records when mismatched read base is N
  --print-qual                 Print quality values for mismatched bases
  --delta                      Print POS field as +/- delta from previous
  --require-mdz                Quit with error unless MD:Z field exists everywhere it's
                               expected
  --head                       Print sequence names and lengths in SAM/BAM header

Coverage and quantification:
  --coverage           Print per-base coverage (slow but totally worth it)
  --auc                Print per-base area-under-coverage, will generate it for the genome
                       and for the annotation if --annotation is also passed in
                       Defaults to STDOUT, unless other params are passed in as well, then
                       if writes to a TSV file <prefix>.auc.tsv
  --bigwig             Output coverage as BigWig file(s).  Writes to <prefix>.bw
                       (also <prefix>.unique.bw when --min-unique-qual is specified).
                       Requires libBigWig.
  --annotation <BED|window_size>   Path to BED file containing list of regions to sum coverage over
                       (tab-delimited: chrm,start,end). Or this can specify a contiguous region size in bp.
  --op <sum[default], mean>     Statistic to run on the intervals provided by --annotation
  --no-index           If using --annotation, skip the use of the BAM index (BAI) for pulling out regions.
                       Setting this can be faster if doing windows across the whole genome.
                       This will be turned on automatically if a window size is passed to --annotation.
  --min-unique-qual <int>
                       Output second bigWig consisting built only from alignments
                       with at least this mapping quality.  --bigwig must be specified.
                       Also produces second set of annotation sums based on this coverage
                       if --annotation is enabled
  --double-count       Allow overlapping ends of PE read to count twice toward
                       coverage
  --num-bases          Report total sum of bases in alignments processed (that pass filters)
  --gzip               Turns on gzipping of coverage output (no effect if --bigwig is passsed),
                       this will also enable --no-coverage-stdout.

Other outputs:
  --read-ends          Print counts of read starts/ends, if --min-unique-qual is set
                       then only the alignments that pass that filter will be counted here
                       Writes to 2 TSV files: <prefix>.starts.tsv, <prefix>.ends.tsv
  --frag-dist          Print fragment length distribution across the genome
                       Writes to a TSV file <prefix>.frags.tsv
  --echo-sam           Print a SAM record for each aligned read
  --ends               Report end coordinate for each read (useful for debugging)
  --test-polya         Lower Poly-A filter minimums for testing (only useful for debugging/testing)
```

