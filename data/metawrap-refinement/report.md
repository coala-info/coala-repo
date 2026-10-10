# metawrap-refinement CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metawrap-refinement_bin_refinement | PASS | ran with --skip-checkm (no CheckM data): binning_refiner made refined bins from two B. fragilis bin sets |


## metawrap-refinement_bin_refinement

### Tool Description
metaWRAP bin_refinement module

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap:1.2--0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-refinement/overview
- **Validation**: PASS

### Original Help Text
```text
metawrap bin_refinement -h

Usage: metaWRAP bin_refinement [options] -o output_dir -A bin_folderA [-B bin_folderB -C bin_folderC]
Note: the contig names in different bin folders must be consistant (must come from the same assembly).

Options:

	-o STR          output directory
	-t INT          number of threads (default=1)
	-m INT		memory available (default=40)
	-c INT          minimum % completion of bins [should be >50%] (default=70)
	-x INT          maximum % contamination of bins that is acceptable (default=10)

	-A STR		folder with metagenomic bins (files must have .fa or .fasta extension)
	-B STR		another folder with metagenomic bins
	-C STR		another folder with metagenomic bins

	--skip-refinement	dont use binning_refiner to come up with refined bins based on combinations of binner outputs
	--skip-checkm		dont run CheckM to assess bins
	--skip-consolidation	choose the best version of each bin from all bin refinement iteration
	--keep-ambiguous	for contigs that end up in more than one bin, keep them in all bins (default: keeps them only in the best bin)
	--remove-ambiguous	for contigs that end up in more than one bin, remove them in all bins (default: keeps them only in the best bin)
	--quick			adds --reduced_tree option to checkm, reducing runtime, especially with low memory
```

