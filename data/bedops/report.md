# bedops CWL Generation Report

## bedops

### Tool Description
The provided text does not contain help information or usage instructions for the tool. It is a system error log indicating a failure to build or extract a container image due to insufficient disk space ('no space left on device').

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Total Downloads**: 229.2K
- **Last updated**: 2025-08-05
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-1971522541/rootfs/usr/local/bin/bedmap: no space left on device
```


## Metadata
- **Skill**: generated

## bedops_sort-bed

### Tool Description
Sort BED file(s). May use '-' to indicate stdin. Results are sent to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS

### Original Help Text
```text
sort-bed
  citation: http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract
            https://doi.org/10.1093/bioinformatics/bts277
  version:  2.4.42 (typical)
  authors:  Scott Kuehn

USAGE: sort-bed [--help] [--version] [--check-sort] [--max-mem <val>] [--tmpdir <path>] [--unique] [--duplicates] <file1.bed> <file2.bed> <...>
        Sort BED file(s).
        May use '-' to indicate stdin.
        Results are sent to stdout.

        <val> for --max-mem may be 8G, 8000M, or 8000000000 to specify 8 GB of memory.
        --tmpdir is useful only with --max-mem.
        --unique can be used to print only unique BED elements (similar to 'sort -u'). Cannot be used with --duplicates.
        --duplicates can be used to print only duplicated or repeated elements (similar to 'uniq -d'). Cannot be used with --unique.
