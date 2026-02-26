# abyss CWL Generation Report

## abyss_abyss-pe

### Tool Description
A tool to control the generation of executables and other non-source files of a program from the program's source files.

### Metadata
- **Docker Image**: quay.io/biocontainers/abyss:2.3.10--hf316886_2
- **Homepage**: https://www.bcgsc.ca/platform/bioinfo/software/abyss
- **Package**: https://anaconda.org/channels/bioconda/packages/abyss/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abyss/overview
- **Total Downloads**: 665.8K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/bcgsc/abyss
- **Stars**: N/A
### Original Help Text
```text
Usage: make [options] [target] ...
Options:
  -b, -m                      Ignored for compatibility.
  -B, --always-make           Unconditionally make all targets.
  -C DIRECTORY, --directory=DIRECTORY
                              Change to DIRECTORY before doing anything.
  -d                          Print lots of debugging information.
  --debug[=FLAGS]             Print various types of debugging information.
  -e, --environment-overrides
                              Environment variables override makefiles.
  -E STRING, --eval=STRING    Evaluate STRING as a makefile statement.
  -f FILE, --file=FILE, --makefile=FILE
                              Read FILE as a makefile.
  -h, --help                  Print this message and exit.
  -i, --ignore-errors         Ignore errors from recipes.
  -I DIRECTORY, --include-dir=DIRECTORY
                              Search DIRECTORY for included makefiles.
  -j [N], --jobs[=N]          Allow N jobs at once; infinite jobs with no arg.
  --jobserver-style=STYLE     Select the style of jobserver to use.
  -k, --keep-going            Keep going when some targets can't be made.
  -l [N], --load-average[=N], --max-load[=N]
                              Don't start multiple jobs unless load is below N.
  -L, --check-symlink-times   Use the latest mtime between symlinks and target.
  -n, --just-print, --dry-run, --recon
                              Don't actually run any recipe; just print them.
  -o FILE, --old-file=FILE, --assume-old=FILE
                              Consider FILE to be very old and don't remake it.
  -O[TYPE], --output-sync[=TYPE]
                              Synchronize output of parallel jobs by TYPE.
  -p, --print-data-base       Print make's internal database.
  -q, --question              Run no recipe; exit status says if up to date.
  -r, --no-builtin-rules      Disable the built-in implicit rules.
  -R, --no-builtin-variables  Disable the built-in variable settings.
  --shuffle[={SEED|random|reverse|none}]
                              Perform shuffle of prerequisites and goals.
  -s, --silent, --quiet       Don't echo recipes.
  --no-silent                 Echo recipes (disable --silent mode).
  -S, --no-keep-going, --stop
                              Turns off -k.
  -t, --touch                 Touch targets instead of remaking them.
  --trace                     Print tracing information.
  -v, --version               Print the version number of make and exit.
  -w, --print-directory       Print the current directory.
  --no-print-directory        Turn off -w, even if it was turned on implicitly.
  -W FILE, --what-if=FILE, --new-file=FILE, --assume-new=FILE
                              Consider FILE to be infinitely new.
  --warn-undefined-variables  Warn when an undefined variable is referenced.

This program built for x86_64-conda-linux-gnu
Report bugs to <bug-make@gnu.org>
```


## abyss_abyss-sealer

### Tool Description
Close gaps by using left and right flanking sequences of gaps as 'reads' for Konnector and performing multiple runs with each of the supplied K values.

### Metadata
- **Docker Image**: quay.io/biocontainers/abyss:2.3.10--hf316886_2
- **Homepage**: https://www.bcgsc.ca/platform/bioinfo/software/abyss
- **Package**: https://anaconda.org/channels/bioconda/packages/abyss/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: abyss-sealer-b <Bloom filter size> -k <kmer size> -k <kmer size>... -o <output_prefix> -S <path to scaffold file> [options]... <reads1> [reads2]...
i.e. abyss-sealer -b20G -k90 -k80 -k70 -k60 -k50 -k40 -k30 -o test -S scaffold.fa read1.fa read2.fa

