---
name: bioconductor-immunotation
description: The package immunotation provides tools for consistent annotation of HLA genes in typical immunoinformatics workflows such as for example the prediction of MHC-presented peptides in different human donors. Converter functions that provide mappings between different HLA naming schemes are based on the MHC restriction ontology (MRO). The package also provides automated access to HLA alleles frequencies in worldwide human reference populations stored in the Allele Frequency Net Database.
homepage: https://bioconductor.org/packages/release/bioc/html/immunotation.html
---

# bioconductor-immunotation

name: bioconductor-immunotation
description: Tools for consistent HLA gene annotation, mapping between nomenclature schemes (alleles, serotypes, G and P groups, MACs), and automated access to HLA allele frequencies from the Allele Frequency Net Database (AFND). Use when working with immunoinformatics workflows, MHC-peptide prediction, or population genetics involving HLA.

# bioconductor-immunotation

## Overview
The `immunotation` package provides a suite of tools for handling the complex nomenclature of Human Leukocyte Antigen (HLA) genes and Major Histocompatibility Complex (MHC) molecules. It facilitates the conversion between different naming standards (essential for tools like NetMHCpan) and provides programmatic access to global allele frequency data via the Allele Frequency Net Database (AFND).

## Core Workflows

### 1. HLA Annotation and Lookup
Access the MHC Restriction Ontology (MRO) to identify valid organisms and gene chains.

```r
library(immunotation)

# List supported organisms
get_valid_organisms()

# Retrieve a lookup table for human MHC chains
human_chains <- retrieve_chain_lookup_table(organism = "human")

# Access the built-in table of human protein complexes
data("human_protein_complex_table")
```

### 2. Nomenclature Conversion
Map HLA alleles to serotypes, G groups (nucleotide identity in peptide-binding domains), or P groups (protein identity in peptide-binding domains).

```r
alleles <- c("A*01:01:01", "A*02:01:01", "B*07:02:01")

# Get serotypes
get_serotypes(alleles, mhc_type = "MHC-I")

# Map to G and P groups
get_G_group(alleles)
get_P_group(alleles)
```

### 3. Tool Integration (NetMHCpan)
Convert standard HLA allele names into the specific string formats required by popular immunoinformatics tools.

```r
# Format for NetMHCpan (MHC-I)
get_mhcpan_input(alleles, mhc_class = "MHC-I")

# Format for NetMHCIIpan (MHC-II)
alleles_ii <- c("DPA1*01:03:01", "DPB1*14:01:01")
get_mhcpan_input(alleles_ii, mhc_class = "MHC-II")
```

### 4. Multiple Allele Codes (MAC)
Encode lists of alleles into NMDP Multiple Allele Codes or decode them back into allele strings.

```r
# Encode
mac_code <- encode_MAC(c("A*01:01:01", "A*01:02"))

# Decode
decode_MAC("A*01:AYMG")
```

### 5. Allele Frequency Queries
Query the Allele Frequency Net Database (AFND) for population-specific data.

```r
# Query frequency for a specific allele with quality filters
# standard="g" filters for Gold Standard data
freq_df <- query_allele_frequencies(
  hla_selection = "A*02:01", 
  hla_sample_size_pattern = "bigger_than", 
  hla_sample_size = 5000, 
  standard = "g"
)

# Query by ethnicity or region
asian_freq <- query_allele_frequencies(hla_selection = "A*01:01", hla_ethnic = "Asian")

# Visualize frequencies on a world map
plot_allele_frequency(freq_df)
```

### 6. Haplotype and Population Metadata
Retrieve complex haplotype frequencies or detailed information about specific study populations.

```r
# Query haplotype frequencies in a region
haplo_df <- query_haplotype_frequencies(
  hla_selection = c("A*02:01", "B*", "C*"),
  hla_region = "Europe"
)

# Get metadata for a specific population ID
pop_info <- query_population_detail(1986)
```

## Tips and Best Practices
- **MHC-II Serotypes:** Serotypes for MHC class II are only returned if the complete molecule (both alpha and beta chains) is annotated in the MRO.
- **Population IDs:** If a population ID is unknown, search the AFND website and extract the 4-digit ID from the URL.
- **Data Standards:** Use the `standard` parameter (`"g"` for gold, `"s"` for silver, `"b"` for bronze) in frequency queries to ensure data quality. Gold standard requires sample sizes ≥ 50 and frequencies summing to ~1.0.

## Reference documentation
- [User guide: immunotation package](./references/immunotation_vignette.md)
- [User guide: immunotation package (Rmd)](./references/immunotation_vignette.Rmd)