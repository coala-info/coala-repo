# finestructure CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| finestructure_beagle2chromopainter | PASS |  |
| finestructure_chromopainter2chromopainterv2 | PASS |  |
| finestructure_convertrecfile | PASS |  |
| finestructure_fs | Not completed | pipeline, skipped |
| finestructure_greedy | PASS |  |
| finestructure_impute2chromopainter | PASS |  |
| finestructure_makeuniformrecfile | PASS |  |
| finestructure_msms2cp | PASS |  |
| finestructure_phasescreen | PASS |  |
| finestructure_phasesubsample | PASS |  |
| finestructure_plink2chromopainter | PASS |  |

## finestructure_fs

### Tool Description
running the whole chromopainter/finestructure inference pipeline in 'automatic' mode

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Total Downloads**: 9.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
***** Help for fs - running the whole chromopainter/finestructure inference pipeline in 'automatic' mode *****
USAGE: "fs <projectname>.cp <options> <actions>" 
GENERAL OPTIONS FOR "project" tool: 
    -h/-help:    Show this help.
    -help info: Show 'overview' help explaining how this software works.
    -help actions: Show help for all actions.
    -help parameters: Show help for all parameters.
    -help <list of commands or parameters>: Show help on any specific commands or parameters.
    -help input: Show examples and give details of the input file formats.
    -help output: Details of the files that may be created.
    -help stages: Detailed description of what happens in, and between, each stage of the computation.
    -help tools: Show help on how to access the chromopainter/chromocombine/finestructure tools directly.
    -help example: Create and show help for a simple example.
    <tool> -h: Show help on a particular tool: one of fs,cp,combine. IMPORTANT NOTE: These have simplified interfaces with different names when running in automatic mode. The help for automatic mode parameters explains which parameters it changes.
    -v      :    Verbose mode
    -n      :    New settings file, overwriting any previous file
    -<parameter>:<value> : Sets the internal parameter, exactly as if they were read in from -import. 
The colon is optional, unless <value> starts with a '-' symbol. Escape spaces and don't use quotes; 
e.g. '-s1args:-in\ -iM'.
    
IMPORTANT PARAMETERS:
idfile : IDfile location, containing the labels of each individual. REQUIRED, no default (unless -createids is used).
phasefiles : Comma or space separated list of all 'phase' files containing the (phased) SNP details for each haplotype. Required. Must be sorted alphanumerically to ensure chromosomes are correctly ordered. So don't use *.phase, use file{1..22}.phase. Override this with upper case -PHASEFILES.
recombfiles : Comma or space separated list of all recombination map files containing the recombination distance between SNPs. If provided, a linked analysis is performed. Otherwise an 'unlinked' analysis is performed. Note that linkage is very important for dense markers!
IMPORTANT ACTIONS:
   -go : Do the next things that are necessary to get a complete set of finestructure runs.
   -import <file> : Import some settings from an external file. If you need to set any non-trivial settings, this is the way to do it. See "fs -hh" for more details.
   -createid <filename> : Create an ID file from a PROVIDED phase file. Individuals are labelled IND1-IND<N>.
```

## finestructure_beagle2chromopainter

### Tool Description
Converts phased BEAGLE output to ChromoPainter-style input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text

CONVERTS PHASED BEAGLE OUTPUT TO CHROMOPAINTER-STYLE INPUT FILES
usage:   perl beagle2chromopainter.pl <options> beagle_phased_output_file output_filename_prefix
where:
        (i) beagle_phased_output_file = filename of BEAGLE v3 or less (not vcf!) phased file (unzipped) that contains phased haplotypes
        (ii) output_filename_prefix = filename prefix for chromopainter input file(s). The suffixes ".phase" amd ".ids" are added

The output, by default, is in CHROMOPAINTER v2 input format. NOTE THAT ONLY BIALLELIC SNPS ARE RETAINED, i.e. we omit triallelic and non-polymorphic sites.
<options>:
-J:                 Jitter (add 1) to snp locations if snps are not strictly ascending. Otherwise an error is produced.
<further options>   NOTE: YOU ONLY NEED THESE OPTIONS FOR BACKWARDS COMPATABILITY!
-v1:                Produce output compatible with CHROMOPAINTER v1, i.e. include the line of "S" for each SNP. 
-f:                 By default, this script produces PHASE-style output, which differs from 
			   ChromoPainter input which requires an additional first line.  This option creates the correct
		           first line for standard fineSTRUCTURE usage (i.e. the first line is "0", all other lines are appended)

 !!! WARNING:  THIS PROGRAM DOES NOT SUFFICIENTLY CHECK FOR MISSPECIFIED FILES. WE ARE NOT ACCOUNTABLE FOR THIS RUNNING INCORRECTLY !!!
NOTE: TO USE IN CHROMOPAINTER: You also need a recombination map. Create this with the "convertrecfile.pl" or "makeuniformrecfile.pl" scripts provided.
```

