# rhocall CWL Generation Report

## rhocall_aggregate

### Tool Description
Aggregate runs of autozygosity from rhofile into windowed rho BED file.
Accepts a bcftools roh style TSV-file with CHR,POS,AZ,QUAL.

### Metadata
- **Docker Image**: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
- **Homepage**: https://github.com/dnil/rhocall
- **Package**: https://anaconda.org/channels/bioconda/packages/rhocall/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rhocall/overview
- **Total Downloads**: 9.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dnil/rhocall
- **Stars**: N/A
### Original Help Text
```text
Usage: rhocall aggregate [OPTIONS] ROH

  Aggregate runs of autozygosity from rhofile into windowed rho BED file.
  Accepts a bcftools roh style TSV-file with CHR,POS,AZ,QUAL.

Options:
  -q, --quality_threshold FLOAT  Minimum quality trusted to start or end ROH-
                                 windows.
  -v, --verbose
  -o, --output FILENAME
  --help                         Show this message and exit.
```


## rhocall_annotate

### Tool Description
Markup VCF file using rho-calls. Use BED file to mark all variants in AZ
  windows. Alternatively, use a bcftools v>=1.4 file with RG entries to mark
  all vars. With the --no-v14 flag, use an older bcftools v<=1.2 style roh TSV
  to mark only selected AZ variants. Roh is broken in bcftools v1.3 - do not
  use.

### Metadata
- **Docker Image**: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
- **Homepage**: https://github.com/dnil/rhocall
- **Package**: https://anaconda.org/channels/bioconda/packages/rhocall/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rhocall annotate [OPTIONS] VCF

  Markup VCF file using rho-calls. Use BED file to mark all variants in AZ
  windows. Alternatively, use a bcftools v>=1.4 file with RG entries to mark
  all vars. With the --no-v14 flag, use an older bcftools v<=1.2 style roh TSV
  to mark only selected AZ variants. Roh is broken in bcftools v1.3 - do not
  use.

Options:
  -r FILENAME                     Bcftools roh style TSV file with
                                  CHR,POS,AZ,QUAL.
  --v14 / --no-v14                Bcftools v1.4 or newer roh file including RG
                                  calls.
  -b FILENAME                     BED file with AZ windows.
  -q, --quality_threshold FLOAT   Minimum quality calls that are imported in
                                  region totals.
  -u, --flag_upd_at_fraction FLOAT
                                  Flag UPD if this fraction of chr quality
                                  positions called AZ.
  -v, --verbose
  -o, --output FILENAME
  --help                          Show this message and exit.
```


## rhocall_call

### Tool Description
Call runs of autozygosity. (deprecated: use bcftools roh instead.

### Metadata
- **Docker Image**: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
- **Homepage**: https://github.com/dnil/rhocall
- **Package**: https://anaconda.org/channels/bioconda/packages/rhocall/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rhocall call [OPTIONS] VCF

  Call runs of autozygosity. (deprecated: use bcftools roh instead.

Options:
  -m, --max_hets FLOAT            Max heterozygotes per Mb in a homozygous
                                  block
  -f, --max_het_fraction FLOAT    Max heterozygotes over homozygotes fraction
                                  in a homozygous block
  -n, --minimum_homs INTEGER      Minimum absolute number of homozygotes to
                                  report a block
  -s, --shortest_block INTEGER    Shortest block
  -u, --flag_upd_at_fraction FLOAT
                                  Flag UPD if homozygous blocks span this
                                  fraction of total chr size
  -k, --individual INTEGER        Index of individual in vcf/bcf, 0-based.
  -s, --block_constant INTEGER    Should be adapted to type of analysis(exome
                                  or genome)
  -v, --verbose
  --help                          Show this message and exit.
```


## rhocall_tally

### Tool Description
Tally runs of autozygosity from rhofile. Accepts a bcftools roh style TSV-file with CHR,POS,AZ,QUAL.

### Metadata
- **Docker Image**: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
- **Homepage**: https://github.com/dnil/rhocall
- **Package**: https://anaconda.org/channels/bioconda/packages/rhocall/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rhocall tally [OPTIONS] ROH

  Tally runs of autozygosity from rhofile. Accepts a bcftools roh style TSV-
  file with CHR,POS,AZ,QUAL.

Options:
  -q, --quality_threshold FLOAT   Minimum quality that counts towards region
                                  totals.
  -u, --flag_upd_at_fraction FLOAT
                                  Flag UPD if this fraction of chr quality
                                  positions called AZ.
  -v, --verbose
  -o, --output FILENAME
  --help                          Show this message and exit.
```


## rhocall_viz

### Tool Description
Plot binned zygosity and RHO-regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
- **Homepage**: https://github.com/dnil/rhocall
- **Package**: https://anaconda.org/channels/bioconda/packages/rhocall/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rhocall viz [OPTIONS] VCF

  Plot binned zygosity and RHO-regions.

Options:
  --out_dir PATH              Output directory. The files will be named
                              out_dir/chr.png. One picture is drawn per
                              chromosome.  [required]
  --wig / --no-wig            Produce wig file.
  -p, --pointsize INTEGER     Size of the points (pixels)
  -r, --rho FILENAME          Input RHO file produced from rhocall  [required]
  -m, --minsnv INTEGER        Minimum number of snvs for each plotted bin
  -M, --maxsnv INTEGER        Maximum number of snvs for each plotted bin
  --minaf FLOAT               Minimum allele frequency. This variable must be
                              set to 0 if the allele frequency is not
                              annotated.
  --maxaf FLOAT               Maximum allele frequency
  --aftag TEXT                The allele frequency tag to use.
  -q, --minqual INTEGER       Do not add SNVs to a bin if their quality is
                              less than this value.
  --mnv / --no-mnv            Include MNV
  -w, --window INTEGER        Window size(bases)
  -s, --rsid / --no-rsid      Skip variants not containing an rsid
  -n, --filter / --no-filter  include variants, even if they are not labeled
                              PASS
  -v, --verbose
  --help                      Show this message and exit.
```

