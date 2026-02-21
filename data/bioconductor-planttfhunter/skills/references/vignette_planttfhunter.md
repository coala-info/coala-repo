# Genome-wide identification and classification of transcription factors in plant genomes

Fabricio Almeida-Silva1 and Yves Van de Peer1

1VIB-UGent Center for Plant Systems Biology, Ghent University,
Ghent, Belgium

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Data description](#data-description)
* [4 Algorithm description](#algorithm-description)
* [5 Identifying and classifying TFs](#identifying-and-classifying-tfs)
* [6 Counting TFs per family in multiple species at once](#counting-tfs-per-family-in-multiple-species-at-once)
* [Session information](#session-information)
* [References](#references)

# 1 Introduction

Transcription factors (TFs) are proteins that bind to cis-regulatory elements
in promoter regions of genes and regulate their expression.
Identifying them in a genome is useful for a variety of reasons, such as
exploring their evolutionary history across clades and inferring
gene regulatory networks. *[planttfhunter](https://github.com/almeidasilvaf/planttfhunter)*
allows users to identify plant TFs from whole-genome protein sequences and
classify them into families and subfamilies (when applicable) using the
classification scheme implemented in [PlantTFDB](http://planttfdb.gao-lab.org/).
As *[planttfhunter](https://github.com/almeidasilvaf/planttfhunter)* interoperates with
core Bioconductor packages (i.e., `AAStringSet` objects as input,
`SummarizedExperiment` objects as output), it can be easily incorporated in
pipelines for TF identification and classification in large-scale genomic
data sets.

# 2 Installation

You can install *[planttfhunter](https://github.com/almeidasilvaf/planttfhunter)*
with the following code:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("planttfhunter")
```

Loading package after installation:

```
library(planttfhunter)
```

# 3 Data description

In this vignette, we will use protein sequences of TFs from the algae
species *Galdieria sulphuraria* as an example, as its proteome is
very small. The proteome file was
downloaded from the PLAZA Diatoms database (Osuna-Cruz et al. [2020](#ref-osuna2020seminavis)), and
it was filtered to keep only TFs for demonstration purposes.
The object `gsu` stores the protein sequences in an `AAStringSet` object.

```
data(gsu)
gsu
#> AAStringSet object of length 290:
#>       width seq                                             names
#>   [1]   383 MSVLLQTSRGDIVVDLFTDLAP...EKALFQEHRRSSYSKTSKRYK* gsu00340.1
#>   [2]   301 MESMSQTKRWSCVIYQVDSILP...PNISLQQLLGDEDEISWSGLP* gsu04730.1
#>   [3]   232 MEKGPCSHKWKQLHVGDYQHDN...PNISLQQLLGDEDEISWSGLP* gsu05000.1
#>   [4]   340 MDVPSYRFECTPLVEVKKEARD...EVTQSSTRNCNDKEWNPNANE* gsu06140.1
#>   [5]   120 MAPKERSKPKSRSSKAGLQFPV...SGGVLPNVHPNLLPKKKAKEE* gsu06160.1
#>   ...   ... ...
#> [286]   394 MSKLEAASDSGSLKTSSCSFQE...NETNSHDKPGEDRMNIQENTS* gsu98790.1
#> [287]   365 MITEVDNPMSFVHSEHFMNYSS...RRHSRLPVFQTLEEKSDIHSK* gsu99250.1
#> [288]   365 MITEVDNPMSFVHSEHFMNYSS...RRHSRLPVFQTLEEKSDIHSK* gsu99270.1
#> [289]   284 MTSFYIKKGITFSSIVYNHNYK...LFQRIIEINKNYNPLIQLQRI* AIG92462.1
#> [290]   219 MKYKLLVIDDELSIRQSLKKYL...TFTRSRTELVRYAIKNNLIIE* AIG92471.1
```

# 4 Algorithm description

TF identification and classification is based on the presence of signature
protein domains, which are identified using profile hidden Markov models (HMMs).
The family classification scheme is the same as the one used by
PlantTFDB (Jin et al. [2016](#ref-jin2016planttfdb)), and it is summarized below:111 **Tip:** You can access this classification scheme in your R session by
loading the data frame `data(classification_scheme)`.

|  | Family | Subfamily | DBD | Auxiliary | Forbidden |
| --- | --- | --- | --- | --- | --- |
| 2 | AP2/ERF | AP2 | AP2 (>=2) (PF00847) | NA | NA |
| 3 | AP2/ERF | ERF | AP2 (1) (PF00847) | NA | NA |
| 4 | AP2/ERF | RAV | AP2 (PF00847) and B3 (PF02362) | NA | NA |
| 5 | B3 superfamily | ARF | B3 (PF02362) | Auxin\_resp (PF06507) | NA |
| 6 | B3 superfamily | B3 | B3 (PF02362) | NA | NA |
| 7 | BBR-BPC | BBR-BPC | GAGA\_bind (PF06217) | NA | NA |
| 8 | BES1 | BES1 | DUF822 (PF05687) | NA | NA |
| 9 | bHLH | bHLH | HLH (PF00010) | NA | NA |
| 10 | bZIP | bZIP | bZIP\_1 (PF00170) | NA | NA |
| 11 | C2C2 | CO-like | zf-B\_box (PF00643) | CCT (PF06203) | NA |
| 12 | C2C2 | Dof | Zf-Dof (PF02701) | NA | NA |
| 13 | C2C2 | GATA | GATA-zf (PF00320) | NA | NA |
| 14 | C2C2 | LSD | Zf-LSD1 (PF06943) | NA | Peptidase\_C14 (PF00656) |
| 15 | C2C2 | YABBY | YABBY (PF04690) | NA | NA |
| 16 | C2H2 | C2H2 | zf-C2H2 (PF00096) | NA | RNase\_T (PF00929) |
| 17 | C3H | C3H | Zf-CCCH (PF00642) | NA | RRM\_1 (PF00076) or Helicase\_C (PF00271) |
| 18 | CAMTA | CAMTA | CG1 (PF03859) | NA | NA |
| 19 | CPP | CPP | TCR (PF03638) | NA | NA |
| 20 | DBB | DBB | zf-B\_box (>=2) (PF00643) | NA | NA |
| 21 | E2F/DP | E2F/DP | E2F\_TDP (PF02319) | NA | NA |
| 22 | EIL | EIL | EIN3 (PF04873) | NA | NA |
| 23 | FAR1 | FAR1 | FAR1 (PF03101) | NA | NA |
| 24 | GARP | ARR-B | G2-like | Response\_reg (PF00072) | NA |
| 25 | GARP | G2-like | G2-like | NA | NA |
| 26 | GeBP | GeBP | DUF573 (PF04504) | NA | NA |
| 27 | GRAS | GRAS | GRAS (PF03514) | NA | NA |
| 28 | GRF | GRF | WRC (PF08879) | QLQ (PF08880) | NA |
| 29 | HB | HD-ZIP | Homeobox (PF00046) | HD-ZIP\_I/II or SMART (PF01852) | NA |
| 30 | HB | TALE | Homeobox (PF00046) | BELL or ELK (PF03789) | NA |
| 31 | HB | WOX | homeobox (PF00046) | Wus type homeobox | NA |
| 32 | HB | HB-PHD | homeobox (PF00046) | PHD (PF00628) | NA |
| 33 | HB | HB-other | homeobox (PF00046) | NA | NA |
| 34 | HRT-like | HRT-like | HRT-like | NA | NA |
| 35 | HSF | HSF | HSF\_dna\_bind (PF00447) | NA | NA |
| 36 | LBD (AS2/LOB) | LBD (AS2/LOB) | DUF260 (PF03195) | NA | NA |
| 37 | LFY | LFY | FLO\_LFY (PF01698) | NA | NA |
| 38 | MADS | M\_type | SRF-TF (PF00319) | NA | NA |
| 39 | MADS | MIKC | SRF-TF (PF00319) | K-box (PF01486) | NA |
| 40 | MYB superfamily | MYB | Myb\_dna\_bind (>=2) (PF00249) | NA | SWIRM (PF04433) |
| 41 | MYB superfamily | MYB\_related | Myb\_dna\_bind (1) (PF00249) | NA | SWIRM (PF04433) |
| 42 | NAC | NAC | NAM (PF02365) | NA | NA |
| 43 | NF-X1 | NF-X1 | Zf-NF-X1 (PF01422) | NA | NA |
| 44 | NF-Y | NF-YA | CBFB\_NFYA (PF02045) | NA | NA |
| 45 | NF-Y | NF-YB | NF-YB | NA | NA |
| 46 | NF-Y | NF-YC | NF-YC | NA | NA |
| 47 | Nin-like | Nin-like | RWP-RK (PF02042) | NA | NA |
| 48 | NZZ/SPL | NZZ/SPL | NOZZLE (PF08744) | NA | NA |
| 49 | S1Fa-like | S1Fa-like | S1FA (PF04689) | NA | NA |
| 50 | SAP | SAP | SAP | NA | NA |
| 51 | SBP | SBP | SBP (PF03110) | NA | NA |
| 52 | SRS | SRS | DUF702 (PF05142) | NA | NA |
| 53 | STAT | STAT | STAT | NA | NA |
| 54 | TCP | TCP | TCP (PF03634) | NA | NA |
| 55 | Trihelix | Trihelix | Trihelix | NA | NA |
| 56 | VOZ | VOZ | VOZ | NA | NA |
| 57 | Whirly | Whirly | Whirly (PF08536) | NA | NA |
| 58 | WRKY | WRKY | WRKY (PF03106) | NA | NA |
| 59 | ZF-HD | ZF-HD | ZF-HD\_dimer (PF04770) | NA | NA |

# 5 Identifying and classifying TFs

To identify TFs from protein sequence data, you will use the
function `annotate_pfam()`. This function takes as input an `AAStringSet`
object222 **Tip:** If you have protein sequences in a FASTA file, you can read
them into an `AAStringSet` object with the function `readAAStringSet()` from
the *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* package. and returns a data frame of protein domains associated with
each sequence. The HMMER program (Finn, Clements, and Eddy [2011](#ref-finn2011hmmer)) is used to scan protein
sequences for the presence of DNA-binding protein domains, as well as
auxiliary and forbidden domains. Pre-built HMM profiles can be found in the
*extdata/* directory of this package.

This is how you can run `annotate_pfam()`:333 **Note:** in the code chunk below, the if statement is not required.
We just added it to make sure that the function `annotate_pfam()` is only
executed if HMMER is installed, to avoid problems when building this
vignette in machines that do not have HMMER installed.

```
data(gsu_annotation)

# Annotate TF-related domains using a local installation of HMMER
if(hmmer_is_installed()) {
  gsu_annotation <- annotate_pfam(gsu)
}

# Take a look at the first few lines of the output
head(gsu_annotation)
#>          Gene  Domain
#> 1 gsu144370.1 PF00010
#> 2 gsu140730.1 PF00010
#> 3 gsu127100.1 PF00046
#> 4 gsu109490.1 PF00046
#> 5  AIG92462.1 PF00072
#> 6  AIG92471.1 PF00072
```

Now that we have our TF-related domains, we can classify TFs in families
with the function `classify_tfs()`.

```
# Classify TFs into families
gsu_families <- classify_tfs(gsu_annotation)

# Take a look at the output
head(gsu_families)
#>          Gene      Family
#> 1  gsu04730.1    Nin-like
#> 2  gsu05000.1    Nin-like
#> 3  gsu06140.1     G2-like
#> 4  gsu06140.1 MYB-related
#> 5  gsu09770.1         C3H
#> 6 gsu100410.1    Nin-like

# Count number of TFs per family
table(gsu_families$Family)
#>
#>        C2H2         C3H     CO-like         CPP      E2F/DP     G2-like
#>           4          11           2           3           8           2
#>        GATA    HB-other         HSF         LSD      M-type         MYB
#>           8           2           6           3           1          16
#> MYB-related       NF-X1       NF-YA       NF-YB       NF-YC    Nin-like
#>          25           1           1           4           5          10
#>        bHLH        bZIP
#>           2           8
```

# 6 Counting TFs per family in multiple species at once

If you want to get TF counts per family for multiple species, you can use
the function `get_tf_counts()`. This function takes a list of `AAStringSet`
objects containing proteomes as input,444 **Tip:** If you have whole-genome protein sequences for multiple
species as FASTA files in a given directory, you can read them all as a list
of `AAStringSet` objects with the function `fasta2AAStringSetlist()` from
the Bioconductor package *[syntenet](https://bioconductor.org/packages/3.22/syntenet)*. and it returns a `SummarizedExperiment`
object containing TF counts per family in each species, as well as species
metadata (optional). If you are not familiar with the `SummarizedExperiment`
class, you should consider checking the vignettes of the
*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* Bioconductor package.

To demonstrate how `get_tf_counts()` works, we will simulate a
list of 4 `AAStringSet` objects by sampling 50 random genes from the example
data set `gsu` 4 times.

```
set.seed(123) # for reproducibility

# Simulate 4 different species by sampling 100 random genes from `gsu`
proteomes <- list(
    Gsu1 = gsu[sample(names(gsu), 50, replace = FALSE)],
    Gsu2 = gsu[sample(names(gsu), 50, replace = FALSE)],
    Gsu3 = gsu[sample(names(gsu), 50, replace = FALSE)],
    Gsu4 = gsu[sample(names(gsu), 50, replace = FALSE)]
)
proteomes
#> $Gsu1
#> AAStringSet object of length 50:
#>      width seq                                              names
#>  [1]   405 MSQDTYTFEKLGVCKILCEECKN...SSSYNCPTDERMESEEEKLET* gsu49120.1
#>  [2]   292 MGRSTTVFVGNIAYNTSEEQLQE...TLGAQMGQPGLGSSAFSSNNN* gsu102250.1
#>  [3]   530 MTFTRIENNLKKYFGYENFRPLQ...KMSKTQNINQKTLLRWFSETM* gsu56420.1
#>  [4]   672 MNRSLFTPTLRWSQWFAKTCTTL...EKRKLSVVHNKTQQIVSFNRH* gsu22760.1
#>  [5]   606 MSQERLTPFERHLKKVEEKNQRE...EEDLDGVPLEEDEEAIEIEIK* gsu68790.1
#>  ...   ... ...
#> [46]   465 MNMFSYSTIETPKYVRSNSSDDR...STQMSHLLSVALQDWVEWNQE* gsu47220.1
#> [47]  2225 MSFPPKFRNYLLAQKGQPVSVEQ...MWRWVDNKSQFLSSYQVAWNE* gsu96990.1
#> [48]   292 MRGKSKSVVFPASRIKRIMRINE...LDKVESPSRVFISIEELVHSV* gsu124540.1
#> [49]   477 MDSSKKSTNPKLSESGTKDNRGN...PSDTTAPQVAVNVHAGNGSSK* gsu67550.1
#> [50]   740 MERLQPPYRYLIILDLEATAVDL...CTQDKSVSLGSVSLEGKGDSV* gsu102410.1
#>
#> $Gsu2
#> AAStringSet object of length 50:
#>      width seq                                              names
#>  [1]   764 MSQSVPVKNDTEDSCGVQKLSNA...NSDDTSRIRRRTLNVHDLLSE* gsu21860.1
#>  [2]   406 MQPHVSDHRYPTTVEQREYHSGS...QTTDVTGGAVFLRKETEHKDI* gsu140730.1
#>  [3]   714 MEDERNSRLLIQGLPKYIAEKRL...LVFDYLVNWMALIVALVLSSF* gsu84990.1
#>  [4]   236 MDTSEQGSEQGEESISNNSQQLC...YTNTASHRFRKLLKASVGDTS* gsu72770.1
#>  [5]   524 MKKNAKEIGAQYSALVFIHVALF...PVSTVPYFVMDNNSGGSYSFV* gsu136350.1
#>  ...   ... ...
#> [46]   284 MTSFYIKKGITFSSIVYNHNYKF...LFQRIIEINKNYNPLIQLQRI* AIG92462.1
#> [47]   546 MAPRLNKTTQTKLKKQSSFREQP...NACGLFWAKHKQLRPKEKWVR* gsu134260.1
#> [48]   310 MSGGSGIYQPSGMSLYVGNLDPR...EIAGCVVQCEWGREGLKSRYF* gsu10640.1
#> [49]   445 MEPISKDDVYGGFSTVENCDSSM...NCKCVDCKNQSSLSLLKNTAM* gsu21090.1
#> [50]   318 MFICGHMIQNLVSVCAHSRIFCI...DCSYIFATDASDYPPPWQYFP* gsu64800.1
#>
#> $Gsu3
#> AAStringSet object of length 50:
#>      width seq                                              names
#>  [1]   196 MAYLYEDRPVTLYRDRRFQGTQE...RDETDEVFQTEKNPRFREEED* gsu18660.1
#>  [2]   171 MEDRMQVVVSETSKGEERGRGRG...SWAFSRGPLGTRLSTRRRSEK* gsu34810.1
#>  [3]   461 MTERIDKSRRKKYVLTKKREYWT...HKESFSKRTYPDSVQAVIVGQ* gsu38570.1
#>  [4]  1207 MELVSGPLLDQFPFVAGHSRQTL...KYGREHHWQYSLEHPFVSPIL* gsu143710.1
#>  [5]   928 MFILVVEVKVEEYFSFQLDDFQQ...LRRVLDILRQIPRLPAKQWLS* gsu79190.1
#>  ...   ... ...
#> [46]   150 MAAVEDNRVFVGGLPWSVGEDDL...GHGHGGRGGRSGGFRRREDFE* gsu58080.1
#> [47]   122 MAPKERSKPKSRSSKAGLQFPVG...GVLPNVHPNLLPKKKAKEDMQ* gsu59350.1
#> [48]   680 MWSTVDYSLNCDEEFRELSNAAA...QQSTNVVYPSNTNNSETCENS* gsu44800.1
#> [49]   148 MVANGEPGVIYIGHLPHGFYENE...ERRNKELEVKLKKLGVSFSLS* gsu97960.1
#> [50]   226 MAYRKLETRVPSYLDEVLGKVSS...SAPEGVWRCPDCRSGGANRAR* gsu111770.1
#>
#> $Gsu4
#> AAStringSet object of length 50:
#>      width seq                                              names
#>  [1]   740 MERLQPPYRYLIILDLEATAVDL...CTQDKSVSLGSVSLEGKGDSV* gsu102410.1
#>  [2]   701 MFKSSLLTFPALKTVVGAQDQYT...NLTKSFDLKKSQLSKRKKKWK* gsu110850.1
#>  [3]   484 MSEVSWEAGRSPVQPGKDHKSSS...DRSSTENRNSGRRRSVEGRAR* gsu114840.1
#>  [4]   483 MEEERKQKKGTGTSVSKTRAVQE...AKSADDESSRPVRQYDVENVA* gsu100590.1
#>  [5]   122 MAPKERSKPKSRSSKAGLQFPVG...GVLPNVHPNLLPKKKAKEDMQ* gsu59350.1
#>  ...   ... ...
#> [46]   798 MVLYQSYSSDTNSDVKPSEVSNS...EDENNKILCLCGAPTCRKFLN* gsu40400.1
#> [47]   383 MSVLLQTSRGDIVVDLFTDLAPL...EKALFQEHRRSSYSKTSKRYK* gsu139150.1
#> [48]   518 MRSGTTLSSLHNSHTEDATSLRA...EIGDIASLLEGEEVNYERLER* gsu32730.1
#> [49]   287 MKASQVLASQLCELCQSANSSIY...RKQLAERRCRFKGRFIKNTAS* gsu55840.1
#> [50]  1886 MDDTEYVPVKKRRQRILQQAKEL...TEVTRKQLIYYLSDVLANNKE* gsu43660.1
```

Great, we have a list of 4 `AAStringSet` objects. Now, let’s also create a
simulated species metadata data frame for each “species” (simulated).

```
# Create simulated species metadata
species_metadata <- data.frame(
    row.names = names(proteomes),
    Division = "Rhodophyta",
    Origin = c("US", "Belgium", "China", "Brazil")
)

species_metadata
#>        Division  Origin
#> Gsu1 Rhodophyta      US
#> Gsu2 Rhodophyta Belgium
#> Gsu3 Rhodophyta   China
#> Gsu4 Rhodophyta  Brazil
```

You can add as many columns as you want to the species metadata data frame,
but make sure that **species names are in row names**, and
that `names(proteomes)` match `rownames(species)`,
otherwise `get_tf_counts()` will return an error.

Now that we have a list of `AAStringSet` objects and species metadata, we
can execute `get_tf_counts()`. This function uses `annotate_pfam()` under
the hood, so you also need to have HMMER installed and in your PATH to run it.
Here is how you can run it:

```
data(tf_counts)

# Get TF counts per family in each species as a SummarizedExperiment object
if(hmmer_is_installed()) {
    tf_counts <- get_tf_counts(proteomes, species_metadata)
}

# Take a look at the SummarizedExperiment object
tf_counts
#> class: SummarizedExperiment
#> dim: 19 4
#> metadata(0):
#> assays(1): counts
#> rownames(19): C2H2 C3H ... NF-YA NF-YB
#> rowData names(0):
#> colnames(4): Gsu1 Gsu2 Gsu3 Gsu4
#> colData names(2): Division Origin

# Look at the matrix of counts: assay() function from SummarizedExperiment
SummarizedExperiment::assay(tf_counts)
#>             Gsu1 Gsu2 Gsu3 Gsu4
#> C2H2           3    1    1    2
#> C3H            3    2    0    3
#> CPP            1    1    1    0
#> E2F/DP         1    2    2    2
#> GATA           1    2    1    0
#> HSF            2    0    0    3
#> MYB            3    3    0    2
#> MYB-related    4    5    3    9
#> NF-X1          1    0    0    0
#> NF-YC          3    0    0    1
#> Nin-like       2    0    1    1
#> bHLH           0    1    1    0
#> bZIP           0    2    4    0
#> G2-like        0    1    0    0
#> HB-other       0    1    0    0
#> LSD            0    1    0    0
#> M-type         0    1    1    0
#> NF-YA          0    1    0    0
#> NF-YB          0    2    0    1

# Look at the species metadata: colData() function from SummarizedExperiment
SummarizedExperiment::colData(tf_counts)
#> DataFrame with 4 rows and 2 columns
#>         Division      Origin
#>      <character> <character>
#> Gsu1  Rhodophyta          US
#> Gsu2  Rhodophyta     Belgium
#> Gsu3  Rhodophyta       China
#> Gsu4  Rhodophyta      Brazil
```

Cool, huh? In real-world analyses, once you have TF counts per family in
multiple species obtained with `get_tf_counts()`,
you can try to find associations between TF counts and
eco-evolutionary aspects or traits of each species (e.g., higher frequencies of
a stress-related TF family in a species that inhabits a stressful environment).

# Session information

This document was created under the following conditions:

```
sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  Biobase                2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics           0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle            * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown               0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  generics               0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges          1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  IRanges                2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics         1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats            1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  planttfhunter        * 1.10.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors              0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  Seqinfo                1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SummarizedExperiment   1.40.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  xfun                   0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/Rtmp4S1aj3/Rinst2353ea1d459630
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```

# References

Finn, Robert D, Jody Clements, and Sean R Eddy. 2011. “HMMER Web Server: Interactive Sequence Similarity Searching.” *Nucleic Acids Research* 39 (suppl\_2): W29–W37.

Jin, Jinpu, Feng Tian, De-Chang Yang, Yu-Qi Meng, Lei Kong, Jingchu Luo, and Ge Gao. 2016. “PlantTFDB 4.0: Toward a Central Hub for Transcription Factors and Regulatory Interactions in Plants.” *Nucleic Acids Research*, gkw982.

Osuna-Cruz, Cristina Maria, Gust Bilcke, Emmelien Vancaester, Sam De Decker, Atle M Bones, Per Winge, Nicole Poulsen, et al. 2020. “The Seminavis Robusta Genome Provides Insights into the Evolutionary Adaptations of Benthic Diatoms.” *Nature Communications* 11 (1): 1–13.