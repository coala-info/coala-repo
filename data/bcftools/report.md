# bcftools CWL Generation Report

## bcftools_index

### Tool Description
Index bgzip compressed VCF/BCF files for random access.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Total Downloads**: 3.9M
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/samtools/bcftools
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
index: unrecognized option '--help'

About:   Index bgzip compressed VCF/BCF files for random access.
Usage:   bcftools index [options] <in.bcf>|<in.vcf.gz>

Indexing options:
    -c, --csi                generate CSI-format index for VCF/BCF files [default]
    -f, --force              overwrite index if it already exists
    -m, --min-shift INT      set minimal interval size for CSI indices to 2^INT [14]
    -o, --output FILE        optional output index file name
    -t, --tbi                generate TBI-format index for VCF files
        --threads INT        use multithreading with INT worker threads [0]
    -v, --verbosity INT      verbosity level

Stats options:
    -a, --all            with --stats, print stats for all contigs even when zero
    -n, --nrecords       print number of records based on existing index file
    -s, --stats          print per contig stats based on existing index file


```


## bcftools_annotate

### Tool Description
Annotate and edit VCF/BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
annotate: unrecognized option '--help'

About:   Annotate and edit VCF/BCF files.
Usage:   bcftools annotate [options] VCF

Options:
   -a, --annotations FILE          VCF file or tabix-indexed FILE with annotations: CHR\tPOS[\tVALUE]+
   -c, --columns LIST              List of columns in the annotation file, e.g. CHROM,POS,REF,ALT,-,INFO/TAG. See man page for details
   -C, --columns-file FILE         Read -c columns from FILE, one name per row, with optional --merge-logic TYPE: NAME[ TYPE]
   -e, --exclude EXPR              Exclude sites for which the expression is true (see man page for details)
       --force                     Continue despite parsing error (at your own risk!)
   -H, --header-line STR           Header line which should be appended to the VCF header, can be given multiple times
   -h, --header-lines FILE         Lines which should be appended to the VCF header
   -I, --set-id [+]FORMAT          Set ID column using a `bcftools query`-like expression, see man page for details
   -i, --include EXPR              Select sites for which the expression is true (see man page for details)
   -k, --keep-sites                Leave -i/-e sites unchanged instead of discarding them
   -l, --merge-logic TAG:TYPE      Merge logic for multiple overlapping regions (see man page for details), EXPERIMENTAL
   -m, --mark-sites [+-]TAG        Add INFO/TAG flag to sites which are ("+") or are not ("-") listed in the -a file
       --min-overlap ANN:VCF       Required overlap as a fraction of variant in the -a file (ANN), the VCF (:VCF), or reciprocal (ANN:VCF)
       --no-version                Do not append version and command line to the header
   -o, --output FILE               Write output to a file [standard output]
   -O, --output-type u|b|v|z[0-9]  u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
       --pair...
```


## bcftools_concat

### Tool Description
Concatenate or combine VCF/BCF files. All source files must have the same sample columns appearing in the same order. The program can be used, for example, to concatenate chromosome VCFs into one VCF, or combine a SNP VCF and an indel VCF into one. The input files must be sorted by chr and position. The files must be given in the correct order to produce sorted VCF on output unless the -a, --allow-overlaps option is specified. With the --naive option, the files are concatenated without being recompressed, which is very fast.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
concat: unrecognized option '--help'

About:   Concatenate or combine VCF/BCF files. All source files must have the same sample
         columns appearing in the same order. The program can be used, for example, to
         concatenate chromosome VCFs into one VCF, or combine a SNP VCF and an indel
         VCF into one. The input files must be sorted by chr and position. The files
         must be given in the correct order to produce sorted VCF on output unless
         the -a, --allow-overlaps option is specified. With the --naive option, the files
         are concatenated without being recompressed, which is very fast.
Usage:   bcftools concat [options] <A.vcf.gz> [<B.vcf.gz> [...]]

Options:
   -a, --allow-overlaps           First coordinate of the next file can precede last record of the current file.
   -c, --compact-PS               Do not output PS tag at each site, only at the start of a new phase set block.
   -d, --rm-dups STRING           Output duplicate records present in multiple files only once: <snps|indels|both|all|exact>
   -D, --remove-duplicates        Alias for -d exact
   -f, --file-list FILE           Read the list of files from a file.
   -G, --drop-genotypes           Drop individual genotype information.
   -l, --ligate                   Ligate phased VCFs by matching phase at overlapping haplotypes
       --ligate-force             Ligate even non-overlapping chunks, keep all sites
       --ligate-warn              Drop sites in imperfect overlaps
       --no-version               Do not append version and command line to the header
   -n, --naive                    Concatenate files without recompression, a header check compatibility is performed
       --naive-force              Same as --naive, but header compatibility is not checked. Dangerous, use with caution.
   -o, --output FILE              Write output...
