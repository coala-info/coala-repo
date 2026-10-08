# goldrush CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| goldrush_goldpolish | Failed | tool bug: goldpolish-targeted-bfs exits silently while loading the sequence index, so goldpolish hangs on real PacBio HiFi reads. |
| goldrush_goldrush_path | PASS |  |

## goldrush_goldrush_path

### Tool Description
Find golden paths from long reads with GoldRush-Path.

### goldrush_goldpolish

### Tool Description
Polish sequences with long reads (GoldPolish).

### Metadata
- **Docker Image**: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
- **Homepage**: https://github.com/bcgsc/goldrush
- **Package**: https://anaconda.org/channels/bioconda/packages/goldrush/overview
- **Validation**: PASS

### Original Help Text
```text
usage: goldpolish [-h] [-k K] [-b BSIZE] [-m SHARED_MEM] [-t THREADS] [-v]
                  [-x MX_MAX_READS_PER_10KBP]
                  [-s SUBSAMPLE_MAX_READS_PER_10KBP]
                  [--ntlink | --minimap2 | --mappings MAPPINGS]
                  [--k-ntlink K_NTLINK] [--w-ntlink W_NTLINK] [--target]
                  [-l LENGTH] [--bed BED | --softmask]
                  seqs_to_polish polishing_seqs output_seqs

positional arguments:
  seqs_to_polish        Sequences to polish.
  polishing_seqs        Sequences to polish with.
  output_seqs           Filename to write polished sequences to.

optional arguments:
  -h, --help            show this help message and exit
  -k K                  k-mer sizes to use for polishing. Example: -k32 -k28
                        (Default: 32, 28, 24, 20)
  -b BSIZE, --bsize BSIZE
                        Batch size. A batch is how many polished sequences are
                        processed per Bloom filter. (Default: 1)
  -m SHARED_MEM, --shared-mem SHARED_MEM
                        Shared memory path to do polishing in. (Default:
                        /dev/shm)
  -t THREADS, --threads THREADS
                        How many threads to use. (Default: 48)
  -v, --verbose
  -x MX_MAX_READS_PER_10KBP, --mx-max-reads-per-10kbp MX_MAX_READS_PER_10KBP
                        When subsampling, increase the common minimizer count
                        threshold for ntLink mappings until there's at most
                        this many reads per 10kbp of polished sequence.
                        (Default: 150)
  -s SUBSAMPLE_MAX_READS_PER_10KBP, --subsample-max-reads-per-10kbp SUBSAMPLE_MAX_READS_PER_10KBP
                        Random subsampling of mapped reads. For ntLink
                        mappings, this is done after common minimizer
                        subsampling. For minimap2 mappings, only this
                        subsampling is done. By default, 40 if using minimap2
                        mappings and 100 if using ntLink mappings.
  --ntlink              Run ntLink to generate read mappings (default).
  --minimap2            Run minimap2 to generate read mappings.
  --mappings MAPPINGS   Use provided pre-generated mappings. Accepted formats
                        are PAF, SAM, and *.verbose_mapping.tsv from ntLink.
  --k-ntlink K_NTLINK   k-mer size used for ntLink mappings (if --ntlink
                        specified)
  --w-ntlink W_NTLINK   Window size used for ntLink mappings (if --ntlink
                        specified)
  --target              Run GoldPolish in targeted mode
  -l LENGTH, --length LENGTH
                        GoldPolish-Target flank length (if --target specified)
  --bed BED             BED file specifying target coordinates (if --target
                        specified)
  --softmask            Target coordinates determined from softmasked regions
                        in the input assembly (if --target specified)
```


## Metadata
- **Docker Image**: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
- **Homepage**: https://github.com/bcgsc/goldrush
- **Package**: https://anaconda.org/channels/bioconda/packages/goldrush/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  goldrush_path  -k K -w W -i INPUT -g G [-p prefix] [-P PHRED_AVG] [-o O] [-t T] [-f F] [-h H] [-u U] [-m M] [-H HASH_UNIVERSE] [-s S] [-x X] [-M MAX_PATHS][-a A] [-j J] [-b B] [-d D] [--silver_path] [--ntcard] [--help] 

  -i INPUT                find golden paths from INPUT [required]
  -g G                    estimated genome size [required]
  -b B                    during insertion, B number of consecutive tiles to be inserted with the same ID [10]
  -d D                    remove reads with greater or equal then D phred average between first half and second half of the read [5]
  -f F                    don't use reads from F. Expects one read per line
  -o O                    use O as occupancy [0.1]
  -h H                    use h as number of spaced seed patterns [1]
  -H HASH_UNIVERSE        determine MiBF size based on HASH_UNIVERSE [Calculated based on W and h]
  -t T                    tile length [1000]
  -k K                    span of spaced seed [required]
  -w W                    weight of spaced seed [required]
  -m M                    use reads longer than M [20000]
  -u U                    U minimum unassigned tiles for read to be unassigned [5]
  -a A                    A maximum assigned tiles for read to be unassigned [1]
  -p prefix               write output to files with prefix [goldrush_out]
  -P PHRED_AVG            minimum average phred score for each read [0 (calculates phred score minimum automatically)]
  -j J                    number of threads [48]
  -s S                    use S seed preset. Must be consistent with k and w [n/a, generate one randomly based on k and w]
  -x X                    require X hits for a tile to be assigned [10]
  -M MAX_PATHS            output MAX_PATHS [5, used with --silver_path]
  --ntcard                use ntcard to estimate genome size [false, assume max entries]
  --silver_path           generate silver path(s) instead of golden path. Silver paths terminate when the number of bases recruited equals or exceeds T * r
 --verbose                print verbose messages [false]
  --help                  display this help and exit
```


