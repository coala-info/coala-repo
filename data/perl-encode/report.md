# perl-encode CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-encode_enc2xs | PASS |  |
| perl-encode_encguess | Failed | tool bug: -s splits the suspect list on the literal string ':,' so a list of encodings is not split and gives a wrong guess (EUC-CN for a JIS X 0208 file) |
| perl-encode_piconv | PASS |  |

## perl-encode_encguess

### Tool Description
Guess the character encoding of files

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-encode:3.19--pl5321hec16e2b_1
- **Homepage**: http://metacpan.org/pod/Encode
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-encode/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
      encguess [switches] filename...

  Switches:
    -h
      show this message and exit.

    -s
      specify a list of "suspect encoding types" to test, seperated by
      either ":" or ","

    -S
      output a list of all acceptable encoding types that can be used with
      the -s param

    -u
      suppress display of unidentified types

  Examples:
    * Guess encoding of a file named "test.txt", using only the default
      suspect types.

         encguess test.txt

    * Guess the encoding type of a file named "test.txt", using the suspect
      types "euc-jp,shiftjis,7bit-jis".

         encguess -s euc-jp,shiftjis,7bit-jis test.txt
         encguess -s euc-jp:shiftjis:7bit-jis test.txt

    * Guess the encoding type of several files, do not display results for
      unidentified files.

         encguess -us euc-jp,shiftjis,7bit-jis test*.txt
```

## perl-encode_enc2xs

### Tool Description
Perl Encode module generator from .ucm or .enc mapping files

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-encode:3.19--pl5321hec16e2b_1
- **Homepage**: http://metacpan.org/pod/Encode
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-encode/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    enc2xs -- Perl Encode Module Generator

SYNOPSIS
      enc2xs -[options]
      enc2xs -M ModName mapfiles...
      enc2xs -C

DESCRIPTION
    enc2xs builds a Perl extension for use by Encode from either Unicode
    Character Mapping files (.ucm) or Tcl Encoding Files (.enc). Besides
    being used internally during the build process of the Encode module, you
    can use enc2xs to add your own encoding to perl. No knowledge of XS is
    necessary.

Quick Guide
    If you want to know as little about Perl as possible but need to add a
    new encoding, just read this chapter and forget the rest.

    0.  Have a .ucm file ready. You can get it from somewhere or you can
        write your own from scratch or you can grab one from the Encode
        distribution and customize it. For the UCM format, see the next
        Chapter. In the example below, I'll call my theoretical encoding
        myascii, defined in *my.ucm*. "$" is a shell prompt.
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

