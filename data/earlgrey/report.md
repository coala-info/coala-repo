# earlgrey CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| earlgrey_earlGreyAnnotationOnly | Not completed | pipeline, skipped |

## earlgrey_earlGreyAnnotationOnly

### Tool Description
earlGrey version 7.0.2 (AnnotationOnly)

### Metadata
- **Docker Image**: quay.io/biocontainers/earlgrey:7.0.2--hd63eeec_0
- **Homepage**: https://github.com/TobyBaril/EarlGrey
- **Package**: https://anaconda.org/channels/bioconda/packages/earlgrey/overview
- **Validation**: PASS

### Original Help Text
```text
)  (
	     (   ) )
	     ) ( (
	   _______)_
	.-'---------|  
       ( C|/\/\/\/\/|
	'-./\/\/\/\/|
	  '_________'
	   '-------'
	<<< Checking Parameters >>>
	#############################
	earlGrey version 7.0.2 (AnnotationOnly)
	Required Parameters:
		-g == genome.fasta
		-s == species name
		-o == output directory
        -l == Starting consensus library for annotation (in fasta format)

	Optional Parameters:
		-t == Number of Threads (DO NOT specify more than are available)
       	-r == RepeatMasker species for addition to custom library (Default: None)
		-m == Remove putative spurious TE annotations <100bp? (yes/no, Default: no)
		-d == Create soft-masked genome at the end? (yes/no, Default: no)
		-e == Run HELIANO as an optional step to detect Helitrons (yes/no, Default: no)
		-h == Show help

	Example Usage:

	earlGreyAnnotationOnly -g bombyxMori.fasta -s bombyxMori -o /home/toby/bombyxMori/repeatAnnotation/ -l bombyx-families.fa.strained -t 16

	Queries can be sent to:
	tobias.baril[at]unine.ch

	Please make use of the GitHub Issues and Discussion Tabs at: https://github.com/TobyBaril/EarlGrey
	#############################
```


## Metadata
- **Skill**: generated