## finestructure_chromopainter2chromopainterv2

### Tool Description
Converts from ChromoPainter v1 format to v2.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text

CONVERTS FROM CHROMOPAINTER v1 FORMAT TO v2
usage: perl chromopainter2chromopainterv2.pl <phasefile> <outputphasefile>
with:
<phasefile>:		ChromoPainter/PHASE style SNP file
<outputphasefile>:       Output phase file

<options>:
-p <val> : Ploidy
-v: Verbose mode
```

## finestructure_convertrecfile

### Tool Description
Create recombination maps for phase files from other maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text
-----convertrecfile.pl, create recombination maps for phase files from other maps.
Copyright (C) 2014 Daniel Lawson (dan.lawson@bristol.ac.uk) licenced under GPLv3
This is free software with NO WARRANTY, you are free to distribute and modify; see http://www.gnu.org/licenses

Usage: ./convertrecfile.pl <MAJOR MODE> <options> phasefile inrecfile outputrecfile
phasefile is a valid chromopainter or chromopainter v2 inputfile ending in .phase
inrecfile is a recombination file specified in one of the formats specified in <mode>
outputrecfile will be a valid recombination file for use with ChromoPainter.
MAJOR MODES: specified with -M. (Shortest unambiguous mode option will work)
 -M: <val>:      Specify the major mode. <val> can be:
         hapmap: The hapmap format is specified as 4 columns: chromosome, Position(BP) Rate(cM/Mb) Map(cM)
                 This uses columns 2 and 4 to reconstruct the map.
         plain:  (default) Assumes that the data are specified in 2 columns, Position(BP) Rate(M/b)
                 This is the mode assumed chromopainter (note: the rate is Morgans per base).
Other important options:
 -v:	        Verbose mode.
 -h:             This help.
 -H:             Detailed help on the wide variety of different options, including different column
                 separators, different units, reading of Culmulative vs non-culmulative distributions,
                 and handling maps that do not cover the full range of the SNPs.
EXAMPLE: ./convertrecfile.pl -M hap my_chr1.phase genetic_map_GRCh37_chr1.txt my_chr1.recombfile
```

## finestructure_impute2chromopainter

### Tool Description
Converts phased SHAPEIT/IMPUTE2 output to ChromoPainter-style input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text

CONVERTS PHASED SHAPEIT/IMPUTE2 OUTPUT TO CHROMOPAINTER-STYLE INPUT FILES
usage:   perl impute2chromopainter.pl <options> impute_output_file.haps output_filename_prefix
where:
        (i) impute_output_file.haps = filename of IMPUTE2 output file with suffix ".haps" that contains phased haplotypes
        (ii) output_filename_prefix = filename prefix for chromopainter input file(s). The suffix ".phase" is added

The output, by default, is in CHROMOPAINTER v2 input format.
<options>:
-J:                 Jitter (add 1) snp locations if snps are not strictly ascending. Otherwise an error is produced.
<further options>   NOTE: YOU ONLY NEED THESE OPTIONS FOR BACKWARDS COMPATABILITY!
-v1:                Produce output compatible with CHROMOPAINTER v1, i.e. include the line of "S" for each SNP. 
-f:                 By default, this script produces PHASE-style output, which differs from 
			   ChromoPainter input which requires an additional first line.  This option creates the correct
		           first line for standard fineSTRUCTURE usage (i.e. the first line is "0", all other lines are appended)

NOTE: TO USE IN CHROMOPAINTER: You also need a recombination map. Create this with the "convertrecfile.pl" or "makeuniformrecfile.pl" scripts provided.

 !!! WARNING:  THIS PROGRAM DOES NOT SUFFICIENTLY CHECK FOR MISSPECIFIED FILES. WE ARE NOT ACCOUNTABLE FOR THIS RUNNING INCORRECTLY !!!
```

## finestructure_makeuniformrecfile

### Tool Description
Create a uniform recombination file for a ChromoPainter phase file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text
Usage ./makeuniformrecfile.pl <phasefile> <outputfile>
     <phasefile> is a valid chromopainter inputfile ending in .phase (in ChromoPainter v1 or v2 format) 
     <outputfile> will be a recombination file usable with <phasefile> in ChromoPainter, nominally in Morgans/base.
The recombination rate is scaled to be approximately that in humans (0.1 Morgans/Mb). Because of this, it will NOT be usable directly and should only ever be used in conjunction with EM parameter estimation, which corrects for the global amount of recombination. If you are working on non-humans or simulated data, you may experience problems with EM estimation. The parameter may get stuck at a local mode where there is effectively infinite (or no) recombination. In this case, you should specify the initial conditions of ChromoPainter to have a much smaller or larger Ne (-n) value.
```

