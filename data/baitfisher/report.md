# baitfisher CWL Generation Report

## baitfisher

### Tool Description
FAIL to generate CWL: baitfisher not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: biocontainers/baitfisher:v1.2.7git20180107.e92dbf2dfsg-1-deb_cv1
- **Homepage**: https://github.com/cmayer/BaitFisher-package
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/baitfisher/overview
- **Total Downloads**: 9.3K
- **Last updated**: 2025-10-08
- **GitHub**: https://github.com/cmayer/BaitFisher-package
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: baitfisher not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: baitfisher not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: not generated

## baitfisher_BaitFisher

### Tool Description
BaitFisher program for designing bait sets for phylogenomics and other applications.

### Metadata
- **Docker Image**: biocontainers/baitfisher:v1.2.7git20180107.e92dbf2dfsg-1-deb_cv1
- **Homepage**: https://github.com/cmayer/BaitFisher-package
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Welcome to the BaitFisher program, version 1.2.8

Usage: /usr/bin/BaitFisher parameter-file [gffFileTest]
```

## baitfisher_BaitFilter

### Tool Description
BaitFilter is designed to post-process the output of the BaitFisher program to select appropriate bait regions, filter baits based on specificity (BLAST), and convert bait files to uploadable formats.

### Metadata
- **Docker Image**: biocontainers/baitfisher:v1.2.7git20180107.e92dbf2dfsg-1-deb_cv1
- **Homepage**: https://github.com/cmayer/BaitFisher-package
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Welcome to Bait-Filter, version 1.0.6.


USAGE: 

   /usr/bin/BaitFilter  -i <string> [-o <string>] [-c <string>] [-m
                        <string>] [--blast-second-hit-evalue <floating
                        point number>] [--blast-first-hit-evalue <floating
                        point number>]
                        [--blast-min-hit-coverage-of-baits-in-tiling-stack
                        <floating point number>] [--ref-blast-db <string>]
                        [--blast-extra-commandline <string>]
                        [--blast-evalue-cutoff <floating point number>] [-B
                        <string>] [-t <positive integer>] [--ID-prefix
                        <string>] [-S] [--verbosity <unsigned integer>] [-b
                        <string>] [--] [--version] [-h]


Where: 

   -i <string>,  --input-bait-file-name <string>
     (required)  Name of the input bait locus file. This is the bait file
     obtained from the BaitFisher program or from a previous filter run
     with BaitFilter.

   -o <string>,  --output-bait-file-name <string>
     Name of the output bait file. All modes, except the conversion mode,
     produce files in the BaitFisher format.

   -c <string>,  --convert <string>
     Allows the user to produce the final output file which can be uploaded
     at a bait producing company. In this mode, BaitFilter reads the input
     bait file and instead of doing a filtering step, it produces a custom
     bait file that can be uploaded at the baits producing company. In
     order to avoid confusion, a filtering step cannot be done in the same
     run as the conversion. If you want to filter a bait file and convert
     the output, you will need to call this program more than once, first
     to do the filtering and second to do the conversion. Allowed
     conversion parameters currently are: "four-column-upload".

     New output formats can be added upon request. Please contact the
     author: Christoph Mayer, Email: Mayer Christoph
     <c.mayer.zfmk@uni-bonn.de>

   -m <string>,  --mode <string>
     Apart from the input file option, the mode option is the most
     important option. This option specifies which filter mode BaitFilter
     uses. (See the user manual for more details):

     "ab":      Retain only the best bait locus for each alignment file
     when using the optimality criterion             to minimize the total
     number of required baits.

     "as":      Retain only the best bait locus for each alignment file
     when using the optimality criterion             to maximize the number
     of sequences the result is based on.

     "fb":      Retain only the best bait locus for each feature (e.g. CDS)
     when using the optimality criterion             to minimize the total
     number of required baits. Only applicable if alignment cutting has
     been used in BaitFisher.

     "fs":      Retain only the best bait locus for each feature (e.g. CDS)
     when using the optimality criterion             to maximize the number
     of sequences the result is based on. Only applicable if alignment
     cutting has been used in BaitFisher. 

     "blast-a": Remove all bait regions of all ALIGNMENTs for which one or
     more baits have at least two good hits to a reference genome. (Not
     recommended.)

     "blast-f": Remove all bait regions of all FEATUREs for which one or
     more baits have at least two good hits to a reference genome. (Not
     recommended.)

     "blast-l": Remove only the bait REGIONs that contain a bait that has
     multiple good hits to a reference genome. (Recommended over blast-f
     and blast-a.)

     "blast-c": Conduct a coverage filter run without a search for multiple
     hits. Requires the blast-min-hit-coverage-of-baits-in-tiling-stack
     option to be specified.

     "thin-b":  Thin out a bait file to every Nth bait region, by finding
     the start position that minimizes the number of baits.

     "thin-s":  Thin out a bait file to every Nth bait region, by finding
     the start position that maximizes the number of
     sequences.

     "thin-b-old":  Similar to thin-b, but treats all loci as if they come
     from one alignment file. Identical to behaviour of thin-b in version
     1.0.5 or earlier.

     "thin-s-old":  Similar to thin-s, but treats all loci as if they come
     from one alignment file. Identical to behaviour of thin-b in version
     1.0.5 or earlier.


   --blast-second-hit-evalue <floating point number>
     Maximum E-value for the second or second best hit. A bait is
     characterised to bind ambiguously, if we have at least two good hits.
     This option is the E-value threshold for the second best hit to
     different loci of the genome.This option is the E-value threshold for
     the second best hit. Default: 0.000001

   --blast-first-hit-evalue <floating point number>
     Maximum E-value for the first or best hit of the bait against the
     genome. A bait is characterized to bind ambiguously, if we have at
     least two good hits to different loci of the genome. This option is
     the E-value threshold for the first/best hit. Default: 0.000001

   --blast-min-hit-coverage-of-baits-in-tiling-stack <floating point
      number>
     Can be specified together with the following modes (-m option):
     blast-a, blast-f, blast-l, blast-c. In all these modes, a blast
     analysis of all baits against a reference genome is conducted. This
     option specifies a minimum query hit coverage which at least one bait
     has to have in each tiling stack (i.e. the column in the tiling
     design). Otherwise the bait region is discarded. If not specified, no
     hit coverage is checked. The coverage is determined for each bait by
     dividing the length of the best hit of this bait against the specified
     genome by the length of this bait. Then the highest coverage is
     determined for each bait stack of the tiling design.  If this option
     is used together with another filter, it is important to know the
     order in which the two are applied, since the order matters for the
     final result:For the mode options: blast-a, blast-f, blast-l the hit
     coverage is checked after filtering for baits with multiple good hits
     to the reference genome.

   --ref-blast-db <string>
     Base name to a blast data base file. This name is passed to the blast
     command. This is the name of the fasta file of your reference genome.
     IMPORTANT: The makeblastdb program has to be called before starting
     the Bait-Filter program. makeblastdb takes the fasta file and  creates
     data base files out of it. Cannot be specified together with the
     blast-result-file option.

   --blast-extra-commandline <string>
     When invoking the blast command, extra command line parameters can be
     passed to the blast program with the aid of this option. As an example
     , this option allows to specify the number of threads the blast
     program should use. Example: --blast-extra-commandline "-num_threads
     20" sets the number of threads to 20. 

   --blast-evalue-cutoff <floating point number>
     When conducting a blast search, a maximum E-value can be specified
     when calling the blast program. The effect is that hits with a higher
     E-value are not reported. BaitFilter always specifies such an E-value
     when calling the blast program. The default E-value passed by
     BaitFilter to the blast program is twice the
     --blast-second-hit-evalue. If a coverage filter is requested the
     default value is set to 0.001 if twice the value of
     --blast-second-hit-evalue is smaller than 0.001. This should guarantee
     that all hits necessary for the blast and/or coverage filter are
     found. If the user wants to set a different E-value threshold, this
     can be specified with this option. With version 1.0.6 of this program,
     the value is automatically changed to be larger or equal to 0.001 if
     the coverage filter is used. This makes the usage of this option
     unnecessary in most cases.

   -B <string>,  --blast-executable <string>
     Name of or path+name to the blast executable. Default: blastn. Minimum
     blast version number: Blast+ 2.2.x. Default: blastn. Cannot be
     specified together with the blast-result-file option. 

   -t <positive integer>,  --thinning-step-width <positive integer>
     Thin out the bait file by retaining only every Nth bait region. The
     integer after the option specifies the step width N. If one of the
     modes thin-b (thin-b-old), or thin-s (thin-s-old) is active, this
     option is required, otherwise it is not allowed to set this
     parameter.

   --ID-prefix <string>
     In the conversion mode to the four-column-upload file format, each
     converted file should get a unique ProbeID prefix, since even among
     multiple files, ProbeIDs are not allowed to be identical. With this
     option the user is able to specify a prefix string to all probe IDs in
     the four-column-upload file created by BaitFilter.

   -S,  --stats
     Compute bait file characteristics for the input file and report these.
     This mode is automatically used for all modes specified with -m option
     or the conversion mode specified with -c option. The purpose of the -S
     option is to compute stats without having to filter or convert the
     input file. In particular, the -S mode does not require specifying an
     output file.

     This option has no effect if combined with the -m or -c modes.


   --verbosity <unsigned integer>
     The verbosity option controls the amount of information Bait-Filter
     writes to the console while running. 0: Print only welcome message and
     essential error messages that lead to exiting the program. 1: report
     also warnings, 2: report also progress, 3: report more detailed
     progress, >10: debug output. Maximum 10000: write all possible
     diagnostic output. A value of 2 is required if startup parameters
     should be reported.


   -b <string>,  --blast-result-file <string>
     Conducting a blast analysis of all baits against a reference genome
     can take a long time. If different filtering parameters, e.g.
     different coverage thresholds are to be compared, the same blast has
     to be done multiple times. With this argument, the blast will be
     skipped and the specified blast result file will be used. This option
     has to be used with caution! No checks are done (so far) to ensure
     that the blast result file corresponds to the specified bait file. If
     a BaitFilter run was conducted which did a blast search, BaitFilter
     will not delete the blast result file after the run was completed. The
     result file with the name blast_result.txt will remain in the working
     directory. It can be moved or renamed and with this option it can be
     specified as the input file for further BaitFilter runs. If you have
     the slightest doubt whether you are using the correct blast result
     file, you should not use this option. This option is only allowed in
     modes that would normally do a blast search. This option cannot be
     specified together with the blast-executable, blast-evalue-cutoff,
     blast-extra-commandline, ref-blast-db options, since these are options
     specific to runs in which a blast search is conducted.

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.


   The Bait-Filter program has been designed to post process the output of
   the BaitFisher program in order select appropriate bait regions and to
   create the final bait set. BaitFilter offers several filtering and
   conversion modes. If multiple filtering steps and a final conversion are
   required, BaitFilter will have to be started multiple times and the
   output of the different runs are used as input in the next step.

   The BaitFisher program designs baits for every locus for which a bait
   design is possible for a full bait region. A bait region can start at
   every nucleotide as long as the remaining sequence is long enough. This
   output has to be reduced and the purpose of BaitFilter is to find for
   each feature, gene or alignment the optimal locus or the optimal loci
   for the bait regions. Before determining the locus with the fewest
   number of baits or the largest sequence coverage, one might want to
   determine which baits are expected to bind specifically in a given
   reference genome. This is achieved by conducting a Blast search of the
   baits against a genome. Baits which are highly similar to at least two
   loci of the genome can be determined and their bait regions can be
   removed. The blast search result can also be used to specify a minimum
   hit coverage of the baits in a bait region against the reference genome.
   After removing bait regions at inferior loci, the optimal bait region
   starting locus (start coordinate) can be inferred with the aid of
   different criteria in a subsequent run of BaitFilter. As input,
   BaitFilter requires a bait file generated by the BaitFisher program or a
   BaitFile generated by a previous filtering run of BaitFilter. This bait
   file is specified with the -i command line parameter (see below).
   Furthermore, the user has to specify an output file name with the -o
   parameter and a filter mode with the -m parameter.

   To convert a file to final and uploadable output format, see the -c
   option below.

   To compute a bait file statistics of an input file, see the -S option
   below.

   The different filter modes provided by BaitFilter are the following:

   1a) Retain only the best bait locus per alignment file. Criterion:
   Minimize number of required baits.

   1b) Retain only the best bait locus per alignment file. Criterion:
   Maximize number of sequences.

   2a) Retain only best bait locus per feature (requires that features were
   selected in BaitFisher). Criterion: Minimize number of required
   baits.

   2b) Retain only best bait locus per feature (requires that features were
   selected in BaitFisher). Criterion: Maximize number of sequences.

   3) Use a blast search of the bait sequences against a reference genome
   to detect putative non-unique target loci. Non unique target sites will
   have multiple good hits against the reference genome.   Furthermore, a
   minimum coverage of the best blast hit of bait sequence against the
   genome can be specified. Note that all blast modes require additional
   command line parameters!  These modes remove bait regions for which
   multiple good blast hits where found or for which baits have
   insufficiently long hits. Different versions of this mode are
   available:

   3a) If a single bait is not unique, remove all bait regions from the
   current gene.

   3b) If a single bait is not unique, remove all bait regions from the
   current feature (if applicable).

   3c) If a single bait is not unique, remove only the bait region that
   contains this bait.

   4) Thin out the given bait file: Retain only every Nth bait region,
   where N has to be specified by the user. Two submodes are available:

   4a) Thin out bait regions by retaining only every Nth bait region in a
   bait file. The starting offset will by chosen such that the number of
   required baits is minimized.

   4b) Thin out bait regions by retaining only every Nth bait region in a
   bait file. The starting offset will by chosen such that the number of
   sequences the result is based on is maximized.
```

