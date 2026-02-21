# perl-encode CWL Generation Report

## perl-encode

### Tool Description
FAIL to generate CWL: perl-encode not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-encode:3.19--pl5321hec16e2b_1
- **Homepage**: http://metacpan.org/pod/Encode
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-encode/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-encode/overview
- **Total Downloads**: 898.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-encode not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-encode not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## perl-encode_piconv

### Tool Description
Iconv-like interface to Encode, used for converting text from one encoding to another.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-encode:3.19--pl5321hec16e2b_1
- **Homepage**: http://metacpan.org/pod/Encode
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-encode/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Option h is ambiguous (help, htmlcref)
piconv [-f from_encoding] [-t to_encoding]
      [-p|--perlqq|--htmlcref|--xmlcref] [-C N|-c] [-D] [-S scheme]
      [-s string|file...]
piconv -l
piconv -r encoding_alias
piconv -h
Common options:
  -l,--list
     lists all available encodings
  -r,--resolve encoding_alias
    resolve encoding to its (Encode) canonical name
  -f,--from from_encoding  
     when omitted, the current locale will be used
  -t,--to to_encoding    
     when omitted, the current locale will be used
  -s,--string string         
     "string" will be the input instead of STDIN or files
The following are mainly of interest to Encode hackers:
  -C N | -c           check the validity of the input
  -D,--debug          show debug information
  -S,--scheme scheme  use the scheme for conversion
Those are handy when you can only see ASCII characters:
  -p,--perlqq         transliterate characters missing in encoding to \x{HHHH}
                      where HHHH is the hexadecimal Unicode code point
  --htmlcref          transliterate characters missing in encoding to &#NNN;
                      where NNN is the decimal Unicode code point
  --xmlcref           transliterate characters missing in encoding to &#xHHHH;
                      where HHHH is the hexadecimal Unicode code point
```

