# seismic-rna CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seismic-rna_seismic_align | PASS | synthetic data: seismic-rna tutorial amplicon reads made by seismic sim (two DMS replicates, HIV RRE); BAMs pass quickcheck, 92 percent of read pairs aligned |
| seismic-rna_seismic_cleanfa | PASS | synthetic data: tutorial amplicon reads made by seismic sim; reference FASTA rewritten into the out folder with the same name and sequence |
| seismic-rna_seismic_cluster | PASS | synthetic data: tutorial amplicon reads; two clusters found with 73 and 27 percent of reads, as the tutorial expects |
| seismic-rna_seismic_ct2db | PASS | synthetic data: tutorial amplicon reads made by seismic sim; dot-bracket file written from the folded CT file (179 nt, balanced brackets) |
| seismic-rna_seismic_db2ct | PASS | synthetic data: tutorial amplicon reads made by seismic sim; CT file rebuilt from the dot-bracket file with the same base pairs (numbering restarts at 1) |
| seismic-rna_seismic_demult | Failed | image problem: demult calls seqkit, which is not in the image; all barcode counts are 0 (read names were relabelled in Illumina style to reach that step) |
| seismic-rna_seismic_draw | Failed | image problem: RNArtistCore is not in the image and jgo cannot write its cache in /usr/local/jgo, so no drawing is made |
| seismic-rna_seismic_ensembles | PASS | synthetic data: tutorial amplicon reads made by seismic sim; two regions (26-204 and 114-178) masked and clustered with 2 clusters each, tables written |
| seismic-rna_seismic_export | PASS | synthetic data: tutorial amplicon reads; SEISMICgraph JSON written with the folded structure included |
| seismic-rna_seismic_fold | PASS | synthetic data: tutorial amplicon reads; MFE structure of 179 nt with balanced brackets (-163.2 kcal/mol) |
| seismic-rna_seismic_graph | PASS | synthetic data: tutorial amplicon reads; per-position mutation ratio CSV and HTML written (only seismic graph profile is wrapped) |
| seismic-rna_seismic_graph_abundance | PASS | synthetic data: tutorial amplicon reads made by seismic sim; cluster abundance CSV and HTML written (K=2: two clusters, 33 and 67 percent of reads) |
| seismic-rna_seismic_graph_aucroll | PASS | synthetic data: tutorial amplicon reads made by seismic sim; rolling AUC-ROC CSV and HTML written against the folded structure |
| seismic-rna_seismic_graph_corroll | PASS | synthetic data: tutorial amplicon reads made by seismic sim; rolling Pearson correlation between samples dms1 and dms2 written as CSV and HTML |
| seismic-rna_seismic_graph_delprof | PASS | synthetic data: tutorial amplicon reads made by seismic sim; per-position difference between samples dms1 and dms2 written as CSV and HTML |
| seismic-rna_seismic_graph_giniroll | PASS | synthetic data: tutorial amplicon reads made by seismic sim; rolling Gini coefficient CSV and HTML written |
| seismic-rna_seismic_graph_histpos | PASS | synthetic data: tutorial amplicon reads made by seismic sim; histogram of mutation ratios per position written as CSV and HTML |
| seismic-rna_seismic_graph_histread | PASS | synthetic data: tutorial amplicon reads made by seismic sim; histogram of mutation ratios per read written as CSV and HTML |
| seismic-rna_seismic_graph_mutdist | PASS | synthetic data: tutorial amplicon reads made by seismic sim; distribution of distances between mutations written as CSV and HTML |
| seismic-rna_seismic_graph_poscorr | PASS | synthetic data: tutorial amplicon reads made by seismic sim; position-by-position phi correlation matrix written as CSV and HTML |
| seismic-rna_seismic_graph_roc | PASS | synthetic data: tutorial amplicon reads made by seismic sim; ROC curve CSV and HTML written against the folded structure |
| seismic-rna_seismic_graph_scatter | PASS | synthetic data: tutorial amplicon reads made by seismic sim; scatter data of dms1 against dms2 mutation ratios written as CSV and HTML |
| seismic-rna_seismic_graph_snrroll | PASS | synthetic data: tutorial amplicon reads made by seismic sim; rolling signal-to-noise ratio CSV and HTML written |
| seismic-rna_seismic_join | PASS | synthetic data: tutorial amplicon reads; regions 26-100 and 101-204 joined into 179 positions with the same mean mutation rate |
| seismic-rna_seismic_list | PASS | synthetic data: tutorial amplicon reads made by seismic sim; relate-position-list.csv names positions 1-8, which have fewer than 30000 informative bases |
| seismic-rna_seismic_mask | PASS | synthetic data: tutorial amplicon reads; primer region 26-204 masked, G bases masked and A mutation rate about 8 percent |
| seismic-rna_seismic_migrate | Not completed | no v0.23 output directory available; the run on a v0.24 folder only copied it |
| seismic-rna_seismic_pool | PASS | synthetic data: tutorial amplicon reads; pooled coverage and mutation counts equal the sum of the two samples |
| seismic-rna_seismic_relate | PASS | synthetic data: tutorial amplicon reads; relate tables written for both samples |
| seismic-rna_seismic_renumct | Failed | tool bug: renumct without --inplace crashes with TypeError (PosixPath is not iterable) and writes nothing; --inplace renumbers correctly |
| seismic-rna_seismic_sim_abstract | PASS | synthetic data: tutorial amplicon reads made by seismic sim; parameters abstracted from the masked pooled sample against the folded structure (printed as seismic sim options) |
| seismic-rna_seismic_sim_clusts | PASS | synthetic data: simulator output; clusts CSV written next to the simulated CT file |
| seismic-rna_seismic_sim_ends | PASS | synthetic data: simulator output; read end proportions CSV written next to the simulated CT file |
| seismic-rna_seismic_sim_fastq | PASS | synthetic data: simulator output; paired FASTQ files of about 1800 reads written from the parameter files |
| seismic-rna_seismic_sim_fold | PASS | synthetic data: simulator output; MFE structure of the simulated reference written as a CT file |
| seismic-rna_seismic_sim_muts | PASS | synthetic data: simulator output; mutation rate CSV written next to the simulated CT file |
| seismic-rna_seismic_sim_params | PASS | synthetic data: simulator output; ends, muts and clusts parameter files written for the simulated structure |
| seismic-rna_seismic_sim_ref | PASS | synthetic data: simulator output; one 150 nt reference written to a FASTA file |
| seismic-rna_seismic_sim_relate | PASS | synthetic data: simulator output; relate report and batches written for sample s1 |
| seismic-rna_seismic_sim_total | PASS | synthetic data: simulator output; reference, structure, parameters and paired FASTQ files made in one run |
| seismic-rna_seismic_splitbam | PASS | synthetic data: tutorial amplicon reads made by seismic sim; aligned BAM split into one BAM per reference (rre.bam) with a split report |
| seismic-rna_seismic_table | PASS | synthetic data: tutorial amplicon reads; per-read table has one row per read pair (21883) |

## seismic-rna_seismic_align

### Tool Description
Trim FASTQ files and align them to reference sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic align [OPTIONS] FASTA

  Trim FASTQ files and align them to reference sequences.

