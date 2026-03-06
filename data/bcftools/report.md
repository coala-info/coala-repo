# bcftools CWL Generation Report

## Runtime validation summary

| Tool | Runtime | Data used | Reason (if fail) |
|------|---------|-----------|------------------|
| bcftools_annotate | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_call | FAIL | plan:pileup.vcf | WARNING Final process status is permanentFail |
| bcftools_cnv | FAIL | plan:vcf_file.vcf.gz | WARNING Final process status is permanentFail |
| bcftools_concat | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_consensus | FAIL | plan:vcf_file.vcf.gz | } |
| bcftools_convert | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_csq | FAIL | plan:vcf_file.vcf.gz, plan:minimal.fa, plan:gff_file.gff | WARNING Final process status is permanentFail |
| bcftools_filter | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_gtcheck | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_head | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_index | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_isec | FAIL | plan:vcf_file.vcf.gz | WARNING Final process status is permanentFail |
| bcftools_merge | FAIL | plan:vcf_file.vcf.gz | WARNING Final process status is permanentFail |
| bcftools_mpileup | PASS | plan:mpileup.1.bam | — |
| bcftools_norm | FAIL | plan:vcf_file.vcf.gz | WARNING Final process status is permanentFail |
| bcftools_plugin | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_polysomy | FAIL | plan:vcf_file.vcf.gz | WARNING Final process status is permanentFail |
| bcftools_query | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_reheader | FAIL | plan:vcf_file.vcf.gz | WARNING Final process status is permanentFail |
| bcftools_roh | FAIL | plan:vcf_file.vcf.gz | baseCommand 'bcftools' not found in container; the image may… |
| bcftools_sort | FAIL | plan:vcf_file.vcf | WARNING Final process status is permanentFail |
| bcftools_stats | PASS | plan:vcf_file.vcf.gz | — |
| bcftools_view | PASS | plan:vcf_file.vcf.gz | — |


## bcftools_index

### Tool Description
Index VCF or BCF files for random access.

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
[E::main_vcfindex] must specify an output path for index file when reading VCF/BCF from stdin
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_index_job.json`

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
annotate: option '--h' is ambiguous; possibilities: '--header-lines' '--header-line'

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
       --pair-logic STR            Matching records by <snps|indels|both|all|some|exact|id>, see man page for details [some]
   -r, --regions REGION            Restrict to comma-separated list of regions
   -R, --regions-file FILE         Restrict to regions listed in FILE
       --regions-overlap 0|1|2     Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
       --rename-annots FILE        Rename annotations: TYPE/old\tnew, where TYPE is one of FILTER,INFO,FORMAT
       --rename-chrs FILE          Rename sequences according to the mapping: old\tnew
   -s, --samples [^]LIST           Comma separated list of samples to annotate (or exclude with "^" prefix)
   -S, --samples-file [^]FILE      File of samples to annotate (or exclude with "^" prefix)
       --single-overlaps           Keep memory low by avoiding complexities arising from handling multiple overlapping intervals
   -x, --remove LIST               List of annotations (e.g. ID,INFO/DP,FORMAT/DP,FILTER) to remove (or keep with "^" prefix). See man page for details
       --threads INT               Number of extra output compression threads [0]
   -v, --verbosity INT             Verbosity level
   -W, --write-index[=FMT]         Automatically index the output files [off]

Examples:
   http://samtools.github.io/bcftools/howtos/annotate.html
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_annotate_job.json`

## bcftools_concat

