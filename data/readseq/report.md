# readseq CWL Generation Report

## readseq

### Tool Description
Read & reformat biosequences, Java command-line version

### Metadata
- **Docker Image**: quay.io/biocontainers/readseq:2.1.30--1
- **Homepage**: http://iubio.bio.indiana.edu/soft/molbio/readseq/java/
- **Package**: https://anaconda.org/channels/bioconda/packages/readseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/readseq/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Readseq version 2.1.30 (12-May-2010)

  Read & reformat biosequences, Java command-line version
  Usage: java -cp readseq.jar run [options] input-file(s)
  For more details: java -cp readseq.jar help more

  Options
    -a[ll]              select All sequences
    -c[aselower]        change to lower case
    -C[ASEUPPER]        change to UPPER CASE
    -ch[ecksum]         calculate & print checksum of sequences
    -degap[=-]          remove gap symbols
    -f[ormat=]#         Format number for output,  or
    -f[ormat=]Name      Format name for output
          see Formats   list below for names and numbers
    -inform[at]=#       input format number,  or
    -inform[at]=Name    input format name.  Assume input data is this format
    -i[tem=2,3,4]       select Item number(s) from several
    -l[ist]             List sequences only
    -o[utput=]out.seq   redirect Output
    -p[ipe]             Pipe (command line, < stdin, > stdout)
    -r[everse]          reverse-complement of input sequence
    -t[ranslate=]io     translate input symbol [i] to output symbol [o]
                        use several -tio to translate several symbols
    -v[erbose]          Verbose progress
    -compare=1          Compare two sequence files, reporting differences (flags=nodoc,noid,nolen,nocrc)
    -amino[translate]   translate dna to amino acids
    
   Documentation and Feature Table extraction:
    -feat[ures]=exon,CDS...   extract sequence of selected features
    -nofeat[ures]=repeat_region,intron... remove sequence of selected features 
    -field=AC,ID...      include selected document fields in output
    -nofield=COMMENT,... remove selected document fields from output 
    
    -extract=1000..9999  * extract all features, sequence from given base range
    -subrange=-1000..10  * extract subrange of sequence for feature locations
    -subrange=1..end      
    -subrange=end-10..end+99  
    -pair=1              * combine features (fff,gff) and sequence files to one output
    -unpair=1            * split features,sequence from one input to two files
                             
   Pretty format options:
    -wid[th]=#            sequence line width
    -tab=#                left indent
    -col[space]=#         column space within sequence line on output
    -gap[count]           count gap chars in sequence numbers
    -nameleft, -nameright[=#]   name on left/right side [=max width]
    -nametop              name at top/bottom
    -numleft, -numright   seq index on left/right side
    -numtop, -numbot      index on top/bottom
    -match[=.]            use match base for 2..n species
    -inter[line=#]        blank line(s) between sequence blocks

This program requires a Java runtime (java or jre) program, version 1.1.x, 1.2 or later
The leading '-' on option is optional if '=' is present.  All non-options
(no leading '-' or embedded '=') are used as input file names.
These options and call format are compatible with the classic readseq (v.1992)
* New experimental feature handling options, may not yet work as desired.
To test readeq, use: java -cp readseq.jar test
  
  Known biosequence formats:
 ID  Name             Read  Write  Int'leaf  Features  Sequence  Suffix  Content-type
  1  IG|Stanford      yes    yes        --        --       yes   .ig     biosequence/ig
  2  GenBank|gb       yes    yes        --       yes       yes   .gb     biosequence/genbank
  3  NBRF             yes    yes        --        --       yes   .nbrf   biosequence/nbrf
  4  EMBL|em          yes    yes        --       yes       yes   .embl   biosequence/embl
  5  GCG              yes    yes        --        --       yes   .gcg    biosequence/gcg
  6  DNAStrider       yes    yes        --        --       yes   .strider  biosequence/strider
  7  Fitch             --     --        --        --       yes   .fitch  biosequence/fitch
  8  Pearson|Fasta|fa   yes    yes        --        --       yes   .fasta  biosequence/fasta
  9  Zuker             --     --        --        --       yes   .zuker  biosequence/zuker
 10  Olsen             --     --       yes        --       yes   .olsen  biosequence/olsen
 11  Phylip3.2        yes    yes       yes        --       yes   .phylip2  biosequence/phylip2
 12  Phylip|Phylip4   yes    yes       yes        --       yes   .phylip  biosequence/phylip
 13  Plain|Raw        yes    yes        --        --       yes   .seq    biosequence/plain
 14  PIR|CODATA       yes    yes        --        --       yes   .pir    biosequence/codata
 15  MSF              yes    yes       yes        --       yes   .msf    biosequence/msf
 16  ASN.1             --     --        --        --       yes   .asn    biosequence/asn1
 17  PAUP|NEXUS       yes    yes       yes        --       yes   .nexus  biosequence/nexus
 18  Pretty            --    yes       yes        --       yes   .pretty  biosequence/pretty
 19  XML              yes    yes        --       yes       yes   .xml    biosequence/xml
 20  BLAST            yes     --       yes        --       yes   .blast  biosequence/blast
 21  SCF              yes     --        --        --       yes   .scf    biosequence/scf
 22  Clustal          yes    yes       yes        --       yes   .aln    biosequence/clustal
 23  FlatFeat|FFF     yes    yes        --       yes        --   .fff    biosequence/fff
 24  GFF              yes    yes        --       yes        --   .gff    biosequence/gff
 25  ACEDB            yes    yes        --        --       yes   .ace    biosequence/acedb
   (Int'leaf = interleaved format; Features = documentation/features are parsed)


  Readseq version 2.1.30 (12-May-2010)

  Read & reformat biosequences, Java command-line version
  Usage: java -cp readseq.jar run [options] input-file(s)
  For more details: java -cp readseq.jar help more

  Options
    -a[ll]              select All sequences
    -c[aselower]        change to lower case
    -C[ASEUPPER]        change to UPPER CASE
    -ch[ecksum]         calculate & print checksum of sequences
    -degap[=-]          remove gap symbols
    -f[ormat=]#         Format number for output,  or
    -f[ormat=]Name      Format name for output
          see Formats   list below for names and numbers
    -inform[at]=#       input format number,  or
    -inform[at]=Name    input format name.  Assume input data is this format
    -i[tem=2,3,4]       select Item number(s) from several
    -l[ist]             List sequences only
    -o[utput=]out.seq   redirect Output
    -p[ipe]             Pipe (command line, < stdin, > stdout)
    -r[everse]          reverse-complement of input sequence
    -t[ranslate=]io     translate input symbol [i] to output symbol [o]
                        use several -tio to translate several symbols
    -v[erbose]          Verbose progress
    -compare=1          Compare two sequence files, reporting differences (flags=nodoc,noid,nolen,nocrc)
    -amino[translate]   translate dna to amino acids
    
   Documentation and Feature Table extraction:
    -feat[ures]=exon,CDS...   extract sequence of selected features
    -nofeat[ures]=repeat_region,intron... remove sequence of selected features 
    -field=AC,ID...      include selected document fields in output
    -nofield=COMMENT,... remove selected document fields from output 
    
    -extract=1000..9999  * extract all features, sequence from given base range
    -subrange=-1000..10  * extract subrange of sequence for feature locations
    -subrange=1..end      
    -subrange=end-10..end+99  
    -pair=1              * combine features (fff,gff) and sequence files to one output
    -unpair=1            * split features,sequence from one input to two files
                             
   Pretty format options:
    -wid[th]=#            sequence line width
    -tab=#                left indent
    -col[space]=#         column space within sequence line on output
    -gap[count]           count gap chars in sequence numbers
    -nameleft, -nameright[=#]   name on left/right side [=max width]
    -nametop              name at top/bottom
    -numleft, -numright   seq index on left/right side
    -numtop, -numbot      index on top/bottom
    -match[=.]            use match base for 2..n species
    -inter[line=#]        blank line(s) between sequence blocks

This program requires a Java runtime (java or jre) program, version 1.1.x, 1.2 or later
The leading '-' on option is optional if '=' is present.  All non-options
(no leading '-' or embedded '=') are used as input file names.
These options and call format are compatible with the classic readseq (v.1992)
* New experimental feature handling options, may not yet work as desired.
To test readeq, use: java -cp readseq.jar test
  
  Known biosequence formats:
 ID  Name             Read  Write  Int'leaf  Features  Sequence  Suffix  Content-type
  1  IG|Stanford      yes    yes        --        --       yes   .ig     biosequence/ig
  2  GenBank|gb       yes    yes        --       yes       yes   .gb     biosequence/genbank
  3  NBRF             yes    yes        --        --       yes   .nbrf   biosequence/nbrf
  4  EMBL|em          yes    yes        --       yes       yes   .embl   biosequence/embl
  5  GCG              yes    yes        --        --       yes   .gcg    biosequence/gcg
  6  DNAStrider       yes    yes        --        --       yes   .strider  biosequence/strider
  7  Fitch             --     --        --        --       yes   .fitch  biosequence/fitch
  8  Pearson|Fasta|fa   yes    yes        --        --       yes   .fasta  biosequence/fasta
  9  Zuker             --     --        --        --       yes   .zuker  biosequence/zuker
 10  Olsen             --     --       yes        --       yes   .olsen  biosequence/olsen
 11  Phylip3.2        yes    yes       yes        --       yes   .phylip2  biosequence/phylip2
 12  Phylip|Phylip4   yes    yes       yes        --       yes   .phylip  biosequence/phylip
 13  Plain|Raw        yes    yes        --        --       yes   .seq    biosequence/plain
 14  PIR|CODATA       yes    yes        --        --       yes   .pir    biosequence/codata
 15  MSF              yes    yes       yes        --       yes   .msf    biosequence/msf
 16  ASN.1             --     --        --        --       yes   .asn    biosequence/asn1
 17  PAUP|NEXUS       yes    yes       yes        --       yes   .nexus  biosequence/nexus
 18  Pretty            --    yes       yes        --       yes   .pretty  biosequence/pretty
 19  XML              yes    yes        --       yes       yes   .xml    biosequence/xml
 20  BLAST            yes     --       yes        --       yes   .blast  biosequence/blast
 21  SCF              yes     --        --        --       yes   .scf    biosequence/scf
 22  Clustal          yes    yes       yes        --       yes   .aln    biosequence/clustal
 23  FlatFeat|FFF     yes    yes        --       yes        --   .fff    biosequence/fff
 24  GFF              yes    yes        --       yes        --   .gff    biosequence/gff
 25  ACEDB            yes    yes        --        --       yes   .ace    biosequence/acedb
   (Int'leaf = interleaved format; Features = documentation/features are parsed)
```