Options:
  -x, --fastqx PATH               FASTQ files of paired-end reads with mates 1
                                  and 2 in separate files
  -y, --fastqy PATH               FASTQ file(s) of paired-end reads with mates
                                  1 and 2 interleaved
  -z, --fastqz PATH               FASTQ file(s) of single-end reads
  -X, --dmfastqx PATH             Demultiplexed FASTQ files of mate 1 and mate
                                  2 reads
  -Y, --dmfastqy PATH             Demultiplexed FASTQ files of paired-end
                                  reads interleaved in one file
  -Z, --dmfastqz PATH             Demultiplexed FASTQ files of single-end
                                  reads
  --phred-enc INTEGER             Specify the Phred score encoding of FASTQ
                                  and SAM/BAM/CRAM files  [default: 33]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  --fastp / --no-fastp            Use fastp to QC, filter, and trim reads
                                  before alignment  [default: fastp]
  --fastp-5 / --no-fastp-5        Trim low-quality bases from the 5' ends of
                                  reads  [default: no-fastp-5]
  --fastp-3 / --no-fastp-3        Trim low-quality bases from the 3' ends of
                                  reads  [default: fastp-3]
  --fastp-w INTEGER               Use this window size (nt) for --fastp-5 and
                                  --fastp-3  [default: 6]
  --fastp-m INTEGER               Use this mean quality threshold for
                                  --fastp-5 and --fastp-3  [default: 25]
  --fastp-poly-g [yes|no|auto]    Trim poly(G) tails (two-color sequencing
                                  artifacts) from the 3' end  [default: auto]
  --fastp-poly-g-min-len INTEGER  Minimum number of Gs to consider a poly(G)
                                  tail for --fastp-poly-g  [default: 10]
  --fastp-poly-x / --no-fastp-poly-x
                                  Trim poly(X) tails (i.e. of any nucleotide)
                                  from the 3' end  [default: no-fastp-poly-x]
  --fastp-poly-x-min-len INTEGER  Minimum number of bases to consider a
                                  poly(X) tail for --fastp-poly-x  [default:
                                  10]
  --fastp-adapter-trimming / --no-fastp-adapter-trimming
                                  Trim adapter sequences from the 3' ends of
                                  reads  [default: fastp-adapter-trimming]
  --fastp-adapter-1 TEXT          Trim this adapter sequence from the 3' ends
                                  of read 1s  [default: ""]
  --fastp-adapter-2 TEXT          Trim this adapter sequence from the 3' ends
                                  of read 2s  [default: ""]
  --fastp-adapter-fasta FILE      Trim adapter sequences in this FASTA file
                                  from the 3' ends of reads
  --fastp-detect-adapter-for-pe / --no-fastp-detect-adapter-for-pe
                                  Automatically detect the adapter sequences
                                  for paired-end reads  [default: fastp-
                                  detect-adapter-for-pe]
  --fastp-min-length INTEGER      Discard reads shorter than this length
                                  [default: 9]
  --bt2-local / --bt2-end-to-end  Align reads in local mode rather than end-
                                  to-end mode  [default: bt2-local]
  --bt2-discordant / --bt2-no-discordant
                                  Output paired-end reads whose mates align
                                  discordantly  [default: bt2-no-discordant]
  --bt2-mixed / --bt2-no-mixed    Attempt to align individual mates of pairs
                                  that fail to align  [default: bt2-no-mixed]
  --bt2-dovetail / --bt2-no-dovetail
                                  Consider dovetailed mate pairs to align
                                  concordantly  [default: bt2-no-dovetail]
  --bt2-contain / --bt2-no-contain
                                  Consider nested mate pairs to align
                                  concordantly  [default: bt2-contain]
  --bt2-I INTEGER                 Discard paired-end alignments shorter than
                                  this many bases  [default: 0]
  --bt2-X INTEGER                 Discard paired-end alignments longer than
                                  this many bases  [default: 600]
  --bt2-score-min-e2e TEXT        Discard alignments that score below this
                                  threshold in end-to-end mode  [default:
                                  L,-1,-0.8]
  --bt2-score-min-loc TEXT        Discard alignments that score below this
                                  threshold in local mode  [default: L,1,0.8]
  --bt2-i TEXT                    Seed Bowtie2 alignments at this interval
                                  [default: L,1,0.1]
  --bt2-L INTEGER                 Use this seed length for Bowtie2  [default:
                                  20]
  --bt2-gbar INTEGER              Do not place gaps within this many bases
                                  from the end of a read  [default: 4]
  --bt2-D INTEGER                 Discard alignments if over this many
                                  consecutive seed extensions fail  [default:
                                  4]
  --bt2-R INTEGER                 Re-seed reads with repetitive seeds up to
                                  this many times  [default: 2]
  --bt2-dpad INTEGER              Pad the alignment matrix with this many
                                  bases (to allow gaps)  [default: 2]
  --bt2-orient [fr|rf|ff]         Require paired mates to have this
                                  orientation  [default: fr]
  --bt2-un / --bt2-no-un          Output unaligned reads to a FASTQ file
                                  [default: bt2-un]
  --min-mapq INTEGER              Discard reads with mapping qualities below
                                  this threshold  [default: 25]
  -N, --min-reads INTEGER         Discard alignment maps with fewer than this
                                  many reads  [default: 1000]
  --sep-strands / --mix-strands   Separate each alignment map into forward-
                                  and reverse-strand reads  [default: mix-
                                  strands]
  --f1r2-fwd / --f1r2-rev         With --sep-strands, consider forward mate 1s
                                  and reverse mate 2s to be forward-stranded
                                  [default: f1r2-rev]
  --rev-label TEXT                With --sep-strands, add this label to each
                                  reverse-strand reference  [default: -rev]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_relate

### Tool Description
Compute relationships between references and aligned reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic relate [OPTIONS] FASTA [INPUT_PATH]...

  Compute relationships between references and aligned reads.

Options:
  --sep-strands / --mix-strands   Separate each alignment map into forward-
                                  and reverse-strand reads  [default: mix-
                                  strands]
  --rev-label TEXT                With --sep-strands, add this label to each
                                  reverse-strand reference  [default: -rev]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  --min-mapq INTEGER              Discard reads with mapping qualities below
                                  this threshold  [default: 25]
  --phred-enc INTEGER             Specify the Phred score encoding of FASTQ
                                  and SAM/BAM/CRAM files  [default: 33]
  --min-phred INTEGER             Mark base calls with Phred scores lower than
                                  this threshold as ambiguous  [default: 25]
  -N, --min-reads INTEGER         Discard alignment maps with fewer than this
                                  many reads  [default: 1000]
  --batch-size INTEGER            Limit batches to at most this many reads
                                  [default: 65536]
  --insert3 / --insert5           Mark each insertion on the base to its 3'
                                  (True) or 5' (False) side  [default:
                                  insert3]
  --ambindel / --no-ambindel      Mark all ambiguous insertions and deletions
                                  (indels)  [default: ambindel]
  --overhangs / --no-overhangs    Retain the overhangs of paired-end mates
                                  that dovetail  [default: overhangs]
  -5, --clip-end5 INTEGER         Clip this many bases from the 5' end of each
                                  read  [default: 4]
  -3, --clip-end3 INTEGER         Clip this many bases from the 3' end of each
                                  read  [default: 4]
  --brotli-level INTEGER          Compress pickle files with this level of
                                  Brotli (0 - 11)  [default: 10]
  --write-read-names / --no-write-read-names
                                  Write the name of each read in a second set
                                  of batches (necessary for the options
                                  --mask-read or --mask-read-file)  [default:
                                  no-write-read-names]
  --relate-pos-table / --no-relate-pos-table
                                  Tabulate relationships per position for
                                  relate data  [default: relate-pos-table]
  --relate-read-table / --no-relate-read-table
                                  Tabulate relationships per read for relate
                                  data  [default: no-relate-read-table]
  --relate-cx / --relate-py       Use a fast (C extension module) version of
                                  the relate algorithm; the slow (Python)
                                  version is still avilable as a fallback if
                                  the C extension cannot be loaded, and for
                                  debugging/benchmarking  [default: relate-cx]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_pool

### Tool Description
Merge samples (vertically) from the Relate step.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic pool [OPTIONS] [INPUT_PATH]...

  Merge samples (vertically) from the Relate step.