### Tool Description
Concatenate or combine VCF/BCF files. All source files must have the same sample columns appearing in the same order. The input files must be sorted by chr and position.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
concat: option requires an argument -- 'h'

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
   -o, --output FILE              Write output to a file [standard output]
   -O, --output-type u|b|v|z[0-9] u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
   -q, --min-PQ INT               Break phase set if phasing quality is lower than <int> [30]
   -r, --regions REGION           Restrict to comma-separated list of regions
   -R, --regions-file FILE        Restrict to regions listed in a file
       --regions-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
       --threads INT              Use multithreading with <int> worker threads [0]
   -v, --verbosity INT            Set verbosity level
   -W, --write-index[=FMT]        Automatically index the output files [off]
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_concat_job.json`

## bcftools_convert

### Tool Description
Converts VCF/BCF to other formats and back.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
convert: option '--h' is ambiguous; possibilities: '--hapsample' '--hapsample2vcf' '--haploid2diploid' '--haplegendsample' '--haplegendsample2vcf'

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
       --3N6                      Use 3*N+6 column format instead of the old 3*N+5 column format
       --tag STRING               Tag to take values for .gen file: GT,PL,GL,GP [GT]
       --chrom                    Output chromosome in first column instead of CHROM:POS_REF_ALT
       --keep-duplicates          Keep duplicate positions
       --sex FILE                 Output sex column in the sample-file, input format is: Sample\t[MF]
       --vcf-ids                  Output VCF IDs in second column instead of CHROM:POS_REF_ALT

gVCF conversion:
       --gvcf2vcf                 Expand gVCF reference blocks
   -f, --fasta-ref FILE           Reference sequence in fasta format

HAP/SAMPLE conversion (output from SHAPEIT):
       --hapsample2vcf ...        <PREFIX>|<HAP-FILE>,<SAMPLE-FILE>
       --hapsample ...            <PREFIX>|<HAP-FILE>,<SAMPLE-FILE>
       --haploid2diploid          Convert haploid genotypes to diploid homozygotes
       --sex FILE                 Output sex column in the sample-file, input format is: Sample\t[MF]
       --vcf-ids                  Output VCF IDs instead of CHROM:POS_REF_ALT

HAP/LEGEND/SAMPLE conversion:
   -H, --haplegendsample2vcf ...  <PREFIX>|<HAP-FILE>,<LEGEND-FILE>,<SAMPLE-FILE>
   -h, --haplegendsample ...      <PREFIX>|<HAP-FILE>,<LEGEND-FILE>,<SAMPLE-FILE>
       --haploid2diploid          Convert haploid genotypes to diploid homozygotes
       --sex FILE                 Output sex column in the sample-file, input format is: Sample\t[MF]
       --vcf-ids                  Output VCF IDs instead of CHROM:POS_REF_ALT

TSV conversion:
       --tsv2vcf FILE
   -c, --columns STRING           Columns of the input tsv file, see man page for details [ID,CHROM,POS,AA]
   -f, --fasta-ref FILE           Reference sequence in fasta format
   -s, --samples LIST             List of sample names
   -S, --samples-file FILE        File of sample names
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_convert_job.json`

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
head: option '--headers' requires an argument

About: Displays VCF/BCF headers and optionally the first few variant records
Usage: bcftools head [OPTION]... [FILE]

Options:
  -h, --headers INT      Display INT header lines [all]
  -n, --records INT      Display INT variant record lines [none]
  -s, --samples INT      Display INT records starting with the #CHROM header line [none]
  -v, --verbosity INT    Verbosity level
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 1 (CWL modified by LLM)
- **Example job**: `bcftools_head_job.json`

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
        --threads INT              Use multithreading with INT worker threads [0]
    -v, --verbosity INT            Verbosity level
    -w, --write LIST               List of files to write with -p given as 1-based indexes. By default, all files are written
    -W, --write-index[=FMT]        Automatically index the output files [off]

Examples:
   # Create intersection and complements of two sets saving the output in dir/*
   bcftools isec A.vcf.gz B.vcf.gz -p dir

   # Filter sites in A and B (but not in C) and create intersection
   bcftools isec -e'MAF<0.01' -i'dbSNP=1' -e - A.vcf.gz B.vcf.gz C.vcf.gz -p dir

   # Extract and write records from A shared by both A and B using exact allele match
   bcftools isec A.vcf.gz B.vcf.gz -p dir -n =2 -w 1

   # Extract and write records from C found in A and C but not in B
   bcftools isec A.vcf.gz B.vcf.gz C.vcf.gz -p dir -n~101 -w 3

   # Extract records private to A or B comparing by position only
   bcftools isec A.vcf.gz B.vcf.gz -p dir -n -1 -c all
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_isec_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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
        --no-index                    Merge unindexed files, the same chromosomal order is required and -r/-R are not allowed
        --no-version                  Do not append version and command line to the header
    -o, --output FILE                 Write output to a file [standard output]
    -O, --output-type u|b|v|z[0-9]    u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
    -r, --regions REGION              Restrict to comma-separated list of regions
    -R, --regions-file FILE           Restrict to regions listed in a file
        --regions-overlap 0|1|2       Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
        --threads INT                 Use multithreading with INT worker threads [0]
    -v, --verbosity INT               Verbosity level
    -W, --write-index[=FMT]           Automatically index the output files [off]
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_merge_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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
        --old-rec-tag STR           Annotate modified records with INFO/STR indicating the original variant
    -o, --output FILE               Write output to a file [standard output]
    -O, --output-type u|b|v|z[0-9]  u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level [v]
    -r, --regions REGION            Restrict to comma-separated list of regions
    -R, --regions-file FILE         Restrict to regions listed in a file
        --regions-overlap 0|1|2     Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --strict-filter             When merging (-m+), merged site is PASS only if all sites being merged PASS
    -S, --sort METHOD               Sort order: chr_pos,lex [chr_pos]
    -t, --targets REGION            Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE         Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2     Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
        --threads INT               Use multithreading with INT worker threads [0]
    -v, --verbosity INT             Verbosity level
    -w, --site-win INT              Buffer for sorting lines which changed position during realignment [1000]
    -W, --write-index[=FMT]         Automatically index the output files [off]

