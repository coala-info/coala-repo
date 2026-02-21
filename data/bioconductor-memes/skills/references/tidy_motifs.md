# Tidying Motif Metadata

memes uses the `universalmotif` package to simplify working with motif metadata. `universalmotif` objects can be represented in an alternative form, the `unviversalmotif_df` which allows users to manipulate motif metadata just as they would a normal R data.frame (in fact, they are just R data.frames).

These objects are useful for tidying motif metadata to prepare a motif database for use with memes, or performing any other data-driven tasks involving motifs. Here I describe one way these data structures can be used to construct a motif database for use with memes.

```
library(memes)
library(magrittr)
library(universalmotif)
```

The `MotifDb` package makes it easy to query thousands of motifs from public databases. Here, I will describe how to use one of these queries as input to memes functions, and how to manipulate the resulting motifs to prepare them for MEME suite tools.

I will use the motifs from the [FlyFactorSurvey](https://mccb.umassmed.edu/ffs/) as an example. They can be accessed from `MotifDb` using the following query.

```
flyFactorDb <- MotifDb::MotifDb %>%
  MotifDb::query("FlyFactorSurvey")
#> See system.file("LICENSE", package="MotifDb") for use restrictions.
```

Use `universalmotif::convert_motifs()` to convert a `MotifDb` query into motif objects. In many cases, the resulting list can be used directly as input to memes functions, like `runTomTom`, or `runAme`.

```
flyFactorMotifs <- flyFactorDb %>%
  convert_motifs()
```

But there are some issues with this database. For example, the following motif name is the FlyBase gene number, and the alternate name is the actual informative name of the PWM. The MEME Suite relies more heavily on the primary name, so it would be nice if the database used interpretable names.

```
flyFactorMotifs %>%
  head(1)
#> [[1]]
#>
#>        Motif name:   FBgn0259750
#>    Alternate name:   ab_SANGER_10_FBgn0259750
#>          Organism:   Dmelanogaster
#>          Alphabet:   DNA
#>              Type:   PPM
#>           Strands:   +-
#>          Total IC:   15.01
#>       Pseudocount:   1
#>         Consensus:   BWNRCCAGGWMCNNTNNNGNN
#>      Target sites:   20
#>        Extra info:   [dataSource] FlyFactorSurvey
#>
#>     B    W    N    R C C A G G    W    M    C    N    N    T    N    N    N
#> A 0.0 0.50 0.20 0.35 0 0 1 0 0 0.55 0.35 0.05 0.20 0.45 0.20 0.10 0.40 0.40
#> C 0.3 0.15 0.25 0.00 1 1 0 0 0 0.10 0.65 0.70 0.45 0.25 0.10 0.25 0.25 0.10
#> G 0.4 0.05 0.50 0.65 0 0 0 1 1 0.00 0.00 0.05 0.05 0.15 0.05 0.20 0.05 0.15
#> T 0.3 0.30 0.05 0.00 0 0 0 0 0 0.35 0.00 0.20 0.30 0.15 0.65 0.45 0.30 0.35
#>      G    N    N
#> A 0.25 0.50 0.30
#> C 0.10 0.25 0.25
#> G 0.55 0.15 0.45
#> T 0.10 0.10 0.00
```

The universalmotif function `to_df()` converts universalmotif lists into `universalmotif_df` format which can be used to update motif entries. This is particularly useful when dealing with several motifs at once.

```
flyFactor_data <- flyFactorMotifs %>%
  to_df()
```

The columns of the `universalmotif_df` can be freely changed to edit the properties of the motifs stored in the `motif` column. Just like standard data.frames, additional columns can be added to store additional metadata. For more details on these objects see the help page: `?universalmotif::to_df`.

```
# The following columns can be changed to update motif metadata
flyFactor_data %>%
  names
#>  [1] "motif"       "name"        "altname"     "family"      "organism"
#>  [6] "consensus"   "alphabet"    "strand"      "icscore"     "nsites"
#> [11] "bkgsites"    "pval"        "qval"        "eval"        "type"
#> [16] "pseudocount" "bkg"         "dataSource"
```

using the `universalmotif_df`, we can quickly see that the issue with FBgn numbers only applies to certain entries. And TFs which are represented by multiple motifs in the database are assigned the same name. The MEME Suite tools which use a motif database (like TomTom and AME) require that the entries have unique primary identifiers, therefore the default names will not be appropriate.

```
flyFactor_data %>%
  head(5)
#>          motif        name                  altname      organism
#> 1 <mot:FBgn..> FBgn0259750 ab_SANGER_10_FBgn0259750 Dmelanogaster
#> 2 <mot:FBgn..> FBgn0259750  ab_SOLEXA_5_FBgn0259750 Dmelanogaster
#> 3  <mot:abd-A>       abd-A Abd-A_FlyReg_FBgn0000014 Dmelanogaster
#> 4  <mot:Abd-B>       Abd-B Abd-B_FlyReg_FBgn0000015 Dmelanogaster
#> 5  <mot:abd-A>       abd-A    AbdA_Cell_FBgn0000014 Dmelanogaster
#>                    consensus alphabet strand   icscore nsites type pseudocount
#> 1      BWNRCCAGGWMCNNTNNNGNN      DNA     +- 15.013759     20  PPM           1
#> 2 NNNNHNRCCAGGWMCYNNNNNNNNNN      DNA     +- 14.570384    446  PPM           1
#> 3                   KNMATWAW      DNA     +-  7.371641     37  PPM           1
#> 4                   YCATAAAA      DNA     +-  7.831193      7  PPM           1
#> 5                    TTAATKA      DNA     +-  8.976569     18  PPM           1
#>            bkg      dataSource
#> 1 0.25, 0..... FlyFactorSurvey
#> 2 0.25, 0..... FlyFactorSurvey
#> 3 0.25, 0..... FlyFactorSurvey
#> 4 0.25, 0..... FlyFactorSurvey
#> 5 0.25, 0..... FlyFactorSurvey
#>
#> [Hidden empty columns: family, bkgsites, pval, qval, eval.]
```

However, the `altname` slots from the `motifDb` query are already unique, so we can make them the primary name.

```
length(flyFactor_data$altname) == length(unique(flyFactor_data$altname))
#> [1] TRUE
```

An easy way is to use `dplyr::rename` to swap the columns.

```
flyFactor_data %<>%
  dplyr::rename("altname" = "name",
                "name" = "altname")
```

The `name` column now contains the full motif name.

```
flyFactor_data %>%
  head(3)
#>            motif     altname                     name      organism
#> 1 * <mot:FBgn..> FBgn0259750 ab_SANGER_10_FBgn0259750 Dmelanogaster
#> 2 * <mot:FBgn..> FBgn0259750  ab_SOLEXA_5_FBgn0259750 Dmelanogaster
#> 3 *  <mot:abd-A>       abd-A Abd-A_FlyReg_FBgn0000014 Dmelanogaster
#>                    consensus alphabet strand   icscore nsites type pseudocount
#> 1      BWNRCCAGGWMCNNTNNNGNN      DNA     +- 15.013759     20  PPM           1
#> 2 NNNNHNRCCAGGWMCYNNNNNNNNNN      DNA     +- 14.570384    446  PPM           1
#> 3                   KNMATWAW      DNA     +-  7.371641     37  PPM           1
#>            bkg      dataSource
#> 1 0.25, 0..... FlyFactorSurvey
#> 2 0.25, 0..... FlyFactorSurvey
#> 3 0.25, 0..... FlyFactorSurvey
#>
#> [Hidden empty columns: family, bkgsites, pval, qval, eval.]
#> [Rows marked with * are changed. Run update_motifs() or to_list() to apply
#>   changes.]
```

Next to solve the issue with the FBgn’s. FBgn numbers are unique identifiers for a gene within a given FlyBase reference assembly. However, FBgn numbers are not stable over time (i.e. the same gene may have a different FBgn number between reference assemblies), therefore they are unreliable values to determine the correct gene symbol. [FlyBase.org](https://flybase.org) has a nice [conversion tool](https://flybase.org/convert/id) which can be used to update FBgn numbers.

As of this writing in March 2021, the FBgn entries provided by the Fly Factor Survey database are out of date. In order to demonstrate an example of methods for tidying motif metadata, I won’t use the FlyBase conversion tool, but will instead highlight some approaches which may be more generally useful when working with motif databases from disparate sources.

For this example, we will try to grab the correct gene name from the motif name, which is stored in the first field of the name, formatted as follows: “”.

We use `tidyr::separate` to split out the first entry to the `tifd` column, then only use this value if the altname contains an FBgn.

```
flyFactor_data %<>%
  # Critical to set remove = FALSE to keep the `name` column
  tidyr::separate(name, c("tfid"), remove = FALSE, extra = "drop") %>%
  # Only use the tfid if the altname contains an FBgn
  dplyr::mutate(altname = ifelse(grepl("^FBgn", altname), tfid, altname))
```

Now, the first two entries are listed as “ab” instead of “FBgn0259750”.

```
flyFactor_data %>%
  head(3)
#>          motif altname                     name tfid family      organism
#> 1 <mot:FBgn..>      ab ab_SANGER_10_FBgn0259750   ab   <NA> Dmelanogaster
#> 2 <mot:FBgn..>      ab  ab_SOLEXA_5_FBgn0259750   ab   <NA> Dmelanogaster
#> 3  <mot:abd-A>   abd-A Abd-A_FlyReg_FBgn0000014  Abd   <NA> Dmelanogaster
#>                    consensus alphabet strand   icscore nsites bkgsites pval
#> 1      BWNRCCAGGWMCNNTNNNGNN      DNA     +- 15.013759     20       NA   NA
#> 2 NNNNHNRCCAGGWMCYNNNNNNNNNN      DNA     +- 14.570384    446       NA   NA
#> 3                   KNMATWAW      DNA     +-  7.371641     37       NA   NA
#>   qval eval type pseudocount          bkg      dataSource
#> 1   NA   NA  PPM           1 0.25, 0..... FlyFactorSurvey
#> 2   NA   NA  PPM           1 0.25, 0..... FlyFactorSurvey
#> 3   NA   NA  PPM           1 0.25, 0..... FlyFactorSurvey
```

Next, because the FBgn’s are out of date, we will remove them from the “names” to shorten up the motif names. This also makes the motif name more comparable to the original motif names from the [FlyFactor Survey](https://mccb.umassmed.edu/ffs/).

```
flyFactor_data %<>%
  dplyr::mutate(name = gsub("_FBgn\\d+", "", name))
```

## A few reality checks

It’s worth taking a look at the instances where the `altname` and our parsed `tfid` do not match. This is a good way to ensure we haven’t missed any important edge cases in the data. As new edge cases are encountered, we can develop new rules for tidying the data to ensure a high quality set of motifs.

Start by simply filtering for all instance where there is a mismatch between `altname` and `tfid`.

Carefully compare the `altname`, `name`, and `tfid` columns. Why might the values differ? Are there instances that make you question the data?

```
flyFactor_data %>%
  dplyr::filter(altname != tfid) %>%
  # I'm only showing the first 5 rows for brevity, but take a look at the full
  # data and see what patterns you notice
  head(5)
#>         motif altname         name tfid family      organism consensus alphabet
#> 1 <mot:abd-A>   abd-A Abd-A_FlyReg  Abd   <NA> Dmelanogaster  KNMATWAW      DNA
#> 2 <mot:Abd-B>   Abd-B Abd-B_FlyReg  Abd   <NA> Dmelanogaster  YCATAAAA      DNA
#> 3 <mot:abd-A>   abd-A    AbdA_Cell AbdA   <NA> Dmelanogaster   TTAATKA      DNA
#> 4 <mot:abd-A>   abd-A  AbdA_SOLEXA AbdA   <NA> Dmelanogaster  NTTAATKR      DNA
#> 5 <mot:Abd-B>   Abd-B    AbdB_Cell AbdB   <NA> Dmelanogaster GWTTTATKA      DNA
#>   strand  icscore nsites bkgsites pval qval eval type pseudocount          bkg
#> 1     +- 7.371641     37       NA   NA   NA   NA  PPM           1 0.25, 0.....
#> 2     +- 7.831193      7       NA   NA   NA   NA  PPM           1 0.25, 0.....
#> 3     +- 8.976569     18       NA   NA   NA   NA  PPM           1 0.25, 0.....
#> 4     +- 8.330000    662       NA   NA   NA   NA  PPM           1 0.25, 0.....
#> 5     +- 9.147674     21       NA   NA   NA   NA  PPM           1 0.25, 0.....
#>        dataSource
#> 1 FlyFactorSurvey
#> 2 FlyFactorSurvey
#> 3 FlyFactorSurvey
#> 4 FlyFactorSurvey
#> 5 FlyFactorSurvey
```

One thing that becomes obvious is that many motifs have mismatched `altname`/`tfid` values because of capitalization or hyphenation differences. You can use domain-specific knowledge to assess which one is correct. For *Drosophila*, “abd-A” is correct over “AbdA”, for example.

After manually inspecting these rows, I determined that instances of different capitalization, hyphenation, or names that contain “.” or “()” can be ignored. To further investigate the data, I will ignore capitalization and special character differences as follows:

```
flyFactor_data %>%
  # calling tolower() on both columns removes capitalization as a difference
  dplyr::filter(tolower(altname) != tolower(tfid),
                # Select all altnames that do not contain "-", "." or "("
                !grepl("-|\\.|\\(", altname),
                ) %>%
  # I'll visalize only these columns for brevity
  dplyr::select(altname, tfid, name, consensus) %>%
  head(10)
#>    altname    tfid              name            consensus
#> 1       da      ac    ac_da_SANGER_5             RCACCTGC
#> 2       da    amos amos_da_SANGER_10          RMCAYMTGBCV
#> 3       da     ase  ase_da_SANGER_10              CACCTGY
#> 4       da     ato  ato_da_SANGER_10          MCAYMTGNCRC
#> 5       da     ato ato_da_SANGER_5_2            GNCAKRTGN
#> 6       da     ato ato_da_SANGER_5_3            MCAYMTGNC
#> 7       da    cato cato_da_SANGER_10           MRCANMTGWC
#> 8      Zif CG10267  CG10267_SANGER_5           WNYAACACTR
#> 9      Zif CG10267  CG10267_SOLEXA_5 CNNNNWAYAACACTASNMNN
#> 10    mamo CG11071  CG11071_SANGER_5         YMMGCCTAYNNM
```

Next, what is obvious is that several `altnames` set to “da” have a high number of mismatched `tfid`s. For instance, `amos_da_SANGER_10`. When checking the [FlyFactorSurvey page for da](https://mccb.umassmed.edu/ffs/TFdetails.php?FlybaseID=FBgn0000413), it reveals only 1 motif corresponds to this factor. Checking the [page for amos](https://mccb.umassmed.edu/ffs/TFdetails.php?FlybaseID=FBgn0003270) shows a match to `amos_da_SANGER_10`. Therefore, we can conclude that factors assigned the name of `da` are incorrectly assigned, and we should prefer our parsed `tfid`.

```
flyFactor_data %<>%
  # rename all "da" instances using their tfid value instead
  dplyr::mutate(altname = ifelse(altname == "da", tfid, altname))
```

Now we’ve handled the “da” mismatches, we filter them out to identify new special cases.

```
flyFactor_data %>%
  dplyr::filter(tolower(altname) != tolower(tfid),
                !grepl("-|\\.|\\(", altname)) %>%
  dplyr::select(altname, tfid, name, consensus) %>%
  head(10)
#>    altname    tfid             name            consensus
#> 1      Zif CG10267 CG10267_SANGER_5           WNYAACACTR
#> 2      Zif CG10267 CG10267_SOLEXA_5 CNNNNWAYAACACTASNMNN
#> 3     mamo CG11071 CG11071_SANGER_5         YMMGCCTAYNNM
#> 4      lms CG13424     CG13424_Cell             NYTAATTR
#> 5      lms CG13424 CG13424_SOLEXA_2           NNYTAATTRN
#> 6      lms CG13424   CG13424_SOLEXA              YTAATTR
#> 7      erm CG31670 CG31670_SANGER_5          AAAWGMGCAWC
#> 8      erm CG31670 CG31670_SOLEXA_5      NNAAAWGAGCAAYNV
#> 9     Spps  CG5669 CG5669_SANGER_10      DRKGGGCGKGGCCAM
#> 10    Spps  CG5669  CG5669_SOLEXA_5      NGKGGGCGKGGCNWN
```

The next thing to notice about these data is that entries with “CG” prefixed tfids are often mismatched. This is because when the FlyFactor survey was conducted, many genes were unnamed, and thus assigned a CG from FlyBase. As time has gone on, some CG’s have been named. Checking the [FlyBase page for CG10267](http://flybase.org/reports/FBgn0037446) reveals that it has been renamed “Zif”. This matches with the `altname`, so we conclude that rows with a “CG” `tfid` can be safely skipped as their `altname` contains the new gene symbol.

```
flyFactor_data %>%
  dplyr::filter(tolower(altname) != tolower(tfid),
                !grepl("-|\\.|\\(", altname),
                # Remove CG genes from consideration
                !grepl("CG\\d+", tfid)
                ) %>%
  dplyr::select(altname, tfid, name, consensus)
#>    altname tfid                 name   consensus
#> 1      cyc  Clk     Clk_cyc_SANGER_5    MCACGTGA
#> 2   CG6272  Crc  Crc_CG6272_SANGER_5 ATTACRTCABC
#> 3      Max   dm     dm_Max_SANGER_10  RNCACGTGGT
#> 4      Clk  gce     gce_Clk_SANGER_5    GCCACGTG
#> 5      Jra  kay     kay_Jra_SANGER_5 NATGASTCAYC
#> 6  schlank Lag1            Lag1_Cell  CYACYAAAWT
#> 7  schlank Lag1          Lag1_SOLEXA  CYACYAAWWT
#> 8     Lim1  lim         lim_SOLEXA_2   NNTAATTRV
#> 9      Mnt  Max     Max_Mnt_SANGER_5     CCACGTG
#> 10     Clk  Met     Met_Clk_SANGER_5    GACACGTG
#> 11  bigmax  Mio  Mio_bigmax_SANGER_5    ATCACGTG
#> 12     Bgb  run          run_Bgb_NBT   WAACCGCAR
#> 13     Clk  tai     tai_Clk_SANGER_5   RCACGTGTC
#> 14     cyc  tgo     tgo_cyc_SANGER_5   GTCACGTGM
#> 15     sim  tgo     tgo_sim_SANGER_5  GWACGTGACC
#> 16    sima  tgo    tgo_sima_SANGER_5   GTACGTGAC
#> 17      ss  tgo      tgo_ss_SANGER_5    TGCGTGAC
#> 18     tai  tgo     tgo_tai_SANGER_5   RCACGTGAC
#> 19     trh  tgo     tgo_trh_SANGER_5  RTACGTGACC
#> 20  CG6272 Xrp1 Xrp1_CG6272_SANGER_5  ATTRCRYMAY
```

The remaining rows (only 20 values) can be manually inspected for any discrepancies. I went through each entry by hand, looking up their motifs on [FlyFactor](https://mccb.umassmed.edu/ffs/), and their gene names on [FlyBase](flybase.org) to determine the best way to handle these motifs. Sometimes the best way to be sure your data are high quality is to carefully inspect it!

I determined from this that a few `altnames` need swapping, and one motif I will remove because it is unusual ([Bgb](https://mccb.umassmed.edu/ffs/TFdetails.php?FlybaseID=FBgn0013753) has an identical motif to [run](https://mccb.umassmed.edu/ffs/TFdetails.php?FlybaseID=FBgn0003300), but the motif is marked “run” on the FlyFactor website).

I’ll make those changes to the data:

```
swap_alt_id <- c("CG6272", "Clk", "Max", "Mnt", "Jra")
remove <- "Bgb"

flyFactor_data %<>%
  dplyr::mutate(altname = ifelse(altname %in% swap_alt_id, tfid, altname)) %>%
  dplyr::filter(!(altname %in% remove))
```

Finally, the remaining motif metadata is also OK based on my manual inspection.

```
flyFactor_data %>%
  dplyr::filter(tolower(altname) != tolower(tfid),
                !grepl("-|\\.|\\(", altname),
                # Remove CG genes from consideration
                !grepl("CG\\d+", tfid)
                ) %>%
  dplyr::select(altname, tfid, name, consensus)
#>    altname tfid                name  consensus
#> 1      cyc  Clk    Clk_cyc_SANGER_5   MCACGTGA
#> 2  schlank Lag1           Lag1_Cell CYACYAAAWT
#> 3  schlank Lag1         Lag1_SOLEXA CYACYAAWWT
#> 4     Lim1  lim        lim_SOLEXA_2  NNTAATTRV
#> 5   bigmax  Mio Mio_bigmax_SANGER_5   ATCACGTG
#> 6      cyc  tgo    tgo_cyc_SANGER_5  GTCACGTGM
#> 7      sim  tgo    tgo_sim_SANGER_5 GWACGTGACC
#> 8     sima  tgo   tgo_sima_SANGER_5  GTACGTGAC
#> 9       ss  tgo     tgo_ss_SANGER_5   TGCGTGAC
#> 10     tai  tgo    tgo_tai_SANGER_5  RCACGTGAC
#> 11     trh  tgo    tgo_trh_SANGER_5 RTACGTGACC
```

## Removing duplicate motif matrices

Just because the metadata for each entry is unique, this does not mean that the motif matrix for each entry is unique. There are many reasons why two different factors could have identical motifs: some biological, others technical. In the case of the FlyFactorSurvey, some entries are duplicated in MotifDb which should not be.

For instance, the following motif is a duplicate where the tidied metadata matches:

```
flyFactor_data %>%
  dplyr::filter(consensus == "MMCACCTGYYV")
#>          motif altname               name   tfid family      organism
#> 1     <mot:da>  HLH54F HLH54F_da_SANGER_5 HLH54F   <NA> Dmelanogaster
#> 2 <mot:HLH54F>  HLH54F HLH54F_da_SANGER_5 HLH54F   <NA> Dmelanogaster
#>     consensus alphabet strand  icscore nsites bkgsites pval qval eval type
#> 1 MMCACCTGYYV      DNA     +- 12.24152     23       NA   NA   NA   NA  PPM
#> 2 MMCACCTGYYV      DNA     +- 12.24152     23       NA   NA   NA   NA  PPM
#>   pseudocount          bkg      dataSource
#> 1           1 0.25, 0..... FlyFactorSurvey
#> 2           1 0.25, 0..... FlyFactorSurvey
```

It is difficult to determine in a high-throughput way whether any matrix entries are identical in a large database, and it is not always possible to rely on metadata to determine matrix duplication.

In order to identify and remove duplicate motif matrices, memes provides `remove_duplicate_motifs()`, which can be used to deduplicate a list of motifs based solely on their motif matrices (i.e. it ignores motif name & other metadata). We will use this strategy to deduplicate the flyFactor data.

(NOTE: When working with other motif databases, it is critical to understand the data source to determine appropriate measures for handling duplicated entries.)

```
# This operation takes a while to run on large motif lists
flyFactor_dedup <- remove_duplicate_motifs(flyFactor_data)
#> Warning in universalmotif::compare_motifs(x, method = "PCC"): Some comparisons
#> failed due to low motif IC
```

Duplicate removal identifies and removes 57 identical matrices.

```
# Rows before cleanup
nrow(flyFactor_data)
#> [1] 613
# Rows after cleanup
nrow(flyFactor_dedup)
#> [1] 556
```

Using the example from before now shows only 1 motif corresponding to this sequence.

```
flyFactor_dedup %>%
  dplyr::filter(consensus == "MMCACCTGYYV")
#>          motif               name altname      organism   consensus alphabet
#> 1 <mot:HLH5..> HLH54F_da_SANGER_5  HLH54F Dmelanogaster MMCACCTGYYV      DNA
#>   strand  icscore nsites type pseudocount          bkg   tfid      dataSource
#> 1     +- 12.24152     23  PPM           1 0.25, 0..... HLH54F FlyFactorSurvey
#>
#> [Hidden empty columns: family, bkgsites, pval, qval, eval.]
```

Finally, now that the database has been tidied and deduplicated, the resulting data.frame can be converted back into a universalmotif list using `to_list()`. To discard the additional columns we created so they are not passed on to the `universalmotif`, set `extrainfo = FALSE`.

```
# extrainfo = FALSE drops the extra columns we added during data cleaning which are now unneeded
flyFactorMotifs_final <- to_list(flyFactor_dedup, extrainfo = FALSE)
#> Discarding unknown slot(s) 'tfid', 'dataSource' (set `extrainfo=TRUE` to
#>   preserve these).
```

The resulting universalmotif list object now reflects the changes we made to the `data.frame` and can now be exported as a .meme format file using `universalmotif::write_meme` or can be used directly as input to tools like `runTomTom` or `runAme`.

```
flyFactorMotifs_final %>%
  head(1)
#> [[1]]
#>
#>        Motif name:   ab_SANGER_10
#>    Alternate name:   ab
#>          Organism:   Dmelanogaster
#>          Alphabet:   DNA
#>              Type:   PPM
#>           Strands:   +-
#>          Total IC:   15.01
#>       Pseudocount:   1
#>         Consensus:   BWNRCCAGGWMCNNTNNNGNN
#>      Target sites:   20
#>
#>     B    W    N    R C C A G G    W    M    C    N    N    T    N    N    N
#> A 0.0 0.50 0.20 0.35 0 0 1 0 0 0.55 0.35 0.05 0.20 0.45 0.20 0.10 0.40 0.40
#> C 0.3 0.15 0.25 0.00 1 1 0 0 0 0.10 0.65 0.70 0.45 0.25 0.10 0.25 0.25 0.10
#> G 0.4 0.05 0.50 0.65 0 0 0 1 1 0.00 0.00 0.05 0.05 0.15 0.05 0.20 0.05 0.15
#> T 0.3 0.30 0.05 0.00 0 0 0 0 0 0.35 0.00 0.20 0.30 0.15 0.65 0.45 0.30 0.35
#>      G    N    N
#> A 0.25 0.50 0.30
#> C 0.10 0.25 0.25
#> G 0.55 0.15 0.45
#> T 0.10 0.10 0.00
```

This cleaned-up version of the FlyFactorSurvey data is packaged with memes in `system.file("extdata/flyFactorSurvey_cleaned.meme", package = "memes")`.

```
write_meme(flyFactorMotifs_final, "flyFactorSurvey_cleaned.meme")
```

# Session Info

```
sessionInfo()
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] universalmotif_1.28.0 magrittr_2.0.4        memes_1.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            dplyr_1.1.4
#>  [3] farver_2.1.2                R.utils_2.13.0
#>  [5] Biostrings_2.78.0           S7_0.2.0
#>  [7] bitops_1.0-9                fastmap_1.2.0
#>  [9] RCurl_1.98-1.17             GenomicAlignments_1.46.0
#> [11] XML_3.99-0.19               digest_0.6.37
#> [13] lifecycle_1.0.4             waldo_0.6.2
#> [15] compiler_4.5.1              rlang_1.1.6
#> [17] sass_0.4.10                 tools_4.5.1
#> [19] yaml_2.3.10                 data.table_1.17.8
#> [21] rtracklayer_1.70.0          knitr_1.50
#> [23] S4Arrays_1.10.0             curl_7.0.0
#> [25] splitstackshape_1.4.8       DelayedArray_0.36.0
#> [27] RColorBrewer_1.1-3          pkgload_1.4.1
#> [29] abind_1.4-8                 BiocParallel_1.44.0
#> [31] withr_3.0.2                 purrr_1.1.0
#> [33] BiocGenerics_0.56.0         desc_1.4.3
#> [35] R.oo_1.27.1                 grid_4.5.1
#> [37] stats4_4.5.1                MotifDb_1.52.0
#> [39] ggplot2_4.0.0               scales_1.4.0
#> [41] MASS_7.3-65                 dichromat_2.0-0.1
#> [43] SummarizedExperiment_1.40.0 cli_3.6.5
#> [45] cmdfun_1.0.2                rmarkdown_2.30
#> [47] crayon_1.5.3                generics_0.1.4
#> [49] httr_1.4.7                  tzdb_0.5.0
#> [51] rjson_0.2.23                cachem_1.1.0
#> [53] ggseqlogo_0.2               parallel_4.5.1
#> [55] XVector_0.50.0              restfulr_0.0.16
#> [57] matrixStats_1.5.0           vctrs_0.6.5
#> [59] Matrix_1.7-4                jsonlite_2.0.0
#> [61] IRanges_2.44.0              hms_1.1.4
#> [63] S4Vectors_0.48.0            testthat_3.2.3
#> [65] tidyr_1.3.1                 jquerylib_0.1.4
#> [67] glue_1.8.0                  codetools_0.2-20
#> [69] gtable_0.3.6                GenomicRanges_1.62.0
#> [71] BiocIO_1.20.0               tibble_3.3.0
#> [73] pillar_1.11.1               htmltools_0.5.8.1
#> [75] Seqinfo_1.0.0               brio_1.1.5
#> [77] R6_2.6.1                    rprojroot_2.1.1
#> [79] evaluate_1.0.5              Biobase_2.70.0
#> [81] lattice_0.22-7              readr_2.1.5
#> [83] R.methodsS3_1.8.2           Rsamtools_2.26.0
#> [85] cigarillo_1.0.0             bslib_0.9.0
#> [87] Rcpp_1.1.0                  SparseArray_1.10.0
#> [89] xfun_0.53                   MatrixGenerics_1.22.0
#> [91] pkgconfig_2.0.3
```