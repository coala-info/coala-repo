# mtgrasp CWL Generation Report

## mtgrasp_mtgrasp.py

### Tool Description
de novo assembly of reference-grade animal mitochondrial genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/mtgrasp:1.1.8--py312h7e72e81_0
- **Homepage**: https://github.com/bcgsc/mtGrasp
- **Package**: https://anaconda.org/channels/bioconda/packages/mtgrasp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mtgrasp/overview
- **Total Downloads**: 108.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/mtGrasp
- **Stars**: N/A
### Original Help Text
```text
usage: mtgrasp.py [-h] [-r1 READ1] [-r2 READ2] [-o OUT_DIR] [-m MT_GEN]
                  [-r REF_PATH] [-t THREADS] [-k KMER] [-c KC]
                  [-p GAP_FILLING_P] [-b SEALER_K] [-sf END_RECOV_SEALER_FPR]
                  [-sk END_RECOV_SEALER_K] [-i END_RECOV_P]
                  [-ma MISMATCH_ALLOWED] [-sub SUBSAMPLE] [-nsub]
                  [-a ABYSS_FPR] [-s SEALER_FPR] [-mp MITOS_PATH] [-an] [-d]
                  [-v] [-u] [-n] [-test]

mtGrasp: de novo assembly of reference-grade animal mitochondrial genomes

options:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Full path to forward read fastq.gz file [Required]
  -r2 READ2, --read2 READ2
                        Full path to reverse read fastq.gz file [Required]
  -o OUT_DIR, --out_dir OUT_DIR
                        Output directory [Required]
  -m MT_GEN, --mt_gen MT_GEN
                        Mitochondrial genetic code [Required]
  -r REF_PATH, --ref_path REF_PATH
                        Full path to the reference fasta file [Required]
  -t THREADS, --threads THREADS
                        Number of threads [8]
  -k KMER, --kmer KMER  k-mer size used in ABySS de novo assembly [91]
  -c KC, --kc KC        minimum k-mer multiplicity for ABySS [3]
  -p GAP_FILLING_P, --gap_filling_p GAP_FILLING_P
                        Merge at most N alternate paths during sealer gap
                        filling step [5]
  -b SEALER_K, --sealer_k SEALER_K
                        k-mer size used in sealer gap filling [60,80,100,120]
  -sf END_RECOV_SEALER_FPR, --end_recov_sealer_fpr END_RECOV_SEALER_FPR
                        False positive rate for the Bloom filter used by
                        Sealer during flanking end recovery [0.01]
  -sk END_RECOV_SEALER_K, --end_recov_sealer_k END_RECOV_SEALER_K
                        k-mer size used in Sealer flanking end recovery
                        [60,80,100,120]
  -i END_RECOV_P, --end_recov_p END_RECOV_P
                        Merge at most N alternate paths during Sealer flanking
                        end recovery [5]
  -ma MISMATCH_ALLOWED, --mismatch_allowed MISMATCH_ALLOWED
                        Maximum number of mismatches allowed in overlaps
                        between the two ends of the mitochondrial assembly [1]
  -sub SUBSAMPLE, --subsample SUBSAMPLE
                        Subsample N read pairs from two paired FASTQ files
                        [2000000]
  -nsub, --nosubsample  Run mtGrasp using the entire read dataset without
                        subsampling [False]
  -a ABYSS_FPR, --abyss_fpr ABYSS_FPR
                        False positive rate for the Bloom filter used by ABySS
                        [0.005]
  -s SEALER_FPR, --sealer_fpr SEALER_FPR
                        False positive rate for the Bloom filter used by
                        Sealer during gap filling [0.01]
  -mp MITOS_PATH, --mitos_path MITOS_PATH
                        Complete path to runmitos.py
  -an, --annotate       Run gene annotation on the final assembly output
                        [False]
  -d, --delete          Delete intermediate subdirectories/files once mtGrasp
                        reaches completion [False]
  -v, --version         show program's version number and exit
  -u, --unlock          Remove a lock implemented by snakemake on the working
                        directory
  -n, --dry_run         Dry-run pipeline
  -test, --test_run     Test run mtGrasp to ensure all required dependencies
                        are installed
```


## mtgrasp_runmitos.py

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/mtgrasp:1.1.8--py312h7e72e81_0
- **Homepage**: https://github.com/bcgsc/mtGrasp
- **Package**: https://anaconda.org/channels/bioconda/packages/mtgrasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: runmitos.py [options]

options:
  -h, --help            show this help message and exit
  -i FILE, --input FILE
                        the input file
  --fasta FASTA         input fasta sequence

mandatory options:
  -c CODE, --code CODE  the genetic code
  -o OUTDIR, --outdir OUTDIR
                        the directory where the output is written.
  --linear              treat sequence as linear
  -r REFSEQVER, --refseqver REFSEQVER
                        directory containing the reference data (relative to
                        --refdir)

advanced options:
  -R REFDIR, --refdir REFDIR
                        base directory containing the reference data
  --prot PROT           position of protein prediction in 1st round (0: skip)
  --trna TRNA           position of tRNA prediction in 1st round (0: skip)
  --rrna RRNA           position of rRNA prediction in 1st round (0: skip)
  --intron INTRON       position of intron prediction in 1st round (0: skip)
  --oril ORIL           position of OL prediction in 1st round (0: skip)
  --orih ORIH           position of OH prediction in 1st round (0: skip)
  --finovl NRNT         final overlap <= NRNT nucleotides
  --circrot DEG         cir circular: rotate mitogenome by DEG and DEG+180
  --best                annotate only the best copy of each feature
  --fragfac FACTOR      allow fragments to differ in quality/evalue by at most
                        a factor FACTOR. Ignored if <= 0.
  --fragovl FRACTION    allow query range overlaps up for FRACTION for
                        fragments
  --noplots             do not create the plots.

protein prediction advanced options:
  --evalue EVL          discard BLAST hits with -1*log(e-value)<EVL (EVL < 1
                        has no effect)
  --cutoff fraction     discard positions with quality <.5 of max
  --clipfac FACTOR      overlapping features of the same name differing by at
                        most a factor of FACTOR are clipped
  --ncbicode            use start/stop codons as in NCBI (default: learned
                        start/stop codons)
  --alarab              Use the hmmer based method of Al Arab et al. 2016.
                        This will consider the evalue, ncbicode, fragovl,
                        fragfac
  --oldstst             Use the old start/stop prediction method of MITOS1

ArgumentParser(prog='runmitos.py', usage='%(prog)s [options]', description=None, formatter_class=<class 'argparse.HelpFormatter'>, conflict_handler='error', add_help=True):
  RNA prediction advanced options

  --locandgloc          run mitfi in glocal and local mode (default: local
                        only)
  --ncev NCEV           evalue to use for inferal fast mode
  --sensitive           use infernals sensitive mode only
  --maxtrnaovl NT       allow tRNA overlap of up to X nt for mitfi
  --maxrrnaovl NT       allow rRNA overlap of up to X nt for mitfi

debug/misc options:
  --debug               print debug output
  --zip                 create zip
  --json JSON           a JSON file with parameters. then outdir is the only
                        other argument needed.
  --version             show program's version number and exit
```