Examples:
   # normalize and left-align indels
   bcftools norm -f ref.fa in.vcf

   # split multi-allelic sites
   bcftools norm -m- in.vcf
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_norm_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_plugin_job.json`

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
	bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%SAMPLE=%GT]\n' file.vcf.gz
	# For more examples see http://samtools.github.io/bcftools/bcftools.html#query
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_query_job.json`

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
reheader: option '--header' requires an argument

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


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_reheader_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_sort_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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
    -a, --trim-alt-alleles            Trim ALT alleles not seen in the genotype fields (or their subset with -s/-S)
    -I, --no-update                   Do not (re)calculate INFO fields for the subset (currently INFO/AC and INFO/AN)
    -s, --samples [^]LIST             Comma separated list of samples to include (or exclude with "^" prefix). Be careful
                                        when combining filtering with sample subsetting as filtering comes (usually) first.
                                        If unsure, split sample subsetting and filtering in two commands, using -Ou when piping.
    -S, --samples-file [^]FILE        File of samples to include (or exclude with "^" prefix)
        --force-samples               Only warn about unknown subset samples

Filter options:
    -c/C, --min-ac/--max-ac INT[:TYPE]     Minimum/maximum count for non-reference (nref), 1st alternate (alt1), least frequent
                                               (minor), most frequent (major) or sum of all but most frequent (nonmajor) alleles [nref]
    -f,   --apply-filters LIST             Require at least one of the listed FILTER strings (e.g. "PASS,.")
    -g,   --genotype [^]hom|het|miss       Require one or more hom/het/missing genotype or, if prefixed with "^", exclude such sites
    -i/e, --include/--exclude EXPR         Select/exclude sites for which the expression is true (see man page for details)
    -k/n, --known/--novel                  Select known/novel sites only (ID is not/is '.')
    -m/M, --min-alleles/--max-alleles INT  Minimum/maximum number of alleles listed in REF and ALT (e.g. -m2 -M2 for biallelic sites)
    -p/P, --phased/--exclude-phased        Select/exclude sites where all samples are phased
    -q/Q, --min-af/--max-af FLOAT[:TYPE]   Minimum/maximum frequency for non-reference (nref), 1st alternate (alt1), least frequent
                                               (minor), most frequent (major) or sum of all but most frequent (nonmajor) alleles [nref]
    -u/U, --uncalled/--exclude-uncalled    Select/exclude sites without a called genotype
    -v/V, --types/--exclude-types LIST     Select/exclude comma-separated list of variant types: snps,indels,mnps,ref,bnd,other [null]
    -x/X, --private/--exclude-private      Select/exclude sites where the non-reference alleles are exclusive (private) to the subset samples
    -W,   --write-index[=FMT]              Automatically index the output files [off]
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_view_job.json`

## bcftools_call

### Tool Description
SNP/indel variant calling from VCF/BCF. To be used in conjunction with bcftools mpileup. This command replaces the former 'bcftools view' caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
- **Homepage**: https://github.com/samtools/bcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools/overview
- **Validation**: PASS

### Original Help Text
```text
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
   -A, --keep-alts                 Keep all possible alternate alleles at variant sites
   -*, --keep-unseen-allele        Keep the unobserved allele <*> or <NON_REF>
   -a, --annotate LIST             Optional tags to output (lowercase allowed); '?' to list available tags
   -F, --prior-freqs AN,AC         Use prior allele frequencies, determined from these pre-filled tags
   -G, --group-samples FILE|-      Group samples by population (file with "sample\tgroup") or "-" for single-sample calling.
                                   This requires FORMAT/QS or other Number=R,Type=Integer tag such as FORMAT/AD
       --group-samples-tag TAG     The tag to use with -G, by default FORMAT/QS and FORMAT/AD are checked automatically
   -g, --gvcf INT,[...]            Group non-variant sites into gVCF blocks by minimum per-sample DP
   -i, --insert-missed             Output also sites missed by mpileup but present in -T
   -M, --keep-masked-ref           Keep sites with masked reference allele (REF=N)
   -V, --skip-variants TYPE        Skip indels/snps
   -v, --variants-only             Output variant sites only
       --verbosity INT             Verbosity level
   -W, --write-index[=FMT]         Automatically index the output files [off]

