# kallisto CWL Generation Report

## kallisto_index

### Tool Description
Builds a kallisto index

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Total Downloads**: 287.8K
- **Last updated**: 2026-03-21
- **GitHub**: https://github.com/pachterlab/kallisto
- **Stars**: N/A
### Original Help Text
```text
kallisto 0.52.0
Builds a kallisto index

Usage: kallisto index [arguments] FASTA-files

Required argument:
-i, --index=STRING          Filename for the kallisto index to be constructed 

Optional argument:
-k, --kmer-size=INT         k-mer (odd) length (default: 31, max value: 63)
-t, --threads=INT           Number of threads to use (default: 1)
-d, --d-list=STRING         Path to a FASTA-file containing sequences to mask from quantification
    --make-unique           Replace repeated target names with unique names
    --aa                    Generate index from a FASTA-file containing amino acid sequences
    --distinguish           Generate index where sequences are distinguished by the sequence name
-T, --tmp=STRING            Temporary directory (default: tmp)
-m, --min-size=INT          Length of minimizers (default: automatically chosen)
-e, --ec-max-size=INT       Maximum number of targets in an equivalence class (default: no maximum)
```


## kallisto_quant

### Tool Description
Computes equivalence classes for reads and quantifies abundances

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0
Computes equivalence classes for reads and quantifies abundances

Usage: kallisto quant [arguments] FASTQ-files

Required arguments:
-i, --index=STRING            Filename for the kallisto index to be used for
                              quantification
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
-b, --bootstrap-samples=INT   Number of bootstrap samples (default: 0)
    --seed=INT                Seed for the bootstrap sampling (default: 42)
    --plaintext               Output plaintext instead of HDF5
    --single                  Quantify single-end reads
    --single-overhang         Include reads where unobserved rest of fragment is
                              predicted to lie outside a transcript
    --fr-stranded             Strand specific reads, first read forward
    --rf-stranded             Strand specific reads, first read reverse
-l, --fragment-length=DOUBLE  Estimated average fragment length
-s, --sd=DOUBLE               Estimated standard deviation of fragment length
                              (default: -l, -s values are estimated from paired
                               end data, but are required when using --single)
-p, --priors                  Priors for the EM algorithm, either as raw counts or as
                              probabilities. Pseudocounts are added to raw reads to
                              prevent zero valued priors. Supplied in the same order
                              as the transcripts in the transcriptome
    --pseudobam               Save pseudoalignments to transcriptome to BAM file
    --genomebam               Project pseudoalignments to genome sorted BAM file
-g, --gtf                     GTF file for transcriptome information
                              (required for --genomebam)
-c, --chromosomes             Tab separated file with chromosome names and lengths
                              (optional for --genomebam, but recommended)
-t, --threads=INT             Number of threads to use (default: 1)
    --verbose                 Print out progress information every 1M proccessed reads
```


## kallisto_quant-tcc

### Tool Description
Quantifies abundance from pre-computed transcript-compatibility counts

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0
Quantifies abundance from pre-computed transcript-compatibility counts

Usage: kallisto quant-tcc [arguments] transcript-compatibility-counts-file

Required arguments:
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
-i, --index=STRING            Filename for the kallisto index to be used
                              (required if file with names of transcripts not supplied)
-T, --txnames=STRING          File with names of transcripts
                              (required if index file not supplied)
-e, --ec-file=FILE            File containing equivalence classes
                              (default: equivalence classes are taken from the index)
-f, --fragment-file=FILE      File containing fragment length distribution
                              (default: effective length normalization is not performed)
--long                        Use version of EM for long reads 
-P, --platform.               [PacBio or ONT] used for sequencing 
-l, --fragment-length=DOUBLE  Estimated average fragment length
-s, --sd=DOUBLE               Estimated standard deviation of fragment length
                              (note: -l, -s values only should be supplied when
                               effective length normalization needs to be performed
                               but --fragment-file is not specified)
-p, --priors                  Priors for the EM algorithm, either as raw counts or as
                              probabilities. Pseudocounts are added to raw reads to
                              prevent zero valued priors. Supplied in the same order
                              as the transcripts in the transcriptome
-t, --threads=INT             Number of threads to use (default: 1)
-g, --genemap                 File for mapping transcripts to genes
                              (required for obtaining gene-level abundances)
-G, --gtf=FILE                GTF file for transcriptome information
                              (can be used instead of --genemap for obtaining gene-level abundances)
-b, --bootstrap-samples=INT   Number of bootstrap samples (default: 0)
    --matrix-to-files         Reorganize matrix output into abundance tsv files
    --matrix-to-directories   Reorganize matrix output into abundance tsv files across multiple directories
    --seed=INT                Seed for the bootstrap sampling (default: 42)
    --plaintext               Output plaintext only, not HDF5
```


## kallisto_bus

### Tool Description
Generates BUS files for single-cell sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0
Generates BUS files for single-cell sequencing

Usage: kallisto bus [arguments] FASTQ-files

Required arguments:
-i, --index=STRING            Filename for the kallisto index to be used for
                              pseudoalignment
