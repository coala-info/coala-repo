# abritamr CWL Generation Report

## abritamr_run

### Tool Description
Run AMR detection using abritamr and amrfinderplus

### Metadata
- **Docker Image**: quay.io/biocontainers/abritamr:1.0.20--pyh5707d69_0
- **Homepage**: https://github.com/MDU-PHL/abritamr
- **Package**: https://anaconda.org/channels/bioconda/packages/abritamr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abritamr/overview
- **Total Downloads**: 32.8K
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/MDU-PHL/abritamr
- **Stars**: N/A
### Original Help Text
```text
usage: abritamr run [-h] [--contigs CONTIGS] [--prefix PREFIX] [--jobs JOBS]
                    [--identity IDENTITY] [--amrfinder_db AMRFINDER_DB]
                    [--species {Acinetobacter_baumannii,Burkholderia_cepacia,Burkholderia_pseudomallei,Burkholderia_mallei,Campylobacter,Citrobacter_freundii,Clostridioides_difficile,Corynebacterium_diphtheriae,Enterobacter_asburiae,Enterobacter_cloacae,Enterococcus_faecalis,Enterococcus_faecium,Escherichia,Klebsiella_oxytoca,Klebsiella_pneumoniae,Neisseria_gonorrhoeae,Neisseria_meningitidis,Pseudomonas_aeruginosa,Salmonella,Serratia_marcescens,Staphylococcus_aureus,Staphylococcus_pseudintermedius,Streptococcus_agalactiae,Streptococcus_pneumoniae,Streptococcus_pyogenes,Vibrio_cholerae,Vibrio_vulfinicus,Vibrio_parahaemolyticus}]

options:
  -h, --help            show this help message and exit
  --contigs, -c CONTIGS
                        Tab-delimited file with sample ID as column 1 and path
                        to assemblies as column 2 OR path to a contig file
                        (used if only doing a single sample - should provide
                        value for -pfx). (default: )
  --prefix, -px PREFIX  If running on a single sample, please provide a prefix
                        for output directory (default: abritamr)
  --jobs, -j JOBS       Number of AMR finder jobs to run in parallel.
                        (default: 16)
  --identity, -i IDENTITY
                        Set the minimum identity of matches with amrfinder (0
                        - 1.0). Defaults to amrfinder preset, which is 0.9
                        unless a curated threshold is present for the gene.
                        (default: )
  --amrfinder_db, -d AMRFINDER_DB
                        Path to amrfinder DB to use (default:
                        /usr/local/lib/python3.14/site-
                        packages/abritamr/db/amrfinderplus/data/2024-07-22.1)
  --species, -sp {Acinetobacter_baumannii,Burkholderia_cepacia,Burkholderia_pseudomallei,Burkholderia_mallei,Campylobacter,Citrobacter_freundii,Clostridioides_difficile,Corynebacterium_diphtheriae,Enterobacter_asburiae,Enterobacter_cloacae,Enterococcus_faecalis,Enterococcus_faecium,Escherichia,Klebsiella_oxytoca,Klebsiella_pneumoniae,Neisseria_gonorrhoeae,Neisseria_meningitidis,Pseudomonas_aeruginosa,Salmonella,Serratia_marcescens,Staphylococcus_aureus,Staphylococcus_pseudintermedius,Streptococcus_agalactiae,Streptococcus_pneumoniae,Streptococcus_pyogenes,Vibrio_cholerae,Vibrio_vulfinicus,Vibrio_parahaemolyticus}
                        Set if you would like to use point mutations, please
                        provide a valid species. (default: )
```


## abritamr_report

### Tool Description
Generate reports for abritamr results

### Metadata
- **Docker Image**: quay.io/biocontainers/abritamr:1.0.20--pyh5707d69_0
- **Homepage**: https://github.com/MDU-PHL/abritamr
- **Package**: https://anaconda.org/channels/bioconda/packages/abritamr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: abritamr report [-h] [--qc QC] [--runid RUNID] [--matches MATCHES]
                       [--partials PARTIALS] [--sop {general,plus}]
                       [--sop_name SOP_NAME]

options:
  -h, --help            show this help message and exit
  --qc, -q QC           Name of checked MDU QC file. (default: )
  --runid, -r RUNID     MDU RunID (default: Run ID)
  --matches, -m MATCHES
                        Path to matches, concatentated output of abritamr
                        (default: summary_matches.txt)
  --partials, -p PARTIALS
                        Path to partial matches, concatentated output of
                        abritamr (default: summary_partials.txt)
  --sop {general,plus}  The pipeline for reporting results. (default: general)
  --sop_name SOP_NAME   The name of the process - will be reflected in the
                        names od the output files. (default: )
```


## abritamr_update_db

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/abritamr:1.0.20--pyh5707d69_0
- **Homepage**: https://github.com/MDU-PHL/abritamr
- **Package**: https://anaconda.org/channels/bioconda/packages/abritamr/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[31;1m[CRITICAL:02/24/2026 04:19:58 AM] It seems that /usr/local/lib/python3.14/site-packages/abritamr/db/update_vars.json does not exist. Please check your installation and try again.[0m
```


## Metadata
- **Skill**: generated
