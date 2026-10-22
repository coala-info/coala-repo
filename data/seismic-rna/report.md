# seismic-rna CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seismic-rna_seismic_align | PASS | synthetic data: seismic-rna tutorial amplicon reads made by seismic sim (two DMS replicates, HIV RRE); BAMs pass quickcheck, 92 percent of read pairs aligned |
| seismic-rna_seismic_cluster | PASS | synthetic data: tutorial amplicon reads; two clusters found with 73 and 27 percent of reads, as the tutorial expects |
| seismic-rna_seismic_export | PASS | synthetic data: tutorial amplicon reads; SEISMICgraph JSON written with the folded structure included |
| seismic-rna_seismic_fold | PASS | synthetic data: tutorial amplicon reads; MFE structure of 179 nt with balanced brackets (-163.2 kcal/mol) |
| seismic-rna_seismic_graph | PASS | synthetic data: tutorial amplicon reads; per-position mutation ratio CSV and HTML written (only seismic graph profile is wrapped) |
| seismic-rna_seismic_join | PASS | synthetic data: tutorial amplicon reads; regions 26-100 and 101-204 joined into 179 positions with the same mean mutation rate |
| seismic-rna_seismic_mask | PASS | synthetic data: tutorial amplicon reads; primer region 26-204 masked, G bases masked and A mutation rate about 8 percent |
| seismic-rna_seismic_pool | PASS | synthetic data: tutorial amplicon reads; pooled coverage and mutation counts equal the sum of the two samples |
| seismic-rna_seismic_relate | PASS | synthetic data: tutorial amplicon reads; relate tables written for both samples |
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