Options:
  -p, --pooled TEXT               Pooled sample name  [default: ""]
  --relate-pos-table / --no-relate-pos-table
                                  Tabulate relationships per position for
                                  relate data  [default: relate-pos-table]
  --relate-read-table / --no-relate-read-table
                                  Tabulate relationships per read for relate
                                  data  [default: no-relate-read-table]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_mask

### Tool Description
Define mutations and regions to filter reads and positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic mask [OPTIONS] [INPUT_PATH]...

  Define mutations and regions to filter reads and positions.

Options:
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  -c, --mask-coords <TEXT INTEGER INTEGER>...
                                  Select a region of a reference given its 5'
                                  and 3' end coordinates
  -P, --mask-primers <TEXT DNA DNA>...
                                  Select a region of a reference given its
                                  forward and reverse primers
  --primer-gap INTEGER            Leave a gap of this many bases between the
                                  primer and the region  [default: 0]
  -i, --mask-regions-file FILE    Select regions of references from
                                  coordinates/primers in a CSV file
  --mask-del / --keep-del         Mask deletions  [default: mask-del]
  --mask-ins / --keep-ins         Mask insertions  [default: mask-ins]
  --mask-mut TEXT                 Mask this type of mutation
  --count-mut TEXT                Count only this type of mutation
  --mask-polya INTEGER            Mask stretches of at least this many
                                  consecutive A bases (0 disables)  [default:
                                  5]
  --mask-gu / --keep-gu           Mask G and U bases  [default: mask-gu]
  --mask-pos <TEXT INTEGER>...    Mask this position in this reference
  --mask-pos-file PATH            Mask positions in references from a file
  --min-ninfo-pos INTEGER         Mask positions with fewer than this many
                                  informative base calls  [default: 1000]
  --max-fmut-pos FLOAT            Mask positions with more than this fraction
                                  of mutated base calls  [default: 1.0]
  --mask-read TEXT                Mask the read with this name
  --mask-read-file PATH           Mask the reads with names in this file
  --mask-discontig / --keep-discontig
                                  Mask paired-end reads with discontiguous
                                  mates  [default: mask-discontig]
  --min-ncov-read INTEGER         Mask reads with fewer than this many bases
                                  covering the region  [default: 1]
  --min-finfo-read FLOAT          Mask reads with less than this fraction of
                                  informative base calls  [default: 0.95]
  --max-fmut-read FLOAT           Mask reads with more than this fraction of
                                  mutated base calls  [default: 1.0]
  --min-mut-gap INTEGER           Mask reads with two mutations separated by
                                  fewer than this many bases  [default: 4]
  --quick-unbias / --exact-unbias
                                  Correct observer bias using a quick
                                  (typically linear time) heuristic  [default:
                                  quick-unbias]
  --quick-unbias-thresh FLOAT     Treat mutated fractions under this threshold
                                  as 0 with --quick-unbias  [default: 0.001]
  --max-mask-iter INTEGER         Stop masking after this many iterations (0
                                  for no limit)  [default: 0]
  --mask-pos-table / --no-mask-pos-table
                                  Tabulate relationships per position for mask
                                  data  [default: mask-pos-table]
  --mask-read-table / --no-mask-read-table
                                  Tabulate relationships per read for mask
                                  data  [default: mask-read-table]
  --brotli-level INTEGER          Compress pickle files with this level of
                                  Brotli (0 - 11)  [default: 10]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_cluster

### Tool Description
Infer structure ensembles by clustering reads' mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic cluster [OPTIONS] [INPUT_PATH]...

  Infer structure ensembles by clustering reads' mutations.

Options:
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  --min-clusters INTEGER          Start at this many clusters  [default: 1]
  -k, --max-clusters INTEGER      Stop at this many clusters (0 for no limit)
                                  [default: 0]
  -e, --min-em-runs INTEGER       Run EM (successfully) at least this number
                                  of times for each K  [default: 6]
  -E, --max-em-runs INTEGER       Run EM (successfully or not) at most this
                                  number of times for each K  [default: 30]
  --em-thresh FLOAT               Stop EM when the log likelihood increases by
                                  less than this threshold  [default: 0.37]
  --min-em-iter INTEGER           Run EM for at least this many iterations
                                  [default: 10]
  --max-em-iter INTEGER           Run EM for at most this many iterations
                                  [default: 500]
  --max-pearson-run FLOAT         Remove runs with two clusters more similar
                                  than this correlation  [default: 0.9]
  --min-marcd-run FLOAT           Remove runs with two clusters that differ by
                                  less than this MARCD  [default: 0.016]
  --max-arcd-vs-ens-avg FLOAT     Remove runs where a cluster differs by more
                                  than this ARCD from the ensemble average at
                                  any position  [default: 0.2]
  --max-gini-run FLOAT            Remove runs where any cluster's Gini
                                  coefficient exceeds this limit  [default:
                                  0.667]
  --jackpot / --no-jackpot        Calculate the jackpotting quotient to find
                                  over-represented reads  [default: jackpot]
  --jackpot-conf-level FLOAT      Confidence level for the jackpotting
                                  quotient confidence interval  [default:
                                  0.95]
  --max-jackpot-quotient FLOAT    Remove runs whose jackpotting quotient
                                  exceeds this limit  [default: 1.1]
  --max-loglike-vs-best FLOAT     Remove Ks with a log likelihood gap larger
                                  than this (0 for no limit)  [default: 0.0]
  --min-pearson-vs-best FLOAT     Remove Ks where every run has less than this
                                  correlation vs. the best  [default: 0.97]
  --max-marcd-vs-best FLOAT       Remove Ks where every run has more than this
                                  MARCD vs. the best  [default: 0.008]
  --try-all-ks / --stop-best-k    Try all numbers of clusters (Ks), even after
                                  finding the best number  [default: stop-
                                  best-k]
  --write-all-ks / --write-best-k
                                  Write all numbers of clusters (Ks), rather
                                  than only the best number  [default: write-
                                  best-k]
  --cluster-pos-table / --no-cluster-pos-table
                                  Tabulate relationships per position for
                                  cluster data  [default: cluster-pos-table]
  --cluster-abundance-table / --no-cluster-abundance-table
                                  Tabulate number of reads per cluster for
                                  cluster data  [default: cluster-abundance-
                                  table]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --brotli-level INTEGER          Compress pickle files with this level of
                                  Brotli (0 - 11)  [default: 10]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_table

### Tool Description
Tabulate counts of relationships per read and position.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic table [OPTIONS] [INPUT_PATH]...

  Tabulate counts of relationships per read and position.

Options:
  --relate-pos-table / --no-relate-pos-table
                                  Tabulate relationships per position for
                                  relate data  [default: relate-pos-table]
  --relate-read-table / --no-relate-read-table
                                  Tabulate relationships per read for relate
                                  data  [default: no-relate-read-table]
  --mask-pos-table / --no-mask-pos-table
                                  Tabulate relationships per position for mask
                                  data  [default: mask-pos-table]
  --mask-read-table / --no-mask-read-table
                                  Tabulate relationships per read for mask
                                  data  [default: mask-read-table]
  --cluster-pos-table / --no-cluster-pos-table
                                  Tabulate relationships per position for
                                  cluster data  [default: cluster-pos-table]
  --cluster-abundance-table / --no-cluster-abundance-table
                                  Tabulate number of reads per cluster for
                                  cluster data  [default: cluster-abundance-
                                  table]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_join

### Tool Description
Merge regions (horizontally) from the Mask or Cluster step.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic join [OPTIONS] [INPUT_PATH]...

  Merge regions (horizontally) from the Mask or Cluster step.