```


## bcftools_convert

### Tool Description
Converts VCF/BCF to other formats and back. When specifying output files explicitly instead of with PREFIX, one can use '-' for stdout and '.' to suppress.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
convert: unrecognized option '--help'

About:   Converts VCF/BCF to other formats and back. See man page for file
         formats details. When specifying output files explicitly instead
         of with PREFIX, one can use '-' for stdout and '.' to suppress.
Usage:   bcftools convert [OPTIONS] INPUT_FILE

VCF input options:
   -e, --exclude EXPR             Exclude sites for which the expression is true
   -i, --include EXPR             Select sites for which the expression is true
   -r, --regions REGION           Restrict to comma-separated list of regions
   -R, --regions-file FILE        Restrict to regions listed in a file
       --regions-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
   -s, --samples LIST             List of samples to include
   -S, --samples-file FILE        File of samples to include
   -t, --targets REGION           Similar to -r but streams rather than index-jumps
   -T, --targets-file FILE        Similar to -R but streams rather than index-jumps
       --targets-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]

General options:
       --no-version               Do not append version and command line to the header
   -o, --output FILE              Output file name [stdout]
   -O, --output-type u|b|v|z[0-9] u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
       --threads INT              Use multithreading with INT worker threads [0]
   -v, --verbosity INT            Verbosity level
   -W, --write-index[=FMT]        Automatically index the output files [off]

GEN/SAMPLE conversion (input/output from IMPUTE2):
   -G, --gensample2vcf ...        <PREFIX>|<GEN-FILE>,<SAMPLE-FILE>
   -g, --gensample ...            <PREFIX>|<GEN-FILE>,<SAMPLE-FILE>
       --3N6                      Use 3*N+6 col...
```


## bcftools_head

### Tool Description
Displays VCF/BCF headers and optionally the first few variant records

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
head: unrecognized option '--help'

About: Displays VCF/BCF headers and optionally the first few variant records
Usage: bcftools head [OPTION]... [FILE]

Options:
  -h, --headers INT      Display INT header lines [all]
  -n, --records INT      Display INT variant record lines [none]
  -s, --samples INT      Display INT records starting with the #CHROM header line [none]
  -v, --verbosity INT    Verbosity level


```


## bcftools_isec

### Tool Description
Create intersections, unions and complements of VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Create intersections, unions and complements of VCF files.
Usage:   bcftools isec [options] <A.vcf.gz> <B.vcf.gz> [...]

Options:
    -c, --collapse STRING          Treat as identical records with <snps|indels|both|all|some|none|id>, see man page for details [none]
    -C, --complement               Output positions present only in the first file but missing in the others
    -e, --exclude EXPR             Exclude sites for which the expression is true
    -f, --apply-filters LIST       Require at least one of the listed FILTER strings (e.g. "PASS,.")
    -i, --include EXPR             Include only sites for which the expression is true
    -l, --file-list FILE           Read the input file names from the file
        --no-version               Do not append version and command line to the header
    -n, --nfiles [+-=~]INT         Output positions present in this many (=), this many or more (+), this many or fewer (-), the exact (~) files
    -o, --output FILE              Write output to a file [standard output]
    -O, --output-type u|b|v|z[0-9] u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
    -p, --prefix DIR               If given, subset each of the input files accordingly, see also -w
    -r, --regions REGION           Restrict to comma-separated list of regions
    -R, --regions-file FILE        Restrict to regions listed in a file
        --regions-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -t, --targets REGION           Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE        Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
        --threads INT              Use multithreading with INT worker th...
```


## bcftools_merge

### Tool Description
Merge multiple VCF/BCF files from non-overlapping sample sets to create one multi-sample file. Note that only records from different files can be merged, never from the same file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Merge multiple VCF/BCF files from non-overlapping sample sets to create one multi-sample file.
         Note that only records from different files can be merged, never from the same file. For
         "vertical" merge take a look at "bcftools norm" instead.
Usage:   bcftools merge [options] <A.vcf.gz> <B.vcf.gz> [...]

