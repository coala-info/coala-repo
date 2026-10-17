# pyani CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyani_anib | Failed | tool bug: pyani anib raises NotImplementedError in this build (0.3.0-alpha) after fragmenting the genomes |
| pyani_aniblastall | Failed | tool bug: pyani aniblastall raises NotImplementedError in this build (0.3.0-alpha) |
| pyani_anim | PASS | 3 real Blochmannia genomes: ANI about 0.83, same values as the legacy script |
| pyani_average_nucleotide_identity | PASS | ANIm on 3 real genomes with heatmaps; identity table equals the pyani anim result |
| pyani_classify | PASS | result is written to the log only (this build writes nothing to the output folder); clique intervals reported |
| pyani_createdb | PASS | empty SQLite database with the pyani tables |
| pyani_download | Not completed | NCBI download hangs after listing the assembly (no genome after 10 minutes); --retries crashes with a type error |
| pyani_fastani | Failed | image problem: fastANI is not installed in the image, every comparison fails |
| pyani_genbank_get_genomes_by_taxon | Not completed | ran but downloaded nothing: current NCBI service reports the assembly NOT DOWNLOADED |
| pyani_index | PASS | labels, classes and md5 files for 3 real Blochmannia genomes match the repo test targets |
| pyani_plot | PASS | 11 plots as png and pdf for run 1 |
| pyani_report | PASS | tables and matrices match the run (identity 0.83); --formats html crashes because Jinja2 is missing in the image |

## pyani_anib

