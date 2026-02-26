# protal CWL Generation Report

## protal

### Tool Description
Protal help text

### Metadata
- **Docker Image**: quay.io/biocontainers/protal:0.2.0a--h5ca1c30_0
- **Homepage**: https://github.com/4less/protal
- **Package**: https://anaconda.org/channels/bioconda/packages/protal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/protal/overview
- **Total Downloads**: 635
- **Last updated**: 2025-11-05
- **GitHub**: https://github.com/4less/protal
- **Stars**: N/A
### Original Help Text
```text
,,  
`7MM"""Mq.                   mm            `7MM  
  MM   `MM.                  MM              MM  
  MM   ,M9 `7Mb,od8 ,pW"Wq.mmMMmm  ,6"Yb.    MM  
  MMmmdM9    MM' "'6W'   `Wb MM   8)   MM    MM  
  MM         MM    8M     M8 MM    ,pm9MM    MM  
  MM         MM    YA.   ,A9 MM   8M   MM    MM  
.JMML.     .JMML.   `Ybmd9'  `Mbmo`Moo9^Yo..JMML.


Total available memory is 62GB

Protal help text
Usage:
  protal [OPTION...]

      --db arg                  Path to protal database folder.
  -1, --first arg               Comma separated list of reads. If paired-end,
                                also specify second read via -2/--second.
                                (default: "")
  -2, --second arg              Comma separated list of reads. must have
                                <-1/--first> specified. Currently this must be
                                specified -- single-end reads are not yet
                                supported. (default: "")
  -3, --prefix arg              Comma separated list of output prefixes
                                (optional). If not specified, output file prefixes
                                are generated from the input file names by
                                taking their longest common prefix. Only works
                                when both pairs of the read file are in the same
                                folder. (default: "")
      --map arg                 For larger datasets you can define parameters
                                -1, -2, -3 and -o in a tsv-file. (default:
                                "")
  -o, --outdir arg              Comma separated list of output prefixes
                                (optional). If not specified, output file prefixes
                                are generated from the input file names. If
                                not otherwise specified by using --map, sam
                                files, profiles, msas, and other miscellaneous
                                files will be stored in the subfolders to this
                                directory 'sam', 'profiles', 'strains', and
                                'misc'.
  -t, --threads arg             Specify number of threads to use. Will be
                                passed on to pigz for compression of sam files.
                                (default: 1)
      --force                   Force redo alignment even if sam files
                                exists.
      --no_strains              Stay on species level. Do not output SNPs or
                                MSAs
      --preload_genomes_off     Do not preload complete reference library
                                (reference.fna and reference.map in protal index
                                folder) and instead do dynamic loading. This
                                usually decreases performance but saves memory.
      --no_profile              Do NOT perform taxonomic profiling, only
                                output alignments.
      --profile_only arg        Provide profile filename (.sam) and only
                                perform profiling based on sam file. (default: "")
  -c, --align_top arg           After seeding, anchor are sorted by quality
                                passed to alignment. <take_top> specifies how
                                many anchors should be aligned starting with
                                the most promising anchor. (default: 3)
  -m, --max_out arg             Maximum alignments that should be outputted
                                (default: 1)
  -u, --max_key_ubiquity arg    Max key ubiquity. Best matching Flexkey count
                                for seed must be lower or equal (default:
                                256)
  -s, --max_seed_size arg       Max seed size after which seeding is stopped.
                                (default: 128)
  -w, --min_successful_lookups arg
                                If the number of seeds is >=max_seed_size and
                                the number of successful core-mer lookups is
                                >= min_successful_lookups, stop looking for
                                further seeds. (default: 4)
  -a, --max_score_ani arg       A max score makes an alignment stop if the
                                alignment diverges too much. This parameter
                                estimates the score for a given ani and is a
                                tradeoff between speed/accuracy. [ Default:
                                0.900000] (default: 0.900000)
  -x, --x_drop arg              Value determines when to cut of branches in
                                the aligment process that are unpromising. [
                                Default: 1000] (default: 1000)
  -e, --output_top arg          After alignment, alignments are sorted by
                                score. <output_top> specifies how many alignments
                                should be reported starting with the highest
                                scoring alignment. (default: 3)
  -k, --msa_min_vcov arg        Protal outputs two MSAs. The processed MSA is
                                condensed horizontally such that each
                                position in the MSA is covered by at least
                                msa_min_cov percent of the sequences with bases that are
                                neither '-' nor 'N' (default: 0.500000)
      --map_range arg           If you specified a map file with --map you
                                can also pass a range to protal to run protal
                                only on a subset. The first entry is 1, the end
                                is inclusive. e.g.: 1-10. If the end open or
                                larger than the number of entries in the map
                                file, the last entry in the map file is selected
                                as end. (default: 1-)
      --mapq_debug_output       Output mapq debug info to stderr
      --build                   Build index from reference file with header
                                format ()
      --full_reference arg      All marker genomes (not only representative
                                ones) to check unique k-mers during build
                                process (default: "")
      --reference arg           Set of reference sequences to build the
                                internal alignment database from (default: "")
      --profile_truth arg       Provide truth file and annotate profile taxa
                                with TP/FP. Format is list of integers
                                (internal ids) (default: "")
      --benchmark_alignment     Benchmark alignment part of protal based on
                                true taxonomic id and gene id supplied in the
                                read header. Header must fulfill the formatting
                                >taxid_geneid... with the regex:
                                >[0-9]+_[0-9]+([^0-9]+.*)*
      --benchmark_alignment_output arg
                                Benchmark alignment output. Output is
                                appended to the file.
  -v, --version                 Output version information
      --verbose                 Have verbose program output
  -h, --help                    Print help.
      --map_help                Get help how to format the map file.
```

