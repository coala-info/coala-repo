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

[View this page](_sources/advanced_usage.md.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# gsMap Advanced Usage[¶](#gsmap-advanced-usage "Link to this heading")

## Using Customized Latent Representations[¶](#using-customized-latent-representations "Link to this heading")

```
# This could be any key in the obsm field of the AnnData object.
latent_customized = 'latent_customized'
gsmap run_latent_to_gene \
    --input_hdf5_path 'sample1.h5ad' \
    --workdir './workdir' \
    --sample_name 'sample1' \
    --annotation 'annotation' \
    --latent_representation $latent_customized
```

## Conditional Analysis[¶](#conditional-analysis "Link to this heading")

**Objective**: Perform conditional analysis by adjusting for other functional annotations or cell-type-level annotations.

This step extends `step 3: generate ldscore`, by adding additional functional annotations to the baseline with the aim of conducting a conditional analysis. The directory of additional annotations can be specified using the parameter `--additional_baseline_annotation`. The other steps are same to the tutorials above.

Download the additional annotations:

```
wget https://yanglab.westlake.edu.cn/data/gsMap/gsMap_additional_annotation.tar.gz
tar -xvzf gsMap_additional_annotation.tar.gz
```

The format of the additional annotation files is such that each line represents a SNP, with columns indicating the annotation values for that SNP. These values can be either binary or continuous.

```
zless -S gsMap_additional_annotation/baseline.1.annot.gz
```

**Execution**:  required memory: ~50G

```
for CHROM in {1..22}
do
    gsmap run_generate_ldscore \
        --workdir './example/Mouse_Embryo' \
        --sample_name 'E16.5_E1S1.MOSTA' \
        --chrom $CHROM \
        --bfile_root 'gsMap_resource/LD_Reference_Panel/1000G_EUR_Phase3_plink/1000G.EUR.QC' \
        --keep_snp_root 'gsMap_resource/LDSC_resource/hapmap3_snps/hm' \
        --gtf_annotation_file 'gsMap_resource/genome_annotation/gtf/gencode.v46lift37.basic.annotation.gtf' \
        --gene_window_size 50000 \
        --additional_baseline_annotation 'gsMap_additional_annotation'
done
```

## gsMap on Biological Replicates[¶](#gsmap-on-biological-replicates "Link to this heading")

**Objective**: When multiple biological replicates are available, a uniform slice mean can be calculated for the gene ranks across the samples. This slice mean rank can then be used to compute the GSS. This approach ensures more consistent and comparable results across different samples.

### Calculate the Slice Mean[¶](#calculate-the-slice-mean "Link to this heading")

To generate the slice mean, use the `create_slice_mean` command. This command outputs a parquet file containing the slice mean ranks for each gene. The `--sample_name_list` parameter specifies the names of the samples, and the `--h5ad_list` parameter provides the paths to the AnnData objects for each sample.

```
gsmap create_slice_mean \
    --sample_name_list 'E16.5_E1S1.MOSTA' 'E16.5_E2S11.MOSTA' \
    --h5ad_list 'gsMap_example_data/ST/E16.5_E1S1.MOSTA.h5ad' 'gsMap_example_data/ST/E16.5_E2S11.MOSTA.h5ad' \
    --slice_mean_output_file './workdir/sample_slice_mean.parquet' \
    --data_layer 'count' \
    --homolog_file 'gsMap_resource/homologs/mouse_human_homologs.txt'
```

### Use the Slice Mean in Quick Mode[¶](#use-the-slice-mean-in-quick-mode "Link to this heading")

The `quick_mode` command allows you to run the entire pipeline in a single step using the slice mean. The `--gM_slices` parameter specifies the path to the slice mean file generated in the previous step.

```
# For the 'E16.5_E1S1.MOSTA' sample (the same applies to 'E16.5_E2S11.MOSTA')
gsmap quick_mode \
    --workdir './workdir' \
    --homolog_file 'gsMap_resource/homologs/mouse_human_homologs.txt' \
    --sample_name 'E16.5_E1S1.MOSTA' \
    --gsMap_resource_dir 'gsMap_resource' \
    --hdf5_path 'gsMap_example_data/ST/E16.5_E1S1.MOSTA.h5ad' \
    --annotation 'annotation' \
    --data_layer 'count' \
    --sumstats_file 'gsMap_example_data/GWAS/IQ_NG_2018.sumstats.gz' \
    --trait_name 'IQ' \
    --gM_slices './workdir/sample_slice_mean.parquet'
```

### Use the Slice Mean in Step-by-Step Mode[¶](#use-the-slice-mean-in-step-by-step-mode "Link to this heading")

To incorporate the slice mean into the step-by-step pipeline, provide the slice mean file using the `--gM_slices` parameter in the `run_latent_to_gene` command. This enables the computation of gene specificity scores based on the slice mean.

```
# For the 'E16.5_E1S1.MOSTA' sample (the same applies to 'E16.5_E2S11.MOSTA')
gsmap run_latent_to_gene \
    --workdir './workdir' \
    --sample_name 'E16.5_E1S1.MOSTA' \
    --annotation 'annotation' \
    --latent_representation 'latent_GVAE' \
    --num_neighbour 51 \
    --num_neighbour_spatial 201 \
    --homolog_file 'gsMap_resource/homologs/mouse_human_homologs.txt' \
    --gM_slices './workdir/sample_slice_mean.parquet'
```

### Cauchy combination for multiple samples[¶](#cauchy-combination-for-multiple-samples "Link to this heading")

Use the `run_cauchy_combination` command to aggregate the spot p-values for the same annotation across multiple samples.

```
gsmap run_cauchy_combination \
    --workdir './workdir' \
    --sample_name_list 'E16.5_E1S1.MOSTA' 'E16.5_E2S11.MOSTA' \
    --trait_name 'IQ' \
    --annotation 'annotation' \
    --output_file './workdir/combined_IQ_cauchy_combination.csv.gz'
```

[Next

Cases on 10x Visium Data](10x.html)
[Previous

Mouse Embryo (Step by Step)](step_by_step.html)

Copyright © 2024, Liyang, Wenhao

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* gsMap Advanced Usage
  + [Using Customized Latent Representations](#using-customized-latent-representations)
  + [Conditional Analysis](#conditional-analysis)
  + [gsMap on Biological Replicates](#gsmap-on-biological-replicates)
    - [Calculate the Slice Mean](#calculate-the-slice-mean)
    - [Use the Slice Mean in Quick Mode](#use-the-slice-mean-in-quick-mode)
    - [Use the Slice Mean in Step-by-Step Mode](#use-the-slice-mean-in-step-by-step-mode)
    - [Cauchy combination for multiple samples](#cauchy-combination-for-multiple-samples)