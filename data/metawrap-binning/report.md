# metawrap-binning CWL Generation Report

## metawrap-binning_metawrap

### Tool Description
Please select a proper module of metaWRAP.

### Metadata
- **Docker Image**: quay.io/biocontainers/metawrap-binning:1.3.0
- **Homepage**: https://github.com/bxlab/metaWRAP
- **Package**: https://anaconda.org/channels/bioconda/packages/metawrap-binning/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metawrap-binning/overview
- **Total Downloads**: 104
- **Last updated**: 2025-10-30
- **GitHub**: https://github.com/bxlab/metaWRAP
- **Stars**: N/A
### Original Help Text
```text
------------------------------------------------------------------------------------------------------------------------
-----                                  Please select a proper module of metaWRAP.                                  -----
------------------------------------------------------------------------------------------------------------------------


MetaWRAP v=1.3.0
Usage: metaWRAP [module]

	Modules:
	read_qc		Raw read QC module (read trimming and contamination removal)
	assembly	Assembly module (metagenomic assembly)
	kraken		KRAKEN module (taxonomy annotation of reads and assemblies)
	blobology	Blobology module (GC vs Abund plots of contigs and bins)

	binning		Binning module (metabat, maxbin, or concoct)
	bin_refinement	Refinement of bins from binning module
	reassemble_bins Reassemble bins using metagenomic reads
	quant_bins	Quantify the abundance of each bin across samples
	classify_bins	Assign taxonomy to genomic bins
	annotate_bins	Functional annotation of draft genomes

	--help | -h		show this help message
	--version | -v	show metaWRAP version
	--show-config	show where the metawrap configuration files are stored
```

