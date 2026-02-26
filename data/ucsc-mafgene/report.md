# ucsc-mafgene CWL Generation Report

## ucsc-mafgene_mafGene

### Tool Description
output protein alignments using maf and genePred

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-mafgene:490--ha62e71f_1
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-mafgene/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-mafgene/overview
- **Total Downloads**: 24.6K
- **Last updated**: 2025-12-17
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
mafGene - output protein alignments using maf and genePred
usage:
   mafGene dbName mafTable genePredTable species.lst output
arguments:
   dbName         name of SQL database
   mafTable       name of maf file table or bigMaf if ends in .bigMaf or .bb
   genePredTable  name of the genePred table or file if useFile is on or ends in .gp
   species.lst    list of species names
   output         put output here
options:
   -twoBit=file.2bit  use 2bit file to fill in spaces in the alignment instead of database
   -geneName=foobar   name of gene as it appears in genePred
   -geneList=foolst   name of file with list of genes
   -geneBeds=foo.bed  name of bed file with genes and positions
   -chrom=chr1        name of chromosome from which to grab genes
   -useFile           genePredTable is a file
   -exons             output exons
   -noTrans           don't translate output into amino acids
   -uniqAA            put out unique pseudo-AA for every different codon
   -includeUtr        include the UTRs, use only with -noTrans
   -delay=N           delay N seconds between genes (default 0)
   -noDash            don't output lines with all dashes
```