Options:
  -j, --joined TEXT               Name of the region formed by joining other
                                  regions  [default: ""]
  -J, --join-clusts FILE          Specify which clusters to join clusters
                                  using this CSV file
  --mask-pos-table / --no-mask-pos-table
                                  Tabulate relationships per position for mask
                                  data  [default: mask-pos-table]
  --mask-read-table / --no-mask-read-table
                                  Tabulate relationships per read for mask
                                  data  [default: mask-read-table]
  --cluster-pos-table / --no-cluster-pos-table
                                  Tabulate relationships per position for
                                  cluster data  [default: cluster-pos-table]
  --cluster-abundance-table / --no-cluster-abundance-table
                                  Tabulate number of reads per cluster for
                                  cluster data  [default: cluster-abundance-
                                  table]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_fold

### Tool Description
Predict RNA secondary structures using mutation rates.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic fold [OPTIONS] [INPUT_PATH]...

  Predict RNA secondary structures using mutation rates.

Options:
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  -f, --fold-regions-file FILE    Fold regions of references from
                                  coordinates/primers in a CSV file
  --fold-coords <TEXT INTEGER INTEGER>...
                                  Fold a region of a reference given its 5'
                                  and 3' end coordinates
  --fold-primers <TEXT DNA DNA>...
                                  Fold a region of a reference given its
                                  forward and reverse primers
  --fold-full / --fold-table      If no regions are specified, whether to
                                  default to the full region or to the table's
                                  region  [default: fold-full]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --fold-temp FLOAT               Predict structures at this temperature
                                  (Kelvin)  [default: 310.15]
  --fold-constraint FILE          Force bases to be paired/unpaired from a
                                  file of constraints
  --fold-md INTEGER               Limit base pair distances to this number of
                                  bases (0 for no limit)  [default: 0]
  --fold-mfe / --fold-sub         Predict only the minimum free energy (MFE)
                                  structure  [default: fold-sub]
  --fold-max INTEGER              Output at most this many structures
                                  (overriden by --fold-mfe)  [default: 20]
  --fold-percent FLOAT            Stop outputting structures when the %
                                  difference in energy exceeds this value
                                  (overriden by --fold-mfe)  [default: 20.0]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph

### Tool Description
Bar graph of relationships(s) per position (seismic graph profile).

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph profile [OPTIONS] [INPUT_PATH]...

  Bar graph of relationships(s) per position.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_export