Options:
        --force-no-index              Merge unindexed files, synonymous to --no-index
        --force-samples               Resolve duplicate sample names
        --force-single                Run even if there is only one file on input
        --print-header                Print only the merged header and exit
        --use-header FILE             Use the provided header
    -0  --missing-to-ref              Assume genotypes at missing sites are 0/0
    -f, --apply-filters LIST          Require at least one of the listed FILTER strings (e.g. "PASS,.")
    -F, --filter-logic x|+            Remove filters if some input is PASS ("x"), or apply all filters ("+") [+]
    -g, --gvcf -|REF.FA               Merge gVCF blocks, INFO/END tag is expected. Implies -i QS:sum,MinDP:min,MIN_DP:min,I16:sum,IDV:max,IMF:max -M PL:max,AD:0
    -i, --info-rules TAG:METHOD,..    Rules for merging INFO fields (method is one of sum,avg,min,max,join) or "-" to turn off the default [DP:sum,DP4:sum]
    -l, --file-list FILE              Read file names from the file
    -L, --local-alleles INT           If more than INT alt alleles are encountered, drop FMT/PL and output LAA+LPL instead; 0=unlimited [0]
    -m, --merge STRING[*|**]          Allow multiallelic records for snps,indels,both,snp-ins-del,all,none,id,*,**; see man page for details [both]
    -M, --missing-rules TAG:METHOD    Rules for replacing missing values in numeric vectors (.,0,max) when unknown allele <*> is not present [.]
        --no-index                    Merg...
```


## bcftools_norm

### Tool Description
Left-align and normalize indels; check if REF alleles match the reference; split multiallelic sites into multiple rows; recover multiallelics from multiple rows.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Left-align and normalize indels; check if REF alleles match the reference;
         split multiallelic sites into multiple rows; recover multiallelics from
         multiple rows.
Usage:   bcftools norm [options] <in.vcf.gz>

Options:
    -a, --atomize                   Decompose complex variants (e.g. MNVs become consecutive SNVs)
        --atom-overlaps '*'|.       Use the star allele (*) for overlapping alleles or set to missing (.) [*]
    -c, --check-ref e|w|x|s         Check REF alleles and exit (e), warn (w), exclude (x), or set (s) bad sites [e]
    -D, --remove-duplicates         Remove duplicate lines of the same type.
    -d, --rm-dup TYPE               Remove duplicate snps|indels|both|all|exact
    -e, --exclude EXPR              Do not normalize records for which the expression is true (see man page for details)
    -f, --fasta-ref FILE            Reference sequence
        --force                     Try to proceed even if malformed tags are encountered. Experimental, use at your own risk
    -g, --gff-annot FILE            Follow HGVS 3'rule and right-align variants in transcripts on the forward strand
    -i, --include EXPR              Normalize only records for which the expression is true (see man page for details)
        --keep-sum TAG,..           Keep vector sum constant when splitting multiallelics (see github issue #360)
    -m, --multiallelics -|+TYPE     Split multiallelics (-) or join biallelics (+), type: snps|indels|both|any [both]
        --multi-overlaps 0|.        Fill in the reference (0) or missing (.) allele when splitting multiallelics [0]
        --no-version                Do not append version and command line to the header
    -N, --do-not-normalize          Do not normalize indels (with -m or -c s)
        --old-rec-tag STR           Annotate modified records with INFO/STR indicating the o...
```


## bcftools_plugin

### Tool Description
Run user defined plugin

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Run user defined plugin
Usage:   bcftools plugin <name> [OPTIONS] <file> [-- PLUGIN_OPTIONS]
         bcftools +name [OPTIONS] <file>  [-- PLUGIN_OPTIONS]

VCF input options:
   -e, --exclude EXPR             Exclude sites for which the expression is true
   -i, --include EXPR             Select sites for which the expression is true
   -r, --regions REGION           Restrict to comma-separated list of regions
   -R, --regions-file FILE        Restrict to regions listed in a file
       --regions-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
   -t, --targets REGION           Similar to -r but streams rather than index-jumps
   -T, --targets-file FILE        Similar to -R but streams rather than index-jumps
       --targets-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
VCF output options:
       --no-version               Do not append version and command line to the header
   -o, --output FILE              Write output to a file [standard output]
   -O, --output-type u|b|v|z[0-9] u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
       --threads INTT             Use multithreading with <int> worker threads [0]
Plugin options:
   -h, --help                     List plugin's options
   -l, --list-plugins             List available plugins. See BCFTOOLS_PLUGINS environment variable and man page for details
   -v, --verbosity INT            Verbosity level
   -V, --version                  Print version string and exit
   -W, --write-index[=FMT]        Automatically index the output files [off]


