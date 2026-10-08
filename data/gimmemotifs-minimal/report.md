# gimmemotifs-minimal CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gimmemotifs-minimal_background | PASS |  |
| gimmemotifs-minimal_cluster | PASS |  |
| gimmemotifs-minimal_diff | Failed | tool bug: gimme diff is wired to the logo command in cli.py, so it always crashes |
| gimmemotifs-minimal_location | PASS | works when the size option is given; without it the tool crashes (zip object is not subscriptable) |
| gimmemotifs-minimal_logo | PASS |  |
| gimmemotifs-minimal_maelstrom | PASS |  |
| gimmemotifs-minimal_match | PASS |  |
| gimmemotifs-minimal_motif2factors | Not completed | needs genome and annotation downloads for several assemblies; too heavy |
| gimmemotifs-minimal_motifs | PASS |  |
| gimmemotifs-minimal_prediction | PASS | works for MDmodule and found the AP-1 motif; the params file option crashes (PyYAML load needs a Loader) |
| gimmemotifs-minimal_scan | PASS |  |
| gimmemotifs-minimal_threshold | PASS |  |

## gimmemotifs-minimal_motifs

### Tool Description
Identify enriched motifs (known and/or de novo)

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] motifs [-h] [-b BACKGROUND]
                                                [-g GENOME] [--denovo]
                                                [--known] [--noreport]
                                                [--rawscore] [--nogc] [-N INT]
                                                [-p PFMFILE] [-t N]
                                                [-a ANALYSIS] [-k] [-S]
                                                [-f FRACTION] [-s N]
                                                INPUT OUTDIR

positional arguments:
  INPUT                 FASTA, BED, narrowPeak or region file.
  OUTDIR                Output directory.

optional arguments:
  -h, --help            show this help message and exit
  -b BACKGROUND, --background BACKGROUND
                        Background type (random,genomic,gc,promoter,custom) or
                        a file with background sequences (FASTA, BED or
                        regions)
  -g GENOME             Genome name or fasta file
  --denovo              Only use de novo motifs
  --known               Only use known motifs
  --noreport            Don't create a HTML report.
  --rawscore            Don't z-score normalize motif scores
  --nogc                Don't use GC% bins
  -N INT, --nthreads INT
                        Number of threads (default 12)

optional arguments for known motifs:
  -p PFMFILE            PFM file with motifs (default:
                        gimme.vertebrate.v5.0.pfm).

optional arguments for de novo motifs:
  -t N, --tools N       Tools to use, any combination of AMD,BioProspector,ChI
                        PMunk,HMS,Improbizer,MDmodule,MotifSampler,Posmo
                        (default BioProspector,Homer,MEME)
  -a ANALYSIS, --analysis ANALYSIS
                        Analysis type: small, medium, large, xl (xl)
  -k, --keepintermediate
                        Don't delete intermediate files
  -S, --singlestrand    Only predict motifs for single + strand (default is
                        both)
  -f FRACTION, --fraction FRACTION
                        Fraction of peaks to use for motif prediction set
                        (0.2).The rest is used as validation set.
  -s N, --size N        Region size to use for motif prediction (200). Set to
                        0 to use the size of the input regions.
```

## gimmemotifs-minimal_scan

### Tool Description
Scan for known motifs

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] scan [-h] [-g] [-p] [-f] [-B] [-c]
                                              [-n] [-r] [-b] [-t] [-T] [-z]
                                              [--gc] [-s] [-N]
                                              INPUTFILE

positional arguments:
  INPUTFILE          inputfile (FASTA, BED, regions)

optional arguments:
  -h, --help         show this help message and exit
  -g , --genome      Genome
  -p , --pfmfile     PFM file with motifs (default:
                     gimme.vertebrate.v5.0.pfm).
  -f , --fpr         FPR for motif scanning (default 0.01)
  -B , --bgfile      background file for threshold
  -c , --cutoff      motif score cutoff or file with cutoffs
  -n , --nreport     report the N best matches (default 1)
  -r, --norc         don't scan reverse complement (- strand)
  -b, --bed          output bed format
  -t, --table        output counts in tabular format
  -T, --score_table  output maximum score in tabular format
  -z, --zscore       convert pfm logodds score to z-score
  --gc               use GC frequency normalized z-score
  -s , --seed        set a random seed (default None)
  -N , --nthreads    Number of threads (default 12)
```

