# coinfinder CWL Generation Report

## coinfinder

### Tool Description
File input- specify either: The path to the gene_presence_absence.csv output from Roary -or- The path of the Gene-to-Genome file with (gene)(TAB)(genome)

### Metadata
- **Docker Image**: quay.io/biocontainers/coinfinder:1.2.1--py39hb8976ed_3
- **Homepage**: https://github.com/fwhelan/coinfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/coinfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coinfinder/overview
- **Total Downloads**: 53.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fwhelan/coinfinder
- **Stars**: N/A
### Original Help Text
```text
./confinder [OPTIONS]
File input- specify either: 
    -i or --input          The path to the gene_presence_absence.csv output from Roary
                           -or-
                           The path of the Gene-to-Genome file with (gene)(TAB)(genome)
    -I or --inputroary     Set if -i is in the gene_presence_absence.csv format from Roary
    -p or --phylogeny      Phylogeny of Betas in Newick format (required)
Max mode (mandatory for coincidence analysis):
    -a or --associate      Overlap; identify groups that tend to associate/co-occur (default).
    -d or --dissociate     Separation; identify groups that tend to dissociate/avoid.
Significance- specify: 
    -L or --level          Specify the significnace level cutoff (default: 0.05)
Significance correction- specify: 
    -m or --bonferroni     Bonferroni correction multiple correction (recommended & default)
    -n or --nocorrection   No correction, use value as-is
    -c or --fraction       (Connectivity analysis only) Use fraction rather than p-value
Alternative hypothesis- specify: 
    -g or --greater        Greater (recommended & default)
    -l or --less           Less
    -t or --twotailed      Two-tailed
Miscellaneous:
    -x or --num_cores      The number of cores to use (default: 2)
    -v or --verbose        Verbose output.
    -r or --filter         Permit filtering of saturated and low-abundance data.
    -U or --upfilthreshold Upper filter threshold for high-abundance data filtering (default: 1.0 i.e. any gene in >=100/% of genomes.
    -F or --filthreshold   Threshold for low-abundance data filtering (default: 0.05 i.e. any gene in <=5% of genomes.
    -q or --query          The path to a file containing a list of genes to specificcally query, one per line (optional).
    -T or --test           Runs the test cases and exits.
    -E or --all            Outputs all results, regardless of significance.
Output:
    -o or --output         The prefix of all output files (default: coincident).


If you use Coinfinder, please cite:

FJ Whelan, M Rusilowicz, & JO McInerney. "Coinfinder: Detecting Significant Associations and Dissociations in Pangenomes." doi: https://doi.org/10.1101/859371
```

