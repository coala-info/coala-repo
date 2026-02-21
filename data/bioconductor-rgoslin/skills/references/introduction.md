# Using rgoslin to parse and normalize lipid nomenclature

Nils Hoffmann1

1Forschungszentrum Jülich, Institute for Bio- and Geosciences, IBG-5, Bielefeld, Germany

#### 24 March 2022

#### Package

rgoslin 1.14.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Related Projects](#related-projects)
  + [1.2 Supported nomenclatures](#supported-nomenclatures)
  + [1.3 Changes from Version 1](#changes-from-version-1)
* [2 Installation](#installation)
* [3 Example use cases](#example-use-cases)
  + [3.1 Parsing a single lipid name](#parsing-a-single-lipid-name)
  + [3.2 Parsing multiple lipid names](#parsing-multiple-lipid-names)
  + [3.3 Parsing IUPAC-compliant Fatty Acid Names](#parsing-iupac-compliant-fatty-acid-names)
  + [3.4 Parsing Adducts](#parsing-adducts)
  + [3.5 Using rgoslin with lipidr](#using-rgoslin-with-lipidr)
* [4 Getting help & support](#getting-help-support)
* [Session information](#session-information)

# 1 Introduction

This project is a parser, validator and normalizer implementation for shorthand lipid nomenclatures, base on the Grammar of Succinct Lipid Nomenclatures project.

[Goslin](https://github.com/lifs-tools/goslin) defines multiple grammars for different sources of shorthand lipid nomenclature. This allows to generate parsers based on the defined grammars, which provide immediate feedback whether a processed lipid shorthand notation string is compliant with a particular grammar, or not.

> ***NOTE:*** Please report any issues you might find to help improve it!

Here, rgoslin 2.0 uses the Goslin grammars and the cppgoslin parser to support the following general tasks:

1. Facilitate the parsing of shorthand lipid names dialects.
2. Provide a structural representation of the shorthand lipid after parsing.
3. Use the structural representation to generate normalized names, following the latest shorthand nomenclature.

## 1.1 Related Projects

* [Goslin grammars and reference test files](http://github.com/lifs-tools/goslin)
* [C++ implementation](https://github.com/lifs-tools/cppgoslin)
* [C# implementation](https://github.com/lifs-tools/csgoslin)
* [Java implementation](https://github.com/lifs-tools/jgoslin)
* [Python implementation](https://github.com/lifs-tools/pygoslin)
* [Webapplication and REST API](https://github.com/lifs-tools/goslin-webapp)

## 1.2 Supported nomenclatures

* [LIPID MAPS](https://www.lipidmaps.org)
* [SwissLipids](https://www.swisslipids.org/)
* Updated Shorthand nomenclature [2020 Update](https://pubmed.ncbi.nlm.nih.gov/33037133/),[2013 Version](https://pubmed.ncbi.nlm.nih.gov/23549332/)
* [HMDB](https://hmdb.ca/)
* [FattyAcids](https://iupac.qmul.ac.uk/lipid/appABC.html#appA)

## 1.3 Changes from Version 1

* The fragment grammar parser has been removed but may be re-added in the future. Please use our [GitHub Issues](https://github.com/lifs-tools/goslin/issues) if you need this parser.
* The column names of the R implementation have been changed to contain “.” instead of " " (space). This makes handling and access easier, since quoting is no longer necessary.

# 2 Installation

The package can be installed with the `BiocManager` package as follows:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("rgoslin")
```

# 3 Example use cases

In order to use the provided translation functions of rgoslin, you first need to load the library. If rgoslin is not yet available, please follow the instructions in the previous section on “Installation”.

```
library(rgoslin)
```

If you want to check, which grammars are supported, use the following command:

```
listAvailableGrammars()
#> [1] "Shorthand2020" "Goslin"        "FattyAcids"    "LipidMaps"
#> [5] "SwissLipids"   "HMDB"
```

To check, whether a given lipid name can be parsed by any of the parsers, you can use the `isValidLipidName` method. It will return `TRUE` if the given name can be parsed by any of the available parsers and `FALSE` if the name was not parseable.

```
isValidLipidName("PC 32:1")
#> [1] TRUE
```

## 3.1 Parsing a single lipid name

Using `parseLipidNames` with a lipid name returns a data frame of properties of the parsed lipid name as columns.

```
df <- parseLipidNames("PC 32:1")
```

Table 1: Table 2: Lipid name parsing results for PC 32:1, FA and LCB columns omitted, since they are unpopulated (`NA`) on the lipid species level.

| Normalized.Name | Original.Name | Grammar | Message | Adduct | Adduct.Charge | Lipid.Maps.Category | Lipid.Maps.Main.Class | Species.Name | Extended.Species.Name | Molecular.Species.Name | Sn.Position.Name | Structure.Defined.Name | Full.Structure.Name | Functional.Class.Abbr | Functional.Class.Synonyms | Level | Total.C | Total.OH | Total.O | Total.DB | Mass | Sum.Formula |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PC 32:1 | PC 32:1 | Shorthand2020 | NA | NA | 0 | GP | PC | PC 32:1 | PC | NA | NA | NA | NA | [PC] | [PC, GPC, GPCho, PlsCho] | SPECIES | 32 | 0 | 0 | 1 | 731.5465 | C40H78NO8P |

If you want to set the grammar to parse against manually, this is also possible as the second argument:

```
originalName <- "TG(16:1(5E)/18:0/20:2(3Z,6Z))"
tagDf <- parseLipidNames(originalName, grammar = "LipidMaps")
```

Table 3: Table 4: Lipid name parsing results for TG isomeric subspecies, FA and LCB columns omitted for brevity.

| Normalized.Name | Original.Name | Grammar | Message | Adduct | Adduct.Charge | Lipid.Maps.Category | Lipid.Maps.Main.Class | Species.Name | Extended.Species.Name | Molecular.Species.Name | Sn.Position.Name | Structure.Defined.Name | Full.Structure.Name | Functional.Class.Abbr | Functional.Class.Synonyms | Level | Total.C | Total.OH | Total.O | Total.DB | Mass | Sum.Formula |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TG 16:1(5E)/18:0/20:2(3Z,6Z) | TG(16:1(5E)/18:0/20:2(3Z,6Z)) | LipidMaps | NA | NA | 0 | GL | TG | TG 54:3 | TG | TG 16:1\_18:0\_20:2 | TG 16:1/18:0/20:2 | TG 16:1(5)/18:0/20:2(3,6) | TG 16:1(5E)/18:0/20:2(3Z,6Z) | [TG] | [TG, TAG] | FULL\_STRUCTURE | 54 | 0 | 0 | 3 | 884.7833 | C57H104O6 |

Table 5: Table 6: Lipid name parsing results for TG isomeric subspecies with FA and LCB columns.

| Normalized.Name | FA1.Position | FA1.C | FA1.OH | FA1.O | FA1.DB | FA1.Bond.Type | FA1.DB.Positions | FA2.Position | FA2.C | FA2.OH | FA2.O | FA2.DB | FA2.Bond.Type | FA2.DB.Positions | FA3.Position | FA3.C | FA3.OH | FA3.O | FA3.DB | FA3.Bond.Type | FA3.DB.Positions | FA4.Position | FA4.C | FA4.OH | FA4.O | FA4.DB | FA4.Bond.Type | FA4.DB.Positions | LCB.Position | LCB.C | LCB.OH | LCB.O | LCB.DB | LCB.Bond.Type | LCB.DB.Positions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TG 16:1(5E)/18:0/20:2(3Z,6Z) | 1 | 16 | 0 | 0 | 1 | ESTER | [5E] | 2 | 18 | 0 | 0 | 0 | ESTER | [] | 3 | 20 | 0 | 0 | 2 | ESTER | [3Z, 6Z] | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |

## 3.2 Parsing multiple lipid names

If you want to parse multiple lipid names, use the `parseLipidNames` method with a vector of lipid names. This returns a data frame of properties of the parsed lipid names with one row per lipid.

> ***NOTE:*** Omitting the grammar argument will test all available parsers, the first one to successfully parse the name wins. This will consequently take longer than explicitly setting the grammar to select the parser for.

```
multipleLipidNamesDf <- parseLipidNames(c("PC 32:1","LPC 34:1","TG(18:1_18:0_16:1)"))
```

Table 7: Table 8: Lipid name parsing results for PC 32:1, LPC 34:1, TG(18:1\_18:0\_16:1), FA and LCB columns omitted for brevity.

| Normalized.Name | Original.Name | Grammar | Message | Adduct | Adduct.Charge | Lipid.Maps.Category | Lipid.Maps.Main.Class | Species.Name | Extended.Species.Name | Molecular.Species.Name | Sn.Position.Name | Structure.Defined.Name | Full.Structure.Name | Functional.Class.Abbr | Functional.Class.Synonyms | Level | Total.C | Total.OH | Total.O | Total.DB | Mass | Sum.Formula |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PC 32:1 | PC 32:1 | Shorthand2020 | NA | NA | 0 | GP | PC | PC 32:1 | PC | NA | NA | NA | NA | [PC] | [PC, GPC, GPCho, PlsCho] | SPECIES | 32 | 0 | 0 | 1 | 731.5465 | C40H78NO8P |
| LPC 34:1 | LPC 34:1 | Shorthand2020 | NA | NA | 0 | GP | LPC | LPC 34:1 | LPC | LPC 34:1 | NA | NA | NA | [LPC] | [LPC, LysoPC, lysoPC] | MOLECULAR\_SPECIES | 34 | 0 | 0 | 1 | 745.5985 | C42H84NO7P |
| TG 18:1\_18:0\_16:1 | TG(18:1\_18:0\_16:1) | LipidMaps | NA | NA | 0 | GL | TG | TG 52:2 | TG | TG 18:1\_18:0\_16:1 | NA | NA | NA | [TG] | [TG, TAG] | MOLECULAR\_SPECIES | 52 | 0 | 0 | 2 | 858.7676 | C55H102O6 |

Table 9: Table 10: Lipid name parsing results for PC 32:1, LPC 34:1, TG(18:1\_18:0\_16:1) with FA and LCB columns.

| Normalized.Name | FA1.Position | FA1.C | FA1.OH | FA1.O | FA1.DB | FA1.Bond.Type | FA1.DB.Positions | FA2.Position | FA2.C | FA2.OH | FA2.O | FA2.DB | FA2.Bond.Type | FA2.DB.Positions | FA3.Position | FA3.C | FA3.OH | FA3.O | FA3.DB | FA3.Bond.Type | FA3.DB.Positions | FA4.Position | FA4.C | FA4.OH | FA4.O | FA4.DB | FA4.Bond.Type | FA4.DB.Positions | LCB.Position | LCB.C | LCB.OH | LCB.O | LCB.DB | LCB.Bond.Type | LCB.DB.Positions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PC 32:1 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| LPC 34:1 | -1 | 34 | 0 | 0 | 1 | ESTER | [] | -1 | 0 | 0 | 0 | 0 | ESTER | [] | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| TG 18:1\_18:0\_16:1 | -1 | 18 | 0 | 0 | 1 | ESTER | [] | -1 | 18 | 0 | 0 | 0 | ESTER | [] | -1 | 16 | 0 | 0 | 1 | ESTER | [] | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |

Finally, if you want to parse multiple lipid names and want to use one particular grammar, simply add its name as the “grammar” argument.

```
originalNames <- c("PC 32:1","LPC 34:1","TAG 18:1_18:0_16:1")
multipleLipidNamesWithGrammar <- parseLipidNames(originalNames, grammar = "Goslin")
```

Table 11: Table 12: Lipid name parsing results for Goslin grammar and lipids PC 32:1, LPC 34:1, TG(18:1\_18:0\_16:1), FA and LCB columns omitted for brevity.

| Normalized.Name | Original.Name | Grammar | Message | Adduct | Adduct.Charge | Lipid.Maps.Category | Lipid.Maps.Main.Class | Species.Name | Extended.Species.Name | Molecular.Species.Name | Sn.Position.Name | Structure.Defined.Name | Full.Structure.Name | Functional.Class.Abbr | Functional.Class.Synonyms | Level | Total.C | Total.OH | Total.O | Total.DB | Mass | Sum.Formula |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PC 32:1 | PC 32:1 | Goslin | NA | NA | 0 | GP | PC | PC 32:1 | PC | NA | NA | NA | NA | [PC] | [PC, GPC, GPCho, PlsCho] | SPECIES | 32 | 0 | 0 | 1 | 731.5465 | C40H78NO8P |
| LPC 34:1 | LPC 34:1 | Goslin | NA | NA | 0 | GP | LPC | LPC 34:1 | LPC | LPC 34:1 | NA | NA | NA | [LPC] | [LPC, LysoPC, lysoPC] | MOLECULAR\_SPECIES | 34 | 0 | 0 | 1 | 745.5985 | C42H84NO7P |
| TG 18:1\_18:0\_16:1 | TAG 18:1\_18:0\_16:1 | Goslin | NA | NA | 0 | GL | TG | TG 52:2 | TG | TG 18:1\_18:0\_16:1 | NA | NA | NA | [TAG] | [TG, TAG] | MOLECULAR\_SPECIES | 52 | 0 | 0 | 2 | 858.7676 | C55H102O6 |

Table 13: Table 14: Lipid name parsing results for Goslin grammar and lipids PC 32:1, LPC 34:1, TG(18:1\_18:0\_16:1) with FA and LCB columns.

| Normalized.Name | FA1.Position | FA1.C | FA1.OH | FA1.O | FA1.DB | FA1.Bond.Type | FA1.DB.Positions | FA2.Position | FA2.C | FA2.OH | FA2.O | FA2.DB | FA2.Bond.Type | FA2.DB.Positions | FA3.Position | FA3.C | FA3.OH | FA3.O | FA3.DB | FA3.Bond.Type | FA3.DB.Positions | FA4.Position | FA4.C | FA4.OH | FA4.O | FA4.DB | FA4.Bond.Type | FA4.DB.Positions | LCB.Position | LCB.C | LCB.OH | LCB.O | LCB.DB | LCB.Bond.Type | LCB.DB.Positions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PC 32:1 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| LPC 34:1 | -1 | 34 | 0 | 0 | 1 | ESTER | [] | -1 | 0 | 0 | 0 | 0 | ESTER | [] | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| TG 18:1\_18:0\_16:1 | -1 | 18 | 0 | 0 | 1 | ESTER | [] | -1 | 18 | 0 | 0 | 0 | ESTER | [] | -1 | 16 | 0 | 0 | 1 | ESTER | [] | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |

## 3.3 Parsing IUPAC-compliant Fatty Acid Names

LIPID MAPS has a number of fatty acids that use names following the IUPAC-IUB Fatty Acids nomenclature. These can now also be parsed and converted to the updated lipid shorthand nomenclature. We are using [LMFA01020216](https://www.lipidmaps.org/databases/lmsd/LMFA01020216) and [LMFA08040030](https://www.lipidmaps.org/databases/lmsd/LMFA08040030) as examples here:

```
originalNames <- c("LMFA01020216"="5-methyl-octadecanoic acid", "LMFA08040030"="N-((+/-)-8,9-dihydroxy-5Z,11Z,14Z-eicosatrienoyl)-ethanolamine")
normalizedFattyAcidsNames <- parseLipidNames(originalNames, "FattyAcids")
```

Table 15: Table 16: Lipid name parsing results for Goslin grammar and fatty acids 5-methyl-octadecanoic acid N-((+/-)-8,9-dihydroxy-5Z,11Z,14Z-eicosatrienoyl)-ethanolamine, some columns omitted for brevity.

| Normalized.Name | Original.Name | Grammar | Message | Lipid.Maps.Category | Lipid.Maps.Main.Class | Species.Name | Extended.Species.Name | Molecular.Species.Name | Sn.Position.Name | Structure.Defined.Name | Full.Structure.Name | Functional.Class.Abbr | Functional.Class.Synonyms | Level | Total.C | Total.OH | Total.O | Total.DB | Mass | Sum.Formula | FA1.Position | FA1.C | FA1.OH | FA1.O | FA1.DB | FA1.Bond.Type | FA1.DB.Positions |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| FA 18:0;5Me | 5-methyl-octadecanoic acid | FattyAcids | NA | FA | FA | FA 19:0 | FA | FA 19:0 | FA 19:0 | FA 18:0;Me | FA 18:0;5Me | [FA] | [FA, fatty acid] | FULL\_STRUCTURE | 19 | 0 | 0 | 0 | 298.2872 | C19H38O2 | 1 | 18 | 0 | 0 | 0 | ESTER | [] |
| NAE 20:3(5Z,11Z,14Z);8OH,9OH | N-((+/-)-8,9-dihydroxy-5Z,11Z,14Z-eicosatrienoyl)-ethanolamine | FattyAcids | NA | FA | NAE | NAE 20:3;O2 | NAE | NAE 20:3;O2 | NAE 20:3;O2 | NAE 20:3(5,11,14);(OH)2 | NAE 20:3(5Z,11Z,14Z);8OH,9OH | [NAE] | [NAE] | FULL\_STRUCTURE | 20 | 2 | 2 | 3 | 381.2879 | C22H39NO4 | 1 | 20 | 2 | 2 | 3 | ESTER | [5Z, 11Z, 14Z] |

## 3.4 Parsing Adducts

The Goslin parser also support reading of lipid shorthand names with adducts:

```
originalNames <- c("PC 32:1[M+H]1+", "PC 32:1 [M+H]+","PC 32:1")
lipidNamesWithAdduct <- parseLipidNames(originalNames, "Goslin")
```

This will populate the columns “Adduct” and “AdductCharge” with the respective values. Please note that we recommend to use the adduct and its charge in full IUPAC recommended nomenclature:

Table 17: Table 18: Lipid name parsing results for Goslin grammar and lipids PC 32:1[M+H]1+, PC 32:1 [M+H]+ and PC 32:1, FA and LCB columns omitted for brevity.

| Normalized.Name | Original.Name | Grammar | Message | Adduct | Adduct.Charge | Lipid.Maps.Category | Lipid.Maps.Main.Class | Species.Name | Extended.Species.Name | Molecular.Species.Name | Sn.Position.Name | Structure.Defined.Name | Full.Structure.Name | Functional.Class.Abbr | Functional.Class.Synonyms | Level | Total.C | Total.OH | Total.O | Total.DB | Mass | Sum.Formula |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PC 32:1 | PC 32:1[M+H]1+ | Goslin | NA | [M+H]1+ | 1 | GP | PC | PC 32:1 | PC | NA | NA | NA | NA | [PC] | [PC, GPC, GPCho, PlsCho] | SPECIES | 32 | 0 | 0 | 1 | 732.5538 | C40H79NO8P |
| PC 32:1 | PC 32:1 [M+H]+ | Goslin | NA | [M+H]1+ | 1 | GP | PC | PC 32:1 | PC | NA | NA | NA | NA | [PC] | [PC, GPC, GPCho, PlsCho] | SPECIES | 32 | 0 | 0 | 1 | 732.5538 | C40H79NO8P |
| PC 32:1 | PC 32:1 | Goslin | NA | NA | 0 | GP | PC | PC 32:1 | PC | NA | NA | NA | NA | [PC] | [PC, GPC, GPCho, PlsCho] | SPECIES | 32 | 0 | 0 | 1 | 731.5465 | C40H78NO8P |

## 3.5 Using rgoslin with lipidr

[lipidr](https://bioconductor.org/packages/release/bioc/html/lipidr.html) is a Bioconductor package with specific support for QC checking, uni- and multivariate analysis and visualization of lipidomics data acquired with Skyline or from metabolomics workbench. It uses a custom implementation for lipid name handling that does not yet support the updated shorthand nomenclature.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("lipidr")
```

After installation of lipidr, we need to load the following libraries for this example:

```
library(rgoslin)
library(lipidr)
library(stringr)
library(ggplot2)
```

We will use [lipidr’s workflow example](https://bioconductor.org/packages/release/bioc/vignettes/lipidr/inst/doc/workflow.html) to illustrate how to apply rgoslin in such a use-case. We read in an example dataset exported from Skyline based on a targeted lipidomics experiment:

```
datadir = system.file("extdata", package="lipidr")
filelist = list.files(datadir, "data.csv", full.names = TRUE) # all csv files
d = read_skyline(filelist)
#> Successfully read 3 methods.
#> Your data contain 58 samples, 10 lipid classes, 277 lipid molecules.
clinical_file = system.file("extdata", "clin.csv", package="lipidr")
d = add_sample_annotation(d, clinical_file)
```

This dataset contains the lipid names in the `Molecule` column and the name preprocessed with `lipidr` in the `clean_name` column. In this excerpt, you can see `PE 34:1 NEG` in row 5, which indicates measurement of this lipid in negative mode. Please note that this is specific to this example and not a generally applied naming convention.

Table 19: Table 20: Subset of first ten rows of row data.

| filename | Molecule | Precursor.Mz | Precursor.Charge | Product.Mz | Product.Charge | clean\_name | ambig | not\_matched | istd | class\_stub | chain1 | l\_1 | s\_1 | chain2 | l\_2 | s\_2 | chain3 | l\_3 | s\_3 | chain4 | l\_4 | s\_4 | total\_cl | total\_cs | Class |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A1\_data.csv | PE 32:0 | 692.5 | 1 | 551.5 | 1 | PE 32:0 | FALSE | FALSE | FALSE | PE | 32:0 | 32 | 0 |  | NA | NA |  | NA | NA |  | NA | NA | 32 | 0 | PE |
| A1\_data.csv | PE 32:1 | 690.5 | 1 | 549.5 | 1 | PE 32:1 | FALSE | FALSE | FALSE | PE | 32:1 | 32 | 1 |  | NA | NA |  | NA | NA |  | NA | NA | 32 | 1 | PE |
| A1\_data.csv | PE 32:2 | 688.5 | 1 | 547.5 | 1 | PE 32:2 | FALSE | FALSE | FALSE | PE | 32:2 | 32 | 2 |  | NA | NA |  | NA | NA |  | NA | NA | 32 | 2 | PE |
| A1\_data.csv | PE 34:1 | 718.5 | 1 | 577.5 | 1 | PE 34:1 | FALSE | FALSE | FALSE | PE | 34:1 | 34 | 1 |  | NA | NA |  | NA | NA |  | NA | NA | 34 | 1 | PE |
| A1\_data.csv | PE 34:1 NEG | 716.5 | 1 | 196.0 | 1 | PE 34:1 | FALSE | FALSE | FALSE | PE | 34:1 | 34 | 1 |  | NA | NA |  | NA | NA |  | NA | NA | 34 | 1 | PE |
| A1\_data.csv | PE 34:2 | 716.5 | 1 | 575.5 | 1 | PE 34:2 | FALSE | FALSE | FALSE | PE | 34:2 | 34 | 2 |  | NA | NA |  | NA | NA |  | NA | NA | 34 | 2 | PE |
| A1\_data.csv | PE 34:3 | 714.5 | 1 | 573.5 | 1 | PE 34:3 | FALSE | FALSE | FALSE | PE | 34:3 | 34 | 3 |  | NA | NA |  | NA | NA |  | NA | NA | 34 | 3 | PE |
| A1\_data.csv | PE 36:0 | 748.6 | 1 | 607.6 | 1 | PE 36:0 | FALSE | FALSE | FALSE | PE | 36:0 | 36 | 0 |  | NA | NA |  | NA | NA |  | NA | NA | 36 | 0 | PE |
| A1\_data.csv | PE 36:1 | 746.6 | 1 | 605.6 | 1 | PE 36:1 | FALSE | FALSE | FALSE | PE | 36:1 | 36 | 1 |  | NA | NA |  | NA | NA |  | NA | NA | 36 | 1 | PE |
| A1\_data.csv | PE 36:1 NEG | 744.6 | 1 | 196.0 | 1 | PE 36:1 | FALSE | FALSE | FALSE | PE | 36:1 | 36 | 1 |  | NA | NA |  | NA | NA |  | NA | NA | 36 | 1 | PE |

Now, let’s try to parse the clean lipid names to enrich the data table.

> ***Note***: In this case, we expect to see error messages, since some lipid names use a) unsupported head group names or b) unsupported suffixes to indicate isotopically labeled lipids.

```
lipidNames <- parseLipidNames(rowData(d)$clean_name)
#> Encountered an error while parsing 'So1P 17:1': Expecting a single string value: [type=character; extent=4].
#> Encountered an error while parsing 'So1P 18:1': Expecting a single string value: [type=character; extent=4].
```

We see that lipidr’s example dataset uses the `(d9)` suffix to indicate isotopically labeled lipids (d=Deuterium) that are used as internal standards for quantification.
We need to convert `Sa1P`, sphinganine-1-phosphate, to `SPBP`, as well as `So1P`, sphingosine-1-phosphate to align with recent nomenclature updates.

```
# lipidr stores original lipid names in the Molecule column
old_names <- rowData(d)$Molecule
# split lipid prefix from potential (d7) suffix for labeled internal standards
new_names <- rowData(d)$clean_name %>% str_match(pattern="([\\w :-]+)(\\(\\w+\\))?")
# extract the first match group (the original word is at column index 1)
normalized_new_names <- new_names[,2] %>% str_replace_all(c("Sa1P"="SPBP","So1P"="SPBP")) %>% parseLipidNames(.)
```

We will receive a number of warnings in the next step, since lipidr currently checks lipid class names against a predefined, internal list that does not contain the updated class names according to the new shorthand nomenclature. The updated Molecule names will however appear in downstream visualizations.

```
updated <- update_molecule_names(d, old_names, normalized_new_names$Normalized.Name)
#> Joining with `by = join_by(Molecule)`
#> Warning in annotate_lipids(updated_names$Molecule): Some lipid names couldn't be parsed because they don't follow the pattern 'CLS xx:x/yy:y'
#>     PE O-34:0, PE O-34:1, PE O-34:2, PE O-36:0, PE O-36:1, PE O-36:2, PE O-36:3, PE O-36:4, PE O-36:5, PE O-38:0, PE O-38:1, PE O-38:2, PE O-38:3, PE O-38:4, PE O-38:5, PE O-40:5, PE O-40:6, PE O-40:7, PE O-32:1, PE O-34:3, PE O-38:6, PE O-38:7, PI O-34:1, SPBP 18:0;OH, SPBP 17:1;O2, SPBP 18:1;O2, SM 18:1;O2, SM 18:0;O2, Cer 18:0;O2, Cer 18:1;O2, Cer 18:2;O2, PC O-32:0, PC O-34:1, PC O-34:2, PC O-34:3, PC O-36:2, PC O-36:3, PC O-36:4, PC O-36:5, PC O-38:0, PC O-38:2, PC O-38:3, PC O-38:4, PC O-38:5, PC O-40:0, PC O-40:1, PC O-40:2, PC O-40:3, PC O-40:4, PC O-40:5, PC O-40:6, PC O-40:7, PC O-32:1, PC O-34:4, PC O-36:6, PC O-38:1, PC O-38:6, PC O-38:7
#> Joining with `by = join_by(Molecule)`
```

We can augment the class column using rgoslin’s LipidMaps main class, since row order in rgoslin’s output is the same as in its input.
Additionally, further information may be interesting to include, such as the mass and sum formula of the uncharged lipids.
We will select the same lipid classes as in the lipidr targeted lipidomics vignette: Ceramides (Cer), Lyso-Phosphatidylcholines (LPC) and Phosphatidylcholines (PC).

```
rowData(updated)$Class <- normalized_new_names$Lipid.Maps.Main.Class
rowData(updated)$Category <- normalized_new_names$Lipid.Maps.Category
rowData(updated)$Molecule <- normalized_new_names$Normalized.Name
rowData(updated)$LipidSpecies <- normalized_new_names$Species.Name
rowData(updated)$Mass <- normalized_new_names$Mass
rowData(updated)$SumFormula <- normalized_new_names$Sum.Formula
# select Ceramides, Lyso-Phosphatidylcholines and Phosphatidylcholines (includes plasmanyls and plasmenyls)
lipid_classes <- rowData(updated)$Class %in% c("Cer","LPC", "PC")
d <- updated[lipid_classes,]
```

In the next step, we use a non-exported method provided by lipidr to convert the row data into a format more suitable for plotting with ggplot. We will plot the area distribution of lipid species as boxplots, colored by lipid class and facetted by filename, similar to some plot examples in lipidr’s vignette.

```
ddf <- lipidr:::to_long_format(d)
ggplot(data=ddf, mapping=aes(x=Molecule, y=Area, fill=Class)) + geom_boxplot() + facet_wrap(~filename, scales = "free_y") + scale_y_log10() + coord_flip()
#> Warning in scale_y_log10(): log-10 transformation introduced infinite values.
#> Warning: Removed 15 rows containing non-finite outside the scale range
#> (`stat_boxplot()`).
```

![](data:image/png;base64...)

In the same manner, other columns of lipidr’s `rowData` can be updated with columns from rgoslin’s output data frame. Further downstream processing is then possible with lipidr’s own functions.

# 4 Getting help & support

If you find any issues with the library, would like to have other functionality included, require help or would like to contribute, please contact us via our [GitHub Project](https://github.com/lifs-tools/rgoslin) or via the [LIFS support page](https://lifs-tools.org/support.html).

# Session information

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] ggplot2_4.0.0               stringr_1.5.2
#>  [3] lipidr_2.24.0               SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           kableExtra_1.4.0
#> [15] knitr_1.50                  dplyr_1.1.4
#> [17] rgoslin_1.14.0              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            viridisLite_0.4.2
#>  [3] farver_2.1.2                S7_0.2.0
#>  [5] fastmap_1.2.0               digest_0.6.37
#>  [7] lifecycle_1.0.4             statmod_1.5.1
#>  [9] magrittr_2.0.4              compiler_4.5.1
#> [11] rlang_1.1.6                 sass_0.4.10
#> [13] tools_4.5.1                 yaml_2.3.10
#> [15] calibrate_1.7.7             data.table_1.17.8
#> [17] S4Arrays_1.10.0             DelayedArray_0.36.0
#> [19] xml2_1.4.1                  RColorBrewer_1.1-3
#> [21] ropls_1.42.0                abind_1.4-8
#> [23] norm_1.0-11.1               purrr_1.1.0
#> [25] withr_3.0.2                 grid_4.5.1
#> [27] scales_1.4.0                MASS_7.3-65
#> [29] tinytex_0.57                MultiAssayExperiment_1.36.0
#> [31] dichromat_2.0-0.1           cli_3.6.5
#> [33] mvtnorm_1.3-3               tmvtnorm_1.7
#> [35] rmarkdown_2.30              rstudioapi_0.17.1
#> [37] BiocBaseUtils_1.12.0        cachem_1.1.0
#> [39] impute_1.84.0               BiocManager_1.30.26
#> [41] XVector_0.50.0              vctrs_0.6.5
#> [43] Matrix_1.7-4                sandwich_3.1-1
#> [45] jsonlite_2.0.0              bookdown_0.45
#> [47] imputeLCMD_2.1              qqman_0.1.9
#> [49] magick_2.9.0                systemfonts_1.3.1
#> [51] limma_3.66.0                tidyr_1.3.1
#> [53] jquerylib_0.1.4             MultiDataSet_1.38.0
#> [55] glue_1.8.0                  stringi_1.8.7
#> [57] gmm_1.9-1                   gtable_0.3.6
#> [59] tibble_3.3.0                pillar_1.11.1
#> [61] pcaMethods_2.2.0            htmltools_0.5.8.1
#> [63] R6_2.6.1                    textshaping_1.0.4
#> [65] evaluate_1.0.5              lattice_0.22-7
#> [67] bslib_0.9.0                 Rcpp_1.1.0
#> [69] svglite_2.2.2               SparseArray_1.10.0
#> [71] xfun_0.53                   zoo_1.8-14
#> [73] forcats_1.0.1               pkgconfig_2.0.3
```