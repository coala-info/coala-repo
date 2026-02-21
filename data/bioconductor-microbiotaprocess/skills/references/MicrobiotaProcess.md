# Introduction to MicrobiotaProcess

#### Shuangbin Xu and GuangChuang Yu School of Basic Medical Sciences, Southern Medical University

#### 2025-10-30

* [1. Anatomy of a **MPSE**](#anatomy-of-a-mpse)
* [2. Overview of the design of **MicrobiotaProcess** package](#overview-of-the-design-of-microbiotaprocess-package)
* [3. **MicrobiotaProcess** profiling](#microbiotaprocess-profiling)
  + [3.1 bridges other tools](#bridges-other-tools)
  + [3.2 alpha diversity analysis](#alpha-diversity-analysis)
  + [3.3 calculate alpha index and visualization](#calculate-alpha-index-and-visualization)
  + [3.4 The visualization of taxonomy abundance](#the-visualization-of-taxonomy-abundance)
  + [3.5 Beta diversity analysis](#beta-diversity-analysis)
    - [3.5.1 The distance between samples or groups](#the-distance-between-samples-or-groups)
    - [3.5.2 The PCoA analysis](#the-pcoa-analysis)
    - [3.5.3 Hierarchical cluster analysis](#hierarchical-cluster-analysis)
  + [3.6 Biomarker discovery](#biomarker-discovery)
* [4. Need helps?](#need-helps)
* [5. Session information](#session-information)
* [6. References](#references)

# 1. Anatomy of a **MPSE**

`MicrobiotaProcess` introduces `MPSE` S4 class. This class inherits the `SummarizedExperiment`(Morgan et al. 2021) class. Here, the `assays` slot is used to store the rectangular abundance matrices of features for a microbiome experimental results. The `colData` slot is used to store the meta-data of sample and some results about samples in the downstream analysis. The `rowData` is used to store the meta-data of features and some results about the features in the downstream analysis. Compared to the `SummarizedExperiment` object, `MPSE` introduces the following additional slots:

* taxatree: is a `treedata`(Wang et al. 2020; Yu 2021) class contained phylo class (hierarchical structure) and tibble class (associated data) to store the taxonomy information, the tip labels of taxonomy tree are the rows of the `assays`, but the internal node labels contain the differences level taxonomy of the rows of the `assays`. The tibble class contains the taxonomy classification of node labels.
* otutree: is also a `treedata` class to store the phylogenetic tree (based with reference sequences) and the associated data, which its tip labels are also the rows of the assays.
* refseq: is a `XStringSet`(Pagès et al. 2021) class contained reference sequences, which its names are also identical with the rows of the assays.

![The structure of the MPSE class.](data:image/png;base64...)

The structure of the MPSE class.

# 2. Overview of the design of **MicrobiotaProcess** package

With this data structure, `MicrobiotaProcess` will be more interoperable with the existing computing ecosystem. For example, the slots inherited `SummarizedExperiment` can be extracted via the methods provided by `SummarizedExperiment`. The `taxatree` and `otutree` can also be extracted via `mp_extract_tree`, and they are compatible with `ggtree`(Yu et al. 2017), `ggtreeExtra`(Xu et al. 2021), `treeio`(Wang et al. 2020) and `tidytree`(Yu 2021) ecosystem since they are all `treedata` class, which is a data structure used directly by these packages.

Moreover, the results of upstream analysis of microbiome based some tools, such as `qiime2`(Bolyen et al. 2019), `dada2`(Callahan et al. 2016) and `MetaPhlAn`(Beghini et al. 2021) or other classes (`SummarizedExperiment`(Morgan et al. 2021), `phyloseq`(McMurdie and Holmes 2013) and `TreeSummarizedExperiment`(Huang et al. 2021)) used to store the result of microbiome can be loaded or transformed to the `MPSE` class.

In addition, `MicrobiotaProcess` also introduces a tidy microbiome data structure paradigm and analysis grammar. It provides a wide variety of microbiome analysis procedures under a unified and common framework (tidy-like framework). We believe `MicrobiotaProcess` can improve the efficiency of related researches, and it also bridges microbiome data analysis with the `tidyverse`(Wickham et al. 2019).

![The Overview of the design of MicrobiotaProcess package](data:image/png;base64...)

The Overview of the design of MicrobiotaProcess package

# 3. **MicrobiotaProcess** profiling

## 3.1 bridges other tools

`MicrobiotaProcess` provides several functions to parsing the output of upstream analysis tools of microbiome, such as qiime2(Bolyen et al. 2019), dada2(Callahan et al. 2016) and MetaPhlAn(Beghini et al. 2021), and return `MPSE` object. Some bioconductor class, such as `phyloseq`(McMurdie and Holmes 2013), `TreeSummarizedExperiment`(Huang et al. 2021) and `SummarizedExperiment`(Morgan et al. 2021) can also be converted to `MPSE` via `as.MPSE()`.

```
library(MicrobiotaProcess)
#parsing the output of dada2
seqtabfile <- system.file("extdata", "seqtab.nochim.rds", package="MicrobiotaProcess")
seqtab <- readRDS(seqtabfile)
taxafile <- system.file("extdata", "taxa_tab.rds", package="MicrobiotaProcess")
taxa <- readRDS(taxafile)
# the seqtab and taxa are output of dada2
sampleda <- system.file("extdata", "mouse.time.dada2.txt", package="MicrobiotaProcess")
mpse1 <- mp_import_dada2(seqtab=seqtab, taxatab=taxa, sampleda=sampleda)
mpse1
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,408 × 11
## # OTU=232 | Samples=19 | Assays=Abundance | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance time  Kingdom Phylum Class Order Family Genus Species
##    <chr>  <chr>      <int> <chr> <chr>   <chr>  <chr> <chr> <chr>  <chr> <chr>
##  1 OTU_1  F3D0         579 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  2 OTU_2  F3D0         345 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  3 OTU_3  F3D0         449 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  4 OTU_4  F3D0         430 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  5 OTU_5  F3D0         154 Early k__Bac… p__Ba… c__B… o__B… f__Ba… g__B… s__un_…
##  6 OTU_6  F3D0         470 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  7 OTU_7  F3D0         282 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  8 OTU_8  F3D0         184 Early k__Bac… p__Ba… c__B… o__B… f__Ri… g__A… s__un_…
##  9 OTU_9  F3D0          45 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
## 10 OTU_10 F3D0         158 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
## # ℹ 4,398 more rows
```

```
# parsing the output of qiime2
otuqzafile <- system.file("extdata", "table.qza", package="MicrobiotaProcess")
taxaqzafile <- system.file("extdata", "taxa.qza", package="MicrobiotaProcess")
mapfile <- system.file("extdata", "metadata_qza.txt", package="MicrobiotaProcess")
mpse2 <- mp_import_qiime2(otuqza=otuqzafile, taxaqza=taxaqzafile, mapfilename=mapfile)
mpse2
```

```
## # A MPSE-tibble (MPSE object) abstraction: 12,006 × 32
## # OTU=138 | Samples=87 | Assays=Abundance | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample    Abundance Sample_Name_s BarcodeSequence LinkerPrimerSequence
##    <chr>  <chr>         <dbl> <chr>         <chr>           <chr>
##  1 OTU_1  ERR13318…       901 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  2 OTU_2  ERR13318…       877 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  3 OTU_3  ERR13318…       239 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  4 OTU_4  ERR13318…       201 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  5 OTU_5  ERR13318…       168 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  6 OTU_6  ERR13318…       115 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  7 OTU_7  ERR13318…       107 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  8 OTU_8  ERR13318…        84 LR53          AGTGTCGATTCG    TATGGTAATTGT
##  9 OTU_9  ERR13318…        67 LR53          AGTGTCGATTCG    TATGGTAATTGT
## 10 OTU_10 ERR13318…        67 LR53          AGTGTCGATTCG    TATGGTAATTGT
## # ℹ 11,996 more rows
## # ℹ 26 more variables: Subject <chr>, Sex <chr>, Age <int>, Pittsburgh <chr>,
## #   Bell <dbl>, BMI <dbl>, sCD14ugml <dbl>, LBPugml <dbl>, LPSpgml <dbl>,
## #   IFABPpgml <dbl>, Physical_functioning <dbl>, Role_physical <dbl>,
## #   Role_emotional <dbl>, Energy_fatigue <dbl>, Emotional_well_being <dbl>,
## #   Social_functioning <dbl>, Pain <dbl>, General_health <dbl>,
## #   Description <lgl>, Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>, …
```

```
# parsing the output of MetaPhlAn
file1 <- system.file("extdata/MetaPhlAn", "metaphlan_test.txt", package="MicrobiotaProcess")
sample.file <- system.file("extdata/MetaPhlAn", "sample_test.txt", package="MicrobiotaProcess")
mpse3 <- mp_import_metaphlan(profile=file1, mapfilename=sample.file)
mpse3
```

```
## # A MPSE-tibble (MPSE object) abstraction: 5,260 × 11
## # OTU=263 | Samples=20 | Assays=Abundance | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus
##    OTU      Sample Abundance group taxid Kingdom Phylum Class Order Family Genus
##    <chr>    <chr>      <dbl> <chr> <chr> <chr>   <chr>  <chr> <chr> <chr>  <chr>
##  1 s__Meth… GupDM…     0.596 testA 2157… k__Arc… p__Eu… c__M… o__M… f__Me… g__M…
##  2 s__Acti… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__A… f__Ac… g__A…
##  3 s__Acti… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__A… f__Ac… g__A…
##  4 s__Acti… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__A… f__Ac… g__A…
##  5 s__Bifi… GupDM…     0.948 testA 2|20… k__Bac… p__Ac… c__A… o__B… f__Bi… g__B…
##  6 s__Bifi… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__B… f__Bi… g__B…
##  7 s__Bifi… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__B… f__Bi… g__B…
##  8 s__Bifi… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__B… f__Bi… g__B…
##  9 s__Bifi… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__B… f__Bi… g__B…
## 10 s__Bifi… GupDM…     0     testA 2|20… k__Bac… p__Ac… c__A… o__B… f__Bi… g__B…
## # ℹ 5,250 more rows
```

```
# convert phyloseq object to mpse
#library(phyloseq)
#data(esophagus)
#esophagus
#mpse4 <- esophagus %>% as.MPSE()
#mpse4
# convert TreeSummarizedExperiment object to mpse
# library(curatedMetagenomicData)
# tse <- curatedMetagenomicData::curatedMetagenomicData("ZhuF_2020.relative_abundance", dryrun=F)
# tse[[1]] %>% as.MPSE() -> mpse5
# mpse5
```

## 3.2 alpha diversity analysis

Rarefaction, based on sampling technique, was used to compensate for the effect of sample size on the number of units observed in a sample(Siegel 2004). `MicrobiotaProcess` provided `mp_cal_rarecurve` and `mp_plot_rarecurve` to calculate and plot the curves based on `rrarefy` of [vegan](https://CRAN.R-project.org/package%3Dvegan)(Oksanen et al. 2019).

```
library(ggplot2)
library(MicrobiotaProcess)
data(mouse.time.mpse)
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 11
## # OTU=218 | Samples=19 | Assays=Abundance | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance time  Kingdom Phylum Class Order Family Genus Species
##    <chr>  <chr>      <int> <chr> <chr>   <chr>  <chr> <chr> <chr>  <chr> <chr>
##  1 OTU_1  F3D0         579 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  2 OTU_2  F3D0         345 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  3 OTU_3  F3D0         449 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  4 OTU_4  F3D0         430 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  5 OTU_5  F3D0         154 Early k__Bac… p__Ba… c__B… o__B… f__Ba… g__B… s__un_…
##  6 OTU_6  F3D0         470 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  7 OTU_7  F3D0         282 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
##  8 OTU_8  F3D0         184 Early k__Bac… p__Ba… c__B… o__B… f__Ri… g__A… s__un_…
##  9 OTU_9  F3D0          45 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
## 10 OTU_10 F3D0         158 Early k__Bac… p__Ba… c__B… o__B… f__Mu… g__u… s__un_…
## # ℹ 4,132 more rows
```

```
# Rarefied species richness
mouse.time.mpse %<>% mp_rrarefy()
# 'chunks' represent the split number of each sample to calculate alpha
# diversity, default is 400. e.g. If a sample has total 40000
# reads, if chunks is 400, it will be split to 100 sub-samples
# (100, 200, 300,..., 40000), then alpha diversity index was
# calculated based on the sub-samples.
# '.abundance' the column name of abundance, if the '.abundance' is not be
# rarefied calculate rarecurve, user can specific 'force=TRUE'.
mouse.time.mpse %<>%
    mp_cal_rarecurve(
        .abundance = RareAbundance,
        chunks = 400
    )
# The RareAbundanceRarecurve column will be added the colData slot
# automatically (default action="add")
mouse.time.mpse %>% print(width=180)
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 13
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance | Taxonomy=Kingdom,
## #   Phylum, Class, Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance time  RareAbundanceRarecurve
##    <chr>  <chr>      <int>         <int> <chr> <list>
##  1 OTU_1  F3D0         579           214 Early <tibble [2,520 × 4]>
##  2 OTU_2  F3D0         345           116 Early <tibble [2,520 × 4]>
##  3 OTU_3  F3D0         449           179 Early <tibble [2,520 × 4]>
##  4 OTU_4  F3D0         430           167 Early <tibble [2,520 × 4]>
##  5 OTU_5  F3D0         154            54 Early <tibble [2,520 × 4]>
##  6 OTU_6  F3D0         470           174 Early <tibble [2,520 × 4]>
##  7 OTU_7  F3D0         282           115 Early <tibble [2,520 × 4]>
##  8 OTU_8  F3D0         184            74 Early <tibble [2,520 × 4]>
##  9 OTU_9  F3D0          45            16 Early <tibble [2,520 × 4]>
## 10 OTU_10 F3D0         158            59 Early <tibble [2,520 × 4]>
##    Kingdom     Phylum           Class          Order
##    <chr>       <chr>            <chr>          <chr>
##  1 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  2 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  3 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  4 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  5 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  6 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  7 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  8 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##  9 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
## 10 k__Bacteria p__Bacteroidetes c__Bacteroidia o__Bacteroidales
##    Family            Genus                   Species
##    <chr>             <chr>                   <chr>
##  1 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
##  2 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
##  3 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
##  4 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
##  5 f__Bacteroidaceae g__Bacteroides          s__un_g__Bacteroides
##  6 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
##  7 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
##  8 f__Rikenellaceae  g__Alistipes            s__un_g__Alistipes
##  9 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
## 10 f__Muribaculaceae g__un_f__Muribaculaceae s__un_f__Muribaculaceae
## # ℹ 4,132 more rows
```

```
# default will display the confidence interval around smooth.
# se=TRUE
p1 <- mouse.time.mpse %>%
      mp_plot_rarecurve(
         .rare = RareAbundanceRarecurve,
         .alpha = Observe,
      )

p2 <- mouse.time.mpse %>%
      mp_plot_rarecurve(
         .rare = RareAbundanceRarecurve,
         .alpha = Observe,
         .group = time
      ) +
      scale_color_manual(values=c("#00A087FF", "#3C5488FF")) +
      scale_fill_manual(values=c("#00A087FF", "#3C5488FF"), guide="none")

# combine the samples belong to the same groups if
# plot.group=TRUE
p3 <- mouse.time.mpse %>%
      mp_plot_rarecurve(
         .rare = RareAbundanceRarecurve,
         .alpha = "Observe",
         .group = time,
         plot.group = TRUE
      ) +
       scale_color_manual(values=c("#00A087FF", "#3C5488FF")) +
       scale_fill_manual(values=c("#00A087FF", "#3C5488FF"),guide="none")

p1 + p2 + p3
```

![The rarefaction of samples or groups](data:image/png;base64...)

The rarefaction of samples or groups

```
# Users can extract the result with mp_extract_rarecurve to extract the result of mp_cal_rarecurve
# and visualized the result manually.
```

## 3.3 calculate alpha index and visualization

Alpha diversity can be estimated the species richness and evenness of some species communities. `MicrobiotaProcess` provides `mp_cal_alpha` to calculate alpha index (Observe, Chao1, ACE, Shannon, Simpson and J (Pielou’s evenness)) and the `mp_plot_alpha` to visualize the result.

```
library(ggplot2)
library(MicrobiotaProcess)
mouse.time.mpse %<>%
    mp_cal_alpha(.abundance=RareAbundance)
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 19
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance | Taxonomy=Kingdom,
## #   Phylum, Class, Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance time  RareAbundanceRarecurve Observe
##    <chr>  <chr>      <int>         <int> <chr> <list>                   <dbl>
##  1 OTU_1  F3D0         579           214 Early <tibble [2,520 × 4]>       104
##  2 OTU_2  F3D0         345           116 Early <tibble [2,520 × 4]>       104
##  3 OTU_3  F3D0         449           179 Early <tibble [2,520 × 4]>       104
##  4 OTU_4  F3D0         430           167 Early <tibble [2,520 × 4]>       104
##  5 OTU_5  F3D0         154            54 Early <tibble [2,520 × 4]>       104
##  6 OTU_6  F3D0         470           174 Early <tibble [2,520 × 4]>       104
##  7 OTU_7  F3D0         282           115 Early <tibble [2,520 × 4]>       104
##  8 OTU_8  F3D0         184            74 Early <tibble [2,520 × 4]>       104
##  9 OTU_9  F3D0          45            16 Early <tibble [2,520 × 4]>       104
## 10 OTU_10 F3D0         158            59 Early <tibble [2,520 × 4]>       104
## # ℹ 4,132 more rows
## # ℹ 12 more variables: Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>,
## #   Pielou <dbl>, Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>,
## #   Family <chr>, Genus <chr>, Species <chr>
```

```
f1 <- mouse.time.mpse %>%
      mp_plot_alpha(
        .group=time,
        .alpha=c(Observe, Chao1, ACE, Shannon, Simpson, Pielou)
      ) +
      scale_fill_manual(values=c("#00A087FF", "#3C5488FF"), guide="none") +
      scale_color_manual(values=c("#00A087FF", "#3C5488FF"), guide="none")

f2 <- mouse.time.mpse %>%
      mp_plot_alpha(
        .alpha=c(Observe, Chao1, ACE, Shannon, Simpson, Pielou)
      )

f1 / f2
```

![The alpha diversity comparison](data:image/png;base64...)

The alpha diversity comparison

Users can extract the result with mp\_extract\_sample() to extract the result of mp\_cal\_alpha and visualized the result manually, see the example of mp\_cal\_alpha.

## 3.4 The visualization of taxonomy abundance

`MicrobiotaProcess` provides the `mp_cal_abundance`, `mp_plot_abundance` to calculate and plot the composition of species communities. And the `mp_extract_abundance` can extract the abundance of specific taxonomy level. User can also extract the abundance table to perform external analysis such as visualize manually (see the example of `mp_cal_abundance`).

```
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 19
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance | Taxonomy=Kingdom,
## #   Phylum, Class, Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance time  RareAbundanceRarecurve Observe
##    <chr>  <chr>      <int>         <int> <chr> <list>                   <dbl>
##  1 OTU_1  F3D0         579           214 Early <tibble [2,520 × 4]>       104
##  2 OTU_2  F3D0         345           116 Early <tibble [2,520 × 4]>       104
##  3 OTU_3  F3D0         449           179 Early <tibble [2,520 × 4]>       104
##  4 OTU_4  F3D0         430           167 Early <tibble [2,520 × 4]>       104
##  5 OTU_5  F3D0         154            54 Early <tibble [2,520 × 4]>       104
##  6 OTU_6  F3D0         470           174 Early <tibble [2,520 × 4]>       104
##  7 OTU_7  F3D0         282           115 Early <tibble [2,520 × 4]>       104
##  8 OTU_8  F3D0         184            74 Early <tibble [2,520 × 4]>       104
##  9 OTU_9  F3D0          45            16 Early <tibble [2,520 × 4]>       104
## 10 OTU_10 F3D0         158            59 Early <tibble [2,520 × 4]>       104
## # ℹ 4,132 more rows
## # ℹ 12 more variables: Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>,
## #   Pielou <dbl>, Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>,
## #   Family <chr>, Genus <chr>, Species <chr>
```

```
mouse.time.mpse %<>%
    mp_cal_abundance( # for each samples
      .abundance = RareAbundance
    ) %>%
    mp_cal_abundance( # for each groups
      .abundance=RareAbundance,
      .group=time
    )
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 20
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance,
## #   RelRareAbundanceBySample | Taxonomy=Kingdom, Phylum, Class, Order, Family,
## #   Genus, Species
##    OTU    Sample Abundance RareAbundance RelRareAbundanceBySample time
##    <chr>  <chr>      <int>         <int>                    <dbl> <chr>
##  1 OTU_1  F3D0         579           214                    8.50  Early
##  2 OTU_2  F3D0         345           116                    4.61  Early
##  3 OTU_3  F3D0         449           179                    7.11  Early
##  4 OTU_4  F3D0         430           167                    6.63  Early
##  5 OTU_5  F3D0         154            54                    2.14  Early
##  6 OTU_6  F3D0         470           174                    6.91  Early
##  7 OTU_7  F3D0         282           115                    4.57  Early
##  8 OTU_8  F3D0         184            74                    2.94  Early
##  9 OTU_9  F3D0          45            16                    0.635 Early
## 10 OTU_10 F3D0         158            59                    2.34  Early
## # ℹ 4,132 more rows
## # ℹ 14 more variables: RareAbundanceRarecurve <list>, Observe <dbl>,
## #   Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>, Pielou <dbl>,
## #   Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>, Family <chr>,
## #   Genus <chr>, Species <chr>
```

```
# visualize the relative abundance of top 20 phyla for each sample.
p1 <- mouse.time.mpse %>%
         mp_plot_abundance(
           .abundance=RareAbundance,
           .group=time,
           taxa.class = Phylum,
           topn = 20,
           relative = TRUE
         )
# visualize the abundance (rarefied) of top 20 phyla for each sample.
p2 <- mouse.time.mpse %>%
          mp_plot_abundance(
            .abundance=RareAbundance,
            .group=time,
            taxa.class = Phylum,
            topn = 20,
            relative = FALSE
          )
p1 / p2
```

![The relative abundance and abundance of phyla of all samples ](data:image/png;base64...)

The relative abundance and abundance of phyla of all samples

The abundance of features also can be visualized by `mp_plot_abundance` with `heatmap` plot by setting `geom='heatmap'`.

```
h1 <- mouse.time.mpse %>%
         mp_plot_abundance(
           .abundance = RareAbundance,
           .group = time,
           taxa.class = Phylum,
           relative = TRUE,
           topn = 20,
           geom = 'heatmap',
           features.dist = 'euclidean',
           features.hclust = 'average',
           sample.dist = 'bray',
           sample.hclust = 'average'
         )

h2 <- mouse.time.mpse %>%
          mp_plot_abundance(
            .abundance = RareAbundance,
            .group = time,
            taxa.class = Phylum,
            relative = FALSE,
            topn = 20,
            geom = 'heatmap',
            features.dist = 'euclidean',
            features.hclust = 'average',
            sample.dist = 'bray',
            sample.hclust = 'average'
          )
# the character (scale or theme) of figure can be adjusted by set_scale_theme
# refer to the mp_plot_dist
aplot::plot_list(gglist=list(h1, h2), tag_levels="A")
```

![The relative abundance and abundance of phyla of all samples ](data:image/png;base64...)

The relative abundance and abundance of phyla of all samples

```
# visualize the relative abundance of top 20 phyla for each .group (time)
p3 <- mouse.time.mpse %>%
         mp_plot_abundance(
            .abundance=RareAbundance,
            .group=time,
            taxa.class = Phylum,
            topn = 20,
            plot.group = TRUE
          )

# visualize the abundance of top 20 phyla for each .group (time)
p4 <- mouse.time.mpse %>%
          mp_plot_abundance(
             .abundance=RareAbundance,
             .group= time,
             taxa.class = Phylum,
             topn = 20,
             relative = FALSE,
             plot.group = TRUE
           )
p3 / p4
```

![The relative abundance and abundance of phyla of groups ](data:image/png;base64...)

The relative abundance and abundance of phyla of groups

## 3.5 Beta diversity analysis

Beta diversity is used to quantify the dissimilarities between the communities (samples). Some distance indexes, such as Bray-Curtis index, Jaccard index, UniFrac (weighted or unweighted) index, are useful for or popular with the community ecologists. Many ordination methods are used to estimated the dissimilarities in community ecology. `MicrobiotaProcess` implements `mp_cal_dist` to calculate the common distance, and provided `mp_plot_dist` to visualize the result. It also provides several commonly-used ordination methods, such as `PCA` (`mp_cal_pca`), `PCoA` (`mp_cal_pcoa`), `NMDS` (`mp_cal_nmds`), `DCA` (`mp_cal_dca`), `RDA` (`mp_cal_rda`), `CCA` (`mp_cal_cca`), and a function (`mp_envfit`) fits environmental vectors or factors onto an ordination. Moreover, it also wraps several statistical analysis for the distance matrices, such as `adonis` (`mp_adonis`), `anosim` (mp\_anosim), `mrpp` (`mp_mrpp`) and `mantel` (`mp_mantel`). All these functions are developed based on tidy-like framework, and provided unified grammar, we believe these functions will help users to do the ordination analysis more conveniently.

### 3.5.1 The distance between samples or groups

```
# standardization
# mp_decostand wraps the decostand of vegan, which provides
# many standardization methods for community ecology.
# default is hellinger, then the abundance processed will
# be stored to the assays slot.
mouse.time.mpse %<>%
    mp_decostand(.abundance=Abundance)
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 21
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance,
## #   RelRareAbundanceBySample, hellinger | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance RelRareAbundanceBySam…¹ hellinger time
##    <chr>  <chr>      <int>         <int>                   <dbl>     <dbl> <chr>
##  1 OTU_1  F3D0         579           214                   8.50     0.298  Early
##  2 OTU_2  F3D0         345           116                   4.61     0.230  Early
##  3 OTU_3  F3D0         449           179                   7.11     0.262  Early
##  4 OTU_4  F3D0         430           167                   6.63     0.257  Early
##  5 OTU_5  F3D0         154            54                   2.14     0.154  Early
##  6 OTU_6  F3D0         470           174                   6.91     0.268  Early
##  7 OTU_7  F3D0         282           115                   4.57     0.208  Early
##  8 OTU_8  F3D0         184            74                   2.94     0.168  Early
##  9 OTU_9  F3D0          45            16                   0.635    0.0830 Early
## 10 OTU_10 F3D0         158            59                   2.34     0.156  Early
## # ℹ 4,132 more rows
## # ℹ abbreviated name: ¹​RelRareAbundanceBySample
## # ℹ 14 more variables: RareAbundanceRarecurve <list>, Observe <dbl>,
## #   Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>, Pielou <dbl>,
## #   Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>, Family <chr>,
## #   Genus <chr>, Species <chr>
```

```
# calculate the distance between the samples.
# the distance will be generated a nested tibble and added to the
# colData slot.
mouse.time.mpse %<>% mp_cal_dist(.abundance=hellinger, distmethod="bray")
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 22
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance,
## #   RelRareAbundanceBySample, hellinger | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance RelRareAbundanceBySam…¹ hellinger time
##    <chr>  <chr>      <int>         <int>                   <dbl>     <dbl> <chr>
##  1 OTU_1  F3D0         579           214                   8.50     0.298  Early
##  2 OTU_2  F3D0         345           116                   4.61     0.230  Early
##  3 OTU_3  F3D0         449           179                   7.11     0.262  Early
##  4 OTU_4  F3D0         430           167                   6.63     0.257  Early
##  5 OTU_5  F3D0         154            54                   2.14     0.154  Early
##  6 OTU_6  F3D0         470           174                   6.91     0.268  Early
##  7 OTU_7  F3D0         282           115                   4.57     0.208  Early
##  8 OTU_8  F3D0         184            74                   2.94     0.168  Early
##  9 OTU_9  F3D0          45            16                   0.635    0.0830 Early
## 10 OTU_10 F3D0         158            59                   2.34     0.156  Early
## # ℹ 4,132 more rows
## # ℹ abbreviated name: ¹​RelRareAbundanceBySample
## # ℹ 15 more variables: RareAbundanceRarecurve <list>, Observe <dbl>,
## #   Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>, Pielou <dbl>,
## #   bray <list>, Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>,
## #   Family <chr>, Genus <chr>, Species <chr>
```

```
# mp_plot_dist provides there methods to visualize the distance between the samples or groups
# when .group is not provided, the dot heatmap plot will be return
p1 <- mouse.time.mpse %>% mp_plot_dist(.distmethod = bray)
p1
```

![the distance between samples](data:image/png;base64...)

the distance between samples

```
# when .group is provided, the dot heatmap plot with group information will be return.
p2 <- mouse.time.mpse %>% mp_plot_dist(.distmethod = bray, .group = time)
# The scale or theme of dot heatmap plot can be adjusted using set_scale_theme function.
p2 %>% set_scale_theme(
          x = scale_fill_manual(
                 values=c("orange", "deepskyblue"),
                 guide = guide_legend(
                             keywidth = 1,
                             keyheight = 0.5,
                             title.theme = element_text(size=8),
                             label.theme = element_text(size=6)
                 )
              ),
          aes_var = time # specific the name of variable
       ) %>%
       set_scale_theme(
          x = scale_color_gradient(
                 guide = guide_legend(keywidth = 0.5, keyheight = 0.5)
              ),
          aes_var = bray
       ) %>%
       set_scale_theme(
          x = scale_size_continuous(
                 range = c(0.1, 3),
                 guide = guide_legend(keywidth = 0.5, keyheight = 0.5)
              ),
          aes_var = bray
       )
```

![The distance between samples with group information](data:image/png;base64...)

The distance between samples with group information

```
# when .group is provided and group.test is TRUE, the comparison of different groups will be returned
p3 <- mouse.time.mpse %>% mp_plot_dist(.distmethod = bray, .group = time, group.test=TRUE, textsize=2)
p3
```

![The comparison of distance among the groups](data:image/png;base64...)

The comparison of distance among the groups

### 3.5.2 The PCoA analysis

The distance can be used to do the ordination analysis, such as `PCoA`, `NMDS`, etc. Here, we only show the example of `PCoA` analysis, other ordinations can refer to the examples and the usages of the corresponding functions.

```
mouse.time.mpse %<>%
    mp_cal_pcoa(.abundance=hellinger, distmethod="bray")
# The dimensions of ordination analysis will be added the colData slot (default).
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 25
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance,
## #   RelRareAbundanceBySample, hellinger | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance RelRareAbundanceBySam…¹ hellinger time
##    <chr>  <chr>      <int>         <int>                   <dbl>     <dbl> <chr>
##  1 OTU_1  F3D0         579           214                   8.50     0.298  Early
##  2 OTU_2  F3D0         345           116                   4.61     0.230  Early
##  3 OTU_3  F3D0         449           179                   7.11     0.262  Early
##  4 OTU_4  F3D0         430           167                   6.63     0.257  Early
##  5 OTU_5  F3D0         154            54                   2.14     0.154  Early
##  6 OTU_6  F3D0         470           174                   6.91     0.268  Early
##  7 OTU_7  F3D0         282           115                   4.57     0.208  Early
##  8 OTU_8  F3D0         184            74                   2.94     0.168  Early
##  9 OTU_9  F3D0          45            16                   0.635    0.0830 Early
## 10 OTU_10 F3D0         158            59                   2.34     0.156  Early
## # ℹ 4,132 more rows
## # ℹ abbreviated name: ¹​RelRareAbundanceBySample
## # ℹ 18 more variables: RareAbundanceRarecurve <list>, Observe <dbl>,
## #   Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>, Pielou <dbl>,
## #   bray <list>, `PCo1 (46.6%)` <dbl>, `PCo2 (13.31%)` <dbl>,
## #   `PCo3 (8.22%)` <dbl>, Kingdom <chr>, Phylum <chr>, Class <chr>,
## #   Order <chr>, Family <chr>, Genus <chr>, Species <chr>
```

```
# We also can perform adonis or anosim to check whether it is significant to the dissimilarities of groups.
mouse.time.mpse %<>%
     mp_adonis(.abundance=hellinger, .formula=~time, distmethod="bray", permutations=9999, action="add")
mouse.time.mpse %>% mp_extract_internal_attr(name=adonis)
```

```
## Permutation test for adonis under reduced model
## Permutation: free
## Number of permutations: 9999
##
## vegan::adonis2(formula = .formula, data = sampleda, permutations = permutations, method = distmethod)
##          Df SumOfSqs      R2      F Pr(>F)
## Model     1  0.58216 0.44137 13.431  1e-04 ***
## Residual 17  0.73683 0.55863
## Total    18  1.31899 1.00000
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```
library(ggplot2)
p1 <- mouse.time.mpse %>%
        mp_plot_ord(
          .ord = pcoa,
          .group = time,
          .color = time,
          .size = 1.2,
          .alpha = 1,
          ellipse = TRUE,
          show.legend = FALSE # don't display the legend of stat_ellipse
        ) +
        scale_fill_manual(values=c("#00A087FF", "#3C5488FF")) +
        scale_color_manual(values=c("#00A087FF", "#3C5488FF"))

# The size of point also can be mapped to other variables such as Observe, or Shannon
# Then the alpha diversity and beta diversity will be displayed simultaneously.
p2 <- mouse.time.mpse %>%
        mp_plot_ord(
          .ord = pcoa,
          .group = time,
          .color = time,
          .size = Observe,
          .alpha = Shannon,
          ellipse = TRUE,
          show.legend = FALSE # don't display the legend of stat_ellipse
        ) +
        scale_fill_manual(
          values = c("#00A087FF", "#3C5488FF"),
          guide = guide_legend(keywidth=0.6, keyheight=0.6, label.theme=element_text(size=6.5))
        ) +
        scale_color_manual(
          values=c("#00A087FF", "#3C5488FF"),
          guide = guide_legend(keywidth=0.6, keyheight=0.6, label.theme=element_text(size=6.5))
        ) +
        scale_size_continuous(
          range=c(0.5, 3),
          guide = guide_legend(keywidth=0.6, keyheight=0.6, label.theme=element_text(size=6.5))
        )
p1 + p2
```

![The PCoA result](data:image/png;base64...)

The PCoA result

### 3.5.3 Hierarchical cluster analysis

The distance of samples can also be used to perform the hierarchical cluster analysis to estimated the dissimilarities of samples. `MicrobiotaProcess` presents `mp_cal_clust` to perform this analysis. It also is implemented with the tidy-like framework.

```
mouse.time.mpse %<>%
       mp_cal_clust(
         .abundance = hellinger,
         distmethod = "bray",
         hclustmethod = "average", # (UPGAE)
         action = "add" # action is used to control which result will be returned
       )
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 25
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance,
## #   RelRareAbundanceBySample, hellinger | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance RelRareAbundanceBySam…¹ hellinger time
##    <chr>  <chr>      <int>         <int>                   <dbl>     <dbl> <chr>
##  1 OTU_1  F3D0         579           214                   8.50     0.298  Early
##  2 OTU_2  F3D0         345           116                   4.61     0.230  Early
##  3 OTU_3  F3D0         449           179                   7.11     0.262  Early
##  4 OTU_4  F3D0         430           167                   6.63     0.257  Early
##  5 OTU_5  F3D0         154            54                   2.14     0.154  Early
##  6 OTU_6  F3D0         470           174                   6.91     0.268  Early
##  7 OTU_7  F3D0         282           115                   4.57     0.208  Early
##  8 OTU_8  F3D0         184            74                   2.94     0.168  Early
##  9 OTU_9  F3D0          45            16                   0.635    0.0830 Early
## 10 OTU_10 F3D0         158            59                   2.34     0.156  Early
## # ℹ 4,132 more rows
## # ℹ abbreviated name: ¹​RelRareAbundanceBySample
## # ℹ 18 more variables: RareAbundanceRarecurve <list>, Observe <dbl>,
## #   Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>, Pielou <dbl>,
## #   bray <list>, `PCo1 (46.6%)` <dbl>, `PCo2 (13.31%)` <dbl>,
## #   `PCo3 (8.22%)` <dbl>, Kingdom <chr>, Phylum <chr>, Class <chr>,
## #   Order <chr>, Family <chr>, Genus <chr>, Species <chr>
```

```
# if action = 'add', the result of hierarchical cluster will be added to the MPSE object
# mp_extract_internal_attr can extract it. It is a treedata object, so it can be visualized
# by ggtree.
sample.clust <- mouse.time.mpse %>% mp_extract_internal_attr(name='SampleClust')
sample.clust
```

```
## 'treedata' S4 object'.
##
## ...@ phylo:
##
## Phylogenetic tree with 19 tips and 18 internal nodes.
##
## Tip labels:
##   F3D0, F3D1, F3D141, F3D142, F3D143, F3D144, ...
##
## Rooted; includes branch length(s).
##
## with the following features available:
##   '', 'time', 'RareAbundanceRarecurve', 'Observe', 'Chao1', 'ACE', 'Shannon',
## 'Simpson', 'Pielou', 'bray', 'PCo1 (46.6%)', 'PCo2 (13.31%)', 'PCo3 (8.22%)'.
##
## # The associated data tibble abstraction: 37 × 15
## # The 'node', 'label' and 'isTip' are from the phylo tree.
##     node label  isTip time  RareAbundanceRarecurve Observe Chao1   ACE Shannon
##    <int> <chr>  <lgl> <chr> <list>                   <dbl> <dbl> <dbl>   <dbl>
##  1     1 F3D0   TRUE  Early <tibble [2,520 × 4]>       104 104.  105.     3.88
##  2     2 F3D1   TRUE  Early <tibble [2,520 × 4]>        99 102   101.     3.97
##  3     3 F3D141 TRUE  Late  <tibble [2,520 × 4]>        74  74    74.2    3.41
##  4     4 F3D142 TRUE  Late  <tibble [2,520 × 4]>        48  48    48      3.12
##  5     5 F3D143 TRUE  Late  <tibble [2,520 × 4]>        56  56    56      3.29
##  6     6 F3D144 TRUE  Late  <tibble [2,520 × 4]>        47  47    47.2    2.98
##  7     7 F3D145 TRUE  Late  <tibble [2,520 × 4]>        71  73.1  74.0    3.12
##  8     8 F3D146 TRUE  Late  <tibble [2,520 × 4]>        83  84.5  83.8    3.60
##  9     9 F3D147 TRUE  Late  <tibble [2,520 × 4]>        97 107   106.     3.31
## 10    10 F3D148 TRUE  Late  <tibble [2,520 × 4]>        92  93.3  94.7    3.44
## # ℹ 27 more rows
## # ℹ 6 more variables: Simpson <dbl>, Pielou <dbl>, bray <list>,
## #   `PCo1 (46.6%)` <dbl>, `PCo2 (13.31%)` <dbl>, `PCo3 (8.22%)` <dbl>
```

```
library(ggtree)
p <- ggtree(sample.clust) +
       geom_tippoint(aes(color=time)) +
       geom_tiplab(as_ylab = TRUE) +
       ggplot2::scale_x_continuous(expand=c(0, 0.01))
p
```

![The hierarchical cluster result of samples](data:image/png;base64...)

The hierarchical cluster result of samples

Since the result of hierarchical cluster is treedata object, so it is very easy to display the result with associated data. For example, we can display the result of hierarchical cluster and the abundance of specific taxonomy level to check whether some biological pattern can be found.

```
library(ggtreeExtra)
library(ggplot2)
phyla.tb <- mouse.time.mpse %>%
            mp_extract_abundance(taxa.class=Phylum, topn=30)
# The abundance of each samples is nested, it can be flatted using the unnest of tidyr.
phyla.tb %<>% tidyr::unnest(cols=RareAbundanceBySample) %>% dplyr::rename(Phyla="label")
phyla.tb
```

```
## # A tibble: 171 × 7
##    Phyla             nodeClass Sample RareAbundance RelRareAbundanceBySa…¹ time
##    <fct>             <chr>     <chr>          <int>                  <dbl> <chr>
##  1 p__Actinobacteria Phylum    F3D0              15                  0.596 Early
##  2 p__Actinobacteria Phylum    F3D1               0                  0     Early
##  3 p__Actinobacteria Phylum    F3D141            11                  0.437 Late
##  4 p__Actinobacteria Phylum    F3D142            28                  1.11  Late
##  5 p__Actinobacteria Phylum    F3D143            10                  0.397 Late
##  6 p__Actinobacteria Phylum    F3D144            18                  0.715 Late
##  7 p__Actinobacteria Phylum    F3D145             6                  0.238 Late
##  8 p__Actinobacteria Phylum    F3D146             4                  0.159 Late
##  9 p__Actinobacteria Phylum    F3D147            15                  0.596 Late
## 10 p__Actinobacteria Phylum    F3D148            19                  0.755 Late
## # ℹ 161 more rows
## # ℹ abbreviated name: ¹​RelRareAbundanceBySample
## # ℹ 1 more variable: RareAbundanceBytime <list>
```

```
p1 <- p +
      geom_fruit(
         data=phyla.tb,
         geom=geom_col,
         mapping = aes(x = RelRareAbundanceBySample,
                       y = Sample,
                       fill = Phyla
                 ),
         orientation = "y",
         #offset = 0.4,
         pwidth = 3,
         axis.params = list(axis = "x",
                            title = "The relative abundance of phyla (%)",
                            title.size = 4,
                            text.size = 2,
                            vjust = 1),
         grid.params = list()
      )
p1
```

![The hierarchical cluster result of samples and the abundance of Phylum](data:image/png;base64...)

The hierarchical cluster result of samples and the abundance of Phylum

## 3.6 Biomarker discovery

The `MicrobiotaProcess` presents `mp_diff_analysis` for the biomarker discovery based on tidy-like framework. The rule of `mp_diff_analysis` is similar with the `LEfSe`(Nicola Segata and Huttenhower 2011). First, all features are tested whether values in different classes are differentially distributed. Second, the significantly different features are tested whether all pairwise comparisons between subclass in different classes distinctly consistent with the class trend. Finally, the significantly discriminative features are assessed by `LDA` (`linear discriminant analysis`) or `rf`(`randomForest`). However, `mp_diff_analysis` is more flexible. The test method of two step can be set by user, and we used the general fold change(Wirbel et al. 2019) and `wilcox.test`(default) to test whether all pairwise comparisons between subclass in different classes distinctly consistent with the class trend. And the result is stored to the treedata object, which can be processed and displayed via `treeio`(Wang et al. 2020), `tidytree`(Yu 2021), `ggtree`(Yu et al. 2017) and `ggtreeExtra`(Xu et al. 2021).

```
library(ggtree)
library(ggtreeExtra)
library(ggplot2)
library(MicrobiotaProcess)
library(tidytree)
library(ggstar)
library(forcats)
mouse.time.mpse %>% print(width=150)
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 25
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance,
## #   RelRareAbundanceBySample, hellinger | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance RelRareAbundanceBySam…¹ hellinger time
##    <chr>  <chr>      <int>         <int>                   <dbl>     <dbl> <chr>
##  1 OTU_1  F3D0         579           214                   8.50     0.298  Early
##  2 OTU_2  F3D0         345           116                   4.61     0.230  Early
##  3 OTU_3  F3D0         449           179                   7.11     0.262  Early
##  4 OTU_4  F3D0         430           167                   6.63     0.257  Early
##  5 OTU_5  F3D0         154            54                   2.14     0.154  Early
##  6 OTU_6  F3D0         470           174                   6.91     0.268  Early
##  7 OTU_7  F3D0         282           115                   4.57     0.208  Early
##  8 OTU_8  F3D0         184            74                   2.94     0.168  Early
##  9 OTU_9  F3D0          45            16                   0.635    0.0830 Early
## 10 OTU_10 F3D0         158            59                   2.34     0.156  Early
##    RareAbundanceRarecurve Observe Chao1   ACE Shannon Simpson Pielou bray
##    <list>                   <dbl> <dbl> <dbl>   <dbl>   <dbl>  <dbl> <list>
##  1 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  2 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  3 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  4 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  5 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  6 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  7 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  8 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
##  9 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
## 10 <tibble [2,520 × 4]>       104  104.  105.    3.88   0.965  0.835 <tibble>
## # ℹ 4,132 more rows
## # ℹ abbreviated name: ¹​RelRareAbundanceBySample
## # ℹ 10 more variables: `PCo1 (46.6%)` <dbl>, `PCo2 (13.31%)` <dbl>, `PCo3 (8.22%)` <dbl>, Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>,
## #   Family <chr>, Genus <chr>, Species <chr>
```

```
mouse.time.mpse %<>%
    mp_diff_analysis(
       .abundance = RelRareAbundanceBySample,
       .group = time,
       first.test.alpha = 0.01
    )
# The result is stored to the taxatree or otutree slot, you can use mp_extract_tree to extract the specific slot.
taxa.tree <- mouse.time.mpse %>%
               mp_extract_tree(type="taxatree")
taxa.tree
```

```
## 'treedata' S4 object'.
##
## ...@ phylo:
##
## Phylogenetic tree with 218 tips and 186 internal nodes.
##
## Tip labels:
##   OTU_67, OTU_231, OTU_188, OTU_150, OTU_207, OTU_5, ...
## Node labels:
##   r__root, k__Bacteria, p__Actinobacteria, p__Bacteroidetes, p__Cyanobacteria,
## p__Deinococcus-Thermus, ...
##
## Rooted; no branch length.
##
## with the following features available:
##   'nodeClass', 'nodeDepth', 'RareAbundanceBySample', 'RareAbundanceBytime',
## 'LDAupper', 'LDAmean', 'LDAlower', 'Sign_time', 'pvalue', 'fdr'.
##
## # The associated data tibble abstraction: 404 × 13
## # The 'node', 'label' and 'isTip' are from the phylo tree.
##     node label   isTip nodeClass nodeDepth RareAbundanceBySample
##    <int> <chr>   <lgl> <chr>         <dbl> <list>
##  1     1 OTU_67  TRUE  OTU               8 <tibble [19 × 4]>
##  2     2 OTU_231 TRUE  OTU               8 <tibble [19 × 4]>
##  3     3 OTU_188 TRUE  OTU               8 <tibble [19 × 4]>
##  4     4 OTU_150 TRUE  OTU               8 <tibble [19 × 4]>
##  5     5 OTU_207 TRUE  OTU               8 <tibble [19 × 4]>
##  6     6 OTU_5   TRUE  OTU               8 <tibble [19 × 4]>
##  7     7 OTU_1   TRUE  OTU               8 <tibble [19 × 4]>
##  8     8 OTU_2   TRUE  OTU               8 <tibble [19 × 4]>
##  9     9 OTU_3   TRUE  OTU               8 <tibble [19 × 4]>
## 10    10 OTU_4   TRUE  OTU               8 <tibble [19 × 4]>
## # ℹ 394 more rows
## # ℹ 7 more variables: RareAbundanceBytime <list>, LDAupper <dbl>,
## #   LDAmean <dbl>, LDAlower <dbl>, Sign_time <chr>, pvalue <dbl>, fdr <dbl>
```

```
# And the result tibble of different analysis can also be extracted
# with tidytree (>=0.3.5)
taxa.tree %>% select(label, nodeClass, LDAupper, LDAmean, LDAlower, Sign_time, pvalue, fdr) %>% dplyr::filter(!is.na(fdr))
```

```
## # A tibble: 399 × 8
##    label   nodeClass LDAupper LDAmean LDAlower Sign_time   pvalue     fdr
##    <chr>   <chr>        <dbl>   <dbl>    <dbl> <chr>        <dbl>   <dbl>
##  1 OTU_67  OTU          NA      NA       NA    <NA>      0.00335  0.0194
##  2 OTU_231 OTU          NA      NA       NA    <NA>      0.343    0.408
##  3 OTU_188 OTU          NA      NA       NA    <NA>      0.563    0.634
##  4 OTU_150 OTU          NA      NA       NA    <NA>      0.235    0.355
##  5 OTU_207 OTU          NA      NA       NA    <NA>      0.878    0.894
##  6 OTU_5   OTU          NA      NA       NA    <NA>      0.568    0.634
##  7 OTU_1   OTU          NA      NA       NA    <NA>      0.744    0.773
##  8 OTU_2   OTU          NA      NA       NA    <NA>      0.437    0.515
##  9 OTU_3   OTU          NA      NA       NA    <NA>      0.437    0.515
## 10 OTU_4   OTU           4.41    4.38     4.36 Late      0.000444 0.00732
## # ℹ 389 more rows
```

```
# Since taxa.tree is treedata object, it can be visualized by ggtree and ggtreeExtra
p1 <- ggtree(
        taxa.tree,
        layout="radial",
        size = 0.3
      ) +
      geom_point(
        data = td_filter(!isTip),
        fill="white",
        size=1,
        shape=21
      )
# display the high light of phylum clade.
p2 <- p1 +
      geom_hilight(
        data = td_filter(nodeClass == "Phylum"),
        mapping = aes(node = node, fill = label)
      )
# display the relative abundance of features(OTU)
p3 <- p2 +
      ggnewscale::new_scale("fill") +
      geom_fruit(
         data = td_unnest(RareAbundanceBySample),
         geom = geom_star,
         mapping = aes(
                       x = fct_reorder(Sample, time, .fun=min),
                       size = RelRareAbundanceBySample,
                       fill = time,
                       subset = RelRareAbundanceBySample > 0
                   ),
         starshape = 13,
         starstroke = 0.25,
         offset = 0.04,
         pwidth = 0.8,
         grid.params = list(linetype=2)
      ) +
      scale_size_continuous(
         name="Relative Abundance (%)",
         range = c(.5, 3)
      ) +
      scale_fill_manual(values=c("#1B9E77", "#D95F02"))
# display the tip labels of taxa tree
p4 <- p3 + geom_tiplab(size=2, offset=7.2)
# display the LDA of significant OTU.
p5 <- p4 +
      ggnewscale::new_scale("fill") +
      geom_fruit(
         geom = geom_col,
         mapping = aes(
                       x = LDAmean,
                       fill = Sign_time,
                       subset = !is.na(LDAmean)
                       ),
         orientation = "y",
         offset = 0.3,
         pwidth = 0.5,
         axis.params = list(axis = "x",
                            title = "Log10(LDA)",
                            title.height = 0.01,
                            title.size = 2,
                            text.size = 1.8,
                            vjust = 1),
         grid.params = list(linetype = 2)
      )

# display the significant (FDR) taxonomy after kruskal.test (default)
p6 <- p5 +
      ggnewscale::new_scale("size") +
      geom_point(
         data=td_filter(!is.na(Sign_time)),
         mapping = aes(size = -log10(fdr),
                       fill = Sign_time,
                       ),
         shape = 21,
      ) +
      scale_size_continuous(range=c(1, 3)) +
      scale_fill_manual(values=c("#1B9E77", "#D95F02"))

p6 + theme(
           legend.key.height = unit(0.3, "cm"),
           legend.key.width = unit(0.3, "cm"),
           legend.spacing.y = unit(0.02, "cm"),
           legend.text = element_text(size = 7),
           legend.title = element_text(size = 9),
          )
```

![The different species and the abundance of sample](data:image/png;base64...)

The different species and the abundance of sample

The visualization methods of result can be various, you can refer to the article or book of `ggtree`(Yu et al. 2017, 2018) and the article of `ggtreeExtra`(Xu et al. 2021). In addition, we also developed `mp_plot_diff_res` to display the result of `mp_diff_analysis`, it can decreases coding burden.

```
# this object has contained the result of mp_diff_analysis
mouse.time.mpse
```

```
## # A MPSE-tibble (MPSE object) abstraction: 4,142 × 31
## # OTU=218 | Samples=19 | Assays=Abundance, RareAbundance,
## #   RelRareAbundanceBySample, hellinger | Taxonomy=Kingdom, Phylum, Class,
## #   Order, Family, Genus, Species
##    OTU    Sample Abundance RareAbundance RelRareAbundanceBySam…¹ hellinger time
##    <chr>  <chr>      <int>         <int>                   <dbl>     <dbl> <chr>
##  1 OTU_1  F3D0         579           214                   8.50     0.298  Early
##  2 OTU_2  F3D0         345           116                   4.61     0.230  Early
##  3 OTU_3  F3D0         449           179                   7.11     0.262  Early
##  4 OTU_4  F3D0         430           167                   6.63     0.257  Early
##  5 OTU_5  F3D0         154            54                   2.14     0.154  Early
##  6 OTU_6  F3D0         470           174                   6.91     0.268  Early
##  7 OTU_7  F3D0         282           115                   4.57     0.208  Early
##  8 OTU_8  F3D0         184            74                   2.94     0.168  Early
##  9 OTU_9  F3D0          45            16                   0.635    0.0830 Early
## 10 OTU_10 F3D0         158            59                   2.34     0.156  Early
## # ℹ 4,132 more rows
## # ℹ abbreviated name: ¹​RelRareAbundanceBySample
## # ℹ 24 more variables: RareAbundanceRarecurve <list>, Observe <dbl>,
## #   Chao1 <dbl>, ACE <dbl>, Shannon <dbl>, Simpson <dbl>, Pielou <dbl>,
## #   bray <list>, `PCo1 (46.6%)` <dbl>, `PCo2 (13.31%)` <dbl>,
## #   `PCo3 (8.22%)` <dbl>, Kingdom <chr>, Phylum <chr>, Class <chr>,
## #   Order <chr>, Family <chr>, Genus <chr>, Species <chr>, LDAupper <dbl>, …
```

```
# Because the released `ggnewscale` modified the internal new aesthetics name,
# The following code is to obtain the new aesthetics name according to version of
# `ggnewscale`
flag <- packageVersion("ggnewscale") >= "0.5.0"
new.fill <- ifelse(flag, "fill_ggnewscale_1", "fill_new_new")
new.fill2 <- ifelse(flag , "fill_ggnewscale_2", "fill_new")

p <- mouse.time.mpse %>%
       mp_plot_diff_res(
         group.abun = TRUE,
         pwidth.abun=0.1
       )
# if version of `ggnewscale` is >= 0.5.0, you can also use p$ggnewscale to view the renamed scales.
p <- p  +
       scale_fill_manual(values=c("deepskyblue", "orange")) +
       scale_fill_manual(
         aesthetics = new.fill2, # The fill aes was renamed to `new.fill` for the abundance dotplot layer
         values = c("deepskyblue", "orange")
       ) +
       scale_fill_manual(
         aesthetics = new.fill, # The fill aes for hight light layer of tree was renamed to `new.fill2`
         values = c("#E41A1C", "#377EB8", "#4DAF4A",
                    "#984EA3", "#FF7F00", "#FFFF33",
                     "#A65628", "#F781BF", "#999999"
                   )
       )
p
```

![The different species and the abundance of group](data:image/png;base64...)

The different species and the abundance of group

We also developed `mp_plot_diff_cladogram` to visualize the result.

```
f <- mouse.time.mpse %>%
     mp_plot_diff_cladogram(
       label.size = 2.5,
       hilight.alpha = .3,
       bg.tree.size = .5,
       bg.point.size = 2,
       bg.point.stroke = .25
     ) +
     scale_fill_diff_cladogram( # set the color of different group.
       values = c('deepskyblue', 'orange')
     ) +
     scale_size_continuous(range = c(1, 4))
f
```

![The cladogram of differential species ](data:image/png;base64...)

The cladogram of differential species

The result also can be visualized with `mp_plot_diff_boxplot`.

```
f.box <- mouse.time.mpse %>%
         mp_plot_diff_boxplot(
           .group = time,
         ) %>%
         set_diff_boxplot_color(
           values = c("deepskyblue", "orange"),
           guide = guide_legend(title=NULL)
         )

f.bar <- mouse.time.mpse %>%
         mp_plot_diff_boxplot(
           taxa.class = c(Genus, OTU), # select the taxonomy level to display
           group.abun = TRUE, # display the mean abundance of each group
           removeUnknown = TRUE, # whether mask the unknown taxa.
         ) %>%
         set_diff_boxplot_color(
           values = c("deepskyblue", "orange"),
           guide = guide_legend(title=NULL)
         )

aplot::plot_list(f.box, f.bar)
```

![The abundance and LDA effect size of differential taxa](data:image/png;base64...)

The abundance and LDA effect size of differential taxa

Or visualizing the results with `mp_plot_diff_manhattan`

```
f.mahattan <- mouse.time.mpse %>%
    mp_plot_diff_manhattan(
       .group = Sign_time,
       .y = fdr,
       .size = 2.4,
       taxa.class = c('OTU', 'Genus'),
       anno.taxa.class = Phylum
    )
f.mahattan
```

![The mahattan plot of differential taxa](data:image/png;base64...)

The mahattan plot of differential taxa

# 4. Need helps?

If you have questions/issues, please visit [github issue tracker](https://github.com/YuLab-SMU/MicrobiotaProcess/issues).

# 5. Session information

Here is the output of sessionInfo() on the system on which this document was compiled:

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] forcats_1.0.1            ggstar_1.0.6             MicrobiotaProcess_1.22.0
##  [4] tidytree_0.4.6           treeio_1.34.0            ggtreeExtra_1.20.0
##  [7] ggtree_4.0.1             shadowtext_0.1.6         phyloseq_1.54.0
## [10] ggplot2_4.0.0            knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] gridExtra_2.3               sandwich_3.1-1
##   [3] permute_0.9-8               rlang_1.1.6
##   [5] magrittr_2.0.4              multcomp_1.4-29
##   [7] ade4_1.7-23                 matrixStats_1.5.0
##   [9] compiler_4.5.1              mgcv_1.9-3
##  [11] ggalluvial_0.12.5           png_0.1-8
##  [13] systemfonts_1.3.1           vctrs_0.6.5
##  [15] reshape2_1.4.4              stringr_1.5.2
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               magick_2.9.0
##  [21] XVector_0.50.0              labeling_0.4.3
##  [23] utf8_1.2.6                  rmarkdown_2.30
##  [25] tinytex_0.57                purrr_1.1.0
##  [27] modeltools_0.2-24           xfun_0.54
##  [29] cachem_1.1.0                aplot_0.2.9
##  [31] jsonlite_2.0.0              biomformat_1.38.0
##  [33] rhdf5filters_1.22.0         DelayedArray_0.36.0
##  [35] Rhdf5lib_1.32.0             parallel_4.5.1
##  [37] cluster_2.1.8.1             R6_2.6.1
##  [39] coin_1.4-3                  bslib_0.9.0
##  [41] stringi_1.8.7               RColorBrewer_1.1-3
##  [43] GenomicRanges_1.62.0        jquerylib_0.1.4
##  [45] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [47] SummarizedExperiment_1.40.0 iterators_1.0.14
##  [49] zoo_1.8-14                  IRanges_2.44.0
##  [51] Matrix_1.7-4                splines_4.5.1
##  [53] igraph_2.2.1                tidyselect_1.2.1
##  [55] dichromat_2.0-0.1           abind_1.4-8
##  [57] yaml_2.3.10                 vegan_2.7-2
##  [59] codetools_0.2-20            lattice_0.22-7
##  [61] tibble_3.3.0                plyr_1.8.9
##  [63] Biobase_2.70.0              withr_3.0.2
##  [65] S7_0.2.0                    evaluate_1.0.5
##  [67] gridGraphics_0.5-1          survival_3.8-3
##  [69] Biostrings_2.78.0           pillar_1.11.1
##  [71] MatrixGenerics_1.22.0       foreach_1.5.2
##  [73] stats4_4.5.1                ggfun_0.2.0
##  [75] generics_0.1.4              dtplyr_1.3.2
##  [77] S4Vectors_0.48.0            scales_1.4.0
##  [79] glue_1.8.0                  gdtools_0.4.4
##  [81] lazyeval_0.2.2              tools_4.5.1
##  [83] ggnewscale_0.5.2            data.table_1.17.8
##  [85] ggsignif_0.6.4              ggside_0.4.0
##  [87] ggiraph_0.9.2               mvtnorm_1.3-3
##  [89] fs_1.6.6                    rhdf5_2.54.0
##  [91] grid_4.5.1                  tidyr_1.3.1
##  [93] ape_5.8-1                   libcoin_1.0-10
##  [95] nlme_3.1-168                patchwork_1.3.2
##  [97] cli_3.6.5                   rappdirs_0.3.3
##  [99] fontBitstreamVera_0.1.1     viridisLite_0.4.2
## [101] S4Arrays_1.10.0             dplyr_1.1.4
## [103] ggh4x_0.3.1                 gtable_0.3.6
## [105] yulab.utils_0.2.1           sass_0.4.10
## [107] digest_0.6.37               fontquiver_0.2.1
## [109] BiocGenerics_0.56.0         ggrepel_0.9.6
## [111] TH.data_1.1-4               SparseArray_1.10.0
## [113] ggplotify_0.1.3             htmlwidgets_1.6.4
## [115] farver_2.1.2                htmltools_0.5.8.1
## [117] multtest_2.66.0             lifecycle_1.0.4
## [119] prettydoc_0.4.1             fontLiberation_0.1.0
## [121] MASS_7.3-65
```

# 6. References

Beghini, Francesco, Lauren J McIver, Aitor Blanco-Mı́guez, Leonard Dubois, Francesco Asnicar, Sagun Maharjan, Ana Mailyan, et al. 2021. “Integrating Taxonomic, Functional, and Strain-Level Profiling of Diverse Microbial Communities with bioBakery 3.” *Elife* 10: e65088.

Bolyen, Evan, Jai Ram Rideout, Matthew R Dillon, Nicholas A Bokulich, Christian C Abnet, Gabriel A Al-Ghalith, Harriet Alexander, et al. 2019. “Reproducible, Interactive, Scalable and Extensible Microbiome Data Science Using Qiime 2.” *Nature Biotechnology* 37 (8): 852–57.

Callahan, Benjamin J, Paul J McMurdie, Michael J Rosen, Andrew W Han, Amy Jo A Johnson, and Susan P Holmes. 2016. “DADA2: High-Resolution Sample Inference from Illumina Amplicon Data.” *Nature Methods* 13 (7): 581–83.

Huang, Ruizhu, Charlotte Soneson, Felix G. M. Ernst, Kevin C. Rue-Albrecht, Guangchuang Yu, Stephanie C. Hicks, and Mark D. Robinson. 2021. “TreeSummarizedExperiment: A S4 Class for Data with Hierarchical Structure.” *F1000Research* 9: 1246. <https://f1000research.com/articles/9-1246>.

McMurdie, Paul J., and Susan Holmes. 2013. “Phyloseq: An R Package for Reproducible Interactive Analysis and Graphics of Microbiome Census Data.” *PLoS ONE* 8 (4): e61217. <https://doi.org/10.1371/journal.pone.0061217>.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2021. *SummarizedExperiment: SummarizedExperiment Container*. <https://bioconductor.org/packages/SummarizedExperiment>.

Nicola Segata, Levi Waldron, Jacques Izard, and Curtis Huttenhower. 2011. “Metagenomic Biomarker Discovery and Explanation.” *Genome Biology* 12 (6): R60. <https://doi.org/10.1186/gb-2011-12-6-r60>.

Oksanen, Jari, F. Guillaume Blanchet, Michael Friendly, Roeland Kindt, Pierre Legendre, Dan McGlinn, Peter R. Minchin, et al. 2019. “Vegan: Community Ecology Package.” [https://CRAN.R-project.org/package=vegan](https://CRAN.R-project.org/package%3Dvegan).

Pagès, H., P. Aboyoun, R. Gentleman, and S. DebRoy. 2021. *Biostrings: Efficient Manipulation of Biological Strings*. <https://bioconductor.org/packages/Biostrings>.

Siegel, Andrew F. 2004. “Rarefaction Curves.” *Encyclopedia of Statistical Sciences* 10. <https://doi.org/10.1002/0471667196.ess2195.pub2>.

Wang, Li-Gen, Tommy Tsan-Yuk Lam, Shuangbin Xu, Zehan Dai, Lang Zhou, Tingze Feng, Pingfan Guo, et al. 2020. “Treeio: An R Package for Phylogenetic Tree Input and Output with Richly Annotated and Associated Data.” *Molecular Biology and Evolution* 37 (2): 599–603. <https://doi.org/10.1093/molbev/msz240>.

Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D’Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019. “Welcome to the tidyverse.” *Journal of Open Source Software* 4 (43): 1686. <https://doi.org/10.21105/joss.01686>.

Wirbel, Jakob, Paul Theodor Pyl, Ece Kartal, Konrad Zych, Alireza Kashani, Alessio Milanese, Jonas S Fleck, et al. 2019. “Meta-Analysis of Fecal Metagenomes Reveals Global Microbial Signatures That Are Specific for Colorectal Cancer.” *Nature Medicine* 25 (4): 679. <https://doi.org/10.1038/s41591-019-0406-6>.

Xu, Shuangbin, Zehan Dai, Pingfan Guo, Xiaocong Fu, Shanshan Liu, Lang Zhou, Wenli Tang, et al. 2021. “GgtreeExtra: Compact Visualization of Richly Annotated Phylogenetic Data.” *Molecular Biology and Evolution* 38 (9): 4039–42. <https://doi.org/10.1093/molbev/msab166>.

Yu, Guangchuang. 2021. *Tidytree: A Tidy Tool for Phylogenetic Tree Data Manipulation*. <https://yulab-smu.top/treedata-book/>.

Yu, Guangchuang, Tommy Tsan-Yuk Lam, Huachen Zhu, and Yi Guan. 2018. “Two Methods for Mapping and Visualizing Associated Data on Phylogeny Using Ggtree.” *Molecular Biology and Evolution* 35 (2): 3041–3. <https://doi.org/10.1093/molbev/msy194>.

Yu, Guangchuang, David Smith, Huachen Zhu, Yi Guan, and Tommy Tsan-Yuk Lam. 2017. “Ggtree: An R Package for Visualization and Annotation of Phylogenetic Trees with Their Covariates and Other Associated Data.” *Methods in Ecology and Evolution* 8 (1): 28–36. <https://doi.org/10.1111/2041-210X.12628>.