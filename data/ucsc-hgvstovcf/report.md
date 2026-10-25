# ucsc-hgvstovcf CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-hgvstovcf_hgvsToVcf | Not completed | Needs a UCSC central database and /gbdb hg38.2bit; the public server denies the hgcentral userDb table. CWL fixed: output file argument and -noLeftShift added. |

## Metadata
- **Skill**: generated

## ucsc-hgvstovcf_hgvsToVcf

### Tool Description
Convert HGVS terms to VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hgvstovcf:377--h199ee4e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hgvstovcf/overview
- **Validation**: PASS
### Original Help Text
```text
hgvsToVcf - Convert HGVS terms to VCF tab-separated output
usage:
   hgvsToVcf db input.hgvs output.vcf
options:
   -noLeftShift        Don't do the VCF-conventional left shifting of ambiguous placements
db is a UCSC database such as hg19, hg38 etc.
Only nucleotide HGVS terms (g., c., n., m.) are supported, not protein (p.).
```

