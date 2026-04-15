---
name: r-rsnps
description: The r-rsnps package provides a programmatic interface to retrieve SNP metadata, genotypes, and phenotypic traits from OpenSNP and NCBI dbSNP. Use when user asks to query SNP metadata, retrieve genotypes for specific users, list phenotypic variations, or access SNPedia and PLOS literature annotations.
homepage: https://cran.r-project.org/web/packages/rsnps/index.html
---

# r-rsnps

## Overview
The `rsnps` package provides a programmatic interface to two major SNP data sources: **OpenSNP** (a community-driven open data platform) and **NCBI dbSNP**. It allows researchers to link genetic variants (RSIDs) with phenotypic traits and literature annotations.

## Installation
```R
install.packages("rsnps")
library(rsnps)
```

## NCBI dbSNP Workflows
Use `ncbi_snp_query()` to retrieve metadata for specific RSIDs.

### Querying SNP Metadata
```R
snps <- c("rs332", "rs420358", "rs1837253")
snp_info <- ncbi_snp_query(snps)

# View basic info (chromosome, bp, alleles)
print(snp_info)

# Access population-specific Minor Allele Frequencies (MAF)
# The maf_population column contains a list of data frames
snp_info$maf_population[[2]] 
```

## OpenSNP Workflows
OpenSNP data is centered around users who have uploaded their genetic profiles.

### Genotype Data
Retrieve genotypes for specific SNPs across all users or specific user IDs.
```R
# Get all users for a specific SNP
all_genotypes <- allgensnp(snp = 'rs7412')

# Get genotypes for specific users
# df = TRUE returns a clean data frame
user_genotypes <- genotypes('rs9939609', userid = '1,6,8', df = TRUE)
```

### Phenotype Data
Explore traits and variations associated with users.
```R
# List all available phenotypes in OpenSNP
pheno_list <- allphenotypes(df = TRUE)

# Get phenotypes for a specific user
user_pheno <- phenotypes(userid = 1)
user_pheno$phenotypes$`Hair Type`

# Get all users with a specific phenotype ID
# Use return_ = 'knownvars' to see possible values for that trait
beard_vars <- phenotypes_byid(phenotypeid = 12, return_ = 'knownvars')
beard_users <- phenotypes_byid(phenotypeid = 12, return_ = 'users')
```

### Annotations and Literature
Retrieve external data linked to a SNP.
```R
# Get SNPedia summaries
snp_summary <- annotations(snp = 'rs7903146', output = 'snpedia')

# Get PLOS literature references
plos_refs <- annotations(snp = 'rs7903146', output = 'plos')
```

## Tips and Best Practices
- **API Limits**: For `ncbi_snp_query()`, it is recommended to set an NCBI API key in your `.Renviron` file to allow higher request rates.
- **Data Frames**: Most functions offer a `df = TRUE` argument. Use this to avoid nested list structures when performing data analysis.
- **User IDs**: OpenSNP user IDs can be passed as single integers, comma-separated strings ("1,2,3"), or ranges ("1-10").

## Reference documentation
- [rsnps README](./references/README.md)
- [rsnps tutorial](./references/rsnps.Rmd)