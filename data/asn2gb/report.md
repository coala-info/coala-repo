# asn2gb CWL Generation Report

## asn2gb

### Tool Description
Convert ASN.1 to GenBank/EMBL/GenPept flatfile formats

### Metadata
- **Docker Image**: quay.io/biocontainers/asn2gb:18.2--0
- **Homepage**: https://www.ncbi.nlm.nih.gov/IEB/ToolBox/C_DOC/lxr/source/doc/asn2gb.txt
- **Package**: https://anaconda.org/channels/bioconda/packages/asn2gb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/asn2gb/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
asn2gb 18.2   arguments:

  -i  Input File Name [File In]
    default = stdin
  -o  Output File Name [File Out]
    default = stdout
  -f  Format (b GenBank, e EMBL, p GenPept, t Feature Table, x INSDSet) [String]
    default = b
  -m  Mode (r Release, e Entrez, s Sequin, d Dump) [String]
    default = s
  -s  Style (n Normal, s Segment, m Master, c Contig) [String]
    default = n
  -g  Bit Flags (1 HTML, 2 XML, 4 ContigFeats, 8 ContigSrcs, 16 FarTransl) [Integer]
    default = 0
  -h  Lock/Lookup Flags (8 LockProd, 16 LookupComp, 64 LookupProd) [Integer]
    default = 0
  -u  Custom Flags (4 HideFeats, 1792 HideRefs, 8192 HideSources, 262144 HideTranslation) [Integer]
    default = 0
  -a  ASN.1 Type
      Single Record: a Any, e Seq-entry, b Bioseq, s Bioseq-set, m Seq-submit, q Catenated
      Release File: t Batch Bioseq-set, u Batch Seq-submit
 [String]  Optional
    default = a
  -t  Batch
      1 Report
      2 Sequin/Release
      3 asn2gb SSEC/nocleanup
      4 asn2flat BSEC/nocleanup
      5 asn2gb/asn2flat
      6 asn2gb NEW dbxref/OLD dbxref
      7 oldasn2gb/newasn2gb [Integer]
    default = 0
    range from 0 to 7
  -b  Input File is Binary [T/F]  Optional
    default = F
  -c  Batch File is Compressed [T/F]  Optional
    default = F
  -p  Propagate Top Descriptors [T/F]  Optional
    default = F
  -l  Log file [File Out]  Optional
  -r  Remote Fetching [T/F]  Optional
    default = F
  -A  Accession to Fetch (or Accession,retcode,flags where flags -1 fetches external features) [String]  Optional
  -F  Remote Annotation Fetch Test (use -A Accession,0,-1 instead) [T/F]  Optional
    default = F
  -q  Ffdiff Executable [File In]  Optional
    default = /netopt/genbank/subtool/bin/ffdiff
  -n  Asn2Flat Executable [File In]  Optional
    default = asn2flat
  -j  SeqLoc From [Integer]  Optional
    default = 0
  -k  SeqLoc To [Integer]  Optional
    default = 0
  -d  SeqLoc Minus Strand [T/F]  Optional
    default = F
  -y  Feature itemID [Integer]  Optional
    default = 0
```


## Metadata
- **Skill**: generated