```


## bcftools_query

### Tool Description
Extracts fields from VCF/BCF file and prints them in user-defined format

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Extracts fields from VCF/BCF file and prints them in user-defined format
Usage:   bcftools query [options] <A.vcf.gz> [<B.vcf.gz> [...]]

Options:
    -e, --exclude EXPR                Exclude sites for which the expression is true (see man page for details)
        --force-samples               Only warn about unknown subset samples
    -F, --print-filtered STR          Output STR for samples failing the -i/-e filtering expression
    -f, --format STRING               See man page for details
    -H, --print-header                Print header, -HH to omit column indices
    -i, --include EXPR                Select sites for which the expression is true (see man page for details)
    -l, --list-samples                Print the list of samples and exit
    -N, --disable-automatic-newline   Disable automatic addition of newline character when not present
    -o, --output FILE                 Output file name [stdout]
    -r, --regions REGION              Restrict to comma-separated list of regions
    -R, --regions-file FILE           Restrict to regions listed in a file
        --regions-overlap 0|1|2       Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --samples LIST                List of samples to include
    -S, --samples-file FILE           File of samples to include
    -t, --targets REGION              Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE           Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2       Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
    -u, --allow-undef-tags            Print "." for undefined tags
    -v, --vcf-list FILE               Process multiple VCFs listed in the file
        --verbosity INT               Verbosity level

Examples:
	bcftools query -f '%CHR...
```


## bcftools_reheader

### Tool Description
Modify header of VCF/BCF files, change sample names.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
reheader: unrecognized option '--help'

About:   Modify header of VCF/BCF files, change sample names.
Usage:   bcftools reheader [OPTIONS] <in.vcf.gz>

Options:
    -f, --fai FILE             Update sequences and their lengths from the .fai file
    -h, --header FILE          New header
    -o, --output FILE          Write output to a file [standard output]
    -n, --samples-list LIST    New sample names given as a comma-separated list
    -N, --samples-file FILE    New sample names in a file, see the man page for details
    -T, --temp-prefix PATH     Ignored; was template for temporary file name
        --threads INT          Use multithreading with INT worker threads (BCF only) [0]
    -v, --verbosity INT        Verbosity level

Example:
   # Write out the header to be modified
   bcftools view -h old.bcf > header.txt

   # Edit the header using your favorite text editor
   vi header.txt

   # Reheader the file
   bcftools reheader -h header.txt -o new.bcf old.bcf


```


## bcftools_sort

### Tool Description
Sort VCF/BCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Sort VCF/BCF file.
Usage:   bcftools sort [OPTIONS] <FILE.vcf>

Options:
    -m, --max-mem FLOAT[kMG]       Maximum memory to use [768M]
    -o, --output FILE              Output file name [stdout]
    -O, --output-type u|b|v|z[0-9] u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
    -T, --temp-dir DIR             Temporary files [/tmp/bcftools.XXXXXX]
    -v, --verbosity INT            Verbosity level
    -W, --write-index[=FMT]        Automatically index the output files [off]


```


## bcftools_view

### Tool Description
VCF/BCF conversion, view, subset and filter VCF/BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
view: unrecognized option '--help'

About:   VCF/BCF conversion, view, subset and filter VCF/BCF files.
Usage:   bcftools view [options] <in.vcf.gz> [region1 [...]]

Output options:
    -G, --drop-genotypes              Drop individual genotype information (after subsetting if -s option set)
    -h, --header-only                 Print only the header in VCF output (equivalent to bcftools head)
    -H, --no-header                   Suppress the header in VCF output
        --with-header                 Print both header and records in VCF output [default]
    -l, --compression-level [0-9]     Compression level: 0 uncompressed, 1 best speed, 9 best compression [-1]
        --no-version                  Do not append version and command line to the header
    -o, --output FILE                 Output file name [stdout]
    -O, --output-type u|b|v|z[0-9]    u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
    -r, --regions REGION              Restrict to comma-separated list of regions
    -R, --regions-file FILE           Restrict to regions listed in FILE
        --regions-overlap 0|1|2       Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -t, --targets [^]REGION           Similar to -r but streams rather than index-jumps. Exclude regions with "^" prefix
    -T, --targets-file [^]FILE        Similar to -R but streams rather than index-jumps. Exclude regions with "^" prefix
        --targets-overlap 0|1|2       Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
        --threads INT                 Use multithreading with INT worker threads [0]
        --verbosity INT               Verbosity level

