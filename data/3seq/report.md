# 3seq CWL Generation Report

## 3seq

### Tool Description
Software For Identifying Recombination In Sequence Data

### Metadata
- **Docker Image**: quay.io/biocontainers/3seq:1.8--h9948957_6
- **Homepage**: https://mol.ax/software/3seq/
- **Package**: https://anaconda.org/channels/bioconda/packages/3seq/overview
- **manual**: https://mol.ax/content/media/2018/02/3seq_manual.20180209.pdf
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/3seq/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-09-10
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
[m
  ════════════════════════════════════════════════════════════════════════════════
  3SEQ -- Software For Identifying Recombination In Sequence Data
  ════════════════════════════════════════════════════════════════════════════════

  For help, email author: mfb9@psu.edu, lamhm@oucru.org

  Input file may be PHYLIP (sequential) or FASTA format.

  ────────────────────────────────────────────────────────────────────────────────

  USAGE:
      3seq -<run_mode>  <run_options>

  There are currently 10 run modes:
      3seq -help

      3seq -version

      3seq -gen-p    <ptable_file>  <ptable_size>

      3seq -check-p  [ptable_file]

      3seq -write    <seq_file>                [options]
      3seq -write    <seq_file> <output_file>  [options]

      3seq -info     <seq_file>                [options]

      3seq -match    <seq_file> <seq_name> <minDistance> <maxDistance> [options]

      3seq -triplet  <seq_file>  <P_name>    <Q_name>      <C_name>    [options]

      3seq -single   <seq_file>                 [options]
      3seq -single   <parent_file> <child_file> [options]

      3seq -full     <seq_file>                 [-ptable ptable_file]  [options]
      3seq -full     <parent_file> <child_file> [-ptable ptable_file]  [options]

  ────────────────────────────────────────────────────────────────────────────────

  OPTIONS:

      -a       use all sites rather than just polymorphic sites; default is off.

      -b -e    beginning sequence / end sequence; e.g. -b13 -e17 tests sequences
               #13 through #17 inclusive (each as the child sequence) to test if
               they are a recombinant of the remaining sequences in the data set.

               This option can be used to parallelize the algorithm (e.g. -b0 -e9
               on processor #1; -b10 -e19 on processor #2).

               To test a single query sequence for recombination, simply use -b19
               -e19.

               Default is to test all sequences for recombination.

      -d       distinct sequences only; removes sequences that are identical to
               other sequences; default is off.

      -f -l    first and last nucleotide to be analyzed, e.g. -f100 -l200
               considers nucleotide positions 100-200 inclusive (first position is
               1, not 0); default is all positions.

      -12po    first and second positions only; strips sequences down to positions
               1, 2, 4, 5, 7, 8 etc. Note that if your start codon is at positions
               20-22, then you must use the option -f20 (and perhaps -l as well)
               to ensure that you are in the right reading frame and that you are
               looking at a coding region.

      -3po     third positions only; strips sequences down to positions 3, 6, 9,
               etc. Note that if your start codon is at positions 20-22, then you
               must use the option -f20 (and perhaps -l as well) to ensure that
               you are in the right reading frame and that you are looking at a
               coding region.

      -L       set the minimum length to count a segment as recombinant;
               e.g. -L150 sets minimum length to 150 nucleotides; default is 100.

      -r       record skipped computation to file "3s.skipped"; default is off.

      -t       rejection threshold, e.g. -t0.01, -t1e-6; default is -t0.05.

      -x       cut; this option can be used with the -f and -l switches to cut out
               a portion of the sequence and use the remainder of the sequence for
               analysis; example:

                    3seq -full seq_file -f100 -l200 -x

      -y       indicate YesNo-mode; algorithm stops once a significant triple has
               been found; this is off by default.

      -#       indicate that for multiple comparisons corrections, the number of
               comparisons to be used is the actual number performed in the run;
               when this option is off, the number of comparisons used in the
               correction is N*(N-1)*(N-2) where N is the total number of
               sequences; this options is off by default.

      -nohs    suppress using Hogan-Siegmund approximations (Adv. Appl. Math.,
               1986), when the exact p-values cannot be computed; default is off.

      -fasta   format output as FASTA; default is PHYLIP format; used in write
               mode only.

      -nexus   format output as NEXUS; default is PHYLIP format; used in write
               mode only.

      -nr      suppress writing to "3s.rec.csv" file.

      -id      give unique identifier for this run; e.g. when running the
               algorithm in parallel, you can specify

                   3seq -full seq_file -b0  -e9  -id run01
                   3seq -full seq_file -b10 -e19 -id run02

               and this will create output files called run01.3s.rec.csv,
               run02.3s.rec.csv, run01.3s.pvalHist, run02.3s.pvalHist, etc.

      -id-auto          automatically give a unique identifier for this run based
                        on the run-time.

      -bp-all           calculate all breakpoint positions for all candidate
                        recombinants; this will significantly slow down the
                        algorithm when the sequence data are highly recombinant;
                        default is to calculate only the best breakpoint positions
                        per candidate recombinant.

      -bp-none          do not calculate any breakpoint positions; this mode will
                        generate a file "3s.rec.csv" with all candidate recombinant
                        triplets but with no breakpoint information; default is to
                        calculate the best breakpoint positions per candidate
                        recombinant and include only these triplets in "3s.rec.csv".

      -subset           designate subset of sequences to be analyzed; the subset
                        file must contain sequence accessions, each separated by
                        an end-line character; command-line usage is

                            3seq -full seq_file -subset subset_file

                        where the file "myfile.subset" is text file with accession
                        numbers separated by whitespace.

      -subset-remove   as above, except that the sequences in the subset file
                       "subset_file" are removed from the dataset.

      -rand            specify the number of random child sequences that will be
                       sub-sampled from the original dataset and used in a recombi
                       -nation sensitivity analysis.  If the parent and the
                       child datasets are taken from different files, this option
                       will not affect the parent dataset.  In case the parent and
                       child sequences are from the same file, only the sub-
                       sampled sequences will be used as both the parent and the
                       child datasets for the sensitivity analysis.

      -n               specify the number of iterations of the recombination
                       analysis.  For example, the following command:

                            3seq-full seq_file -rand 20 -n 100

                       will test the recombination sensitivity of the given
                       dataset 100 times, each time considers 20 randomly sub-
                       sampled sequences.

  ════════════════════════════════════════════════════════════════════════════════


[m
```


## Metadata
- **Skill**: generated
