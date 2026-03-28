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

* data
  + [Overview](#overview)
    - [Motivation](#motivation)
  + [Data](#id1)
  + [genotypes.py](#genotypes-py)
    - [Overview](#id2)
    - [Documentation](#documentation)
    - [Classes](#classes)
      * [Genotypes](#genotypes)
      * [GenotypesVCF](#genotypesvcf)
      * [GenotypesTR](#genotypestr)
      * [GenotypesPLINK](#genotypesplink)
      * [GenotypesPLINKTR](#genotypesplinktr)
  + [haplotypes.py](#haplotypes-py)
    - [Overview](#id4)
    - [Documentation](#id5)
    - [Classes](#id6)
      * [Haplotypes](#haplotypes)
      * [Haplotype](#haplotype)
      * [Repeat](#repeat)
      * [Variant](#variant)
  + [phenotypes.py](#phenotypes-py)
    - [Overview](#id9)
    - [Documentation](#id10)
    - [Classes](#id11)
      * [Phenotypes](#phenotypes)
  + [covariates.py](#covariates-py)
    - [Overview](#id16)
    - [Documentation](#id17)
    - [Classes](#id18)
      * [Covariates](#covariates)
  + [breakpoints.py](#breakpoints-py)
    - [Overview](#id19)
    - [Documentation](#id20)
    - [Classes](#id21)
      * [Breakpoints](#breakpoints)
* [haptools](modules.html)
* [examples](examples.html)

[haptools](../index.html)

* data
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/api/data.rst)

---

# data[](#data "Link to this heading")

## Overview[](#overview "Link to this heading")

The `data` module is a submodule of `haptools` that handles IO for common file types including genotypes, haplotypes, phenotypes, and model covariates.

Note

This page documents common use-cases. To implement more advanced patterns, take a look at our detailed [API docs](haptools.html#api-haptools-data).

### Motivation[](#motivation "Link to this heading")

Using the `data` module makes your code agnostic to the type of file being used. For example, the `Genotypes` class provides the same interface for reading VCFs as it does for PLINK2 PGEN files.

This module also helps reduce common boilerplate, since users can easily *extend* the classes in the `data` module for their own specific goals.

## Data[](#id1 "Link to this heading")

Classes in the `data` module inherit from an abstract class called Data, providing some level of standardization across classes within the module.

The abstract class requires that all classes contain methods for…

1. reading the contents of a file into a `data` property of each class
2. iterating over lines of a file without loading all of the data into memory at once

```
from haptools import data
data.Data
```

All classes are initialized with the path to the file containing the data and, optionally, a [python Logger](https://docs.python.org/3/howto/logging.html) instance. All messages are written to the Logger instance. You can create your own Logger instance as follows.

```
from haptools import logging
log = logging.getLogger(name="name", level="ERROR")
```

## genotypes.py[](#genotypes-py "Link to this heading")

### Overview[](#id2 "Link to this heading")

This module supports reading and writing files that follow [the VCF](https://gatk.broadinstitute.org/hc/en-us/articles/360035531692-VCF-Variant-Call-Format) and [PLINK2 PGEN](https://www.cog-genomics.org/plink/2.0/formats#pgen) file format specifications. We may also offer support for [BGEN](https://www.well.ox.ac.uk/~gav/bgen_format) and [Hail](https://hail.is/docs/0.2/methods/impex.html#native-file-formats) files in the future.

### Documentation[](#documentation "Link to this heading")

The [genotypes.py API docs](haptools.html#api-haptools-data-genotypes) contain example usage of the `Genotypes` class.
See the documentation for the `GenotypesVCF` class for an example of extending the `Genotypes` class so that it loads REF and ALT alleles as well.

### Classes[](#classes "Link to this heading")

#### Genotypes[](#genotypes "Link to this heading")

##### Properties[](#properties "Link to this heading")

The `data` property of a `Genotypes` object is a numpy array representing the genotype matrix. Rows of the array are samples and columns are variants. Each entry in the matrix is a tuple of values – one for each chromosome. Each value is an integer denoting the index of the allele (0 for REF, 1 for the first ALT allele, 2 for the next ALT allele, etc).

There are two additional properties that contain variant and sample metadata. The `variants` property is a numpy structured array and the `samples` property is a simple tuple of sample IDs. The `variants` structured array has three named columns: “id” (variant ID), “chrom” (chromosome name), and “pos” (chromosomal position).

##### Reading a file[](#reading-a-file "Link to this heading")

Extracting genotypes from a VCF file is quite simple:

```
genotypes = data.Genotypes.load('tests/data/simple.vcf')
genotypes.data     # a numpy array of shape n x p x 2
genotypes.variants # a numpy structured array of shape p x 4
genotypes.samples  # a tuple of strings of length n
```

The `load()` method initializes an instance of the `Genotypes` class, calls the `read()` method, and then performs some standard [quality-control checks](#api-data-genotypes-quality-control). You can also call the `read()` method manually if you’d like to forego these checks.

```
genotypes = data.Genotypes('tests/data/simple.vcf')
genotypes.read()
genotypes.data     # a numpy array of shape n x p x 3
genotypes.variants # a numpy structured array of shape p x 4
genotypes.samples  # a tuple of strings of length n

# check that all genotypes are phased and remove the phasing info (in the third dimension)
genotypes.check_phase()
genotypes.data     # a numpy array of shape n x p x 2
```

Both the `load()` and `read()` methods support `region`, `samples`, and `variants` parameters that allow you to request a specific region, list of samples, or set of variant IDs to read from the file.

```
genotypes = data.Genotypes('tests/data/simple.vcf.gz')
genotypes.read(
    region="1:10115-10117",
    samples=["HG00097", "HG00100"],
    variants={"1:10117:C:A"},
)
```

The `region` parameter only works if the file is indexed, since in that case, the `read()` method can take advantage of the indexing to parse the file a bit faster.

##### Iterating over a file[](#iterating-over-a-file "Link to this heading")

If you’re worried that the contents of the VCF file might be large, you may opt to parse the file line-by-line instead of loading it all into memory at once.

In cases like these, you can use the `__iter__()` method in a for-loop:

```
genotypes = data.Genotypes('tests/data/simple.vcf')
for line in genotypes:
    print(line)
```

You’ll have to call `__iter()__` manually if you want to specify any function parameters:

```
genotypes = data.Genotypes('tests/data/simple.vcf.gz')
for line in genotypes.__iter__(region="1:10115-10117", samples=["HG00097", "HG00100"]):
    print(line)
```

##### Quality control[](#quality-control "Link to this heading")

There are several quality-control checks performed by default (in the `load()` method). You can call these methods yourself, if you’d like:

1. `check_missing()` - raises an error if any samples are missing genotypes
2. `check_biallelic()` - raises an error if any variants have more than one ALT allele
3. `check_phase()` - raises an error if any genotypes are unphased

Additionally, you can use the `check_maf()` method after checking for missing genotypes and confirming that all variants are biallelic.

```
genotypes = data.Genotypes('tests/data/simple.vcf.gz')
genotypes.read()
genotypes.check_missing()
genotypes.check_biallelic()
genotypes.check_maf(threshold=0.0) # replace 0 with your desired threshold
genotypes.check_phase()
```

##### Subsetting[](#subsetting "Link to this heading")

You can index into a loaded `Genotypes` instance using the `subset()` function. This works similiar to numpy indexing with the added benefit that you can specify a subset of variants and/or samples by their IDs instead of just their indices.

```
genotypes = data.Genotypes.load('tests/data/simple.vcf')
gts_subset = genotypes.subset(samples=("HG00100", "HG00101"), variants=("1:10114:T:C", '1:10116:A:G'))
gts_subset # a new Genotypes instance containing only the specified samples and variants
```

By default, the `subset()` method returns a new `Genotypes` instance. The samples and variants in the new instance will be in the order specified.

#### GenotypesVCF[](#genotypesvcf "Link to this heading")

The `Genotypes` class can be easily *extended* (sub-classed) to load extra fields into the `variants` structured array. The `GenotypesVCF` class is an example of this where I extended the `Genotypes` class to add REF and ALT fields from the VCF as a new column of the structured array. So the `variants` array will have named columns: “id”, “chrom”, “pos”, “alleles”. The new “alleles” column contains lists of alleles designed such that the first element in the list is the REF allele, the second is ALT1, the third is ALT2, etc.

All of the other methods in the `Genotypes` class are inherited, but the `GenotypesVCF` class implements an additional method `write()` for dumping the contents of the class to the provided file.

```
genotypes = data.GenotypesVCF.load('tests/data/simple.vcf')
# make the first sample homozygous for the alt allele of the fourth variant
genotypes.data[0, 3] = (1, 1)
genotypes.write()
```

#### GenotypesTR[](#genotypestr "Link to this heading")

The `GenotypesTR` class *extends* the `Genotypes` class. The `GenotypesTR` class follows the same structure of `GenotypesVCF`, but can now load repeat counts of tandem repeats as the alleles.

All of the other methods in the `Genotypes` class are inherited, but the `GenotypesTR` class’ `load()` function is unique to loading tandem repeat variants.

```
genotypes = data.GenotypesTR.load('tests/data/simple_tr.vcf')
# make the first sample have 4 and 7 repeats for the alleles of the fourth variant
genotypes.data[0, 3] = (4, 7)
```

The following methods from the `Genotypes` class are disabled, however.

1. `check_biallelic`
2. `check_maf`

The constructor of the `GenotypesTR` class also includes a `vcftype` parameter. This can be helpful when the type of the TR file cannot be inferred automatically. Refer to [the TRTools docs](https://trtools.readthedocs.io/en/stable/trtools.utils.tr_harmonizer.html#trtools.utils.tr_harmonizer.VcfTypes) for a list of accepted types.

#### GenotypesPLINK[](#genotypesplink "Link to this heading")

The `GenotypesPLINK` class offers experimental support for reading and writing PLINK2 PGEN, PVAR, and PSAM files. We are able to read genotypes from PLINK2 PGEN files in a fraction of the time of VCFs. Reading from VCFs is \(O(n\*p)\), while reading from PGEN files is approximately \(O(1)\).

![https://github.com/CAST-genomics/haptools/assets/23412689/6da88941-7520-4c19-beaa-27f540f6b047](https://github.com/CAST-genomics/haptools/assets/23412689/6da88941-7520-4c19-beaa-27f540f6b047)

The time required to load various genotype file formats.[](#id26 "Link to this image")

The `GenotypesPLINK` class inherits from the `GenotypesVCF` class, so it has all the same methods and properties. Loading genotypes is the exact same, for example.

```
genotypes = data.GenotypesPLINK.load('tests/data/simple.pgen')
genotypes.data     # a numpy array of shape n x p x 2
genotypes.variants # a numpy structured array of shape p x 5
genotypes.samples  # a tuple of strings of length n
```

In addition to the `read()` and `load()` methods, the `GenotypesPLINK` class also has methods for reading (or writing) PVAR or PSAM files separately, without having to read (or write) the PGEN file as well.

```
genotypes = data.GenotypesPLINK('tests/data/simple.pgen')

genotypes.read_variants()
genotypes.variants # a numpy structured array of shape p x 5

genotypes.read_samples()
genotypes.samples  # a tuple of strings of length n

genotypes.data     # simply None
```

##### Limiting memory usage[](#limiting-memory-usage "Link to this heading")

Unfortunately, reading from PGEN files can require a lot of memory, at least initially. (Once the genotypes have been loaded, they are converted down to a lower-memory form.) To determine whether you may be having memory issues, you may opt to place the module in “verbose mode” by providing a [python Logger](https://docs.python.org/3/howto/logging.html) object at the “DEBUG” level when initializing the `GenotypesPLINK` class. This will release helpful debugging messages.

```
from haptools import logging
log = logging.getLogger(name="debug_plink_mem", level="DEBUG")

genotypes = data.GenotypesPLINK('tests/data/simple.pgen', log=log)
genotypes.read()
```

If you find yourself running out of memory when trying to load a PGEN file, you may want to try loading the genotypes in chunks. You can specify the number of variants to read (and write) together at once via the `chunk_size` parameter. This parameter is only available for the `GenotypesPLINK` class.

A large `chunk_size` is more likely to result in memory over-use while a small `chunk_size` will increase the time it takes to read the file. If the `chunk_size` is not specified, all of the genotypes will be loaded together in a single chunk.

```
genotypes = data.GenotypesPLINK('tests/data/simple.pgen', chunk_size=500)
genotypes.read()
```

#### GenotypesPLINKTR[](#genotypesplinktr "Link to this heading")

The `` GenotypesPLINKTR` `` class extends the `GenotypesPLINK` class to support loading tandem repeat variants.
The `GenotypesPLINKTR` class works similarly to `GenotypesTR` by filling the `data` property with repeat counts for each allele.

The following methods from the `GenotypesPLINK` class are disabled, however.

1. `write`
2. `check_maf`
3. `write_variants`
4. `check_biallelic`

The `GenotypesPLINKTR` uses INFO fields from the PVAR file to determine the repeat unit and the number of repeats for each allele. To ensure your PVAR file contains the necessary information, use the following command when converting from VCF.

```
plink2 --vcf-half-call m --make-pgen 'pvar-cols=vcfheader,qual,filter,info' --v