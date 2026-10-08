# find_differential_primers CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| find_differential_primers | Failed | image problem: the script crashes at its EMBOSS version check (Python 2 str() call) before any work, so no run can finish |

## find_differential_primers

### Tool Description
Design diagnostic PCR primers that amplify one group of genomes but not others.

### Metadata
- **Docker Image**: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
- **Homepage**: https://github.com/widdowquinn/find_differential_primers
- **Package**: https://anaconda.org/channels/bioconda/packages/find_differential_primers/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: find_differential_primers.py [options] arg

Options:
  -h, --help            show this help message and exit
  -i FILENAME, --infile=FILENAME
                        location of configuration file
  -o OUTDIR, --outdir=OUTDIR
                        directory for output files
  --numreturn=NUMRETURN
                        number of primers to find
  --hybridprobe         generate internal oligo as a hybridisation probe
  --filtergc3prime      allow no more than two GC at the 3` end of primers
  --single_product=SINGLE_PRODUCT
                        location of FASTA sequence file containing sequences
                        from which a sequence-specific primer must amplify
                        exactly one product.
  --prodigal=PRODIGAL_EXE
                        location of Prodigal executable
  --eprimer3=EPRIMER3_EXE
                        location of EMBOSS eprimer3 executable
  --blast_exe=BLAST_EXE
                        location of BLASTN/BLASTALL executable
  --blastdb=BLASTDB     location of BLAST database
  --useblast            use existing BLAST results
  --nocds               do not restrict primer prediction to CDS
  --noprodigal          do not carry out Prodigal prediction step
  --noprimer3           do not carry out ePrimer3 prediction step
  --noprimersearch      do not carry out PrimerSearch step
  --noclassify          do not carry out primer classification step
  --osize=OSIZE         optimal size for primer oligo
  --minsize=MINSIZE     minimum size for primer oligo
  --maxsize=MAXSIZE     maximum size for primer oligo
  --otm=OTM             optimal melting temperature for primer oligo
  --mintm=MINTM         minimum melting temperature for primer oligo
  --maxtm=MAXTM         maximum melting temperature for primer oligo
  --ogcpercent=OGCPERCENT
                        optimal %GC for primer oligo
  --mingc=MINGC         minimum %GC for primer oligo
  --maxgc=MAXGC         maximum %GC for primer oligo
  --psizeopt=PSIZEOPT   optimal size for amplified region
  --psizemin=PSIZEMIN   minimum size for amplified region
  --psizemax=PSIZEMAX   maximum size for amplified region
  --maxpolyx=MAXPOLYX   maximum run of repeated nucleotides in primer
  --mismatchpercent=MISMATCHPERCENT
                        allowed percentage mismatch in primersearch
  --oligoosize=OLIGOOSIZE
                        optimal size for internal oligo
  --oligominsize=OLIGOMINSIZE
                        minimum size for internal oligo
  --oligomaxsize=OLIGOMAXSIZE
                        maximum size for internal oligo
  --oligootm=OLIGOOTM   optimal melting temperature for internal oligo
  --oligomintm=OLIGOMINTM
                        minimum melting temperature for internal oligo
  --oligomaxtm=OLIGOMAXTM
                        maximum melting temperature for internal oligo
  --oligoogcpercent=OLIGOOGCPERCENT
                        optimal %GC for internal oligo
  --oligomingc=OLIGOMINGC
                        minimum %GC for internal oligo
  --oligomaxgc=OLIGOMAXGC
                        maximum %GC for internal oligo
  --oligomaxpolyx=OLIGOMAXPOLYX
                        maximum run of repeated nt in internal oligo
  --cpus=CPUS           number of CPUs to use in multiprocessing
  --sge                 use SGE job scheduler
  --clean               clean up old output files before running
  --cleanonly           clean up old output files and exit
  -l LOGFILE, --logfile=LOGFILE
                        script logfile location
  -v, --verbose         report progress to log
  --debug               report extra progress to log for debugging
  --keep_logs           store log files from each process
  --log_dir=LOG_DIR     store called process log files in this directory
```

## Metadata
- **Skill**: generated
