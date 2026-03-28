# gqt CWL Generation Report

## gqt_convert

### Tool Description
Convert VCF/BCF to GQT index or sample phenotype database

### Metadata
- **Docker Image**: quay.io/biocontainers/gqt:1.1.3--h0263287_3
- **Homepage**: https://github.com/ryanlayer/gqt
- **Package**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ryanlayer/gqt
- **Stars**: N/A
### Original Help Text
```text
gqt v1.1.3
usage:   gqt convert <type> -i <input VCF/VCF.GZ/BCF file>
     types:
         bcf         create a GQT index
         ped         create sample phenotype database

     options:
         -p           PED file name (opt.)
         -c           Sample name column in PED (Default 2)
         -G           GQT output file name (opt.)
         -V           VID output file name (opt.)
         -O           OFF output file name (opt.)
         -B           BIM output file name (opt.)
         -D           PED DB output file name (opt.)
         -r           Number of variants (opt. with index)
         -f           Number of samples (opt. with index)
         -t           Tmp working directory(./ by defualt)
```


## gqt_query

### Tool Description
A GQT query returns a set of variants that meet some number of population and genotype conditions. Conditions are specified by a population query and genotype query pair, where the population query defines the set of individuals to consider and the genotype query defines a filter on that population. The result is the set of variants within that sub-population that meet the given conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/gqt:1.1.3--h0263287_3
- **Homepage**: https://github.com/ryanlayer/gqt
- **Package**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Validation**: PASS

### Original Help Text
```text
gqt v1.1.3
usage:   gqt query -i <bcf/vcf or gqt file> \
                   -d <ped database file> \
                   -c only print number of resulting variants \
                   -v print genotypes (from the source bcf/vcf)\
                   -t tmp direcory name for remote files (default ./)
                   -B <bim file> (opt.)\
                   -O <off file> (opt.)\
                   -V <vid file> (opt.)\
                   -G <gqt file> (opt.)\
                   -p <population query 1> \
                   -g <genotype query 1> \
                   -p <population query 2> \
                   -g <genotype query 2> \

A GQT query returns a set of variants that meet some number of population 
and genotype conditions.  Conditions are specified by a population query 
and genotype query pair, where the population query defines the set of
individuals to consider and the genotype query defines a filter on that
population.  The result is the set of variants within that sub-population
that meet the given conditions.  For example, to find the variants that are
heterozygous in the GBR population the query pair would be:

	-p "Population = 'GBR'" -g "HET"

Any number of query pairs can be included, to further refine that set of
variants.  For example, to find the variants that are heterozygous in at 
least 10 individuals from the GBR population, and are homozygous reference 
in the TSI population the two query pairs would be:

	-p "Population = 'GBR'" -g "count(HET) >= 10" \
	-p "Population = 'GBR'" -g "HOM_REF"

Population queries are based on the PED file that is associated with the
genotypes, and any column in that PED file can be part of the query.  For
example, a PED file that includes the "Paternal_ID" and "Gender" fields
(where male = 1 and female = 2) could be queried by:

	-p "Paternal_ID = 'NA12878' AND Gender = 2"

Genotype queries can either be direct genotype filters or count-based 
filters.  To get the variants that are heterozygous in every member of the
population the query would be:

	-g "HET"

Or to get the variants that are either heterozygous or homozygous alternate
in every member the query would be:

	-g "HET HOM_ALT"

Count based filters used the "count()" operator that takes a genotype 
list as a parameter followed by some condition.  For example, to find the
variants that are either heterozygous or homozygous alternate in no more
than 10 individuals the query would be

	-g "count(HET HOM_ALT) < 10"
```


## gqt_pca-shared

### Tool Description
Performs Principal Component Analysis (PCA) on shared genotypes between populations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gqt:1.1.3--h0263287_3
- **Homepage**: https://github.com/ryanlayer/gqt
- **Package**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Validation**: PASS

### Original Help Text
```text
gqt 1.1.3
usage:   gqt pca-shared -i <gqt file> \
                   -d <ped database file> \
                   -t tmp direcory name for remote files (default ./)
                   -f <label db field name> (requried for pca-shared)\
                   -l <label output file> (requried for pca-shared)\
                   -p <population query 1> \
                   -p <population query 2> \
                   ... \
                   -p <population query N> 

Each population query defines one subpopulation.
For example, to find compare the GBR and YRI subpopulations:
	-p "Population = 'GBR'"
	-p "Population = 'YRI'"

Population queries are based on the PED file that is associated with the
genotypes, and any column in that PED file can be part of the query.  For
example, a PED file that includes the "Paternal_ID" and "Gender" fields
(where male = 1 and female = 2) could be queried by:

	-p "Paternal_ID = 'NA12878' AND Gender = 2"

NOTE: gst and fst assume that variants are biallelic.  If your data
contains multiallelic sites, we recommend decomposing your VCF 
(see A. Tan, Bioinformatics 2015) prior to indexing.
```