```
## bedops_bedmap

### Tool Description
Traverse <ref-file>, while applying <operation(s)> on qualified, overlapping elements from <map-file>. Output is one line for each line in <ref-file>, sent to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS

### Original Help Text
```text
bedmap
  citation: http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract
            https://doi.org/10.1093/bioinformatics/bts277
  version:  2.4.42 (typical)
  authors:  Shane Neph & Scott Kuehn
                                                                                                    
 USAGE: bedmap [process-flags] [overlap-option] <operation(s)...> <ref-file> [map-file]             
     Any input file must be sorted per the sort-bed utility.                                        
     The program accepts BED and Starch file formats.                                               
     You may use '-' for a BED file to indicate the input comes from stdin.                         
                                                                                                    
     Traverse <ref-file>, while applying <operation(s)> on qualified, overlapping elements from     
       <map-file>.  Output is one line for each line in <ref-file>, sent to standard output.  There 
       is no limit on the number of operations you can specify to compute in one bedmap call.       
     If <map-file> is omitted, the given file is treated as both the <ref-file> and <map-file>.     
       This usage is more efficient than specifying the same file twice.                            
     Arguments may be given in any order before the input file(s).                                  
                                                                                                    
    Process Flags:                                                                                  
     --------                                                                                       
      --chrom <chromosome>  Jump to and process data for given <chromosome> only.                   
      --delim <delim>       Change output delimiter from '|' to <delim> between columns (e.g. '\t').
      --ec                  Error check all input files (slower).                                   
      --faster              (advanced) Strong input assumptions are made.  Compatible with:         
                              --bp-ovr, --range, --fraction-both, and --exact overlap options only. 
      --header              Accept headers (VCF, GFF, SAM, BED, WIG) in any input file.             
      --help                Print this message and exit successfully.                               
      --min-memory          Minimize memory usage (slower).                                         
      --multidelim <delim>  Change delimiter of multi-value output columns from ';' to <delim>.     
      --prec <int>          Change the post-decimal precision of scores to <int>.  0 <= <int>.      
      --sci                 Use scientific notation for score outputs.                              
      --skip-unmapped       Print no output for a row with no mapped elements.                      
      --sweep-all           Ensure <map-file> is read completely (helps to prevent broken pipes).   
      --unmapped-val <val>  Print <val> on unmapped --echo-map* and --min/max-element* operations.  
                              The default is to print nothing.                                      
      --version             Print program information.                                              
                                                                                                    
                                                                                                    
    Overlap Options (At most, one may be selected.  By default, --bp-ovr 1 is used):                
     --------                                                                                       
      --bp-ovr <int>           Require <int> bp overlap between elements of input files.            
      --exact                  First 3 fields from <map-file> must be identical to <ref-file>'s.    
      --fraction-both <val>    Both --fraction-ref <val> and --fraction-map <val> must be true to   
                                 qualify as overlapping.  Expect 0 < val <= 1.                      
      --fraction-either <val>  Either --fraction-ref <val> or --fraction-map <val> must be true to  
                                 qualify as overlapping.  Expect 0 < val <= 1.                      
      --fraction-map <val>     The fraction of the element's size from <map-file> that must overlap 
                                 the element in <ref-file>.  Expect 0 < val <= 1.                   
      --fraction-ref <val>     The fraction of the element's size from <ref-file> that must overlap 
                                 an element in <map-file>.  Expect 0 < val <= 1.                    
      --range <int>            Grab <map-file> elements within <int> bp of <ref-file>'s element,    
                                 where 0 <= int.  --range 0 is an alias for --bp-ovr 1.             
                                                                                                    
                                                                                                    
    Operations:  (Any number of operations may be used any number of times.)                        
     ----------                                                                                     
      SCORE:                                                                                        
       <ref-file> must have at least 3 columns and <map-file> 5 columns.                            
                                                                                                    
      --cv                The result of --stdev divided by the result of --mean.
      --kth <val>         Generalized median. Report the value, x, such that the fraction <val>
                            of overlapping elements' scores from <map-file> is less than x,
                            and the fraction 1-<val> of scores is greater than x.  0 < val <= 1.
      --mad <mult=1>      The median absolute deviation of overlapping elements in <map-file>.
                            Multiply mad score by <mult>.  0 < mult, and mult is 1 by default.
      --max               The highest score from overlapping elements in <map-file>.
      --max-element       A (non-random) highest-scoring and overlapping element in <map-file>.
      --max-element-rand  A random highest-scoring and overlapping element in <map-file>.
      --mean              The average score from overlapping elements in <map-file>.
      --median            The median score from overlapping elements in <map-file>.
      --min               The lowest score from overlapping elements in <map-file>.
      --min-element       A (non-random) lowest-scoring and overlapping element in <map-file>.
      --min-element-rand  A random lowest-scoring and overlapping element in <map-file>.
      --stdev             The square root of the result of --variance.
      --sum               Accumulated scores from overlapping elements in <map-file>.
      --tmean <low> <hi>  The mean score from overlapping elements in <map-file>, after
                            ignoring the bottom <low> and top <hi> fractions of those scores.
                            0 <= low <= 1.  0 <= hi <= 1.  low+hi <= 1.
      --variance          The variance of scores from overlapping elements in <map-file>.
      --wmean             Weighted mean, scaled in proportion to the coverage of the <ref-file>
                            element by each overlapping <map-file> element.
     
     ----------
      NON-SCORE:
       <ref-file> must have at least 3 columns.
       For --echo-map-id/echo-map-id-uniq, <map-file> must have at least 4 columns.
       For --echo-map-score, <map-file> must have at least 5 columns.
       For all others, <map-file> requires at least 3 columns.

      --bases             The total number of overlapping bases from <map-file>.
      --bases-uniq        The number of distinct bases from <ref-file>'s element covered by
                            overlapping elements in <map-file>.
      --bases-uniq-f      The fraction of distinct bases from <ref-file>'s element covered by
                            overlapping elements in <map-file>.
      --count             The number of overlapping elements in <map-file>.
      --echo              Print each line from <ref-file>.
      --echo-map          List all overlapping elements from <map-file>.
      --echo-map-id       List IDs from all overlapping <map-file> elements.
      --echo-map-id-uniq  List unique IDs from overlapping <map-file> elements.
      --echo-map-range    Print genomic range of overlapping elements from <map-file>.
      --echo-map-score    List scores from overlapping <map-file> elements.
      --echo-map-size     List the full length of every overlapping element.
      --echo-overlap-size List lengths of overlaps.
      --echo-ref-name     Print the first 3 fields of <ref-file> using chrom:start-end format.
      --echo-ref-row-id   Print 'id-' followed by the line number of <ref-file>.
      --echo-ref-size     Print the length of each line from <ref-file>.
      --indicator         Print 1 if there exists an overlapping element in <map-file>, 0 otherwise.
```
## bedops_closest-features

### Tool Description
For every element in <input-file>, determine the two elements from <query-file> falling nearest to its left and right edges. By default, echo the <input-file> element, followed by those left and right elements found in <query-file>.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS

### Original Help Text
```text
closest-features
  citation: http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract
            https://doi.org/10.1093/bioinformatics/bts277
  version:  2.4.42 (typical)
  authors:  Shane Neph & Scott Kuehn