Consensus/variant calling options:
   -c, --consensus-caller          The original calling method (conflicts with -m)
   -C, --constrain STR             One of: alleles, trio (see manual)
   -m, --multiallelic-caller       Alternative model for multiallelic and rare-variant calling (conflicts with -c)
   -n, --novel-rate FLOAT,[...]    Likelihood of novel mutation for constrained trio calling, see man page for details [1e-8,1e-9,1e-9]
   -p, --pval-threshold FLOAT      Variant if P(ref|D)<FLOAT with -c [0.5]
   -P, --prior FLOAT               Mutation rate (use bigger for greater sensitivity), use with -m [1.1e-3]

Example:
   # See also http://samtools.github.io/bcftools/howtos/variant-calling.html
   bcftools mpileup -Ou -f reference.fa alignments.bam | bcftools call -mv -Ob -o calls.bcf
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:pileup.vcf
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_call_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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
consensus: option '--haplotype' requires an argument

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
        --mark-ins uc|lc|CHAR      Highlight insertions in uppercase (uc), lowercase (lc), or use CHAR, leaving the rest as is
        --mark-snv uc|lc|CHAR      Highlight substitutions in uppercase (uc), lowercase (lc), or use CHAR, leaving the rest as is
    -m, --mask FILE                Replace regions according to the next --mask-with option. The default is --mask-with N
        --mask-with CHAR|uc|lc     Replace with CHAR (skips overlapping variants); change to uppercase (uc) or lowercase (lc)
    -M, --missing CHAR             Output CHAR instead of skipping a missing genotype "./."
    -o, --output FILE              Write output to a file [standard output]
    -p, --prefix STRING            Prefix to add to output sequence names
        --regions-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --samples LIST             Comma-separated list of samples to include, "-" to ignore samples and use REF,ALT
    -S, --samples-file FILE        File of samples to include
    -v, --verbosity INT            Verbosity level