Subset options:
    -A, --trim-unseen-allele          Remove '<*>' or '<NON_REF>' at variant (-A) or at all (-AA) sites
    -a, --trim-alt-alleles            Tr...
```


## bcftools_call

### Tool Description
SNP/indel variant calling from VCF/BCF. To be used in conjunction with bcftools mpileup.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   SNP/indel variant calling from VCF/BCF. To be used in conjunction with bcftools mpileup.
         This command replaces the former "bcftools view" caller. Some of the original
         functionality has been temporarily lost in the process of transition to htslib,
         but will be added back on popular demand. The original calling model can be
         invoked with the -c option.
Usage:   bcftools call [options] <in.vcf.gz>

File format options:
       --no-version                Do not append version and command line to the header
   -o, --output FILE               Write output to a file [standard output]
   -O, --output-type b|u|z|v       Output type: 'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' uncompressed VCF [v]
   -O, --output-type u|b|v|z[0-9]  u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
       --ploidy ASSEMBLY[?]        Predefined ploidy, 'list' to print available settings, append '?' for details [2]
       --ploidy-file FILE          Space/tab-delimited list of CHROM,FROM,TO,SEX,PLOIDY
   -r, --regions REGION            Restrict to comma-separated list of regions
   -R, --regions-file FILE         Restrict to regions listed in a file
       --regions-overlap 0|1|2     Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
   -s, --samples LIST              List of samples to include [all samples]
   -S, --samples-file FILE         PED file or a file with an optional column with sex (see man page for details) [all samples]
   -t, --targets REGION            Similar to -r but streams rather than index-jumps
   -T, --targets-file FILE         Similar to -R but streams rather than index-jumps
       --threads INT               Use multithreading with INT worker threads [0]

Input/output options:
   -A, --keep-alts                 Keep all possib...
```


## bcftools_consensus

### Tool Description
Create consensus sequence by applying VCF variants to a reference fasta file. By default, the program will apply all ALT variants. Using the --samples (and, optionally, --haplotype) option will apply genotype (or haplotype) calls from FORMAT/GT.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
consensus: unrecognized option '--help'

About: Create consensus sequence by applying VCF variants to a reference fasta
       file. By default, the program will apply all ALT variants. Using the
       --samples (and, optionally, --haplotype) option will apply genotype
       (or haplotype) calls from FORMAT/GT. The program ignores allelic depth
       information, such as INFO/AD or FORMAT/AD.
Usage: bcftools consensus [OPTIONS] <file.vcf.gz>
Options:
    -c, --chain FILE               Write a chain file for liftover
    -a, --absent CHAR              Replace positions absent from VCF with CHAR
    -e, --exclude EXPR             Exclude sites for which the expression is true (see man page for details)
    -f, --fasta-ref FILE           Reference sequence in fasta format
    -H, --haplotype WHICH          Choose which allele to use from the FORMAT/GT field, note
                                   the codes are case-insensitive:
                                       N: N={1,2,3,..} is the index of the allele from GT, regardless of phasing (e.g. "2")
                                       R: REF allele in het genotypes
                                       A: ALT allele
                                       I: IUPAC code for all genotypes
                                       LR,LA: longer allele and REF/ALT if equal length
                                       SR,SA: shorter allele and REF/ALT if equal length
                                       NpIu: index of the allele for phased and IUPAC code for unphased GTs (e.g. "2pIu")
    -i, --include EXPR             Select sites for which the expression is true (see man page for details)
    -I, --iupac-codes              Output IUPAC codes based on FORMAT/GT, use -s/-S to subset samples
        --mark-del CHAR            Instead of removing sequence, insert character CHAR for deletions
  ...
