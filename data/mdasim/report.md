# mdasim CWL Generation Report

## mdasim

### Tool Description
mdasim

### Metadata
- **Docker Image**: quay.io/biocontainers/mdasim:2.1.1--hf316886_7
- **Homepage**: https://sourceforge.net/projects/mdasim/
- **Package**: https://anaconda.org/channels/bioconda/packages/mdasim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mdasim/overview
- **Total Downloads**: 25.7K
- **Last updated**: 2025-08-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: mdasim [optional args] --input=<input.fa> --output=<mda-amplified_fasta_prefix> --primers=<primers.fasta>

Note: The above used arguments have defaults, but it is recommended to explicitly set them.
Note: Arguments that require a value are marked with an '=' sign below. This needs to be used 
      between the argument and the value on the command line.


	-l,--log                = file name for a log file of all single nucleotide errors that happen during amplification
	-m,--mutationrate       = chance of a nucleotide substitution
	-V,--version              prints the version
	-h,--help                 shows this help
	-v,--verbose              extended verbose for debug mode
	-I,--input              = file name of reference DNA sequence (default: reference.fasta)
	-O,--output             = output files prefix , `Amplicons.fasta` will be appended to the prefix (default: out)
	-o,--outputfragments      writes the lists of fragments and primer positions at the end of simulation in two txt files suffixed by Fragments.txt and PrimerPositions.txt
	-P,--primers            = file name of input primers in fasta format (default: primerList.fasta)
	-p,--primerNo           = average number of initial available primers (default: input reference length * coverage / frgLngth * 1000)
	-L,--frgLngth           = average number of synthesized bases per phi29 (default: 70,000 nt; synthesized bases per phi29 has uniform distribution; variance = frgLngth^2 / 1200)
	-C,--coverage           = expected average coverage (default: 1000)
	-s,--stepSize           = number of synthesized bases per phi29 in each step (default: 10000)
	-A,--alpha              = normalized number of primers attached in each step (default: 0.5e-11)
	-a,--attachNum          = number of primers attached per single strand of reference sequence in the first step. It can be any positive number. (overrides -A; alpha = attachNum / (input reference length * primerNo))
	-R,--readLength         = minimum length of output amplicons (default: 10)
	-S,--single               Input reference is amplified as a single strand sequence
```


## Metadata
- **Skill**: generated