Examples:
   # Get the consensus for one region. The fasta header lines are then expected
   # in the form ">chr:from-to".
   samtools faidx ref.fa 8:11870-11890 | bcftools consensus in.vcf.gz > out.fa

   # See also http://samtools.github.io/bcftools/howtos/consensus-sequence.html
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_consensus_job.json`
- **Reason (not pass)**:                              }

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
    -L, --LRR-smooth-win INT         Window of LRR moving average smoothing [10]
    -O, --optimize FLOAT             Estimate fraction of aberrant cells down to FLOAT [1.0]
    -P, --same-prob FLOA>            Prior probability of -s/-c being the same [0.5]
    -x, --xy-prob FLOAT              P(x|y) transition probability [1e-9]
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_cnv_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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
   -i, --include EXPR                Select sites for which the expression is true
       --no-version                  Do not append version and command line to the header
   -o, --output FILE                 Write output to a file [standard output]
   -O, --output-type b|u|z|v|t[0-9]  b: compressed BCF, u: uncompressed BCF, z: compressed VCF
                                     v: uncompressed VCF, t: plain tab-delimited text output, 0-9: compression level [v]
   -r, --regions REGION              Restrict to comma-separated list of regions
   -R, --regions-file FILE           Restrict to regions listed in a file
       --regions-overlap 0|1|2       Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
   -s, --samples -|LIST              Samples to include or "-" to apply all variants and ignore samples
   -S, --samples-file FILE           Samples to include
   -t, --targets REGION              Similar to -r but streams rather than index-jumps
   -T, --targets-file FILE           Similar to -R but streams rather than index-jumps
       --targets-overlap 0|1|2       Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
       --threads INT                 Use multithreading with <int> worker threads [0]
   -v, --verbosity INT               Verbosity level 0-6 [1]
   -W, --write-index[=FMT]           Automatically index the output files [off]

Example:
   bcftools csq -f hs37d5.fa -g Homo_sapiens.GRCh37.87.gff3.gz in.vcf

   # GFF3 annotation files can be downloaded from Ensembl. e.g. for human:
   http://ftp.ensembl.org/pub/current_gff3/homo_sapiens/
   http://ftp.ensembl.org/pub/grch37/current/gff3/homo_sapiens/
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz, plan:minimal.fa, plan:gff_file.gff
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_csq_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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
    -t, --targets REGION           Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE        Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2    Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
        --threads INT              Use multithreading with <int> worker threads [0]
    -v, --verbosity INT            Verbosity level
    -W, --write-index[=FMT]        Automatically index the output files [off]
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_filter_job.json`

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
gtcheck: option '--h' is ambiguous; possibilities: '--homs-only' '--help'

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
    -p, --pairs LIST                   Comma-separated sample pairs to compare (qry,gt[,qry,gt..] with -g or qry,qry[,qry,qry..] w/o)
    -P, --pairs-file FILE              File with tab-delimited sample pairs to compare (qry,gt with -g or qry,qry w/o)
    -r, --regions REGION               Restrict to comma-separated list of regions
    -R, --regions-file FILE            Restrict to regions listed in a file
        --regions-overlap 0|1|2        Include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --samples [qry|gt]:LIST        List of query or -g samples, "-" to select all samples (by default all samples are compared)
    -S, --samples-file [qry|gt]:FILE   File with the query or -g samples to compare
    -t, --targets REGION               Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE            Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2        Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
    -u, --use TAG1[,TAG2]              Which tag to use in the query file (TAG1) and the -g file (TAG2) [PL,GT]
    -v, --verbosity INT                Verbosity level