```


## bcftools_cnv

### Tool Description
Copy number variation caller, requires Illumina's B-allele frequency (BAF) and Log R Ratio intensity (LRR). The HMM considers the following copy number states: CN 2 (normal), 1 (single-copy loss), 0 (complete loss), 3 (single-copy gain)

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
cnv: unrecognized option '--help'

About:   Copy number variation caller, requires Illumina's B-allele frequency (BAF) and Log R
         Ratio intensity (LRR). The HMM considers the following copy number states: CN 2
         (normal), 1 (single-copy loss), 0 (complete loss), 3 (single-copy gain)
Usage:   bcftools cnv [OPTIONS] FILE.vcf
General Options:
    -c, --control-sample STRING      Optional control sample name to highlight differences
    -f, --AF-file FILE               Read allele frequencies from file (CHR\tPOS\tREF,ALT\tAF)
    -o, --output-dir PATH            
    -p, --plot-threshold FLOAT       Plot aberrant chromosomes with quality at least FLOAT
    -r, --regions REGION             Restrict to comma-separated list of regions
    -R, --regions-file FILE          Restrict to regions listed in a file
        --regions-overlap 0|1|2      Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --query-sample STRING        Query samply name
    -t, --targets REGION             Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE          Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2      Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
    -v, --verbosity INT              Verbosity level
HMM Options:
    -a, --aberrant FLOAT[,FLOAT]     Fraction of aberrant cells in query and control [1.0,1.0]
    -b, --BAF-weight FLOAT           Relative contribution from BAF [1]
    -d, --BAF-dev FLOAT[,FLOAT]      Expected BAF deviation in query and control [0.04,0.04]
    -e, --err-prob FLOAT             Uniform error probability [1e-4]
    -k, --LRR-dev FLOAT[,FLOAT]      Expected LRR deviation [0.2,0.2]
    -l, --LRR-weight FLOAT           Relative contribution from LRR [0.2]
    -L, --LRR-smooth-win INT         Window...
```


## bcftools_csq

### Tool Description
Haplotype-aware consequence caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About: Haplotype-aware consequence caller.
Usage: bcftools csq [OPTIONS] in.vcf

Required options:
   -f, --fasta-ref FILE              Reference file in fasta format
   -g, --gff-annot FILE              GFF3 annotation file

CSQ options:
   -B, --trim-protein-seq INT        Abbreviate protein-changing predictions to max INT aminoacids
   -C, --genetic-code INT|l          Specify the genetic code table to use, 'l' to print a list [0]
   -c, --custom-tag STRING           Use this tag instead of the default BCSQ
   -l, --local-csq                   Localized predictions, consider only one VCF record at a time
   -n, --ncsq INT                    Maximum number of per-haplotype consequences to consider for each site [15]
   -p, --phase a|m|r|R|s             How to handle unphased heterozygous genotypes: [r]
                                       a: take GTs as is, create haplotypes regardless of phase (0/1 -> 0|1)
                                       m: merge *all* GTs into a single haplotype (0/1 -> 1, 1/2 -> 1)
                                       r: require phased GTs, throw an error on unphased het GTs
                                       R: create non-reference haplotypes if possible (0/1 -> 1|1, 1/2 -> 1|2)
                                       s: skip unphased hets
GFF options:
       --dump-gff FILE.gz            Dump the parsed GFF file (for debugging purposes)
       --force                       Run even if some sanity checks fail
       --unify-chr-names 0|LIST      Unify chromosome naming by stripping a prefix in VCF,GFF,fasta, respectively [0]
                                     (e.g., "chr,Chr,-" trims "chr" in VCF and "Chr" in GFF, fasta is unchanged)
General options:
   -e, --exclude EXPR                Exclude sites for which the expression is true
   -i, --include EXPR                Select sites for which the expres...
```


## bcftools_filter

### Tool Description
Apply fixed-threshold filters.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
filter: unrecognized option '--help'

About:   Apply fixed-threshold filters.
Usage:   bcftools filter [options] <in.vcf.gz>

Options:
    -e, --exclude EXPR             Exclude sites for which the expression is true (see man page for details)
    -g, --SnpGap INT[:TYPE]        Filter SNPs within <int> base pairs of an indel (the default) or any combination of indel,mnp,bnd,other,overlap
    -G, --IndelGap INT             Filter clusters of indels separated by <int> or fewer base pairs allowing only one to pass
    -i, --include EXPR             Include only sites for which the expression is true (see man page for details
        --mask [^]REGION           Soft filter regions, "^" to negate
    -M, --mask-file [^]FILE        Soft filter regions listed in a file, "^" to negate
        --mask-overlap 0|1|2       Mask if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -m, --mode [+x]                "+": do not replace but add to existing FILTER; "x": reset filters at sites which pass
        --no-version               Do not append version and command line to the header
    -o, --output FILE              Write output to a file [standard output]
    -O, --output-type u|b|v|z[0-9] u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
    -r, --regions REGION           Restrict to comma-separated list of regions
    -R, --regions-file FILE        Restrict to regions listed in a file
        --regions-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --soft-filter STRING       Annotate FILTER column with <string> or unique filter name ("Filter%d") made up by the program ("+")
    -S, --set-GTs .|0              Set genotypes of failed samples to missing (.) or ref (0)
    -t, --targets REGION           Similar to -r but streams rather than index-jump...
```