-o, --output-dir=STRING       Directory to write output to

Optional arguments:
-x, --technology=STRING       Single-cell technology used 
-l, --list                    List all single-cell technologies supported
-B, --batch=FILE              Process files listed in FILE
-t, --threads=INT             Number of threads to use (default: 1)
-b, --bam                     Input file is a BAM file
-n, --num                     Output number of read in flag column (incompatible with --bam)
-N, --numReads                Maximum number of reads to process from supplied input
-T, --tag=STRING              5′ tag sequence to identify UMI reads for certain technologies
    --fr-stranded             Strand specific reads for UMI-tagged reads, first read forward
    --rf-stranded             Strand specific reads for UMI-tagged reads, first read reverse
    --unstranded              Treat all read as non-strand-specific
    --paired                  Treat reads as paired
    --long                    Treat reads as long
    --threshold               Threshold for rate of unmapped kmers per read
    --aa                      Align to index generated from a FASTA-file containing amino acid sequences
    --inleaved                Specifies that input is an interleaved FASTQ file
    --batch-barcodes          Records both batch and extracted barcode in BUS file
    --genomebam               Project pseudoalignments to genome sorted BAM file
-g, --gtf                     GTF file for transcriptome information
                              (required for --genomebam)
-c, --chromosomes             Tab separated file with chromosome names and lengths
                              (optional for --genomebam, but recommended)
    --verbose                 Print out progress information every 1M proccessed reads