## finestructure_msms2cp

### Tool Description
Converts MSMS/SCRM/MS output to ChromoPainter-style input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text
CONVERTS MSMS/SCRM/MS OUTPUT TO CHROMOPAINTER-STYLE INPUT FILES
usage:   perl msms2cp.pl <options> msmsoutput.txt output_filename_prefix

OPTIONS
-c1    : Output chromopainter version1 format
-n <x> : Multiplier for the SNP locations (default: 1000000)
-p <x> : Specify the ploidy (default:2 for diploid; needed only for CP version 1)
-ms <x>: Specify ms mode, and give the number of *haplotypes* in it (because ms doesn't include this in the header)
-v     : Verbose mode
```

## finestructure_phasescreen

### Tool Description
Remove singletons or non-SNPs from phase data.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text

REMOVE SINGLETONS OR NON-SNPS FROM PHASE DATA
usage:   perl phasesscreen.pl <phasefile> <outputphasefile>
```

## finestructure_phasesubsample

### Tool Description
Extracts a SNP range from phase (ChromoPainter) format.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text
EXTRACTS SNP RANGE FROM PHASE (CHROMOPAINTER) FORMAT
usage:   perl phasesubsample.pl <options> <from> <to> <phasefile> <outputphasefile>
Extract the SNPs [from to] inclusive, i.e. 1 2 extracts the 1st and 2nd SNPs.
where:
<from>:		First SNP to retain (1 is the first snp)
<to>:		Final SNP to retain (L is the last snp)
<phasefile>:		ChromoPainter/PHASE style SNP file, i.e. 
<outputphasefile>:       Output phase file

<options>:
-v: Verbose mode
NB Compatible with chromopainter and chromopainterv2 phase formats. Updated 6th June 2017 to fix an out-by-one error.
```

## finestructure_plink2chromopainter

### Tool Description
Convert PLINK ped/map files to a ChromoPainter phase file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: ./plink2chromopainter.pl -p=pedfile -m=mapfile -o=phasefile 
		[-d=idfile] [-f] [-g=chromosomegap] [--quiet] [--asis]

pedfile is a valid PLINK ped inputfile (DIPLOID)
mapfile is a valid PLINK map file
phasefile will be a valid chromopainter phase file (ChromoPainter's -g switch)
	(i.e. a fastphase file with an additional header line)
idfile is OPTIONAL and simply stores the list of individual names (ChromoPainter's -t switch, but without the optional population and inclusion columns)
YOU STILL NEED TO CREATE A RECOMBINATION FILE; either with convertrecfile.pl or makeuniformrecfile.pl.
-f: Specify that the IDS from the FIRST column of the ped file (the family ID) should be used. The default is try the second and fall back to the first.
-g chromosomegap (=10e6 by default) is the gap in BP placed between different chromosomes
-a or --asis assume the SNPs are stored as 0/1 rather than 1/2 (default plink behaviour)
-q or --quiet reduces the amount of screen output
IMPORTANT: You should use the --recode12 option in plink
MORE HELP ON FILE FORMATS: ./plink2chromopainter.pl -h
```

## finestructure_greedy

### Tool Description
Greedy maximisation using fineSTRUCTURE.

### Metadata
- **Docker Image**: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
- **Homepage**: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
- **Package**: https://anaconda.org/channels/bioconda/packages/finestructure/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: finestructuregreedy.sh: [-r] [-R] [-d] [-m value] [-x value] [-t value] [-a value] [-f value] datafile outputfile
Essentials: datafile and outputfile
Important flags are -m and -x
  -m value: sets the number of repeated FineSTRUCTURE runs to perform before giving in. (default: 20)
  -x value: sets the number of FineSTRUCTURE iterations to perform per step (finestructure -x flag). (default: 50000)
  -t value: (finestructure -t flag). (default: t=100000000, i.e. effectively infinite. careful, this may be slow)
  -a value: finestructure flags to be passed to all runs, e.g. "-X -Y". Quotes essential! Usually not needed. (default: "")
  -f value: set the location of the finestructure executable (default: finestructure)
  -r: when set, temporary files are replaced. without this you can run more iterations by changing -m and -x
  -R: when set, the final tree file is deleted if present. Default is to not run.
  -d: perform a dry run but don't actually do anything. Useful to see the fineSTRUCTURE arguments sued in each step.
```