USAGE: closest-features [Process-Flags] <input-file> <query-file>
   All input files must be sorted per sort-bed.
   The program accepts BED and Starch file formats
   May use '-' for a file to indicate reading from standard input (BED format only).

   For every element in <input-file>, determine the two elements from <query-file> falling
     nearest to its left and right edges (See NOTES below).  By default, echo the <input-file>
     element, followed by those left and right elements found in <query-file>.

  Process Flags:
    --chrom <chromosome>   Jump to and process data for given <chromosome> only.
    --closest              Choose the closest element for output only.  Ties go the left element.
    --delim <delim>        Change output delimiter from '|' to <delim> between columns (e.g. '\t')
    --dist                 Print the signed distances to the <input-file> element as additional
                             columns of output.  An overlapping element has a distance of 0.
    --ec                   Error check all input files (slower).
    --header               Accept headers (VCF, GFF, SAM, BED, WIG) in any input file.
    --help                 Print this message and exit successfully.
    --no-overlaps          Overlapping elements from <query-file> will not be reported.
    --no-ref               Do not echo elements from <input-file>.
    --no-query             Do not echo elements from <query-file>.
    --version              Print program information.

  NOTES:
    If an element from <query-file> overlaps the <input-file> element, its distance is zero.
      An overlapping element takes precedence over all non-overlapping elements.  This is true
      even when the overlapping element's edge-to-edge distance to the <input-file>'s element
      is greater than the edge-to-edge distance from a non-overlapping element.
    Overlapping elements may be ignored completely (no precedence) with --no-overlaps.
    Elements reported as closest to the left and right edges are never the same.
    When no qualifying element from <query-file> exists as a closest feature, 'NA' is reported.
```
## bedops_bedextract

### Tool Description
The provided text does not contain help information for the tool, but rather error logs from a container runtime (Singularity/Apptainer) indicating a 'no space left on device' failure during image extraction. Based on the tool name hint, bedextract is a BEDOPS utility used to quickly extract features from sorted BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-1259364496/rootfs/usr/local/bin/bedmap: no space left on device
```

## bedops_gff2bed

### Tool Description
The provided text does not contain help information for the tool; it is an error log describing a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-3144656372/rootfs/usr/local/bin/bedmap: no space left on device
```

## bedops_starch

### Tool Description
The provided text does not contain help information for the tool. It appears to be a system error log regarding a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-2224620709/rootfs/usr/local/bin/bedmap: no space left on device
```

## bedops_unstarch

### Tool Description
The provided text does not contain help information for the tool. It appears to be a system error log indicating a failure to build or extract a container image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-3614662249/rootfs/usr/local/bin/bedmap: no space left on device
```

## bedops_starchcat

### Tool Description
Concatenate, update metadata, or recompress lexicographically-sorted, headerless starch archives, performing a multiset union operation and sending compressed data to standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: No files specified
starchcat
  citation: http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract
            https://doi.org/10.1093/bioinformatics/bts277
  version:  2.4.42 (typical)
  authors:  Alex Reynolds and Shane Neph

USAGE: starchcat [ --note="..." ]
                 [ --bzip2 | --gzip ]
                 [ --omit-signature ]
                 [ --report-progress=N ] <starch-file-1> [<starch-file-2> ...]

    * At least one lexicographically-sorted, headerless starch archive is
      required.

    * While two or more inputs make sense for a multiset union operation, you
      can starchcat one file in order to update its metadata, recompress it
      with a different backend method, or add a note annotation.

    * Compressed data are sent to standard output. Use the '>' operator to
      redirect to a file.

    Process Flags
    --------------------------------------------------------------------------
    --note="foo bar..."   Append note to output archive metadata (optional).

    --bzip2 | --gzip      Specify backend compression type (optional, default
                          is bzip2).

    --omit-signature      Skip generating per-chromosome data integrity signature
                          (optional, default is to generate signature).

    --report-progress=N   Report compression progress every N elements per
                          chromosome to standard error stream (optional)

    --version             Show binary version.

    --help                Show this usage message.
```
## bedops_bam2bed

### Tool Description
The provided text does not contain help information or usage instructions for the tool. It is a system error log indicating a failure to build or extract a container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-2662418273/rootfs/usr/local/bin/bedmap: no space left on device
```

## bedops_gtf2bed

### Tool Description
A script to convert GTF (Gene Transfer Format) files to BED format. Note: The provided input text appears to be a container execution error log rather than help text, so no arguments could be extracted.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-3270268849/rootfs/usr/local/bin/bedmap: no space left on device
```

## bedops_vcf2bed

### Tool Description
The provided text does not contain help information for the tool. It contains system log messages and a fatal error indicating a failure to build or extract a container image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
- **Homepage**: http://bedops.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/bedops/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:cf543e2ec7e485a72e2c0d49b202d481d757646bb44885f51d20a835043f8545: unpack entry: usr/local/bin/bedmap: unpack to regular file: short write: write /scratch/21813747/build-temp-3432574815/rootfs/usr/local/bin/bedmap: no space left on device
```

