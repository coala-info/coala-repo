# funcannot CWL Generation Report

## funcannot

### Tool Description
Annotates each line of a VCF file to show codon, protein, and mutation for each gene given in the genelist

### Metadata
- **Docker Image**: quay.io/biocontainers/funcannot:v2.8--0
- **Homepage**: https://github.com/BioTools-Tek/funcannot
- **Package**: https://anaconda.org/channels/bioconda/packages/funcannot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/funcannot/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BioTools-Tek/funcannot
- **Stars**: N/A
### Original Help Text
```text
funcannot  v2.8-20170607
Annotates each line of a VCF file to show codon, protein, and mutation for each gene given in the genelist
Please note that TYP and GENE annotations must have been performed prior to running this program

    usage: ./funcannot <INPUTS> <FLAGS> <OUTPUTS>

(the following arguments are all MANDATORY)
INPUTS:
file1.vcf[+file2.vcf]  VCF file, or list seperated with '+' (NO SPACES)
input.genemap          Genemap for positions of genes/exons
input.dnamap           DNA codon map of format: Alu[TAB]AAC,AGC,GCA
FASTA_folder           Folder containing FASTA .fa files for each chromosome

FLAGS:
--geneid=AL            specifies common genelist identifier in VCF file(s)

OUTPUTS:
annotated_folder       each of the annotated VCF files will be placed here
rejects_folder         each of the corresponding rejects will be placed here
```


## Metadata
- **Skill**: generated