### Tool Description
Export each sample to SEISMICgraph (https://seismicrna.org).

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic export [OPTIONS] [INPUT_PATH]...

  Export each sample to SEISMICgraph (https://seismicrna.org).

Options:
  -S, --samples-meta FILE     Add sample metadata from this CSV file to
                              exported results
  -R, --refs-meta FILE        Add reference metadata from this CSV file to
                              exported results
  --all-pos / --unmasked-pos  Export all positions (not just unmasked
                              positions)  [default: all-pos]
  --force / --no-force        Force all tasks to run, overwriting any existing
                              output files  [default: no-force]
  --num-cpus INTEGER          Use up to this many CPUs simultaneously
                              [default: 20]
  --help                      Show this message and exit.
```

## seismic-rna_seismic_list

### Tool Description
List positions to mask.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic list [OPTIONS] [INPUT_PATH]...

  List positions to mask.

Options:
  -b, --branch TEXT        Create a new branch of the workflow with this name
                           [default: ""]
  --min-ninfo-pos INTEGER  Mask positions with fewer than this many
                           informative base calls  [default: 1000]
  --max-fmut-pos FLOAT     Mask positions with more than this fraction of
                           mutated base calls  [default: 1.0]
  --force / --no-force     Force all tasks to run, overwriting any existing
                           output files  [default: no-force]
  --num-cpus INTEGER       Use up to this many CPUs simultaneously  [default:
                           20]
  --help                   Show this message and exit.
```

## seismic-rna_seismic_ensembles

### Tool Description
Infer independent structure ensembles along an entire RNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic ensembles [OPTIONS] [INPUT_PATH]...

  Infer independent structure ensembles along an entire RNA.

Options:
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  -c, --mask-coords <TEXT INTEGER INTEGER>...
                                  Select a region of a reference given its 5'
                                  and 3' end coordinates
  -P, --mask-primers <TEXT DNA DNA>...
                                  Select a region of a reference given its
                                  forward and reverse primers
  --primer-gap INTEGER            Leave a gap of this many bases between the
                                  primer and the region  [default: 0]
  -i, --mask-regions-file FILE    Select regions of references from
                                  coordinates/primers in a CSV file
  --mask-del / --keep-del         Mask deletions  [default: mask-del]
  --mask-ins / --keep-ins         Mask insertions  [default: mask-ins]
  --mask-mut TEXT                 Mask this type of mutation
  --count-mut TEXT                Count only this type of mutation
  --mask-polya INTEGER            Mask stretches of at least this many
                                  consecutive A bases (0 disables)  [default:
                                  5]
  --mask-gu / --keep-gu           Mask G and U bases  [default: mask-gu]
  --mask-pos <TEXT INTEGER>...    Mask this position in this reference
  --mask-pos-file PATH            Mask positions in references from a file
  --min-ninfo-pos INTEGER         Mask positions with fewer than this many
                                  informative base calls  [default: 1000]
  --max-fmut-pos FLOAT            Mask positions with more than this fraction
                                  of mutated base calls  [default: 1.0]
  --mask-read TEXT                Mask the read with this name
  --mask-read-file PATH           Mask the reads with names in this file
  --mask-discontig / --keep-discontig
                                  Mask paired-end reads with discontiguous
                                  mates  [default: mask-discontig]
  --min-ncov-read INTEGER         Mask reads with fewer than this many bases
                                  covering the region  [default: 1]
  --min-finfo-read FLOAT          Mask reads with less than this fraction of
                                  informative base calls  [default: 0.95]
  --max-fmut-read FLOAT           Mask reads with more than this fraction of
                                  mutated base calls  [default: 1.0]
  --min-mut-gap INTEGER           Mask reads with two mutations separated by
                                  fewer than this many bases  [default: 4]
  --quick-unbias / --exact-unbias
                                  Correct observer bias using a quick
                                  (typically linear time) heuristic  [default:
                                  quick-unbias]
  --quick-unbias-thresh FLOAT     Treat mutated fractions under this threshold
                                  as 0 with --quick-unbias  [default: 0.001]
  --max-mask-iter INTEGER         Stop masking after this many iterations (0
                                  for no limit)  [default: 0]
  --mask-pos-table / --no-mask-pos-table
                                  Tabulate relationships per position for mask
                                  data  [default: mask-pos-table]
  --mask-read-table / --no-mask-read-table
                                  Tabulate relationships per read for mask
                                  data  [default: mask-read-table]
  --brotli-level INTEGER          Compress pickle files with this level of
                                  Brotli (0 - 11)  [default: 10]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --min-clusters INTEGER          Start at this many clusters  [default: 1]
  -k, --max-clusters INTEGER      Stop at this many clusters (0 for no limit)
                                  [default: 0]
  -e, --min-em-runs INTEGER       Run EM (successfully) at least this number
                                  of times for each K  [default: 6]
  -E, --max-em-runs INTEGER       Run EM (successfully or not) at most this
                                  number of times for each K  [default: 30]
  --em-thresh FLOAT               Stop EM when the log likelihood increases by
                                  less than this threshold  [default: 0.37]
  --min-em-iter INTEGER           Run EM for at least this many iterations
                                  [default: 10]
  --max-em-iter INTEGER           Run EM for at most this many iterations
                                  [default: 500]
  --max-pearson-run FLOAT         Remove runs with two clusters more similar
                                  than this correlation  [default: 0.9]
  --min-marcd-run FLOAT           Remove runs with two clusters that differ by
                                  less than this MARCD  [default: 0.016]
  --max-arcd-vs-ens-avg FLOAT     Remove runs where a cluster differs by more
                                  than this ARCD from the ensemble average at
                                  any position  [default: 0.2]
  --max-gini-run FLOAT            Remove runs where any cluster's Gini
                                  coefficient exceeds this limit  [default:
                                  0.667]
  --jackpot / --no-jackpot        Calculate the jackpotting quotient to find
                                  over-represented reads  [default: jackpot]
  --jackpot-conf-level FLOAT      Confidence level for the jackpotting
                                  quotient confidence interval  [default:
                                  0.95]
  --max-jackpot-quotient FLOAT    Remove runs whose jackpotting quotient
                                  exceeds this limit  [default: 1.1]
  --max-loglike-vs-best FLOAT     Remove Ks with a log likelihood gap larger
                                  than this (0 for no limit)  [default: 0.0]
  --min-pearson-vs-best FLOAT     Remove Ks where every run has less than this
                                  correlation vs. the best  [default: 0.97]
  --max-marcd-vs-best FLOAT       Remove Ks where every run has more than this
                                  MARCD vs. the best  [default: 0.008]
  --try-all-ks / --stop-best-k    Try all numbers of clusters (Ks), even after
                                  finding the best number  [default: stop-
                                  best-k]
  --write-all-ks / --write-best-k
                                  Write all numbers of clusters (Ks), rather
                                  than only the best number  [default: write-
                                  best-k]
  --cluster-pos-table / --no-cluster-pos-table
                                  Tabulate relationships per position for
                                  cluster data  [default: cluster-pos-table]
  --cluster-abundance-table / --no-cluster-abundance-table
                                  Tabulate number of reads per cluster for
                                  cluster data  [default: cluster-abundance-
                                  table]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  -L, --tile-length INTEGER       Make each tile this length (if 0, use 2x the
                                  median read length)  [default: 0]
  -O, --tile-min-overlap FLOAT    Make adjacent tiles overlap by at least this
                                  fraction of length  [default: 0.5]
  --erase-tiles / --keep-tiles    Erase the mask reports/batches from the
                                  tiling step  [default: erase-tiles]
  --pair-fdr FLOAT                Find correlated pairs at this false
                                  discovery rate (FDR)  [default: 0.05]
  --min-pairs INTEGER             Cluster only the regions with at least this
                                  many correlated pairs  [default: 2]
  --min-cluster-length INTEGER    Cluster only the regions with at least this
                                  many positions  [default: 20]
  --max-cluster-length INTEGER    Cluster only the regions with no more than
                                  this many positions  [default: 1200]
  --gap-mode [omit|insert|expand]
                                  If there are gaps between regions to
                                  cluster, OMIT (do not cluster) the gaps,
                                  INSERT a new region into each gap, or EXPAND
                                  the existing regions to fill the gaps
                                  [default: omit]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_draw

### Tool Description
Draw RNA structures with reactivities using RNArtistCore.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic draw [OPTIONS] [INPUT_PATH]...

  Draw RNA structures with reactivities using RNArtistCore.

Options:
  --struct-num INTEGER            Draw the specified structure (zero-indexed)
                                  or -1 for all structures. By default, draw
                                  the structure with the best AUROC.
  --color / --no-color            Color bases by their reactivity  [default:
                                  color]
  --draw-svg / --no-draw-svg      Output each drawing in a Scalable Vector
                                  Graphics file  [default: draw-svg]
  --draw-png / --no-draw-png      Output each drawing in a Portable Network
                                  Graphics file  [default: no-draw-png]
  --update-rnartistcore / --no-update-rnartistcore
                                  Check for and install updates to
                                  RNArtistCore.  [default: no-update-
                                  rnartistcore]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_ct2db

### Tool Description
Convert connectivity table (CT) to dot-bracket (DB) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic ct2db [OPTIONS] [INPUT_PATH]...

  Convert connectivity table (CT) to dot-bracket (DB) files.

Options:
  --force / --no-force  Force all tasks to run, overwriting any existing
                        output files  [default: no-force]
  --num-cpus INTEGER    Use up to this many CPUs simultaneously  [default: 20]
  --help                Show this message and exit.
```

## seismic-rna_seismic_db2ct

### Tool Description
Convert dot-bracket (DB) to connectivity table (CT) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic db2ct [OPTIONS] [INPUT_PATH]...

  Convert dot-bracket (DB) to connectivity table (CT) files.

Options:
  --force / --no-force  Force all tasks to run, overwriting any existing
                        output files  [default: no-force]
  --num-cpus INTEGER    Use up to this many CPUs simultaneously  [default: 20]
  --help                Show this message and exit.
```

## seismic-rna_seismic_renumct

### Tool Description
Renumber connectivity table (CT) files given a 5' position.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic renumct [OPTIONS]

  Renumber connectivity table (CT) files given a 5' position.

Options:
  -c, --ct-pos-5 <PATH INTEGER>...
                                  Connectivity table (CT) file or directory of
                                  CT files and the 5' position to assign to
                                  each file
  --inplace / --no-inplace        Modify files in-place instead of writing new
                                  files (CAUTION: you cannot recover the
                                  original files afterwards)  [default: no-
                                  inplace]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_cleanfa

### Tool Description
Clean the names and sequences in FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic cleanfa [OPTIONS] [INPUT_PATH]...

  Clean the names and sequences in FASTA files.

Options:
  --inplace / --no-inplace  Modify files in-place instead of writing new files
                            (CAUTION: you cannot recover the original files
                            afterwards)  [default: no-inplace]
  -o, --out-dir DIRECTORY   Write all output files to this directory
                            [default: ./out]
  --force / --no-force      Force all tasks to run, overwriting any existing
                            output files  [default: no-force]
  --num-cpus INTEGER        Use up to this many CPUs simultaneously  [default:
                            20]
  --help                    Show this message and exit.
```

## seismic-rna_seismic_splitbam

### Tool Description
Split a BAM file into one file for each reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic splitbam [OPTIONS] FASTA [INPUT_PATH]...

  Split a BAM file into one file for each reference.

Options:
  --phred-enc INTEGER             Specify the Phred score encoding of FASTQ
                                  and SAM/BAM/CRAM files  [default: 33]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  --bt2-local / --bt2-end-to-end  Align reads in local mode rather than end-
                                  to-end mode  [default: bt2-local]
  --bt2-discordant / --bt2-no-discordant
                                  Output paired-end reads whose mates align
                                  discordantly  [default: bt2-no-discordant]
  --bt2-mixed / --bt2-no-mixed    Attempt to align individual mates of pairs
                                  that fail to align  [default: bt2-no-mixed]
  --bt2-dovetail / --bt2-no-dovetail
                                  Consider dovetailed mate pairs to align
                                  concordantly  [default: bt2-no-dovetail]
  --bt2-contain / --bt2-no-contain
                                  Consider nested mate pairs to align
                                  concordantly  [default: bt2-contain]
  --bt2-I INTEGER                 Discard paired-end alignments shorter than
                                  this many bases  [default: 0]
  --bt2-X INTEGER                 Discard paired-end alignments longer than
                                  this many bases  [default: 600]
  --bt2-score-min-loc TEXT        Discard alignments that score below this
                                  threshold in local mode  [default: L,1,0.8]
  --bt2-score-min-e2e TEXT        Discard alignments that score below this
                                  threshold in end-to-end mode  [default:
                                  L,-1,-0.8]
  --bt2-i TEXT                    Seed Bowtie2 alignments at this interval
                                  [default: L,1,0.1]
  --bt2-L INTEGER                 Use this seed length for Bowtie2  [default:
                                  20]
  --bt2-D INTEGER                 Discard alignments if over this many
                                  consecutive seed extensions fail  [default:
                                  4]
  --bt2-R INTEGER                 Re-seed reads with repetitive seeds up to
                                  this many times  [default: 2]
  --bt2-gbar INTEGER              Do not place gaps within this many bases
                                  from the end of a read  [default: 4]
  --bt2-dpad INTEGER              Pad the alignment matrix with this many
                                  bases (to allow gaps)  [default: 2]
  --bt2-orient [fr|rf|ff]         Require paired mates to have this
                                  orientation  [default: fr]
  --min-mapq INTEGER              Discard reads with mapping qualities below
                                  this threshold  [default: 25]
  -N, --min-reads INTEGER         Discard alignment maps with fewer than this
                                  many reads  [default: 1000]
  --sep-strands / --mix-strands   Separate each alignment map into forward-
                                  and reverse-strand reads  [default: mix-
                                  strands]
  --f1r2-fwd / --f1r2-rev         With --sep-strands, consider forward mate 1s
                                  and reverse mate 2s to be forward-stranded
                                  [default: f1r2-rev]
  --rev-label TEXT                With --sep-strands, add this label to each
                                  reverse-strand reference  [default: -rev]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_migrate

### Tool Description
Migrate output directories from v0.23 to v0.24

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic migrate [OPTIONS] [INPUT_PATH]...

  Migrate output directories from v0.23 to v0.24

Options:
  -o, --out-dir DIRECTORY  Write all output files to this directory  [default:
                           ./out]
  --num-cpus INTEGER       Use up to this many CPUs simultaneously  [default:
                           20]
  --help                   Show this message and exit.
```

## seismic-rna_seismic_demult

### Tool Description
Split multiplexed FASTQ files by their barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic demult [OPTIONS] FASTA

  Split multiplexed FASTQ files by their barcodes.

Options:
  -x, --fastqx PATH               FASTQ files of paired-end reads with mates 1
                                  and 2 in separate files
  --phred-enc INTEGER             Specify the Phred score encoding of FASTQ
                                  and SAM/BAM/CRAM files  [default: 33]
  --barcode-start INTEGER         Index of start of barcode  [default: 0]
  --barcode-end INTEGER           Length of barcode  [default: 0]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  --parallel-demultiplexing BOOLEAN
                                  Whether to run demultiplexing at maximum
                                  speed by submitting multithreaded grep
                                  functions  [default: False]
  --clipped INTEGER               Designates the amount of clipped patterns to
                                  search for in the sample, will raise
                                  compution time  [default: 0]
  --mismatch-tolerence INTEGER    Designates the allowable amount of
                                  mismatches allowed in a string and still be
                                  considered a valid pattern find. will
                                  increase non-parallel computation at a
                                  factorial rate. use caution going above 2
                                  mismatches. does not apply to clipped
                                  sequences.  [default: 0]
  --index-tolerance INTEGER       Designates the allowable amount of distance
                                  you allow the pattern to be found in a read
                                  from the reference index  [default: 0]
  --demulti-overwrite BOOLEAN     Desiginates whether to overwrite the grepped
                                  fastq. should only be used if changing
                                  setting on the same sample  [default: False]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  -R, --refs-meta FILE            Add reference metadata from this CSV file to
                                  exported results
  --help                          Show this message and exit.
```

## seismic-rna_seismic_sim_abstract

### Tool Description
Abstract simulation parameters from existing datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim abstract [OPTIONS] [INPUT_PATH]...

  Abstract simulation parameters from existing datasets.

Options:
  --struct-file PATH              Compare mutational profiles to the
                                  structure(s) in this CT file
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_sim_clusts

### Tool Description
Simulate the proportions of 5' and 3' end coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim clusts [OPTIONS]

  Simulate the proportions of 5' and 3' end coordinates.

Options:
  -i, --ct-file FILE      Simulate parameters using the structure(s) in this
                          CT file
  -c, --clust-conc FLOAT  Set the concentration parameter for simulating
                          cluster proportions  [default: 0.0]
  --force / --no-force    Force all tasks to run, overwriting any existing
                          output files  [default: no-force]
  --num-cpus INTEGER      Use up to this many CPUs simultaneously  [default:
                          20]
  --help                  Show this message and exit.
```

## seismic-rna_seismic_sim_ends

### Tool Description
Simulate the proportions of 5' and 3' end coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim ends [OPTIONS]

  Simulate the proportions of 5' and 3' end coordinates.

Options:
  -i, --ct-file FILE    Simulate parameters using the structure(s) in this CT
                        file
  --center-fmean FLOAT  Set the mean read center as a fraction of the region
                        length  [default: 0.5]
  --center-fvar FLOAT   Set the variance of the read center as a fraction of
                        its maximum  [default: 0.3333333333333333]
  --length-fmean FLOAT  Set the mean read length as a fraction of the region
                        length  [default: 0.5]
  --length-fvar FLOAT   Set the variance of the read length as a fraction of
                        its maximum  [default: 0.012345679012345678]
  --force / --no-force  Force all tasks to run, overwriting any existing
                        output files  [default: no-force]
  --num-cpus INTEGER    Use up to this many CPUs simultaneously  [default: 20]
  --help                Show this message and exit.
```

## seismic-rna_seismic_sim_muts

### Tool Description
Simulate the rate of each kind of mutation at each position.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim muts [OPTIONS]

  Simulate the rate of each kind of mutation at each position.

Options:
  -i, --ct-file FILE              Simulate parameters using the structure(s)
                                  in this CT file
  -p, --pmut-paired <TEXT FLOAT>...
                                  Set the mean rate of each kind of mutation
                                  for paired bases
  -u, --pmut-unpaired <TEXT FLOAT>...
                                  Set the mean rate of each kind of mutation
                                  for unpaired bases
  -v, --vmut-paired FLOAT         Set the relative variance of mutation rates
                                  of paired bases  [default: 0.001]
  -w, --vmut-unpaired FLOAT       Set the relative variance of mutation rates
                                  of unpaired bases  [default: 0.02]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_sim_params

### Tool Description
Simulate parameter files.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim params [OPTIONS]

  Simulate parameter files.

Options:
  -i, --ct-file FILE              Simulate parameters using the structure(s)
                                  in this CT file
  -c, --clust-conc FLOAT          Set the concentration parameter for
                                  simulating cluster proportions  [default:
                                  0.0]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --center-fmean FLOAT            Set the mean read center as a fraction of
                                  the region length  [default: 0.5]
  --center-fvar FLOAT             Set the variance of the read center as a
                                  fraction of its maximum  [default:
                                  0.3333333333333333]
  --length-fmean FLOAT            Set the mean read length as a fraction of
                                  the region length  [default: 0.5]
  --length-fvar FLOAT             Set the variance of the read length as a
                                  fraction of its maximum  [default:
                                  0.012345679012345678]
  -p, --pmut-paired <TEXT FLOAT>...
                                  Set the mean rate of each kind of mutation
                                  for paired bases
  -u, --pmut-unpaired <TEXT FLOAT>...
                                  Set the mean rate of each kind of mutation
                                  for unpaired bases
  -v, --vmut-paired FLOAT         Set the relative variance of mutation rates
                                  of paired bases  [default: 0.001]
  -w, --vmut-unpaired FLOAT       Set the relative variance of mutation rates
                                  of unpaired bases  [default: 0.02]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_sim_fastq

### Tool Description
Simulate a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim fastq [OPTIONS] [INPUT_PATH]...

  Simulate a FASTQ file.

Options:
  -d, --param-dir DIRECTORY    Simulate data using parameter files in this
                               directory
  -P, --profile-name TEXT      Give the simulated structure and parameters
                               this profile name  [default: simulated]
  -s, --sample TEXT            Give this name to the simulated sample
                               [default: sim-sample]
  --paired-end / --single-end  Simulate paired-end or single-end reads
                               [default: paired-end]
  --read-length INTEGER        Simulate reads with this many base calls
                               [default: 151]
  --reverse-fraction FLOAT     Simulate this fraction of reverse-oriented
                               reads  [default: 0.5]
  --min-mut-gap INTEGER        Mask reads with two mutations separated by
                               fewer than this many bases  [default: 4]
  --fq-gzip / --fq-text        Simulate FASTQ files with gzip compression or
                               as plain text  [default: fq-gzip]
  -n, --num-reads INTEGER      Simulate this many reads  [default: 65536]
  --num-cpus INTEGER           Use up to this many CPUs simultaneously
                               [default: 20]
  --force / --no-force         Force all tasks to run, overwriting any
                               existing output files  [default: no-force]
  --help                       Show this message and exit.
```

## seismic-rna_seismic_sim_relate

### Tool Description
Simulate a Relate dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim relate [OPTIONS]

  Simulate a Relate dataset.

Options:
  -d, --param-dir DIRECTORY       Simulate data using parameter files in this
                                  directory
  -P, --profile-name TEXT         Give the simulated structure and parameters
                                  this profile name  [default: simulated]
  -s, --sample TEXT               Give this name to the simulated sample
                                  [default: sim-sample]
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  --paired-end / --single-end     Simulate paired-end or single-end reads
                                  [default: paired-end]
  --read-length INTEGER           Simulate reads with this many base calls
                                  [default: 151]
  --reverse-fraction FLOAT        Simulate this fraction of reverse-oriented
                                  reads  [default: 0.5]
  --min-mut-gap INTEGER           Mask reads with two mutations separated by
                                  fewer than this many bases  [default: 4]
  -n, --num-reads INTEGER         Simulate this many reads  [default: 65536]
  --batch-size INTEGER            Limit batches to at most this many reads
                                  [default: 65536]
  --write-read-names / --no-write-read-names
                                  Write the name of each read in a second set
                                  of batches (necessary for the options
                                  --mask-read or --mask-read-file)  [default:
                                  no-write-read-names]
  --brotli-level INTEGER          Compress pickle files with this level of
                                  Brotli (0 - 11)  [default: 10]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_sim_ref

### Tool Description
Simulate a FASTA file of a reference sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim ref [OPTIONS]

  Simulate a FASTA file of a reference sequence.

Options:
  -o, --sim-dir DIRECTORY  Write all simulated files to this directory
                           [default: ./sim]
  -R, --refs TEXT          Give this name to the file of simulated references
                           [default: sim-refs]
  -r, --ref TEXT           Give this name to the simulated reference
                           [default: sim-ref]
  -N, --reflen INTEGER     Simulate a reference sequence with this many bases
                           [default: 280]
  --force / --no-force     Force all tasks to run, overwriting any existing
                           output files  [default: no-force]
  --help                   Show this message and exit.
```

## seismic-rna_seismic_sim_fold

### Tool Description
Simulate secondary structure(s) a reference sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim fold [OPTIONS] FASTA

  Simulate secondary structure(s) a reference sequence.

Options:
  -o, --sim-dir DIRECTORY         Write all simulated files to this directory
                                  [default: ./sim]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  -P, --profile-name TEXT         Give the simulated structure and parameters
                                  this profile name  [default: simulated]
  -f, --fold-regions-file FILE    Fold regions of references from
                                  coordinates/primers in a CSV file
  --fold-coords <TEXT INTEGER INTEGER>...
                                  Fold a region of a reference given its 5'
                                  and 3' end coordinates
  --fold-primers <TEXT DNA DNA>...
                                  Fold a region of a reference given its
                                  forward and reverse primers
  --fold-constraint FILE          Force bases to be paired/unpaired from a
                                  file of constraints
  --fold-temp FLOAT               Predict structures at this temperature
                                  (Kelvin)  [default: 310.15]
  --fold-md INTEGER               Limit base pair distances to this number of
                                  bases (0 for no limit)  [default: 0]
  --fold-mfe / --fold-sub         Predict only the minimum free energy (MFE)
                                  structure  [default: fold-sub]
  --fold-max INTEGER              Output at most this many structures
                                  (overriden by --fold-mfe)  [default: 20]
  --fold-percent FLOAT            Stop outputting structures when the %
                                  difference in energy exceeds this value
                                  (overriden by --fold-mfe)  [default: 20.0]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_sim_total

### Tool Description
Simulate FASTQ files from scratch.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic sim total [OPTIONS]

  Simulate FASTQ files from scratch.

Options:
  -P, --profile-name TEXT         Give the simulated structure and parameters
                                  this profile name  [default: simulated]
  -s, --sample TEXT               Give this name to the simulated sample
                                  [default: sim-sample]
  --paired-end / --single-end     Simulate paired-end or single-end reads
                                  [default: paired-end]
  --read-length INTEGER           Simulate reads with this many base calls
                                  [default: 151]
  --reverse-fraction FLOAT        Simulate this fraction of reverse-oriented
                                  reads  [default: 0.5]
  --min-mut-gap INTEGER           Mask reads with two mutations separated by
                                  fewer than this many bases  [default: 4]
  --fq-gzip / --fq-text           Simulate FASTQ files with gzip compression
                                  or as plain text  [default: fq-gzip]
  -n, --num-reads INTEGER         Simulate this many reads  [default: 65536]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  -o, --sim-dir DIRECTORY         Write all simulated files to this directory
                                  [default: ./sim]
  -t, --tmp-pfx DIRECTORY         Write all temporary files to a directory
                                  with this prefix  [default: ./tmp]
  -f, --fold-regions-file FILE    Fold regions of references from
                                  coordinates/primers in a CSV file
  --fold-coords <TEXT INTEGER INTEGER>...
                                  Fold a region of a reference given its 5'
                                  and 3' end coordinates
  --fold-primers <TEXT DNA DNA>...
                                  Fold a region of a reference given its
                                  forward and reverse primers
  --fold-constraint FILE          Force bases to be paired/unpaired from a
                                  file of constraints
  --fold-temp FLOAT               Predict structures at this temperature
                                  (Kelvin)  [default: 310.15]
  --fold-md INTEGER               Limit base pair distances to this number of
                                  bases (0 for no limit)  [default: 0]
  --fold-mfe / --fold-sub         Predict only the minimum free energy (MFE)
                                  structure  [default: fold-sub]
  --fold-max INTEGER              Output at most this many structures
                                  (overriden by --fold-mfe)  [default: 20]
  --fold-percent FLOAT            Stop outputting structures when the %
                                  difference in energy exceeds this value
                                  (overriden by --fold-mfe)  [default: 20.0]
  --keep-tmp / --erase-tmp        Keep temporary files after finishing
                                  [default: erase-tmp]
  -c, --clust-conc FLOAT          Set the concentration parameter for
                                  simulating cluster proportions  [default:
                                  0.0]
  --center-fmean FLOAT            Set the mean read center as a fraction of
                                  the region length  [default: 0.5]
  --center-fvar FLOAT             Set the variance of the read center as a
                                  fraction of its maximum  [default:
                                  0.3333333333333333]
  --length-fmean FLOAT            Set the mean read length as a fraction of
                                  the region length  [default: 0.5]
  --length-fvar FLOAT             Set the variance of the read length as a
                                  fraction of its maximum  [default:
                                  0.012345679012345678]
  -p, --pmut-paired <TEXT FLOAT>...
                                  Set the mean rate of each kind of mutation
                                  for paired bases
  -u, --pmut-unpaired <TEXT FLOAT>...
                                  Set the mean rate of each kind of mutation
                                  for unpaired bases
  -v, --vmut-paired FLOAT         Set the relative variance of mutation rates
                                  of paired bases  [default: 0.001]
  -w, --vmut-unpaired FLOAT       Set the relative variance of mutation rates
                                  of unpaired bases  [default: 0.02]
  -R, --refs TEXT                 Give this name to the file of simulated
                                  references  [default: sim-refs]
  -r, --ref TEXT                  Give this name to the simulated reference
                                  [default: sim-ref]
  -N, --reflen INTEGER            Simulate a reference sequence with this many
                                  bases  [default: 280]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_abundance

### Tool Description
Abundance of each cluster.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph abundance [OPTIONS] [INPUT_PATH]...

  Abundance of each cluster.

Options:
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_aucroll

### Tool Description
Rolling AUC-ROC comparing a profile to a structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph aucroll [OPTIONS] [INPUT_PATH]...

  Rolling AUC-ROC comparing a profile to a structure.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --struct-file PATH              Compare mutational profiles to the
                                  structure(s) in this CT file
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  -f, --fold-regions-file FILE    Fold regions of references from
                                  coordinates/primers in a CSV file
  --fold-coords <TEXT INTEGER INTEGER>...
                                  Fold a region of a reference given its 5'
                                  and 3' end coordinates
  --fold-primers <TEXT DNA DNA>...
                                  Fold a region of a reference given its
                                  forward and reverse primers
  --fold-full / --fold-table      If no regions are specified, whether to
                                  default to the full region or to the table's
                                  region  [default: fold-full]
  -w, --window INTEGER            Use a sliding window of this many bases
                                  [default: 45]
  -n, --winmin INTEGER            Mask sliding windows with fewer than this
                                  number of data  [default: 9]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_corroll

### Tool Description
Rolling correlation/comparison of two profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph corroll [OPTIONS] [INPUT_PATH]...

  Rolling correlation/comparison of two profiles.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  -w, --window INTEGER            Use a sliding window of this many bases
                                  [default: 45]
  -n, --winmin INTEGER            Mask sliding windows with fewer than this
                                  number of data  [default: 9]
  --comppair / --no-comppair      Compare every pair of table files  [default:
                                  comppair]
  --compself / --no-compself      Compare every table file with itself
                                  [default: no-compself]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  -m, --metric [marcd|pcc|scc|r2]
                                  Metric to compare mutation rates: 'pcc' =
                                  Pearson correlation coefficient (r), 'scc' =
                                  Spearman correlation coefficient (ρ), 'r2' =
                                  coefficient of determination (R²), 'marcd' =
                                  mean arcsine distance (MARCD)  [default:
                                  pcc]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_delprof

### Tool Description
Bar graph of differences between two profiles per position.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph delprof [OPTIONS] [INPUT_PATH]...

  Bar graph of differences between two profiles per position.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --comppair / --no-comppair      Compare every pair of table files  [default:
                                  comppair]
  --compself / --no-compself      Compare every table file with itself
                                  [default: no-compself]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_giniroll

### Tool Description
Rolling Gini coefficient.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph giniroll [OPTIONS] [INPUT_PATH]...

  Rolling Gini coefficient.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  -w, --window INTEGER            Use a sliding window of this many bases
                                  [default: 45]
  -n, --winmin INTEGER            Mask sliding windows with fewer than this
                                  number of data  [default: 9]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_histpos

### Tool Description
Histogram of relationship(s) per position.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph histpos [OPTIONS] [INPUT_PATH]...

  Histogram of relationship(s) per position.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --hist-bins INTEGER             Number of bins in each histogram; must be ≥
                                  1  [default: 10]
  --hist-margin FLOAT             Autofill margins of at most this width in
                                  histograms of ratios  [default: 0.1]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_histread

### Tool Description
Histogram of relationship(s) per read.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph histread [OPTIONS] [INPUT_PATH]...

  Histogram of relationship(s) per read.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --hist-bins INTEGER             Number of bins in each histogram; must be ≥
                                  1  [default: 10]
  --hist-margin FLOAT             Autofill margins of at most this width in
                                  histograms of ratios  [default: 0.1]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_mutdist

### Tool Description
Distance between the closest two mutations in each read.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph mutdist [OPTIONS] [INPUT_PATH]...

  Distance between the closest two mutations in each read.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --mutdist-null / --no-mutdist-null
                                  Include the null distribution of distances
                                  between mutations  [default: mutdist-null]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_poscorr

### Tool Description
Phi correlations between pairs of positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph poscorr [OPTIONS] [INPUT_PATH]...

  Phi correlations between pairs of positions.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_roc

### Tool Description
ROC curve comparing a profile to a structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph roc [OPTIONS] [INPUT_PATH]...

  ROC curve comparing a profile to a structure.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --struct-file PATH              Compare mutational profiles to the
                                  structure(s) in this CT file
  -b, --branch TEXT               Create a new branch of the workflow with
                                  this name  [default: ""]
  -f, --fold-regions-file FILE    Fold regions of references from
                                  coordinates/primers in a CSV file
  --fold-coords <TEXT INTEGER INTEGER>...
                                  Fold a region of a reference given its 5'
                                  and 3' end coordinates
  --fold-primers <TEXT DNA DNA>...
                                  Fold a region of a reference given its
                                  forward and reverse primers
  --fold-full / --fold-table      If no regions are specified, whether to
                                  default to the full region or to the table's
                                  region  [default: fold-full]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_scatter

### Tool Description
Scatter plot comparing two profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph scatter [OPTIONS] [INPUT_PATH]...

  Scatter plot comparing two profiles.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  --comppair / --no-comppair      Compare every pair of table files  [default:
                                  comppair]
  --compself / --no-compself      Compare every table file with itself
                                  [default: no-compself]
  -o, --out-dir DIRECTORY         Write all output files to this directory
                                  [default: ./out]
  -m, --metric [marcd|pcc|scc|r2]
                                  Metric to compare mutation rates: 'pcc' =
                                  Pearson correlation coefficient (r), 'scc' =
                                  Spearman correlation coefficient (ρ), 'r2' =
                                  coefficient of determination (R²), 'marcd' =
                                  mean arcsine distance (MARCD)  [default:
                                  pcc]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

## seismic-rna_seismic_graph_snrroll

### Tool Description
Rolling signal-to-noise ratio.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seismic graph snrroll [OPTIONS] [INPUT_PATH]...

  Rolling signal-to-noise ratio.

Options:
  --cgroup [c|k|a]                Put each Cluster in its own file, each K in
                                  its own file, or All clusters in one file
                                  [default: k]
  --verify-times / --no-verify-times
                                  Verify that report files from later steps
                                  have later timestamps  [default: verify-
                                  times]
  --use-ratio / --use-count       Graph ratios or counts  [default: use-ratio]
  -r, --rels TEXT                 Graph these relationship(s)  [default: m]
  -q, --quantile FLOAT            Normalize and winsorize ratios to this
                                  quantile (0.0 disables)  [default: 0.0]
  -w, --window INTEGER            Use a sliding window of this many bases
                                  [default: 45]
  -n, --winmin INTEGER            Mask sliding windows with fewer than this
                                  number of data  [default: 9]
  --csv / --no-csv                Output the data for each graph in a Comma-
                                  Separated Values file  [default: csv]
  --html / --no-html              Output each graph in an interactive
                                  HyperText Markup Language file  [default:
                                  html]
  --svg / --no-svg                Output each graph in a Scalable Vector
                                  Graphics file  [default: no-svg]
  --pdf / --no-pdf                Output each graph in a Portable Document
                                  Format file  [default: no-pdf]
  --png / --no-png                Output each graph in a Portable Network
                                  Graphics file  [default: no-png]
  --force / --no-force            Force all tasks to run, overwriting any
                                  existing output files  [default: no-force]
  --num-cpus INTEGER              Use up to this many CPUs simultaneously
                                  [default: 20]
  --help                          Show this message and exit.
```

