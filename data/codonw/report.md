# codonw CWL Generation Report

## codonw

### Tool Description
A program for codon usage analysis, including correspondence analysis and calculation of various indices.

### Metadata
- **Docker Image**: biocontainers/codonw:v1.4.4-4-deb_cv1
- **Homepage**: http://codonw.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/codonw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/codonw/overview
- **Total Downloads**: 9.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
codonW [inputfile] [outputfile] [bulkoutfile] [options]
General options and defaults:
 -h(elp)	This help message
 -nomenu	Prevent the menu interface being displayed
 -nowarn	Prevent warnings about sequences being displayed
 -silent	Overwrite files silently
 -totals	Concatenate all genes in inputfile
 -machine	Machine readable output
 -human		Human readable output
 -code N	Genetic code as defined under menu 3 option 5
 -f_type N	Fop/CBI codons as defined by menu 3 option 6
 -c_type N	Cai fitness values as defined by menu 3 option 7
 -t (char)	Column separator to be used in output files (comma,tab,space)

Codon usage indices and Amino acid indices 
 -cai		calculate Codon Adaptation Index (CAI)
 -fop		calculate Frequency of OPtimal codons index (FOP)
 -cbi		calculate Codon Bias Index (CBI)
 -enc		Effective Number of Codons (ENc)
 -gc		G+C content of gene (all 3 codon positions)
 -gcs3		GC of synonymous codons 3rd positions
 -sil_base	Base composition at synonymous third codon positions
 -L_sym		Number of synonymous codons
 -L_aa		Total number of synonymous and non-synonymous codons
 -all_indices		All the above indices
 -aro		Calculate aromaticity of protein
 -hyd		Calculate hydropathicity of protein
 -cai_file  {file}	User input file of CAI values
 -cbi_file  {file}	User input file of CBI values
 -fop_file  {file}	User input file of Fop values

Correspondence analysis (COA) options 
 -coa_cu 	COA of codon usage frequencies
 -coa_rscu	COA of Relative Synonymous Codon Usage
 -coa_aa	COA of amino acid usage frequencies
 -coa_expert	Generate detailed(expert) statistics on COA
 -coa_axes N	Select number of axis to record
 -coa_num N	Select number of genes to use to identify optimal codons
		values can be whole numbers or a percentage (5 or 10%)

Bulk output options | only one can be selected per analysis
 -aau		Amino Acid Usage (AAU)
 -raau		Relative Amino Acid Usage (RAAU)
 -cu		Codon Usage (CU) (default)
 -cutab		Tabulation of codon usage
 -cutot		Tabulation of dataset's codon usage
 -rscu		Relative Synonymous Codon Usage (RSCU)
 -fasta		fasta format
 -tidy		fasta format
 -reader	Reader format (codons are separated by spaces)
 -transl	Conceptual translation of DNA to amino acid
 -base		Detailed report of codon G+C composition
 -dinuc		Dinucleotide usage of the three codon pos.
 -noblk		No bulk output to be written to file

Where {file} represents an input filename, and N an integer value Controlled exit <>
```

