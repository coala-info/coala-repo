# seacr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seacr | Failed | image problem: the image has no bedtools, so the control bedgraph mode crashes (SEACR_1.3.sh: bedtools: command not found); numeric threshold mode matched Galaxy output (46 peaks) |

## seacr

### Tool Description
SEACR is a highly selective peak caller for CUT&RUN tool that uses the global distribution of background signal to determine a threshold for peak calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/seacr:1.3--hdfd78af_2
- **Homepage**: https://github.com/FredHutch/SEACR
- **Package**: https://anaconda.org/channels/bioconda/packages/seacr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seacr/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FredHutch/SEACR
- **Stars**: N/A
### Original Help Text
```text

	SEACR: Sparse Enrichment Analysis for CUT&RUN
	
	Usage: bash SEACR_1.3.sh <experimental bedgraph>.bg [<control bedgraph>.bg | <FDR threshold>] [norm | non] [relaxed | stringent] output prefix
	
	Description of input fields:
	
	Field 1: Target data bedgraph file in UCSC bedgraph format (https://genome.ucsc.edu/goldenpath/help/bedgraph.html) that omits regions containing 0 signal.
	
	Field 2: Control (IgG) data bedgraph file to generate an empirical threshold for peak calling. Alternatively, a numeric threshold n between 0 and 1 returns the top n fraction of peaks based on total signal within peaks.
	
	Field 3: “norm” denotes normalization of control to target data, “non” skips this behavior. norm is recommended unless experimental and control data are already rigorously normalized to each other (e.g. via spike-in).
		
	Field 4: “relaxed” uses a total signal threshold between the knee and peak of the total signal curve, and corresponds to the “relaxed” mode described in the text, whereas “stringent” uses the peak of the curve, and corresponds to “stringent” mode.
	
	Field 5: Output prefix
	
	Output file:
	<output prefix>.auc.threshold.merge.bed (Bed file of enriched regions)
	
	Output data structure: 
	
	<chr>	<start>	<end>	<AUC>	<max signal>	<max signal region>
	
	Description of output fields:
	Field 1: Chromosome
	
	Field 2: Start coordinate
	
	Field 3: End coordinate
	
	Field 4: Total signal contained within denoted coordinates
	
	Field 5: Maximum bedgraph signal attained at any base pair within denoted coordinates
	
	Field 6: Region representing the farthest upstream and farthest downstream bases within the denoted coordinates that are represented by the maximum bedgraph signal
	
	Examples:
	bash SEACR_1.3.sh target.bedgraph IgG.bedgraph norm stringent output
	Calls enriched regions in target data using normalized IgG control track with stringent threshold
	
	bash SEACR_1.3.sh target.bedgraph IgG.bedgraph non relaxed output
	Calls enriched regions in target data using non-normalized IgG control track with relaxed threshold
	bash SEACR_1.3.sh target.bedgraph 0.01 non stringent output
	Calls enriched regions in target data by selecting the top 1% of regions by area under the curve (AUC)
```

## Metadata
- **Skill**: generated