## gimmemotifs-minimal_maelstrom

### Tool Description
Find differential motifs

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] maelstrom [-h] [-p] [--no-filter]
                                                   [-F] [-m] [-a] [-s] [-N]
                                                   [--nocenter] [--rawscore]
                                                   [--nogc]
                                                   [--all-motif-plots]
                                                   [--no-motif-plots]
                                                   INPUTFILE GENOME DIR

positional arguments:
  INPUTFILE             file with regions and clusters
  GENOME                genome
  DIR                   output directory

optional arguments:
  -h, --help            show this help message and exit
  -p , --pfmfile        PFM file with motifs (default:
                        gimme.vertebrate.v5.0.pfm).
  --no-filter           Don't remove redundant motifs.
  -F , --filter_cutoff 
                        Cutoff to select non-redundant motifs. Default is 0.8,
                        increase this value to get fewer motifs.
  -m , --methods        Run with specific methods (default all)
  -a , --aggregation    How to combine motifs from individual methods. Default
                        is "int_stouffer", for inverse normal transform of
                        ranks, followed by Stouffer's method to combine
                        z-scores. Alternatively, specify "stuart" for log-
                        transformed rank aggregation p-values.
  -s , --seed           set a random seed (default None)
  -N , --nthreads       Number of threads (default 12)
  --nocenter            Don't mean-center the rows by default
  --rawscore            Don't z-score normalize motif scores
  --nogc                Don't use GC% bins
  --all-motif-plots     Specify to plot all motifs
  --no-motif-plots      Specify to plot no motifs
```

## gimmemotifs-minimal_match

### Tool Description
Find motif matches in database

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] match [-h] [-d DBFILE] [-n INT]
                                               [-o FILE]
                                               pfmfile

positional arguments:
  pfmfile     File with pfms

optional arguments:
  -h, --help  show this help message and exit
  -d DBFILE   File with pfms to match against (default:
              gimme.vertebrate.v5.0.pfm)
  -n INT      Number of matches to return (default 1)
  -o FILE     Output file with graphical report (png, svg, ps, pdf)
```

## gimmemotifs-minimal_logo

### Tool Description
Create sequence logo(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] logo [-h] [-p pfmfile] [-i IDS]
                                              [-k TYPE] [--notitle]

optional arguments:
  -h, --help            show this help message and exit
  -p pfmfile, --pfmfile pfmfile
                        PFM file with motifs
  -i IDS, --ids IDS     Comma-separated list of motif ids (default is all ids)
  -k TYPE, --kind TYPE  Type of motif (information, frequency, energy or
                        ensembl)
  --notitle             Don't include motif ID as title
```

## gimmemotifs-minimal_cluster

### Tool Description
Cluster similar motifs

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] cluster [-h] [-s] [-t THRESHOLD]
                                                 [-N INT]
                                                 INPUTFILE OUTDIR

positional arguments:
  INPUTFILE             Inputfile (PFM format)
  OUTDIR                Name of output directory

optional arguments:
  -h, --help            show this help message and exit
  -s                    Don't compare reverse complements of motifs
  -t THRESHOLD          Cluster threshold
  -N INT, --nthreads INT
                        Number of threads (default 12)
```

## gimmemotifs-minimal_background

### Tool Description
Create a background file

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] background [-h] [-i FILE] [-f TYPE]
                                                    [-s INT] [-n NUMBER]
                                                    [-g GENOME] [-m N]
                                                    FILE TYPE

positional arguments:
  FILE        outputfile
  TYPE        type of background sequences to generate
              (random,genomic,gc,promoter)

optional arguments:
  -h, --help  show this help message and exit
  -i FILE     input sequences (BED or FASTA)
  -f TYPE     output format (BED or FASTA
  -s INT      size of random sequences
  -n NUMBER   number of sequence to generate
  -g GENOME   genome version (not for type 'random')
  -m N        order of the Markov model (only for type 'random', default 1)
```

## gimmemotifs-minimal_threshold

### Tool Description
Calculate motif scan threshold

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] threshold [-h] pfmfile FAFILE FPR

positional arguments:
  pfmfile     File with pfms
  FAFILE      FASTA file with background sequences
  FPR         Desired fpr

optional arguments:
  -h, --help  show this help message and exit
```

## gimmemotifs-minimal_location

### Tool Description
Motif location histograms

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] location [-h] [-s INT] [-i IDS]
                                                  [-c CUTOFF]
                                                  pfmfile FAFILE

