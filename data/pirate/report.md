# pirate CWL Generation Report

## pirate_PIRATE

### Tool Description
PIRATE input/output:

### Metadata
- **Docker Image**: quay.io/biocontainers/pirate:1.0.5--hdfd78af_3
- **Homepage**: https://github.com/SionBayliss/PIRATE
- **Package**: https://anaconda.org/channels/bioconda/packages/pirate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pirate/overview
- **Total Downloads**: 14.8K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/SionBayliss/PIRATE
- **Stars**: N/A
### Original Help Text
```text
- ERROR: no input (-i) directory specified.
Usage:
            PIRATE -i /path/to/directory/containing/gffs/ 

     PIRATE input/output:
     -i|--input     input directory containing gffs [mandatory]
     -o|--output    output directory in which to create PIRATE folder 
                    [default: input_dir/PIRATE]

     Global:
     -s|--steps     % identity thresholds to use for pangenome construction
                    [default: 50,60,70,80,90,95,98]
     -f|--features  choose features to use for pangenome construction. 
                    Multiple may be entered, seperated by a comma [default: CDS]
     -n|--nucl      CDS are not translated to AA sequence [default: off]
     --pan-opt      additional arguments to pass to pangenome_contruction   
     --pan-off      don't run pangenome tool [assumes PIRATE has been previously
                    run and resulting files are present in output folder]
     --min-len      minimum length for feature extraction [default: 120]

     Paralog classification:
     --para-off     switch off paralog identification [default: on]
     --para-args    options to pass to paralog splitting algorithm
                    [default: none] 
     --classify-off do not classify paralogs, assumes this has been
                    run previously [default: on]

     Output:
     -a|--align     align all genes and produce core/pangenome alignments 
                    [default: off]
     -r|--rplots    plot summaries using R [requires dependencies]

     Usage:
     -t|--threads   number of threads/cores used by PIRATE [default: 2]
     -q|--quiet     switch off verbose
     -z             retain intermediate files [0 = none, 1 = retain pangenome 
                    files (default - re-run using --pan-off), 2 = all]  
     -c|--check     check installation and run on example files
     --check-n      check installation and run on example files using --nucl
     -h|--help      usage information
```


## pirate_subsample_outputs.pl

### Tool Description
Subsamples PIRATE gene family files based on GFFs and isolates.

### Metadata
- **Docker Image**: quay.io/biocontainers/pirate:1.0.5--hdfd78af_3
- **Homepage**: https://github.com/SionBayliss/PIRATE
- **Package**: https://anaconda.org/channels/bioconda/packages/pirate/overview
- **Validation**: PASS

### Original Help Text
```text
- ERROR: no input file specified
Usage:
     subsample_outputs.pl -i /path/to/PIRATE.*.tsv -g /path/to/gff_directory/  -o /path/to/output_file

     Input-Output:  
     -i|--input             input PIRATE.gene_families.tsv file [required]
     -g|--gffs              path to gff directory [required]
     -o|--output    path to output file [required]
 
     Options
     --feature              feature type to include [default: CDS]
     --field                replace locus tag with value from field [default: off] 
     --list         list of isolates to include in output [default: off]
 
     General:
     -h|--help              usage information
```