Examples:
   # Check discordance of all samples from B against all samples in A
   bcftools gtcheck -g A.bcf B.bcf

   # Limit comparisons to the given list of samples
   bcftools gtcheck -s gt:a1,a2,a3 -s qry:b1,b2 -g A.bcf B.bcf

   # Compare only two pairs a1,b1 and a1,b2
   bcftools gtcheck -p a1,b1,a1,b2 -g A.bcf B.bcf
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_gtcheck_job.json`

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
  -t, --targets REG[,...] Similar to -r but streams rather than index-jumps
  -T, --targets-file FILE Similar to -R but streams rather than index-jumps
  -x, --ignore-overlaps   Disable read-pair overlap detection
      --seed INT          Random number seed used for sampling deep regions [0]

Output options:
  -a, --annotate LIST     Optional tags to output; '\?' to list available tags []
  -g, --gvcf INT[,...]    Group non-variant sites into gVCF blocks according
                          To minimum per-sample DP
      --no-version        Do not append version and command line to the header
  -o, --output FILE       Write output to FILE [standard output]
  -O, --output-type TYPE  'b' compressed BCF; 'u' uncompressed BCF;
                          'z' compressed VCF; 'v' uncompressed VCF; 0-9 compression level [v]
      --threads INT       Use multithreading with INT worker threads [0]
  -v, --verbosity INT     Verbosity level
  -W, --write-index[=FMT] Automatically index the output files [off]

SNP/INDEL genotype likelihoods options:
  -X, --config STR        Specify platform profile (use "-X list" for details)
  -e, --ext-prob INT      Phred-scaled gap extension seq error probability [20]
  -F, --gap-frac FLOAT    Minimum fraction of gapped reads [0.05]
  -h, --tandem-qual INT   Coefficient for homopolymer errors [500]
  -I, --skip-indels       Do not perform indel calling
  -L, --max-idepth INT    Maximum per-file depth for INDEL calling [250]
  -m, --min-ireads INT    Minimum number gapped reads for indel candidates [2]
  -M, --max-read-len INT  Maximum length of read to pass to BAQ algorithm [500]
  -o, --open-prob INT     Phred-scaled gap open seq error probability [40]
  -p, --per-sample-mF     Apply -m and -F per-sample for increased sensitivity
  -P, --platforms STR     Comma separated list of platforms for indels [all]
  --ar, --ambig-reads STR   What to do with ambiguous indel reads: drop,incAD,incAD0 [drop]
      --indel-bias FLOAT  Raise to favour recall over precision [1.00]
      --del-bias FLOAT    Relative likelihood of insertion to deletion [0.00]
      --score-vs-ref FLOAT
                          Ratio of score vs ref (1) or 2nd-best allele (0) [0.00]
      --indel-size INT    Approximate maximum indel size considered [110]
      --indels-2.0        New EXPERIMENTAL indel calling model (diploid reference consensus)
      --indels-cns        New EXPERIMENTAL indel calling model with edlib
      --seqq-offset       Indel-cns tuning for indel seq-qual scores [120]
      --no-indels-cns     Disable CNS mode, to use after a -X profile
      --poly-mqual        (Edlib mode) Use minimum quality within homopolymers

Notes: Assuming diploid individuals.

Example:
   # See also http://samtools.github.io/bcftools/howtos/variant-calling.html
   bcftools mpileup -Ou -f reference.fa alignments.bam | bcftools call -mv -Ob -o calls.bcf
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:mpileup.1.bam
- **Fix rounds**: 1 (CWL modified by LLM)
- **Example job**: `bcftools_mpileup_job.json`

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


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_polysomy_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

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
roh: option '--hw-to-az' requires an argument

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
    -o, --output FILE                Write output to a file [standard output]
    -O, --output-type [srz]          Output s:per-site, r:regions, z:compressed [sr]
    -r, --regions REGION             Restrict to comma-separated list of regions
    -R, --regions-file FILE          Restrict to regions listed in a file
        --regions-overlap 0|1|2      include if POS in the region (0), record overlaps (1), variant overlaps (2) [1]
    -s, --samples LIST               List of samples to analyze [all samples]
    -S, --samples-file FILE          File of samples to analyze [all samples]
    -t, --targets REGION             Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE          Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2      Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
        --threads INT                Use multithreading with <int> worker threads [0]
    -v, --verbosity INT              Verbosity level

HMM Options:
    -a, --hw-to-az FLOAT             P(AZ|HW) transition probability from HW (Hardy-Weinberg) to AZ (autozygous) state [6.7e-8]
    -H, --az-to-hw FLOAT             P(HW|AZ) transition probability from AZ to HW state [5e-9]
    -V, --viterbi-training FLOAT     Estimate HMM parameters, FLOAT is the convergence threshold, e.g. 1e-10 (experimental)

Example:
   # Find RoH regions assuming default allele frequency 0.4
   bcftools roh -G30 --AF-dflt 0.4 test.vcf -o out.txt

   # Create HTML/JavaScript visualization with the accompanied roh-viz script
   misc/roh-viz -i out.txt -v test.vcf -o out.html
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:vcf_file.vcf.gz
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `bcftools_roh_job.json`
- **Reason (not pass)**: baseCommand 'bcftools' not found in container; the image may not provide this executable. CWL generation/validation failed. Original error: INFO /media/qhu/slim/Workspace/cwlagent/.venv/bin/cwltool 3.1.20260108082145
INFO Resolved '/media

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
    -s, --samples LIST               List of samples for sample stats, "-" to include all samples
    -S, --samples-file FILE          File of samples to include
    -t, --targets REGION             Similar to -r but streams rather than index-jumps
    -T, --targets-file FILE          Similar to -R but streams rather than index-jumps
        --targets-overlap 0|1|2      Include if POS in the region (0), record overlaps (1), variant overlaps (2) [0]
    -u, --user-tstv TAG[:min:max:n]  Collect Ts/Tv stats for any tag using the given binning [0:1:100]
                                       A subfield can be selected as e.g. 'PV4[0]', here the first value of the PV4 tag
        --threads INT                Use multithreading with <int> worker threads [0]
    -v, --verbosity INT              Verbosity level
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `bcftools_stats_job.json`