## gqt_on

### Tool Description
gqt, v1.1.3

### Metadata
- **Docker Image**: quay.io/biocontainers/gqt:1.1.3--h0263287_3
- **Homepage**: https://github.com/ryanlayer/gqt
- **Package**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown command
gqt, v1.1.3
usage:   gqt <command> [options]
         convert    Convert between file types
         query      Query the index
         pca-shared Compute the similarity matrix for PCA base
                    on the number of shared non-reference loci.
         calpha     Calculate C-alpha paramters (Neal 2011)
         gst        Calculate Gst statistic (Neil 1973)
         fst        Calculate Fst statistic (Weir and Cockerham 1984)
```


## gqt_calpha

### Tool Description
Calculates alpha diversity statistics between subpopulations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gqt:1.1.3--h0263287_3
- **Homepage**: https://github.com/ryanlayer/gqt
- **Package**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Validation**: PASS

### Original Help Text
```text
gqt 1.1.3
usage:   gqt calpha -i <gqt file> \
                   -d <ped database file> \
                   -t tmp direcory name for remote files (default ./)
                   -f <label db field name> (requried for pca-shared)\
                   -l <label output file> (requried for pca-shared)\
                   -p <population query 1> \
                   -p <population query 2> \
                   ... \
                   -p <population query N> 

Each population query defines one subpopulation.
For example, to find compare the GBR and YRI subpopulations:
	-p "Population = 'GBR'"
	-p "Population = 'YRI'"

Population queries are based on the PED file that is associated with the
genotypes, and any column in that PED file can be part of the query.  For
example, a PED file that includes the "Paternal_ID" and "Gender" fields
(where male = 1 and female = 2) could be queried by:

	-p "Paternal_ID = 'NA12878' AND Gender = 2"

NOTE: gst and fst assume that variants are biallelic.  If your data
contains multiallelic sites, we recommend decomposing your VCF 
(see A. Tan, Bioinformatics 2015) prior to indexing.
```


## gqt_gst

### Tool Description
Calculates GST and FST statistics for subpopulations. NOTE: gst and fst assume that variants are biallelic. If your data contains multiallelic sites, we recommend decomposing your VCF (see A. Tan, Bioinformatics 2015) prior to indexing.

### Metadata
- **Docker Image**: quay.io/biocontainers/gqt:1.1.3--h0263287_3
- **Homepage**: https://github.com/ryanlayer/gqt
- **Package**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Validation**: PASS

### Original Help Text
```text
gqt 1.1.3
usage:   gqt gst -i <gqt file> \
                   -d <ped database file> \
                   -t tmp direcory name for remote files (default ./)
                   -f <label db field name> (requried for pca-shared)\
                   -l <label output file> (requried for pca-shared)\
                   -p <population query 1> \
                   -p <population query 2> \
                   ... \
                   -p <population query N> 

Each population query defines one subpopulation.
For example, to find compare the GBR and YRI subpopulations:
	-p "Population = 'GBR'"
	-p "Population = 'YRI'"

Population queries are based on the PED file that is associated with the
genotypes, and any column in that PED file can be part of the query.  For
example, a PED file that includes the "Paternal_ID" and "Gender" fields
(where male = 1 and female = 2) could be queried by:

	-p "Paternal_ID = 'NA12878' AND Gender = 2"

NOTE: gst and fst assume that variants are biallelic.  If your data
contains multiallelic sites, we recommend decomposing your VCF 
(see A. Tan, Bioinformatics 2015) prior to indexing.
```


## gqt_fst

### Tool Description
Calculate Fst between populations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gqt:1.1.3--h0263287_3
- **Homepage**: https://github.com/ryanlayer/gqt
- **Package**: https://anaconda.org/channels/bioconda/packages/gqt/overview
- **Validation**: PASS

### Original Help Text
```text
gqt 1.1.3
usage:   gqt fst -i <gqt file> \
                   -d <ped database file> \
                   -t tmp direcory name for remote files (default ./)
                   -f <label db field name> (requried for pca-shared)\
                   -l <label output file> (requried for pca-shared)\
                   -p <population query 1> \
                   -p <population query 2> \
                   ... \
                   -p <population query N> 

Each population query defines one subpopulation.
For example, to find compare the GBR and YRI subpopulations:
	-p "Population = 'GBR'"
	-p "Population = 'YRI'"

Population queries are based on the PED file that is associated with the
genotypes, and any column in that PED file can be part of the query.  For
example, a PED file that includes the "Paternal_ID" and "Gender" fields
(where male = 1 and female = 2) could be queried by:

	-p "Paternal_ID = 'NA12878' AND Gender = 2"

NOTE: gst and fst assume that variants are biallelic.  If your data
contains multiallelic sites, we recommend decomposing your VCF 
(see A. Tan, Bioinformatics 2015) prior to indexing.
```


## Metadata
- **Skill**: generated
