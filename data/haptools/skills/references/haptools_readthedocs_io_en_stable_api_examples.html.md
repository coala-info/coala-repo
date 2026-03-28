[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](../formats/genotypes.html)
* [Haplotypes](../formats/haplotypes.html)
* [Phenotypes and Covariates](../formats/phenotypes.html)
* [Linkage disequilibrium](../formats/ld.html)
* [Summary Statistics](../formats/linear.html)
* [Causal SNPs](../formats/snplist.html)
* [Breakpoints](../formats/breakpoints.html)
* [Sample Info](../formats/sample_info.html)
* [Models](../formats/models.html)
* [Maps](../formats/maps.html)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](data.html)
* [haptools](modules.html)
* examples
  + [Converting a `.blocks.det` file into a `.hap` file](#converting-a-blocks-det-file-into-a-hap-file)
  + [Converting a `.snplist` file into a `.hap` file](#converting-a-snplist-file-into-a-hap-file)
  + [Converting a `.bp` file into a `.hanc` per-site ancestry file](#converting-a-bp-file-into-a-hanc-per-site-ancestry-file)

[haptools](../index.html)

* examples
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/api/examples.rst)

---

# examples[](#examples "Link to this heading")

## Converting a `.blocks.det` file into a `.hap` file[](#converting-a-blocks-det-file-into-a-hap-file "Link to this heading")

You can use the [data API](data.html#api-data) to convert [a PLINK 1.9 .blocks.det file](https://www.cog-genomics.org/plink/1.9/formats#blocks) into a `.hap` file.

As an example, let’s say we would like to convert [the following simple.blocks.det file](https://github.com/cast-genomics/haptools/blob/main/tests/data/simple.blocks.det).

```
CHR  BP1         BP2     KB   NSNPS  SNPS
 1      10114   10117   2.001   2       1:10114:T:C|1:10116:A:G
 1      10114   10119   2.007   2       1:10114:T:C|1:10117:C:A
 1      10116   10119   2.011   2       1:10116:A:G|1:10117:C:A
```

```
from haptools import data

# load the genotypes file
# you can use either a VCF or PGEN file
gt = data.GenotypesVCF.load("tests/data/simple.vcf.gz")
gt = data.GenotypesPLINK.load("tests/data/simple.pgen")

# load the haplotypes
hp = data.Haplotypes("output.hap")
hp.data = {}

# iterate through lines of the .blocks.det file
with open("tests/data/simple.blocks.det") as blocks_file:
    for idx, line in enumerate(blocks_file.read().splitlines()[1:]):
        # initialize variables and parse line from the blocks file
        hap_id = f"H{idx}"
        chrom, bp1, bp2, kb, nsnps, snps = line.strip().split()

        # create a haplotype line in the .hap file
        hp.data[hap_id] = data.Haplotype(
            chrom=chrom, start=int(bp1), end=int(bp2), id=hap_id
        )

        # fetch alleles from the genotypes file
        snp_gts = gt.subset(variants=tuple(snps.split("|")))

        # create variant lines for each haplotype
        # Note that the .blocks.det file doesn't specify an allele, so
        # we simply choose the first allele (ie the REF allele) for this example
        hp.data[hap_id].variants = tuple(
            data.Variant(
                start=v["pos"],
                end=v["pos"] + len(v["alleles"][0]),
                id=v["id"],
                allele=v["alleles"][0],
            )
            for v in snp_gts.variants
        )

hp.write()
```

## Converting a `.snplist` file into a `.hap` file[](#converting-a-snplist-file-into-a-hap-file "Link to this heading")

How would you convert a [.snplist file](../formats/snplist.html) into a `.hap` file suitable for use by `simphenotype`?

The basic idea is to encode each SNP as a haplotype containing only a single allele. For example, let’s say your `.snplist` file has two SNPs like this.

```
rs429358        0.73
rs7412  0.30
```

Then your `.hap` file might look something like this.

```
#       orderH  beta
#       version 0.2.0
#H      beta    .2f     Effect size in linear model
H       19      45411941        45411942        rs429358        0.73
H       19      45412079        45412080        rs7412  0.30
V       rs429358        45411941        45411942        rs429358        C
V       rs7412  45412079        45412080        rs7412  T
```

You can use the [data API](data.html#api-data) and the [simphenotype API](haptools.html#api-haptools-sim-phenotype) to create such a file.

```
from haptools import data
from haptools.sim_phenotype import Haplotype

variants = {}
# load variants from the snplist file
with open("tests/data/apoe.snplist") as snplist_file:
    for line in snplist_file.readlines():
        # parse variant ID and beta from file
        ID, beta = line.split("\t")
        variants[ID] = float(beta)

# load the genotypes file
gt = data.GenotypesVCF("tests/data/apoe.vcf.gz")
gt.read(variants=variants.keys())

# initialize an empty haplotype file
hp = data.Haplotypes("output.hap", haplotype=Haplotype)
hp.data = {}

for variant in gt.variants:
    ID, chrom, pos, alleles = variant[["id", "chrom", "pos", "alleles"]]
    # we arbitrarily choose to use the ALT allele but alleles[0] will give you REF
    allele = alleles[1]
    end = pos + len(allele)

    # create a haplotype line in the .hap file
    hp.data[ID] = Haplotype(chrom=chrom, start=pos, end=end, id=ID, beta=variants[ID])

    # create a variant line for each haplotype
    hp.data[ID].variants = (data.Variant(start=pos, end=end, id=ID, allele=allele),)

hp.write()
```

## Converting a `.bp` file into a `.hanc` per-site ancestry file[](#converting-a-bp-file-into-a-hanc-per-site-ancestry-file "Link to this heading")

You can obtain the ancestry of a list of variants directly from a `.bp` file using the [data API](data.html#api-data-bp2anc).

**Input:**

* Breakpoints in a [.bp file](../formats/breakpoints.html#formats-breakpoints)
* A list of variants in a [PLINK2 PVAR file](../formats/genotypes.html#formats-genotypesplink)

**Output:**

* An `.hanc` per-site ancestry file as described in [the admix-simu documentation](https://github.com/williamslab/admix-simu/tree/master?tab=readme-ov-file#per-site-ancestry-values):

```
0000
1020
0000
0100
0010
0000
2101
0100
0002
0102
```

```
import numpy as np
from pathlib import Path
from haptools import data

output = Path("output.hanc")

# load breakpoints from the bp file and encode each population label as an int
breakpoints = data.Breakpoints.load("tests/data/simple.bp")
breakpoints.encode()
print(breakpoints.labels)

# load the SNPs array from a PVAR file
snps = data.GenotypesPLINK("tests/data/simple.pgen")
snps.read_variants()
snps = snps.variants[["chrom", "pos"]]

# create array of per-site ancestry values
arr = breakpoints.population_array(variants=snps)
# reshape from n x p x 2 to n*2 x p
# so rows are haplotypes and columns are variants
arr = arr.transpose((0, 2, 1)).reshape(-1, arr.shape[1])

# write to haplotype ancestry file
np.savetxt(output, arr, fmt="%i", delimiter="")
```

[Previous](haptools.html "Documentation")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).