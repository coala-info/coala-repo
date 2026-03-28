[ ]
[ ]

[Skip to content](#output-files-of-shibasnakeshiba)

[![logo](../../assets/icon_black.png)](../.. "Shiba")

Shiba

Shiba/SnakeShiba

Initializing search

[Sika-Zheng-Lab/Shiba](https://github.com/Sika-Zheng-Lab/Shiba "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [Quick start](../../quickstart/diff_splicing_bulk/)
* [Output](./)
* [Usage](../../usage/shiba/)

[![logo](../../assets/icon_black.png)](../.. "Shiba")
Shiba

[Sika-Zheng-Lab/Shiba](https://github.com/Sika-Zheng-Lab/Shiba "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [ ]

  Quick start

  Quick start
  + [With bulk RNA-seq data](../../quickstart/diff_splicing_bulk/)
  + [With single-cell RNA-seq data](../../quickstart/diff_splicing_sc/)
* [x]

  Output

  Output
  + [ ]

    Shiba/SnakeShiba

    [Shiba/SnakeShiba](./)

    Table of contents
    - [Files in results/splicing](#files-in-resultssplicing)
    - [Column description of PSI\_\*.txt](#column-description-of-psi_txt)
    - [PSI\_SE.txt](#psi_setxt)
    - [PSI\_FIVE.txt and PSI\_THREE.txt](#psi_fivetxt-and-psi_threetxt)
    - [PSI\_MXE.txt](#psi_mxetxt)
    - [PSI\_RI.txt](#psi_ritxt)
    - [PSI\_MSE.txt](#psi_msetxt)
    - [PSI\_AFE.txt and PSI\_ALE.txt](#psi_afetxt-and-psi_aletxt)
    - [when ttest is true](#when-ttest-is-true)
    - [Files in results/expression](#files-in-resultsexpression)
    - [Files in results/pca](#files-in-resultspca)
    - [An example of output directory structure](#an-example-of-output-directory-structure)
  + [scShiba/SnakeScShiba](../scshiba/)
* [ ]

  Usage

  Usage
  + [Shiba](../../usage/shiba/)
  + [scShiba](../../usage/scshiba/)
  + [SnakeShiba](../../usage/snakeshiba/)
  + [SnakeScShiba](../../usage/snakescshiba/)

Table of contents

* [Files in results/splicing](#files-in-resultssplicing)
* [Column description of PSI\_\*.txt](#column-description-of-psi_txt)
* [PSI\_SE.txt](#psi_setxt)
* [PSI\_FIVE.txt and PSI\_THREE.txt](#psi_fivetxt-and-psi_threetxt)
* [PSI\_MXE.txt](#psi_mxetxt)
* [PSI\_RI.txt](#psi_ritxt)
* [PSI\_MSE.txt](#psi_msetxt)
* [PSI\_AFE.txt and PSI\_ALE.txt](#psi_afetxt-and-psi_aletxt)
* [when ttest is true](#when-ttest-is-true)
* [Files in results/expression](#files-in-resultsexpression)
* [Files in results/pca](#files-in-resultspca)
* [An example of output directory structure](#an-example-of-output-directory-structure)

# Output files of Shiba/SnakeShiba[¶](#output-files-of-shibasnakeshiba "Permanent link")

The output directory of **Shiba** contains the following sub directories:

* `annotation`: Assembled GTF file.
* `events`: Text files of alternative splicing events.
* `junctions`: Junction read counts.
* `results`: Results of differential expression and splicing analysis.
* `plots`: Plots of alternative splicing events.

The following sub directories are added when **SnakeShiba** is used:

* `benchmark`: [Benchmarking](https://snakemake.readthedocs.io/en/stable/tutorial/additional_features.html) results.
* `log`: Log files of each step.

---

## Files in `results/splicing`[¶](#files-in-resultssplicing "Permanent link")

* `PSI_[SE,FIVE,THREE,MXE,RI,MSE,AFE,ALE].txt`: Results of differential splicing analysis.
* `PSI_matrix_[sample,group].txt`: PSI values of each event for all samples or groups. Blank cells indicate that the event did not pass the minimum read count threshold.
* `summary.txt`: Numbers of the differentially spliced events for each splicing and event type.

---

## Column description of PSI\_\*.txt[¶](#column-description-of-psi_txt "Permanent link")

* **event\_id**: ID of the event.
* **pos\_id**: Positional ID of the event. This is useful for comparing the same event across different **Shiba** runs.
* **strand**: Strand of the event (*+* or *-*).
* **gene\_id**: Gene ID.
* **gene\_name**: Gene name.
* **label**: Label of the event type (*annotated* or *unannotated*). *annotated* means that the event is documented in the reference annotation file, while *unannotated* means that the event is NOT documented in the reference annotation file (i.e. novel or cryptic splicing event).
* **ref\_PSI**: PSI of the reference group.
* **alt\_PSI**: PSI of the alternative group.
* **dPSI**: Delta PSI (alt\_PSI - ref\_PSI).
* **q**: *P*-value of Fisher's exact test adjusted by the Benjamini-Hochberg method.
* **Diff events**: Flag of if the event is differentially spliced between the reference and alternative groups (*Yes* or *No*).

---

## `PSI_SE.txt`[¶](#psi_setxt "Permanent link")

![SE](https://github.com/Sika-Zheng-Lab/Shiba/blob/main/img/SE.png?raw=true)

* **exon**: Genomic coordinates of the skipped exon.
* **intron\_a**: Genomic coordinates of the left-side inclusive intron of the skipped exon.
* **intron\_b**: Genomic coordinates of the right-side inclusive intron of the skipped exon.
* **intron\_c**: Genomic coordinates of the exclusive intron of the skipped exon.
* **ref\_junction\_a**: Junction read counts of the left-side inclusive intron of the skipped exon in the reference group.
* **ref\_junction\_b**: Junction read counts of the right-side inclusive intron of the skipped exon in the reference group.
* **ref\_junction\_c**: Junction read counts of the exclusive intron of the skipped exon in the reference group.
* **alt\_junction\_a**: Junction read counts of the left-side inclusive intron of the skipped exon in the alternative group.
* **alt\_junction\_b**: Junction read counts of the right-side inclusive intron of the skipped exon in the alternative group.
* **alt\_junction\_c**: Junction read counts of the exclusive intron of the skipped exon in the alternative group.
* **OR\_junction\_a**: Odds ratio comparing junction read counts of the left-side inclusive intron to those of the exclusive intron, reference group against alternative group.
* **p\_junction\_a**: *P*-value of Fisher's exact test for the junction read counts of the left-side inclusive intron to those of the exclusive intron, reference group against alternative group.
* **OR\_junction\_b**: Odds ratio comparing junction read counts of the right-side inclusive intron to those of the exclusive intron, reference group against alternative group.
* **p\_junction\_b**: *P*-value of Fisher's exact test for the junction read counts of the right-side inclusive intron to those of the exclusive intron, reference group against alternative group.
* **p\_maximum**: Greater of the two *P*-values of Fisher's exact tests.

---

## `PSI_FIVE.txt` and `PSI_THREE.txt`[¶](#psi_fivetxt-and-psi_threetxt "Permanent link")

![FIVE_THREE](https://github.com/Sika-Zheng-Lab/Shiba/blob/main/img/FIVE_THREE.png?raw=true)

* **exon\_a**: Genomic coordinates of the longer exon using more internal splice site.
* **exon\_b**: Genomic coordinates of the shorter exon using less internal splice site.
* **intron\_a**: Genomic coordinates of the intron associated with the longer exon.
* **intron\_b**: Genomic coordinates of the intron associated with the shorter exon.
* **ref\_junction\_a**: Junction read counts of the intron associated with the longer exon in the reference group.
* **ref\_junction\_b**: Junction read counts of the intron associated with the shorter exon in the reference group.
* **alt\_junction\_a**: Junction read counts of the intron associated with the longer exon in the alternative group.
* **alt\_junction\_b**: Junction read counts of the intron associated with the shorter exon in the alternative group.
* **OR**: Odds ratio comparing junction read counts of the intron associated with the longer exon to those of the intron associated with the shorter exon, reference group against alternative group.
* **p**: *P*-value of Fisher's exact test for the junction read counts of the intron associated with the longer exon to those of the intron associated with the shorter exon, reference group against alternative group.

---

## `PSI_MXE.txt`[¶](#psi_mxetxt "Permanent link")

![MXE](https://github.com/Sika-Zheng-Lab/Shiba/blob/main/img/MXE.png?raw=true)

Mutually exclusive exons

* **exon\_a**: Genomic coordinates of the left-side mutually exclusive exon.
* **exon\_b**: Genomic coordinates of the right-side mutually exclusive exon.
* **intron\_a1**: Genomic coordinates of the left-side inclusive intron of the left-side mutually exclusive exon.
* **intron\_a2**: Genomic coordinates of the right-side inclusive intron of the left-side mutually exclusive exon.
* **intron\_b1**: Genomic coordinates of the left-side inclusive intron of the right-side mutually exclusive exon.
* **intron\_b2**: Genomic coordinates of the right-side inclusive intron of the right-side mutually exclusive exon.
* **ref\_junction\_a1**: Junction read counts of the left-side inclusive intron of the left-side mutually exclusive exon in the reference group.
* **ref\_junction\_a2**: Junction read counts of the right-side inclusive intron of the left-side mutually exclusive exon in the reference group.
* **ref\_junction\_b1**: Junction read counts of the left-side inclusive intron of the right-side mutually exclusive exon in the reference group.
* **ref\_junction\_b2**: Junction read counts of the right-side inclusive intron of the right-side mutually exclusive exon in the reference group.
* **alt\_junction\_a1**: Junction read counts of the left-side inclusive intron of the left-side mutually exclusive exon in the alternative group.
* **alt\_junction\_a2**: Junction read counts of the right-side inclusive intron of the left-side mutually exclusive exon in the alternative group.
* **alt\_junction\_b1**: Junction read counts of the left-side inclusive intron of the right-side mutually exclusive exon in the alternative group.
* **alt\_junction\_b2**: Junction read counts of the right-side inclusive intron of the right-side mutually exclusive exon in the alternative group.
* **OR\_a1b1**: Odds ratio comparing junction read counts of the left-side inclusive intron of the left-side mutually exclusive exon to those of the left-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **p\_a1b1**: *P*-value of Fisher's exact test for the junction read counts of the left-side inclusive intron of the left-side mutually exclusive exon to those of the left-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **OR\_a1b2**: Odds ratio comparing junction read counts of the left-side inclusive intron of the left-side mutually exclusive exon to those of the right-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **p\_a1b2**: Odds ratio comparing junction read counts of the left-side inclusive intron of the left-side mutually exclusive exon to those of the right-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **OR\_a2b1**: Odds ratio comparing junction read counts of the right-side inclusive intron of the left-side mutually exclusive exon to those of the left-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **p\_a2b1**: Odds ratio comparing junction read counts of the right-side inclusive intron of the left-side mutually exclusive exon to those of the left-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **OR\_a2b2**: Odds ratio comparing junction read counts of the right-side inclusive intron of the left-side mutually exclusive exon to those of the right-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **p\_a2b2**: Odds ratio comparing junction read counts of the right-side inclusive intron of the left-side mutually exclusive exon to those of the right-side inclusive intron of the right-side mutually exclusive exon, reference group against alternative group.
* **p\_maximum**: Greater of the four *P*-values of Fisher's exact tests.

---

## `PSI_RI.txt`[¶](#psi_ritxt "Permanent link")

![RI](https://github.com/Sika-Zheng-Lab/Shiba/blob/main/img/RI.png?raw=true)

Reteined intron

* **exon\_a**: Genomic coordinates of the left-side exon.
* **exon\_b**: Genomic coordinates of the right-side exon.
* **exon\_c**: Genomic coordinates of the exon containing the retained intron.
* **intron\_a**: Genomic coordinates of the retained intron.
* **ref\_junction\_a**: Junction read counts of the intron in the reference group.
* **ref\_junction\_a\_start**: The left-side exon-intron junction read counts of the retained intron in the reference group.
* **ref\_junction\_a\_end**: The right-side exon-intron junction read counts of the retained intron in the reference group.
* **alt\_junction\_a**: : Junction read counts of the intron in the alternative group.
* **alt\_junction\_a\_start**: The left-side exon-intron junction read counts of the retained intron in the alternative group.
* **alt\_junction\_a\_end**: The right-side exon-intron junction read counts of the retained intron in the alternative group.
* **OR\_junction\_a\_start**: Odds ratio comparing the left-side exon-intron junction read counts to the intron junction read counts, reference group against alternative group.
* **p\_junction\_a\_start**: *P*-value of Fisher's exact test for the left-side exon-intron junction read counts to the intron junction read counts, reference group against alternative group.
* **OR\_junction\_a\_end**: Odds ratio comparing the right-side exon-intron junction read counts to the intron junction read counts, reference group against alternative group.
* **p\_junction\_a\_end**: *P*-value of Fisher's exact test for the right-side exon-intron junction read counts to the intron junction read counts, reference group against alternative group.
* **p\_maximum**: Greater of the two *P*-values of Fisher's exact tests.

---

## `PSI_MSE.txt`[¶](#psi_msetxt "Permanent link")

![MSE](https://github.com/Sika-Zheng-Lab/Shiba/blob/main/img/MSE.png?raw=true)

Multiple skipped exons

* **mse\_n**: Number of skipped exons.
* **exon**: Genomic coordinates of the skipped exons, separated by semi-colons from the left to the right (e.g., `chr1:75790152-75790274;chr1:75790446-75790517`).
* **intron**: Genomic coordinates of the associated introns of the skipped exons, separated by semi-colons from the left to the right and the last one is the exclusive intron (e.g., `chr1:75790057-75790152;chr1:75790274-75790446;chr1:75790517-75791285;chr1:75790057-75791285`).
* **ref\_junction**: Junction read counts of the associated introns of the skipped exons in the reference group, separated by semi-colons from the left to the right and the last one is the exclusive intron (e.g., `25;20;32;489`).
* **alt\_junction**: Junction read counts of the associated introns of the skipped exons in the alternative group, separated by semi-colons from the left to the right and the last one is the exclusive intron (e.g., `386;438;703