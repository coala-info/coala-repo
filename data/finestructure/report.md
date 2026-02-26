# finestructure CWL Generation Report

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