## bcftools_gtcheck

### Tool Description
Check sample identity. With no -g BCF given, multi-sample cross-check is performed.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Check sample identity. With no -g BCF given, multi-sample cross-check is performed.
Usage:   bcftools gtcheck [options] [-g <genotypes.vcf.gz>] <query.vcf.gz>

Options:
        --distinctive-sites            Find sites that can distinguish between at least NUM sample pairs.
                  NUM[,MEM[,TMP]]          If the number is smaller or equal to 1, it is interpreted as the fraction of pairs.
                                           The optional MEM string sets the maximum memory used for in-memory sorting [500M]
                                           and TMP is a prefix of temporary files used by external sorting [/tmp/bcftools.XXXXXX]
        --dry-run                      Stop after first record to estimate required time
    -E, --error-probability INT        Phred-scaled probability of genotyping error, 0 for faster but less accurate results [40]
    -e, --exclude [qry|gt]:EXPR        Exclude sites for which the expression is true
    -g, --genotypes FILE               Genotypes to compare against
    -H, --homs-only                    Homozygous genotypes only, useful with low coverage data (requires -g)
    -i, --include [qry|gt]:EXPR        Include sites for which the expression is true
        --keep-refs                    Keep monoallelic sites with no alternate allele
        --n-matches INT                Print only top INT matches for each sample (sorted by average score), 0 for unlimited.
                                           Use negative value to sort by HWE probability rather than by discordance [0]
        --no-HWE-prob                  Disable calculation of HWE probability
    -o, --output FILE                  Write output to a file [standard output]
    -O, --output-type t|z              t: plain tab-delimited text output, z: compressed [t]
    -p, --pairs LIST                   Comma-separated...
```


## bcftools_mpileup

### Tool Description
Generate VCF or BCF containing genotype likelihoods for one or multiple BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bcftools mpileup [options] in1.bam [in2.bam [...]]

Input options:
  -6, --illumina1.3+      Quality is in the Illumina-1.3+ encoding
  -A, --count-orphans     Include anomalous read pairs, with flag PAIRED but not PROPER_PAIR set
  -b, --bam-list FILE     List of input BAM filenames, one per line
  -B, --no-BAQ            Disable BAQ (per-Base Alignment Quality)
  -C, --adjust-MQ INT     Adjust mapping quality [0]
  -D, --full-BAQ          Apply BAQ everywhere, not just in problematic regions
  -d, --max-depth INT     Max raw per-file depth; avoids excessive memory usage [250]
  -E, --redo-BAQ          Recalculate BAQ on the fly, ignore existing BQs
  -f, --fasta-ref FILE    Faidx indexed reference sequence file
      --no-reference      Do not require fasta reference file
  -G, --read-groups FILE  Select or exclude read groups listed in the file
  -q, --min-MQ INT        Skip alignments with mapQ smaller than INT [0]
  -Q, --min-BQ INT        Skip bases with baseQ/BAQ smaller than INT [1]
      --max-BQ INT        Limit baseQ/BAQ to no more than INT [60]
      --delta-BQ INT      Use neighbour_qual + INT if less than qual [30]
  -r, --regions REG[,...] Comma separated list of regions in which pileup is generated
  -R, --regions-file FILE Restrict to regions listed in a file
      --ignore-RG         Ignore RG tags (one BAM = one sample)
  --ls, --skip-all-set STR|INT  Skip reads with all of the bits set []
  --ns, --skip-any-set STR|INT  Skip reads with any of the bits set [UNMAP,SECONDARY,QCFAIL,DUP]
  --lu, --skip-all-unset STR|INT  Skip reads with all of the bits unset []
  --nu, --skip-any-unset STR|INT  Skip reads with any of the bits unset []
  -s, --samples LIST      Comma separated list of samples to include
  -S, --samples-file FILE File of samples to include
  -t, --targets REG[,...] Similar to -r but streams rather than ...
```


## bcftools_polysomy

### Tool Description
Detect number of chromosomal copies from Illumina's B-allele frequency (BAF)

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
polysomy: unrecognized option '--help'

About:   Detect number of chromosomal copies from Illumina's B-allele frequency (BAF)
Usage:   bcftools polysomy [OPTIONS] FILE.vcf

General options:
    -o, --output-dir PATH          
    -r, --regions REGION           Restrict to comma-separated list of regions
    -R, --regions-file FILE        Restrict to regions listed in a file
        --regions-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --sample NAME              Sample to analyze
    -t, --targets REGION           Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE        Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
    -v, --verbosity INT            Verbosity level