```


## kallisto_h5dump

### Tool Description
HDF5 dump tool to display HDF5 file contents

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: h5dump [OPTIONS] files
  OPTIONS
     -h,   --help         Print a usage message and exit
     -V,   --version      Print version number and exit
--------------- Error Options ---------------
     --enable-error-stack Prints messages from the HDF5 error stack as they occur.
                          Optional value 2 also prints file open errors.
                          Default setting disables any error reporting.
--------------- File Options ---------------
     -n,   --contents     Print a list of the file contents and exit
                          Optional value 1 also prints attributes.
     -B,   --superblock   Print the content of the super block
     -H,   --header       Print the header only; no data is displayed
     -f D, --filedriver=D Specify which driver to open the file with
     -o F, --output=F     Output raw data into file F
     -b B, --binary=B     Binary file output, of form B
     -O F, --ddl=F        Output ddl text into file F
                          Use blank(empty) filename F to suppress ddl display
     --s3-cred=<cred>     Supply S3 authentication information to "ros3" vfd.
                          <cred> :: "(<aws-region>,<access-id>,<access-key>)"
                          If absent or <cred> -> "(,,)", no authentication.
                          Has no effect if filedriver is not "ros3".
     --hdfs-attrs=<attrs> Supply configuration information for HDFS file access.
                          For use with "--filedriver=hdfs"
                          <attrs> :: (<namenode name>,<namenode port>,
                                      <kerberos cache path>,<username>,
                                      <buffer size>)
                          Any absent attribute will use a default value.
     --vol-value          Value (ID) of the VOL connector to use for opening the
                          HDF5 file specified
     --vol-name           Name of the VOL connector to use for opening the
                          HDF5 file specified
     --vol-info           VOL-specific info to pass to the VOL connector used for
                          opening the HDF5 file specified
                          If none of the above options are used to specify a VOL, then
                          the VOL named by HDF5_VOL_CONNECTOR (or the native VOL connector,
                          if that environment variable is unset) will be used
     --vfd-value          Value (ID) of the VFL driver to use for opening the
                          HDF5 file specified
     --vfd-name           Name of the VFL driver to use for opening the
                          HDF5 file specified
     --vfd-info           VFD-specific info to pass to the VFL driver used for
                          opening the HDF5 file specified
--------------- Object Options ---------------
     -a P, --attribute=P  Print the specified attribute
                          If an attribute name contains a slash (/), escape the
                          slash with a preceding backslash (\).
                          (See example section below.)
     -d P, --dataset=P    Print the specified dataset
     -g P, --group=P      Print the specified group and all members
     -l P, --soft-link=P  Print the value(s) of the specified soft link
     -t P, --datatype=P   Print the specified named datatype
     -N P, --any_path=P   Print any attribute, dataset, group, datatype, or link that matches P
                          P can be the absolute path or just a relative path.
     -A,   --onlyattr     Print the header and value of attributes
                          Optional value 0 suppresses printing attributes.
     --vds-view-first-missing Set the VDS bounds to first missing mapped elements.
     --vds-gap-size=N     Set the missing file gap size, N=non-negative integers
--------------- Object Property Options ---------------
     -i,   --object-ids   Print the object ids
     -p,   --properties   Print dataset filters, storage layout and fill value
     -M L, --packedbits=L Print packed bits as unsigned integers, using mask
                          format L for an integer dataset specified with
                          option -d. L is a list of offset,length values,
                          separated by commas. Offset is the beginning bit in
                          the data value and length is the number of bits of
                          the mask.
     -R,   --region       Print dataset pointed by region references
--------------- Formatting Options ---------------
     -e,   --escape       Escape non printing characters
     -r,   --string       Print 1-byte integer datasets as ASCII
     -y,   --noindex      Do not print array indices with the data
     -m T, --format=T     Set the floating point output format
     -q Q, --sort_by=Q    Sort groups and attributes by index Q
     -z Z, --sort_order=Z Sort groups and attributes by order Z
     --no-compact-subset  Disable compact form of subsetting and allow the use
                          of "[" in dataset names.
     -w N, --width=N      Set the number of columns of output. A value of 0 (zero)
                          sets the number of columns to the maximum (65535).
                          Default width is 80 columns.
--------------- XML Options ---------------
     -x,   --xml          Output in XML using Schema
     -u,   --use-dtd      Output in XML using DTD
     -D U, --xml-dtd=U    Use the DTD or schema at U
     -X S, --xml-ns=S     (XML Schema) Use qualified names n the XML
                          ":": no namespace, default: "hdf5:"
                          E.g., to dump a file called "-f", use h5dump -- -f

--------------- Subsetting Options ---------------
 Subsetting is available by using the following options with a dataset
 option. Subsetting is done by selecting a hyperslab from the data.
 Thus, the options mirror those for performing a hyperslab selection.
 One of the START, COUNT, STRIDE, or BLOCK parameters are mandatory if you do subsetting.
 The STRIDE, COUNT, and BLOCK parameters are optional and will default to 1 in
 each dimension. START is optional and will default to 0 in each dimension.

      -s START,  --start=START    Offset of start of subsetting selection
      -S STRIDE, --stride=STRIDE  Hyperslab stride
      -c COUNT,  --count=COUNT    Number of blocks to include in selection
      -k BLOCK,  --block=BLOCK    Size of block in hyperslab
  START, COUNT, STRIDE, and BLOCK - is a list of integers the number of which are equal to the
      number of dimensions in the dataspace being queried
      (Alternate compact form of subsetting is described in the Reference Manual)

--------------- Option Argument Conventions ---------------
  D - is the file driver to use in opening the file. Acceptable values
      are "sec2", "family", "split", "multi", "direct", and "stream". Without
      the file driver flag, the file will be opened with each driver in
      turn and in the order specified above until one driver succeeds
      in opening the file.
      See examples below for family, split, and multi driver special file name usage.

  F - is a filename.
  P - is the full path from the root group to the object.
  N - is an integer greater than 1.
  T - is a string containing the floating point format, e.g '%.3f'
  U - is a URI reference (as defined in [IETF RFC 2396],
        updated by [IETF RFC 2732])
  B - is the form of binary output: NATIVE for a memory type, FILE for the
        file type, LE or BE for pre-existing little or big endian types.
        Must be used with -o (output file) and it is recommended that
        -d (dataset) is used. B is an optional argument, defaults to NATIVE
  Q - is the sort index type. It can be "creation_order" or "name" (default)
  Z - is the sort order type. It can be "descending" or "ascending" (default)

--------------- Examples ---------------

  1) Attribute foo of the group /bar_none in file quux.h5

      h5dump -a /bar_none/foo quux.h5

     Attribute "high/low" of the group /bar_none in the file quux.h5

      h5dump -a "/bar_none/high\/low" quux.h5

  2) Selecting a subset from dataset /foo in file quux.h5

      h5dump -d /foo -s "0,1" -S "1,1" -c "2,3" -k "2,2" quux.h5

  3) Saving dataset 'dset' in file quux.h5 to binary file 'out.bin'
        using a little-endian type

      h5dump -d /dset -b LE -o out.bin quux.h5

  4) Display two packed bits (bits 0-1 and bits 4-6) in the dataset /dset

      h5dump -d /dset -M 0,1,4,3 quux.h5

  5) Dataset foo in files file1.h5 file2.h5 file3.h5

      h5dump -d /foo file1.h5 file2.h5 file3.h5

  6) Dataset foo in split files splitfile-m.h5 splitfile-r.h5

      h5dump -d /foo -f split splitfile

  7) Dataset foo in multi files mf-s.h5, mf-b.h5, mf-r.h5, mf-g.h5, mf-l.h5 and mf-o.h5

      h5dump -d /foo -f multi mf

  8) Dataset foo in family files fam00000.h5 fam00001.h5 and fam00002.h5

      h5dump -d /foo -f family fam%05d.h5
```


## kallisto_inspect

### Tool Description
Inspect a kallisto index file

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: PASS

### Original Help Text
```text
kallisto 0.52.0

Usage: kallisto inspect INDEX-file

Optional arguments:
-t                      Number of threads
```


## kallisto_cite

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
- **Homepage**: https://pachterlab.github.io/kallisto
- **Package**: https://anaconda.org/channels/bioconda/packages/kallisto/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
When using this program in your research, please cite

  Bray, N. L., Pimentel, H., Melsted, P. & Pachter, L.
  Near-optimal probabilistic RNA-seq quantification, 
  Nature Biotechnology 34, 525-527(2016), doi:10.1038/nbt.3519
```

