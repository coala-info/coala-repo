# pal2nal CWL Generation Report

## pal2nal

### Tool Description
FAIL to generate CWL: pal2nal not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: biocontainers/pal2nal:v14.1-2-deb_cv1
- **Homepage**: http://www.bork.embl.de/pal2nal/
- **Package**: https://anaconda.org/channels/bioconda/packages/pal2nal/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pal2nal/overview
- **Total Downloads**: 15.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pal2nal not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pal2nal not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pal2nal_pal2nal.pl

### Tool Description
pal2nal is a program that converts a multiple sequence alignment of proteins and the corresponding DNA (or mRNA) sequences into a codon-based DNA alignment.

### Metadata
- **Docker Image**: biocontainers/pal2nal:v14.1-2-deb_cv1
- **Homepage**: http://www.bork.embl.de/pal2nal/
- **Package**: https://anaconda.org/channels/bioconda/packages/pal2nal/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").

pal2nal.pl  (v14)

Usage:  pal2nal.pl  pep.aln  nuc.fasta  [nuc.fasta...]  [options]


    pep.aln:    protein alignment either in CLUSTAL or FASTA format

    nuc.fasta:  DNA sequences (single multi-fasta or separated files)

    Options:  -h            Show help 

              -output (clustal|paml|fasta|codon)
                            Output format; default = clustal

              -blockonly    Show only user specified blocks
                            '#' under CLUSTAL alignment (see example)

              -nogap        remove columns with gaps and inframe stop codons

              -nomismatch   remove mismatched codons (mismatch between
                            pep and cDNA) from the output

              -codontable  N
                    1  Universal code (default)
                    2  Vertebrate mitochondrial code
                    3  Yeast mitochondrial code
                    4  Mold, Protozoan, and Coelenterate Mitochondrial code
                       and Mycoplasma/Spiroplasma code
                    5  Invertebrate mitochondrial
                    6  Ciliate, Dasycladacean and Hexamita nuclear code
                    9  Echinoderm and Flatworm mitochondrial code
                   10  Euplotid nuclear code
                   11  Bacterial, archaeal and plant plastid code
                   12  Alternative yeast nuclear code
                   13  Ascidian mitochondrial code
                   14  Alternative flatworm mitochondrial code
                   15  Blepharisma nuclear code
                   16  Chlorophycean mitochondrial code
                   21  Trematode mitochondrial code
                   22  Scenedesmus obliquus mitochondrial code
                   23  Thraustochytrium mitochondrial code


              -html         HTML output (only for the web server)

              -nostderr     No STDERR messages (only for the web server)


    - sequence order in pep.aln and nuc.fasta should be the same.

    - IDs in pep.aln are used in the output.
```

