# ucsc-hggoldgapgl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-hggoldgapgl_hgGoldGapGl | PASS | Tested in -noLoad mode (no database needed) on an AGP made from real chr22 slices; gold.tab and gap.tab rows match the AGP with zero-based starts and UCSC bins (CWL fixed: input is an AGP file or directory, -verbose=, hg.conf optional); database loading not tested |

## ucsc-hggoldgapgl_hgGoldGapGl

### Tool Description
Put chromosome .agp and .gl files into browser database.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hggoldgapgl:377--h199ee4e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hggoldgapgl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hggoldgapgl/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
hgGoldGapGl - Put chromosome .agp and .gl files into browser database.
usage:
   hgGoldGapGl database gsDir ooSubDir
	(this usage creates split gold and gap tables)
or
   hgGoldGapGl database agpFile
	(this usage creates single gold and gap tables)
options:
   -noGl  - don't do gl bits
   -chrom=chrN - just do a single chromosome.  Don't delete old tables.
   -chromLst=chrom.lst - chromosomes subdirs are named in chrom.lst (1, 2, ...)
   -noLoad - do not load tables, leave SQL files instead.
   -verbose n - n==2 brief information and SQL table create statements
              - n==3 show all gaps
example:
   hgGoldGapGl -noGl hg16 /cluster/data/hg16 .
```

