Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[gsMap documentation](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[gsMap documentation](index.html)

Contents:

* [Installation guide](install.html)
* [gsMap Tutorials](tutorials.html)[x]
* [gsMap Resources Download](data.html)
* [gsMap Command Line Alphabets](api.html)[ ]
* [Release notes](release.html)

Back to top

[View this page](_sources/10x.md.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Cases on 10x Visium Data[¶](#cases-on-10x-visium-data "Link to this heading")

Here we provide case applications based on 10x Visium data (which are not at single-cell resolution). For convenience, we used the `Quick Mode` here, but you can also follow the [Step by Step](step_by_step.html) Guide to analyze 10x Visium data—the steps are the same.

A frequently asked question is how to provide annotations for 10x Visium data. Note that gsMap can run without annotations. The most convenient approaches are to either leave the `annotation` parameter unset (in [Step by Step](step_by_step.html)) or provide annotations from spatial clustering methods, such as [SpaGCN](https://github.com/jianhuupenn/SpaGCN).

## Preparation[¶](#preparation "Link to this heading")

Make sure you have [installed](install.html) the `gsMap` package before proceeding.

### 1. Download Dependencies[¶](#download-dependencies "Link to this heading")

The `gsMap` package in quick mode requires the following resources:

* **Gene transfer format (GTF) file**, for gene coordinates on the genome.
* **LD reference panel**, in quick mode, we provide a pre-built LD score snp-by-gene matrix based on 1000G\_EUR\_Phase3.
* **SNP weight file**, to adjust correlations between SNP-trait association statistics.
* **Homologous gene transformations file** (optional), to map genes between species.

To download all the required files:

```
wget https://yanglab.westlake.edu.cn/data/gsMap/gsMap_resource.tar.gz
tar -xvzf gsMap_resource.tar.gz
```

Directory structure:

```
tree -L 2

gsMap_resource
    ├── genome_annotation
    │   ├── enhancer
    │   └── gtf
    ├── homologs
    │   ├── macaque_human_homologs.txt
    │   └── mouse_human_homologs.txt
    ├── LD_Reference_Panel
    │   └── 1000G_EUR_Phase3_plink
    ├── LDSC_resource
    │   ├── hapmap3_snps
    │   └── weights_hm3_no_hla
    └── quick_mode
        ├── baseline
        ├── SNP_gene_pair
        └── snp_gene_weight_matrix.h5ad
```

### 2. Download Example Data[¶](#download-example-data "Link to this heading")

You can download the example 10x Visium data as follows:

```
wget https://yanglab.westlake.edu.cn/data/gsMap/Visium_example_data.tar.gz
tar -xvzf Visium_example_data.tar.gz
```

Directory structure:

```
tree -L 2

Visium_example_data/
├── GWAS
│   ├── IQ_NG_2018.sumstats.gz
│   └── Serum_creatinine.sumstats.gz
└── ST
    ├── V1_Adult_Mouse_Brain_Coronal_Section.h5ad
    ├── V1_Mouse_Brain_Sagittal_Posterior_Section.h5ad
    └── V1_Mouse_Kidney.h5ad
```

## Case1[¶](#case1 "Link to this heading")

Data: Visium data of adult mouse coronal section
Trait: IQ
 Required memory: 11G (2902 cells)

```
gsmap quick_mode \
    --workdir './example_quick_mode/Visium' \
    --homolog_file 'gsMap_resource/homologs/mouse_human_homologs.txt' \
    --sample_name 'V1_Adult_Mouse_Brain_Coronal_Section' \
    --gsMap_resource_dir 'gsMap_resource' \
    --hdf5_path 'Visium_example_data/ST/V1_Adult_Mouse_Brain_Coronal_Section.h5ad' \
    --annotation 'domain' \
    --data_layer 'count' \
    --sumstats_file 'Visium_example_data/GWAS/IQ_NG_2018.sumstats.gz' \
    --trait_name 'IQ'
```

[gsMap report](https://yanglab.westlake.edu.cn/data/gsMap/Visium_report/coronal/V1_Adult_Mouse_Brain_Coronal_Section_IQ_gsMap_Report.html) for the `IQ` on the adult mouse coronal section Visium data.

## Case2[¶](#case2 "Link to this heading")

Data: Visium data of adult mouse sigital section
Trait: IQ

Required memory: 12G (3289 cells)

```
gsmap quick_mode \
    --workdir './example_quick_mode/Visium' \
    --homolog_file 'gsMap_resource/homologs/mouse_human_homologs.txt' \
    --sample_name 'V1_Mouse_Brain_Sagittal_Posterior_Section' \
    --gsMap_resource_dir 'gsMap_resource' \
    --hdf5_path 'Visium_example_data/ST/V1_Mouse_Brain_Sagittal_Posterior_Section.h5ad' \
    --annotation 'domain' \
    --data_layer 'count' \
    --sumstats_file 'Visium_example_data/GWAS/IQ_NG_2018.sumstats.gz' \
    --trait_name 'IQ'
```

[gsMap report](https://yanglab.westlake.edu.cn/data/gsMap/Visium_report/saggital/V1_Mouse_Brain_Sagittal_Posterior_Section_IQ_gsMap_Report.html) for the `IQ` on the adult mouse sigital section Visium data.

## Case3[¶](#case3 "Link to this heading")

Data: Visium data of adult mouse kindey
Trait: Serum creatinine

Required memory: 8G (1437 cells)

```
gsmap quick_mode \
    --workdir './example_quick_mode/Visium' \
    --homolog_file 'gsMap_resource/homologs/mouse_human_homologs.txt' \
    --sample_name 'V1_Mouse_Kidney' \
    --gsMap_resource_dir 'gsMap_resource' \
    --hdf5_path 'Visium_example_data/ST/V1_Mouse_Kidney.h5ad' \
    --annotation 'domain' \
    --data_layer 'count' \
    --sumstats_file 'Visium_example_data/GWAS/Serum_creatinine.sumstats.gz' \
    --trait_name 'Serum_creatinine'
```

[gsMap report](https://yanglab.westlake.edu.cn/data/gsMap/Visium_report/Serum_creatinine/V1_Mouse_Kidney_Serum_creatinine_gsMap_Report.html) for the `Serum creatinine` on the adult mouse kindey Visium data.

[Next

Data Format](data_format.html)
[Previous

gsMap Advanced Usage](advanced_usage.html)

Copyright © 2024, Liyang, Wenhao

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Cases on 10x Visium Data
  + [Preparation](#preparation)
    - [1. Download Dependencies](#download-dependencies)
    - [2. Download Example Data](#download-example-data)
  + [Case1](#case1)
  + [Case2](#case2)
  + [Case3](#case3)