# plant_tribes_kaks_analysis CWL Generation Report

## plant_tribes_kaks_analysis_KaKsAnalysis

### Tool Description
DETERMINE PAIRWISE SEQUENCE SYNONYMOUS SUBSTITUTIONS (Ks) AND SIGNIFICANT DUPLICATION COMPONENTS

### Metadata
- **Docker Image**: quay.io/biocontainers/plant_tribes_kaks_analysis:1.0.4--0
- **Homepage**: https://github.com/dePamphilis/PlantTribes
- **Package**: https://anaconda.org/channels/bioconda/packages/plant_tribes_kaks_analysis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plant_tribes_kaks_analysis/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dePamphilis/PlantTribes
- **Stars**: N/A
### Original Help Text
```text
Unknown option: help


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#                                DETERMINE PAIRWISE SEQUENCE SYNONYMOUS SUBSTITUTIONS (Ks) AND SIGNIFICANT DUPLICATION COMPONENTS
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Required Options:
#
#  --coding_sequences_species_1 <string>   : Coding sequences (CDS) fasta file for the first species (species1.fna)
#
#  
#  --proteins_species_1 <string>           : Amino acids (proteins) sequences fasta file for the first species (species1.faa) 
#
#
#  --comparison <string>                   : pairwise sequence comparison to determine homolgous pairs
#                                            If self species comparison: paralogs
#                                            If cross species comparison: orthologs (requires second species data)
#
# # # # # # # # # # # # # # # # # # 
#  Others Options:
#
#  --coding_sequences_species_2 <string>   : Coding sequences (CDS) fasta file for the first species (species2.fna)
#                                            requires "--comparison" to be set to "orthologs" 
#
#
#  --proteins_species_2 <string>           : Amino acids (proteins) sequences fasta file for the first species (species2.faa)
#                                            requires "--comparison" to be set to "orthologs"
#
#  --crb_blast <string>                    : Use conditional reciprocal best BLAST to determine for cross-species orthologs
#                                            instead of the default reciprocal best BLAST
#                                            requires "--comparison" to be set to "orthologs" 
#
#  --min_coverage <float>                  : Minimum sequence pairwise coverage length between homologous pairs
#                                            Default: 0.5 (50% coverage) - [0.3 to 1.0]
#
#  --recalibration_rate <float>            : Recalibrate synonymous substitution (ks) rates of a species using a predetermined evolutionary rate that
#                                            can be determined from a species tree inferred from a collection single copy genes from taxa of interest
#                                            (Cui et al., 2006) - mainly applies only paralogous ks analysis
#
#  --codeml_ctl_file <string>              : PAML's codeml control file to carry out ML analysis of protein-coding DNA sequences using codon 
#                                            substitution models. The defaults in the "codeml.ctl.args" template in the config directory of
#                                            the installation will be used if not provided. NOTE: input (seqfile, treefile) and output (outfile)
#                                            parameters of codeml are not included in the template.
#
#
#  --fit_components                        : Fit a mixture model of multivariate normal components to synonymous (ks) distribution to identify
#                                            significant duplication event(s) in a genome
# 
#
#  --num_of_components <int>               : Number components to fit to synonymous substitutions (ks) distribution - required if "--fit_components"
#
#
#  --min_ks <float>                        : Lower limit of synonymous substitutions (ks) - necessary if fitting components to the distribution to
#                                            reduce background noise from young paralogous pairs due to normal gene births and deaths in a genome.  
#
#
#  --max_ks <float>                        : Upper limit of synonymous substitutions (ks) - necessary if fitting components to the distribution to
#                                            exclude likey ancient paralogous pairs.
#
#  --num_threads <int>                     : number of threads (CPUs) 
#                                            Default: 1
#
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Example Usage:
#
#  KaKsAnalysis --coding_sequences_species_1 species1.fna --proteins_species_1 species1.faa --comparison paralogs --num_threads 4
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
```