Algorithm options:
    -b, --peak-size FLOAT          Minimum peak size (0-1, larger is stricter) [0.1]
    -c, --cn-penalty FLOA>         Penalty for increasing CN (0-1, larger is stricter) [0.7]
    -f, --fit-th FLOAT             Goodness of fit threshold (>0, smaller is stricter) [3.3]
    -i, --include-aa               Include the AA peak in CN2 and CN3 evaluation
    -m, --min-fraction FLOAT       Minimum distinguishable fraction of aberrant cells [0.1]
    -p, --peak-symmetry FLOAT      Peak symmetry threshold (0-1, larger is stricter) [0.5]


```


## bcftools_roh

### Tool Description
HMM model for detecting runs of autozygosity.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
roh: unrecognized option '--help'

About:   HMM model for detecting runs of autozygosity.
Usage:   bcftools roh [options] <in.vcf.gz>

General Options:
        --AF-dflt FLOAT              If AF is not known, use this allele frequency [skip]
        --AF-tag TAG                 Use TAG for allele frequency
        --AF-file FILE               read allele frequencies from file (CHR\tPOS\tREF,ALT\tAF)
    -b  --buffer-size INT[,INT]      Buffer size and the number of overlapping sites, 0 for unlimited [0]
                                       If the first number is negative, it is interpreted as the maximum memory to
                                       use, in MB. The default overlap is set to roughly 1% of the buffer size.
    -e, --estimate-AF [TAG],FILE     Estimate AF from FORMAT/TAG (GT or PL) of all samples ("-") or samples listed
                                       in FILE. If TAG is not given, the frequency is estimated from GT by default
        --exclude EXPR               Exclude sites for which the expression is true
    -G, --GTs-only FLOAT             Use GTs and ignore PLs, instead using FLOAT for PL of the two least likely genotypes.
                                       Safe value to use is 30 to account for GT errors.
        --include EXPR               Select sites for which the expression is true
    -i, --ignore-homref              Skip hom-ref genotypes (0/0)
        --include-noalt              Include sites with no ALT allele (ignored by default)
    -I, --skip-indels                Skip indels as their genotypes are enriched for errors
    -m, --genetic-map FILE           Genetic map in IMPUTE2 format, single file or mask, where string "{CHROM}"
                                       is replaced with chromosome name
    -M, --rec-rate FLOAT             Constant recombination rate per bp
    -o, --output FILE  ...
```


## bcftools_stats

### Tool Description
Parses VCF or BCF and produces stats which can be plotted using plot-vcfstats. When two files are given, the program generates separate stats for intersection and the complements.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Parses VCF or BCF and produces stats which can be plotted using plot-vcfstats.
         When two files are given, the program generates separate stats for intersection
         and the complements. By default only sites are compared, -s/-S must given to include
         also sample columns.
Usage:   bcftools stats [options] <A.vcf.gz> [<B.vcf.gz>]

Options:
        --af-bins LIST               Allele frequency bins, a list (0.1,0.5,1) or a file (0.1\n0.5\n1)
        --af-tag STRING              Allele frequency tag to use, by default estimated from AN,AC or GT
    -1, --1st-allele-only            Include only 1st allele at multiallelic sites
    -c, --collapse STRING            Treat as identical records with <snps|indels|both|all|some|none>, see man page for details [none]
    -d, --depth INT,INT,INT          Depth distribution: min,max,bin size [0,500,1]
    -e, --exclude EXPR               Exclude sites for which the expression is true (see man page for details)
    -E, --exons FILE.gz              Tab-delimited file with exons for indel frameshifts (chr,beg,end; 1-based, inclusive, bgzip compressed)
    -f, --apply-filters LIST         Require at least one of the listed FILTER strings (e.g. "PASS,.")
    -F, --fasta-ref FILE             Faidx indexed reference sequence file to determine INDEL context
    -i, --include EXPR               Select sites for which the expression is true (see man page for details)
    -I, --split-by-ID                Collect stats for sites with ID separately (known vs novel)
    -r, --regions REGION             Restrict to comma-separated list of regions
    -R, --regions-file FILE          Restrict to regions listed in a file
        --regions-overlap 0|1|2      Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --samples LIST               List of samples for s...
```


## bcftools_41

### Tool Description
BCFtools (Note: The provided help text indicates an unrecognized command error for '41')

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::main] unrecognized command '41'

```


## Metadata
- **Skill**: generated
