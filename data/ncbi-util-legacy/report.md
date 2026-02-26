# ncbi-util-legacy CWL Generation Report

## ncbi-util-legacy_asntool

### Tool Description
AsnTool 7 arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
- **Homepage**: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/ncbi-util-legacy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ncbi-util-legacy/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
AsnTool 7   arguments:

  -m  ASN.1 Module File [File In]
  -f  ASN.1 Module File [File Out]  Optional
  -X  XML DTD File
	("m" to print each module to a separate file) [File Out]  Optional
  -T  ASN.1 Tree Dump File [File Out]  Optional
  -v  Print Value File [File In]  Optional
  -p  Print Value File [File Out]  Optional
  -x  XML Data File [File Out]  Optional
  -d  Binary Value File (type required) [File In]  Optional
  -t  Binary Value Type [String]  Optional
  -e  Binary Value File [File Out]  Optional
  -o  Header File [File Out]  Optional
  -l  Loader File [File Out]  Optional
  -b  Buffer Size [Integer]  Optional
    default = 1024
    range from 512 to 10000
  -w  Word length maximum for #defines [Integer]  Optional
    default = 31
    range from 31 to 128
  -F  Fix Non-Printing Characters
     0 - Replace with #, post ERROR
     1 - Replace with # silently
     2 - Pass through silently
     3 - Replace with #, post FATAL
 [Integer]  Optional
    default = 0
    range from 0 to 3
  -N  UTF8 Input Conversion
     0 - Convert silently
     1 - Convert, post WARNING first time
     2 - Convert, post WARNING each time
     3 - Do not convert
 [Integer]  Optional
    default = 0
    range from 0 to 3
  -U  UTF8 Output Conversion
     0 - Convert silently
     1 - Convert, post WARNING first time
     2 - Convert, post WARNING each time
     3 - Do not convert
 [Integer]  Optional
    default = 0
    range from 0 to 3
  -G  Generate object loader .c and .h files, 
	if used, see below parameters: [T/F]  Optional
    default = F
  -M  ASN.1 module filenames, comma separated used for external refs from the 'm',
     but no other action taken [File In]  Optional
  -B  Base for filename, without extensions, for generated objects and code [File Out]  Optional
  -D  During code generation, debugging level
     0 - No debugging
     1 - Shallow debugging
     2 - Deep
 [Integer]  Optional
    default = 0
    range from 0 to 9
  -S  Debugging filename [File Out]  Optional
    default = stderr
  -I  In generated .c, add #include to this filename [String]  Optional
  -Z  Bit twiddle for optional zero value base slots [T/F]  Optional
    default = F
  -K  In generated .c, forces name of #included asn header [String]  Optional
  -J  Register type with object manager [String]  Optional
  -L  Label for registered type [String]  Optional
  -P  XML module prefix for DOCTYPE [String]  Optional
    default = 
  -V  Force choice to use structure instead of ValNodePtr [T/F]  Optional
    default = F
  -Q  Use quoted syntax form for generated include files [T/F]  Optional
    default = F
```


## ncbi-util-legacy_errhdr

### Tool Description
Prints error header information.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
- **Homepage**: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/ncbi-util-legacy/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:  errhdr [options] msgfile [hdrfile] 

  options:  -2 for code,subcode tuples
            -s for short subcode defines
```


## ncbi-util-legacy_gene2xml

### Tool Description
Converts NCBI gene information files to XML format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
- **Homepage**: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/
- **Package**: https://anaconda.org/channels/bioconda/packages/ncbi-util-legacy/overview
- **Validation**: PASS

### Original Help Text
```text
gene2xml 1.5   arguments:

  -p  Path to Files [String]  Optional
  -r  Path for Results [String]  Optional
  -i  Single Input File [File In]  Optional
    default = stdin
  -o  Single Output File [File Out]  Optional
    default = stdout
  -b  File is Binary [T/F]  Optional
    default = F
  -c  File is Compressed [T/F]  Optional
    default = F
  -t  Taxon ID to Filter [Integer]  Optional
    default = 0
  -x  Extract .ags -> text .agc [T/F]  Optional
    default = F
  -y  Combine .agc -> text .ags (for testing) [T/F]  Optional
    default = F
  -z  Combine .agc -> binary .ags, then gzip [T/F]  Optional
    default = F
  -l  Log Processing [T/F]  Optional
    default = F
```