Close gaps by using left and right flanking sequences of gaps as 'reads' for Konnector
and performing multiple runs with each of the supplied K values.

 Options:

      --print-flanks           outputs flank files
  -S, --input-scaffold=FILE    load scaffold from FILE
  -L, --flank-length=N         length of flanks to be used as pseudoreads [100]
  -G, --max-gap-length=N       max gap size to fill in bp [800]; runtime increases
                               exponentially with respect to this parameter
  -j, --threads=N              use N parallel threads [1]
  -k, --kmer=N                 the size of a k-mer
  -b, --bloom-size=N           size of Bloom filter (e.g. '40G'). Required
                               when not using pre-built Bloom filter(s)
                               (-i option)
  -d, --dot-file=FILE          write graph traversals to a DOT file
  -e, --fix-errors             find and fix single-base errors when reads
                               have no kmers in bloom filter [disabled]
  -C, --max-cost=N             max edges to traverse during each graph search [100000]
  -i, --input-bloom=FILE       load bloom filter from FILE
      --mask                   mask new and changed bases as lower case
      --no-mask                do not mask bases [default]
      --chastity               discard unchaste reads [default]
      --no-chastity            do not discard unchaste reads
      --trim-masked            trim masked bases from the ends of reads
      --no-trim-masked         do not trim masked bases from the ends
                               of reads [default]
  -m, --flank-mismatches=N     max mismatches between paths and flanks; use
                               'nolimit' for no limit [nolimit]
  -M, --max-mismatches=N       max mismatches between all alternate paths;
                               use 'nolimit' for no limit [nolimit]
  -n  --no-limits              disable all limits; equivalent to
                               '-B nolimit -m nolimit -M nolimit -P nolimit'
  -o, --output-prefix=FILE     prefix of output FASTA files [required]
  -P, --max-paths=N            merge at most N alternate paths; use 'nolimit'
                               for no limit [2]
  -q, --trim-quality=N         trim bases from the ends of reads whose
                               quality is less than the threshold
      --standard-quality       zero quality is `!' (33)
                               default for FASTQ and SAM files
      --illumina-quality       zero quality is `@' (64)
                               default for qseq and export files
  -r, --read-name=STR          only process reads with names that contain STR
  -s, --search-mem=N           mem limit for graph searches; multiply by the
                               number of threads (-j) to get the total mem used
                               for graph traversal [500M]
  -g, --gap-file=FILE          write sealed gaps to FILE
  -t, --trace-file=FILE        write graph search stats to FILE
  -v, --verbose                display verbose output
      --lower                  seal sequences with lower-case IUPAC characters
      --help                   display this help and exit
      --version                output version information and exit

 Deprecated Options:

  -B, --max-branches=N         max branches in de Bruijn graph traversal;
                               use 'nolimit' for no limit [nolimit]
  -f, --min-frag=N             min fragment size in base pairs
  -F, --max-frag=N             max fragment size in base pairs

  Note 1: --max-branches was not effective for truncating expensive searches,
  and has been superseded by the --max-cost option.

  Note 2: --max-frag was formerly used to determine the maximum gap
  size that abyss-sealer would attempt to close, according to the formula
  max_gap_size = max_frag - 2 * flank_length, where flank_length is
  determined by the -L option.  --max-frag is superseded by the more
  intuitive -G (--max-gap-length) option. The related option --min-frag
  does not seem to have any practical use.

Report bugs to <abyss-users@bcgsc.ca>.
```


## abyss_abyss-fatoagp

### Tool Description
Convert FASTA files to AGP format using ABySS

### Metadata
- **Docker Image**: quay.io/biocontainers/abyss:2.3.10--hf316886_2
- **Homepage**: https://www.bcgsc.ca/platform/bioinfo/software/abyss
- **Package**: https://anaconda.org/channels/bioconda/packages/abyss/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/abyss-fatoagp version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: abyss-fatoagp [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -f -s -S

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
```

