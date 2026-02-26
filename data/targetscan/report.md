# targetscan CWL Generation Report

## targetscan_targetscan_70.pl

### Tool Description
Search for predicted miRNA targets using the modified TargetScanS algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/targetscan:7.0--pl5321hdfd78af_0
- **Homepage**: https://www.targetscan.org/vert_80/
- **Package**: https://anaconda.org/channels/bioconda/packages/targetscan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/targetscan/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Description: Search for predicted miRNA targets
		     using the modified TargetScanS algorithm. 

	USAGE:
		/usr/local/bin/targetscan_70.pl miRNA_file UTR_file PredictedTargetsOutputFile

	Required input files:
		miRNA_file    => miRNA families by species
		UTR_file      => Aligned UTRs		

	Output file:
		PredictedTargetsOutputFile    => Lists sites using alignment coordinates (MSA and UTR)

	For a description of input file formats, type
		/usr/local/bin/targetscan_70.pl -h

	Author: George W. Bell, Bioinformatics and Research Computing
	Version: 7.0
	Copyright (c) The Whitehead Institute of Biomedical Research 


	** Required input files:
	
	1 - miRNA_file    => miRNA families by species
		
		contains three fields (tab-delimited):
			a. miRNA family ID/name
			b. seed region (7mer) for this miRNA
			c. semicolon-delimited list of species IDs in which this miRNA has been annotated
		ex:	   
		let-7/98	GAGGUAG	9606;10090;10116
		miR-127/127-3p	GAGGUAG	9606;10090
		
		Each miRNA family should be represented in a single line.
		
	2 - UTR_file      => Aligned UTRs		

		contains three fields (tab-delimited):
			a. Gene/UTR ID or name
			b. Species ID for this gene/UTR (must match ID in miRNA file)
			c. Aligned UTR or gene (with gaps from alignment)
		ex:
		BMP8B	9606	GUCCACCCGCCCGGC
		BMP8B	9615	-GUG--CUGCCCACC
		
		A gene will typically be represented on multiple adjacent lines.
```