### Tool Description
Run ANIb (BLASTN+ based average nucleotide identity) on a directory of genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani anib [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                  [--version] [--citation] [--scheduler {multiprocessing,SGE}]
                  [--workers WORKERS] [--SGEgroupsize SGEGROUPSIZE]
                  [--SGEargs SGEARGS] [--jobprefix JOBPREFIX] [--name NAME]
                  [--classes CLASSES] [--labels LABELS] [--recovery] -i INDIR
                  -o OUTDIR [--dbpath DBPATH] [--blastn_exe BLASTN_EXE]
                  [--format_exe FORMAT_EXE] [--fragsize FRAGSIZE]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  --scheduler {multiprocessing,SGE}
                        Job scheduler (default multiprocessing, i.e. locally)
                        (default: multiprocessing)
  --workers WORKERS     Number of worker processes for multiprocessing
                        (default zero, meaning use all available cores)
                        (default: None)
  --SGEgroupsize SGEGROUPSIZE
                        Number of jobs to place in an SGE array group (default
                        10000) (default: 10000)
  --SGEargs SGEARGS     Additional arguments for qsub (default: None)
  --jobprefix JOBPREFIX
                        Prefix for SGE jobs (default PYANI). (default: PYANI)
  --name NAME           Provide a name to help identify the analysis run
                        (default: None)
  --classes CLASSES     Path to genome classes for the run (default: None)
  --labels LABELS       Path to genome labels for the run (default: None)
  --recovery            Recover comparison results for this run (default:
                        False)
  -i INDIR, --indir INDIR
                        input genome directory (default: None)
  -o OUTDIR, --outdir OUTDIR
                        output analysis results directory (default: None)
  --dbpath DBPATH       path to pyani database (default: .pyani/pyanidb)
  --blastn_exe BLASTN_EXE
                        path to blastn executable (default: blastn)
  --format_exe FORMAT_EXE
                        path to makeblastdb executable (default: makeblastdb)
  --fragsize FRAGSIZE   blastn query fragment size (default: 1020)
```

## pyani_aniblastall

### Tool Description
Run ANIblastall (legacy BLAST based average nucleotide identity) on a directory of genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani aniblastall [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                         [--version] [--citation]
                         [--scheduler {multiprocessing,SGE}]
                         [--workers WORKERS] [--SGEgroupsize SGEGROUPSIZE]
                         [--SGEargs SGEARGS] [--jobprefix JOBPREFIX]
                         [--name NAME] [--classes CLASSES] [--labels LABELS]
                         [--recovery] -i INDIR -o OUTDIR

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  --scheduler {multiprocessing,SGE}
                        Job scheduler (default multiprocessing, i.e. locally)
                        (default: multiprocessing)
  --workers WORKERS     Number of worker processes for multiprocessing
                        (default zero, meaning use all available cores)
                        (default: None)
  --SGEgroupsize SGEGROUPSIZE
                        Number of jobs to place in an SGE array group (default
                        10000) (default: 10000)
  --SGEargs SGEARGS     Additional arguments for qsub (default: None)
  --jobprefix JOBPREFIX
                        Prefix for SGE jobs (default PYANI). (default: PYANI)
  --name NAME           Provide a name to help identify the analysis run
                        (default: None)
  --classes CLASSES     Path to genome classes for the run (default: None)
  --labels LABELS       Path to genome labels for the run (default: None)
  --recovery            Recover comparison results for this run (default:
                        False)
  -i INDIR, --indir INDIR
                        input genome directory (default: None)
  -o OUTDIR, --outdir OUTDIR
                        output analysis results directory (default: None)
```

## pyani_anim

### Tool Description
Run ANIm (nucmer based average nucleotide identity) on a directory of genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani anim [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                  [--version] [--citation] [--scheduler {multiprocessing,SGE}]
                  [--workers WORKERS] [--SGEgroupsize SGEGROUPSIZE]
                  [--SGEargs SGEARGS] [--jobprefix JOBPREFIX] [--name NAME]
                  [--classes CLASSES] [--labels LABELS] [--recovery] -i INDIR
                  -o OUTDIR [--dbpath DBPATH] [--nucmer_exe NUCMER_EXE]
                  [--filter_exe FILTER_EXE] [--maxmatch] [--nofilter]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  --scheduler {multiprocessing,SGE}
                        Job scheduler (default multiprocessing, i.e. locally)
                        (default: multiprocessing)
  --workers WORKERS     Number of worker processes for multiprocessing
                        (default zero, meaning use all available cores)
                        (default: None)
  --SGEgroupsize SGEGROUPSIZE
                        Number of jobs to place in an SGE array group (default
                        10000) (default: 10000)
  --SGEargs SGEARGS     Additional arguments for qsub (default: None)
  --jobprefix JOBPREFIX
                        Prefix for SGE jobs (default PYANI). (default: PYANI)
  --name NAME           Provide a name to help identify the analysis run
                        (default: None)
  --classes CLASSES     Path to genome classes for the run (default: None)
  --labels LABELS       Path to genome labels for the run (default: None)
  --recovery            Recover comparison results for this run (default:
                        False)
  -i INDIR, --indir INDIR
                        input genome directory (default: None)
  -o OUTDIR, --outdir OUTDIR
                        output analysis results directory (default: None)
  --dbpath DBPATH       path to pyani database (default: .pyani/pyanidb)
  --nucmer_exe NUCMER_EXE
                        path to NUCmer executable (default: nucmer)
  --filter_exe FILTER_EXE
                        path to delta-filter executable (default: delta-
                        filter)
  --maxmatch            override MUMmer to allow all NUCmer matches (default:
                        False)
  --nofilter            do not use delta-filter for 1:1 NUCmer matches
                        (default: False)
```

## pyani_average_nucleotide_identity

### Tool Description
Calculate average nucleotide identity (ANIm, ANIb, ANIblastall or TETRA) for all genomes in a directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: average_nucleotide_identity.py [-h] [--version] -o OUTDIRNAME -i
                                      INDIRNAME [-v] [--debug] [-f]
                                      [-s FRAGSIZE] [-l LOGFILE]
                                      [--skip_nucmer] [--skip_blastn]
                                      [--noclobber] [--nocompress] [-g]
                                      [--gformat GFORMAT]
                                      [--gmethod {mpl,seaborn}]
                                      [--labels LABELS] [--classes CLASSES]
                                      [-m {ANIm,ANIb,ANIblastall,TETRA}]
                                      [--scheduler {multiprocessing,SGE}]
                                      [--workers WORKERS]
                                      [--SGEgroupsize SGEGROUPSIZE]
                                      [--SGEargs SGEARGS] [--maxmatch]
                                      [--nucmer_exe NUCMER_EXE]
                                      [--filter_exe FILTER_EXE]
                                      [--blastn_exe BLASTN_EXE]
                                      [--makeblastdb_exe MAKEBLASTDB_EXE]
                                      [--blastall_exe BLASTALL_EXE]
                                      [--formatdb_exe FORMATDB_EXE]
                                      [--write_excel] [--rerender]
                                      [--subsample SUBSAMPLE] [--seed SEED]
                                      [--jobprefix JOBPREFIX]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o OUTDIRNAME, --outdir OUTDIRNAME
                        Output directory (required)
  -i INDIRNAME, --indir INDIRNAME
                        Input directory name (required)
  -v, --verbose         Give verbose output
  --debug               Report debug messages
  -f, --force           Force file overwriting
  -s FRAGSIZE, --fragsize FRAGSIZE
                        Sequence fragment size for ANIb (default 1020)
  -l LOGFILE, --logfile LOGFILE
                        Logfile location
  --skip_nucmer         Skip NUCmer runs, for testing (e.g. if output already
                        present)
  --skip_blastn         Skip BLASTN runs, for testing (e.g. if output already
                        present)
  --noclobber           Don't nuke existing files
  --nocompress          Don't compress/delete the comparison output
  -g, --graphics        Generate heatmap of ANI
  --gformat GFORMAT     Graphics output format(s) [pdf|png|jpg|svg] (default
                        pdf,png,eps meaning three file formats)
  --gmethod {mpl,seaborn}
                        Graphics output method (default mpl)
  --labels LABELS       Path to file containing sequence labels
  --classes CLASSES     Path to file containing sequence classes
  -m {ANIm,ANIb,ANIblastall,TETRA}, --method {ANIm,ANIb,ANIblastall,TETRA}
                        ANI method (default ANIm)
  --scheduler {multiprocessing,SGE}
                        Job scheduler (default multiprocessing, i.e. locally)
  --workers WORKERS     Number of worker processes for multiprocessing
                        (default zero, meaning use all available cores)
  --SGEgroupsize SGEGROUPSIZE
                        Number of jobs to place in an SGE array group (default
                        10000)
  --SGEargs SGEARGS     Additional arguments for qsub
  --maxmatch            Override MUMmer to allow all NUCmer matches
  --nucmer_exe NUCMER_EXE
                        Path to NUCmer executable
  --filter_exe FILTER_EXE
                        Path to delta-filter executable
  --blastn_exe BLASTN_EXE
                        Path to BLASTN+ executable
  --makeblastdb_exe MAKEBLASTDB_EXE
                        Path to BLAST+ makeblastdb executable
  --blastall_exe BLASTALL_EXE
                        Path to BLASTALL executable
  --formatdb_exe FORMATDB_EXE
                        Path to BLAST formatdb executable
  --write_excel         Write Excel format output tables
  --rerender            Rerender graphics output without recalculation
  --subsample SUBSAMPLE
                        Subsample a percentage [0-1] or specific number (1-n)
                        of input sequences
  --seed SEED           Set random seed for reproducible subsampling.
  --jobprefix JOBPREFIX
                        Prefix for SGE jobs (default ANI).
```

## pyani_classify

### Tool Description
Classify genomes of a run into clusters by identity and coverage thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani classify [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                      [--version] [--citation] -o OUTDIR --run_id RUN_ID
                      [--dbpath DBPATH] [--cov_min COV_MIN] [--id_min ID_MIN]
                      [--min_id MIN_ID] [--max_id MAX_ID]
                      [--resolution RESOLUTION] [--show_all]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  -o OUTDIR, --outdir OUTDIR
                        output directory (default: None)
  --run_id RUN_ID       run ID to classify (default: None)
  --dbpath DBPATH       path to pyani database (default: .pyani/pyanidb)
  --cov_min COV_MIN     minimum %coverage for an edge (default: 0.5)
  --id_min ID_MIN       minimum %identity for an edge (default: 0.8)
  --min_id MIN_ID       minimum identity threshold to test (default: None)
  --max_id MAX_ID       maximum identity threshold to test (default: None)
  --resolution RESOLUTION
                        number of identity thresholds to test (default:
                        0.0001)
  --show_all            report all intervals in log (default: only intervals
                        where all subgraphs are k-complete (default: False)
```

## pyani_createdb

### Tool Description
Create an empty pyani SQLite database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani createdb [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                      [--version] [--citation] [--dbpath DBPATH] [-f]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  --dbpath DBPATH       path to pyani database (default: .pyani/pyanidb)
  -f, --force           force creation of new empty database (default: False)
```

## pyani_download

### Tool Description
Download genomes from NCBI by taxon ID.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani download [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                      [--version] [--citation] -o OUTDIR -t TAXON --email
                      EMAIL [--api_key API_KEYPATH] [--retries RETRIES]
                      [--batchsize BATCHSIZE] [--timeout TIMEOUT] [-f]
                      [--noclobber] [--labels LABELFNAME]
                      [--classes CLASSFNAME] [--kraken] [--dry-run]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  -o OUTDIR, --outdir OUTDIR
                        output directory (default: None)
  -t TAXON, --taxon TAXON
                        NCBI taxonomy IDs (required, comma-separated list)
                        (default: None)
  --email EMAIL         Email associated with NCBI queries (required)
                        (default: None)
  --api_key API_KEYPATH
                        Path to NCBI Entrez API key file (default:
                        ~/.ncbi/api_key)
  --retries RETRIES     Number of Entrez retry attempts per request (default:
                        20)
  --batchsize BATCHSIZE
                        Entrez record return batch size (default: 10000)
  --timeout TIMEOUT     Timeout for URL connection (s) (default: 10)
  -f, --force           Allow download to existing directory (default: False)
  --noclobber           Don't replace existing files (default: False)
  --labels LABELFNAME   Filename for labels file (default: labels.txt)
  --classes CLASSFNAME  Filename for classes file (default: classes.txt)
  --kraken              Modify downloaded sequence ID for Kraken (default:
                        False)
  --dry-run             Dry run only, do not download or overwrite. (default:
                        False)
```

## pyani_fastani

### Tool Description
Run fastANI based average nucleotide identity on a directory of genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani fastani [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                     [--version] [--citation]
                     [--scheduler {multiprocessing,SGE}] [--workers WORKERS]
                     [--SGEgroupsize SGEGROUPSIZE] [--SGEargs SGEARGS]
                     [--jobprefix JOBPREFIX] [--name NAME] [--classes CLASSES]
                     [--labels LABELS] [--recovery] -i INDIR -o OUTDIR
                     [--dbpath DBPATH] [--fastani_exe FASTANI_EXE]
                     [--kmer KMERSIZE] [--fragLen FRAGLEN] [-t THREADS]
                     [--minFraction MINFRACTION] [--matrix]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  --scheduler {multiprocessing,SGE}
                        Job scheduler (default multiprocessing, i.e. locally)
                        (default: multiprocessing)
  --workers WORKERS     Number of worker processes for multiprocessing
                        (default zero, meaning use all available cores)
                        (default: None)
  --SGEgroupsize SGEGROUPSIZE
                        Number of jobs to place in an SGE array group (default
                        10000) (default: 10000)
  --SGEargs SGEARGS     Additional arguments for qsub (default: None)
  --jobprefix JOBPREFIX
                        Prefix for SGE jobs (default PYANI). (default: PYANI)
  --name NAME           Provide a name to help identify the analysis run
                        (default: None)
  --classes CLASSES     Path to genome classes for the run (default: None)
  --labels LABELS       Path to genome labels for the run (default: None)
  --recovery            Recover comparison results for this run (default:
                        False)
  -i INDIR, --indir INDIR
                        input genome directory (default: None)
  -o OUTDIR, --outdir OUTDIR
                        output analysis results directory (default: None)
  --dbpath DBPATH       path to pyani database (default: .pyani/pyanidb)
  --fastani_exe FASTANI_EXE
                        path to fastani executable (default: fastANI)
  --kmer KMERSIZE       kmer size <= 16 (default: 16)
  --fragLen FRAGLEN     fragment length (default: 3000)
  -t THREADS, --threads THREADS
                        thread count for parallel execution (default: 1)
  --minFraction MINFRACTION
                        Minimum fraction of genome that must be shared for
                        trusting ANI. If reference and query genome size
                        differ, smaller one among the two is considered.
                        (default: 0.2)
  --matrix              Also output ANI values as lower triangular matrix
                        (format inspired from phylip). If enabled, you should
                        expect an output file with .matrix extension.
                        (default: False)
```

## pyani_genbank_get_genomes_by_taxon

### Tool Description
Download genomes of a taxon from NCBI GenBank (legacy pyani script).

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genbank_get_genomes_by_taxon.py [-h] -o OUTDIRNAME [-t TAXON] [-v]
                                       [--debug] [-f] [--noclobber]
                                       [-l LOGFILE] [--format FORMAT] --email
                                       EMAIL [--retries RETRIES]
                                       [--batchsize BATCHSIZE]
                                       [--timeout TIMEOUT]

options:
  -h, --help            show this help message and exit
  -o OUTDIRNAME, --outdir OUTDIRNAME
                        Output directory (required)
  -t TAXON, --taxon TAXON
                        NCBI taxonomy ID
  -v, --verbose         Give verbose output
  --debug               Report debugging output
  -f, --force           Force file overwriting
  --noclobber           Don't nuke existing files
  -l LOGFILE, --logfile LOGFILE
                        Logfile location
  --format FORMAT       Output file format [gbk|fasta]
  --email EMAIL         Email associated with NCBI queries (required)
  --retries RETRIES     Number of Entrez retry attempts per request.
  --batchsize BATCHSIZE
                        Entrez record return batch size
  --timeout TIMEOUT     Timeout for URL connection (s)
```

## pyani_index

### Tool Description
Index a directory of genome FASTA files: write labels, classes and checksum files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani index [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                   [--version] [--citation] -i INDIR [--labels LABELFNAME]
                   [--classes CLASSFNAME]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  -i INDIR, --indir INDIR
                        input directory (default: None)
  --labels LABELFNAME   Filename for labels file (default: labels.txt)
  --classes CLASSFNAME  Filename for classes file (default: classes.txt)
```

## pyani_plot

### Tool Description
Plot heatmaps and distributions for runs in a pyani database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani plot [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                  [--version] [--citation] -o OUTDIR --run_ids RUN_ID
                  [RUN_ID ...] [--dbpath DBPATH]
                  [--formats FORMAT [FORMAT ...]] [--method METHOD]
                  [--workers WORKERS]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  -o OUTDIR, --outdir OUTDIR
                        output directory (default: None)
  --run_ids RUN_ID [RUN_ID ...]
                        run IDs to plot (default: None)
  --dbpath DBPATH       path to pyani database (default: .pyani/pyanidb)
  --formats FORMAT [FORMAT ...]
                        graphics output format; options: (pdf, png, svg, jpg)
                        (default: ['png'])
  --method METHOD       graphics method to use for plotting; options (seaborn,
                        mpl, plotly) (default: seaborn)
  --workers WORKERS     Number of worker processes for multiprocessing
                        (default zero, meaning use all available cores)
                        (default: None)
```

## pyani_report

### Tool Description
Report tables from a pyani database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
- **Homepage**: https://github.com/widdowquinn/pyani
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyani report [-h] [-l LOGFILE] [-v] [--debug] [--disable_tqdm]
                    [--version] [--citation] -o OUTDIR [--dbpath DBPATH]
                    [--runs] [--genomes] [--runs_genomes] [--genomes_runs]
                    [--run_results RUN_ID [RUN_ID ...]]
                    [--run_matrices RUN_ID [RUN_ID ...]] [--no_matrix_labels]
                    [--formats FORMAT [FORMAT ...]]

options:
  -h, --help            show this help message and exit
  -l LOGFILE, --logfile LOGFILE
                        logfile location (default: None)
  -v, --verbose         report verbose progress to log (default: False)
  --debug               report debug messages to log (default: False)
  --disable_tqdm        Turn off tqdm progress bar (default: False)
  --version
  --citation
  -o OUTDIR, --outdir OUTDIR
                        output analysis results directory (default: None)
  --dbpath DBPATH       path to pyani database (default: .pyani/pyanidb)
  --runs                Report table of analysis runs in database (default:
                        False)
  --genomes             Report table of genomes in database (default: False)
  --runs_genomes        Report table of all genomes for each run in database
                        (default: False)
  --genomes_runs        Report table of all runs in which each genome in the
                        database participates (default: False)
  --run_results RUN_ID [RUN_ID ...]
                        Report table of results for space-separated list of
                        runs (default: None)
  --run_matrices RUN_ID [RUN_ID ...]
                        Report matrices of results for space-separated list of
                        runs (default: None)
  --no_matrix_labels    Turn off row/column labels in output matrix files
                        (default: False)
  --formats FORMAT [FORMAT ...]
                        Space-separated list of output formats (in addition to
                        .tab); possible values: {html, excel, stdout}
                        (default: None)
```

