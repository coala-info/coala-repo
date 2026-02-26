# maaslin2 CWL Generation Report

## maaslin2_Maaslin2.R

### Tool Description
Maaslin2 is a tool for analyzing microbiome compositional data.

### Metadata
- **Docker Image**: quay.io/biocontainers/maaslin2:1.16.0--r43hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/maaslin2
- **Package**: https://anaconda.org/channels/bioconda/packages/maaslin2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maaslin2/overview
- **Total Downloads**: 13.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/Maaslin2.R [options]  <data.tsv>  <metadata.tsv>  <output_folder>


Options:
	-h, --help
		Show this help message and exit

	-a MIN_ABUNDANCE, --min_abundance=MIN_ABUNDANCE
		The minimum abundance for each feature[ Default: 0 ]

	-p MIN_PREVALENCE, --min_prevalence=MIN_PREVALENCE
		The minimum percent of samples for whicha feature is detected at minimum abundance[ Default: 0.1 ]

	-b MIN_VARIANCE, --min_variance=MIN_VARIANCE
		Keep features with variancesgreater than value[ Default: 0 ]

	-s MAX_SIGNIFICANCE, --max_significance=MAX_SIGNIFICANCE
		The q-value threshold for significance[ Default: 0.25 ]

	-n NORMALIZATION, --normalization=NORMALIZATION
		The normalization method to apply [ Default: TSS ] [ Choices: TSS, CLR, CSS, NONE, TMM ]

	-t TRANSFORM, --transform=TRANSFORM
		The transform to apply [ Default: LOG ] [ Choices: LOG, LOGIT, AST, NONE ]

	-m ANALYSIS_METHOD, --analysis_method=ANALYSIS_METHOD
		The analysis method to apply [ Default: LM ] [ Choices: LM, CPLM, NEGBIN, ZINB ]

	-r RANDOM_EFFECTS, --random_effects=RANDOM_EFFECTS
		The random effects for the model,  comma-delimited for multiple effects [ Default: none ]

	-f FIXED_EFFECTS, --fixed_effects=FIXED_EFFECTS
		The fixed effects for the model, comma-delimited for multiple effects [ Default: all ]

	-c CORRECTION, --correction=CORRECTION
		The correction method for computing the q-value [ Default: BH ]

	-z STANDARDIZE, --standardize=STANDARDIZE
		Apply z-score so continuous metadata are on the same scale [ Default: TRUE ]

	-l PLOT_HEATMAP, --plot_heatmap=PLOT_HEATMAP
		Generate a heatmap for the significant associations [ Default: TRUE ]

	-i HEATMAP_FIRST_N, --heatmap_first_n=HEATMAP_FIRST_N
		In heatmap, plot top N features with significant associations [ Default: 50 ]

	-o PLOT_SCATTER, --plot_scatter=PLOT_SCATTER
		Generate scatter plots for the significant associations [ Default: TRUE ]

	-g MAX_PNGS, --max_pngs=MAX_PNGS
		The maximum number of scatterplots for signficant associations to save as png files [ Default: 10 ]

	-O SAVE_SCATTER, --save_scatter=SAVE_SCATTER
		Save all scatter plot ggplot objects to an RData file [ Default: FALSE ]

	-e CORES, --cores=CORES
		The number of R processes to  run in parallel [ Default: 1 ]

	-j SAVE_MODELS, --save_models=SAVE_MODELS
		Return the full model outputs  and save to an RData file [ Default: FALSE ]

	-d REFERENCE, --reference=REFERENCE
		The factor to use as a reference for a variable with more than two levels provided as a string of 'variable,reference' semi-colon delimited for multiple variables [ Default: NA ]
```

