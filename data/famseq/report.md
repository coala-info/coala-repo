# famseq CWL Generation Report

## famseq_FamSeq

### Tool Description
FamSeq is a tool for variant calling in family-based sequencing data, supporting VCF and likelihood-only formats using Bayesian networks, Elston-Stewart, or MCMC methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/famseq:1.0.3--h9948957_8
- **Homepage**: http://bioinformatics.mdanderson.org/main/FamSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/famseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/famseq/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-06-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
FamSeq: Version: 1.0.2
Usage:	FamSeq <input type> [options]

FamSeq accepts two kinds of input files: vcf file and likelihood only format file. If the input is vcf file, type 'FamSeq vcf [options]' in the command line. Type 'FamSeq LK [options]' if the input is likelihood only format. The user can only use only of them.

Options:

-vcfFile	The name of input vcf file.

-lkFile		The name of input likelihood only format file.

-lkType	The likelihood type stored in the likelihood only format file. n:normal(default); log10: log10 scaled; ln: ln scaled; PS: phred scaled.

-pedFile	The name of the file storing the pedigree information.

-output		The name of output file

-method		Choose the method used in variant calling. 1(default): Bayesian network; 2: Elston-Stewart algorithm; 3: MCMC.

-mRate		Mutation rate. The default value is 1e-7

-v		Only record the position at which the genotype is not RR in the output file. (R: reference allele, A: alternative allele).

-a		Record all the position in the output file.

-genoProbN	Genotype probability of three kinds of genotype for autosome in population (Pr(G)) when the variant is not in dbSNP. The default value is:  0.9985, 0.001 and 0.0005. The dbSNP position should be provided in column ID in input vcf file. 

-genoProbK	Genotype probability of three kinds of genotype for autosome in population (Pr(G)) when the variant is in dbSNP. The default value is: 0.45, 0.1 and 0.45.

-genoProbXN	Genotype probability of two kinds of genotype for chromosome X for male in population (Pr(G)) when the variant is not in dbSNP. The default value is: 0.999 and 0.001.

-genoProbXK	Genotype probability of two kinds of genotype for chromosome X for male in population (Pr(G)) when the variant is in dbSNP. The default value is: 0.5 and 0.5.

-numBurnIn	Number of burn in when the user chooses the MCMC method. The default value is 1,000n, where n is the number of individuals in the pedigree.

-numRep		Number of iteration times when the user chooses MCMC method. The default value is 20,000n.
```