positional arguments:
  pfmfile     File with pfms
  FAFILE      Fasta formatted file

optional arguments:
  -h, --help  show this help message and exit
  -s INT      Set size to W (default: determined from fastafile)
  -i IDS      Comma-separated list of motif ids to plot (default is all ids)
  -c CUTOFF   Cutoff for motif scanning (default 0.95)
```

## gimmemotifs-minimal_diff

### Tool Description
Compare motif frequency and enrichment between fasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] diff [-h] [-p pfmfile] [-c]
                                              [-e MINENR] [-f MINFREQ]
                                              [-g GENOME]
                                              FAFILES BGFAFILE PNGFILE

positional arguments:
  FAFILES               FASTA-formatted inputfiles OR a BED file with an
                        identifier in the 4th column, for instance a cluster
                        number.
  BGFAFILE              FASTA-formatted background file
  PNGFILE               outputfile (image)

optional arguments:
  -h, --help            show this help message and exit
  -p pfmfile, --pfmfile pfmfile
                        PFM file with motifs (default:
                        gimme.vertebrate.v5.0.pfm).
  -c , --cutoff         motif score cutoff or file with cutoffs (default 0.9)
  -e MINENR, --enrichment MINENR
                        minimum enrichment in at least one of the datasets
                        compared to background
  -f MINFREQ, --frequency MINFREQ
                        minimum frequency in at least one of the datasets
  -g GENOME, --genome GENOME
                        Genome; only necessary in combination with a BED file
                        with clusters as inputfile.
```

## gimmemotifs-minimal_prediction

### Tool Description
Run a specific motif prediction tool

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] prediction [-h] [-p FILE]
                                                    NAME FILE FILE

positional arguments:
  NAME        Specific motif prediction tool to run
  FILE        Input FASTA file
  FILE        Output PFM file

optional arguments:
  -h, --help  show this help message and exit
  -p FILE     YAML file with paramaters
```

## gimmemotifs-minimal_motif2factors

### Tool Description
Generate a motif database based on orthology for any species

### Metadata
- **Docker Image**: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
- **Homepage**: https://github.com/vanheeringen-lab/gimmemotifs
- **Package**: https://anaconda.org/channels/bioconda/packages/gimmemotifs-minimal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gimme [-h] <subcommand> [options] motif2factors [-h] --new-reference
                                                       ASSEMBLY [ASSEMBLY ...]
                                                       [--database db]
                                                       [--database-references ASSEMBLY [ASSEMBLY ...]]
                                                       [--ortholog-references ASSEMBLY [ASSEMBLY ...]]
                                                       [--genomes_dir DIR]
                                                       [--tmpdir DIR]
                                                       [--outdir OUTDIR]
                                                       [--strict]
                                                       [--threads INT]
                                                       [--keep-intermediate]

optional arguments:
  -h, --help            show this help message and exit
  --new-reference ASSEMBLY [ASSEMBLY ...]
                        The assembly the new motif2factors file will be based
                        on.
  --database db         The database you want to change convert to your
                        species of interest. (default is
                        gimme.vertebrate.v5.0)
  --database-references ASSEMBLY [ASSEMBLY ...]
                        The assembly(s) on which the orginal motif2factors is
                        based on. (default is human and mouse)
  --ortholog-references ASSEMBLY [ASSEMBLY ...]
                        Extra assemblies for better orthology inference
                        between the new reference and database reference.
                        (default is a range of vertebrate species)
  --genomes_dir DIR     Where to find/store genomepy genomes. Defaults to the
                        genomepy config settings.
  --tmpdir DIR          Where to place intermediate files. Defaults to system
                        temp.
  --outdir OUTDIR       Where to save the results to. Defaults to current
                        working directory.
  --strict, --medium, --lenient
                        How strict should the names of the genes in the
                        assembly be followed. Strict: base names only on what
                        is in the annotation file; Medium: base on annotation
                        file, as well as on mygene.info name and symbol query;
                        Lenient: based on annotation file, and mygeneinfo
                        name, symbol, alias, other_names, accession,
                        accession.protein, refseq, refseq.protein, ensembl,
                        ensembl.gene. Lenient is the default, but in case of
                        false-positive hits you can tune this stricter.
  --threads INT         Maximum number of parallel threads used.
  --keep-intermediate   Keep temporary files, do not delete tmpdir.
```

