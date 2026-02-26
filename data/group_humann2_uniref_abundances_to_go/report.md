# group_humann2_uniref_abundances_to_go CWL Generation Report

## group_humann2_uniref_abundances_to_go_group_humann2_uniref_abundances_to_GO.sh

### Tool Description
Groups UniRef abundances to Gene Ontology (GO) terms.

### Metadata
- **Docker Image**: quay.io/biocontainers/group_humann2_uniref_abundances_to_go:1.3.0--0
- **Homepage**: https://github.com/ASaiM/group_humann2_uniref_abundances_to_GO
- **Package**: https://anaconda.org/channels/bioconda/packages/group_humann2_uniref_abundances_to_go/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/group_humann2_uniref_abundances_to_go/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ASaiM/group_humann2_uniref_abundances_to_GO
- **Stars**: N/A
### Original Help Text
```text
ERROR
Missing argument: -i   

Usage:
	group_humann2_uniref_abundances_to_GO.sh [OPTIONS] -i humann2_gene_families_abundance -m molecular_function_abundances -b biological_process_abundances -c cellular_component_abundances

Required options:
             -i   Path to file with UniRef50 gene family abundance (HUMAnN2 output)
             -m   Path to file which will contain GO slim term abudances corresponding to molecular functions
             -b   Path to file which will contain GO slim term abudances corresponding to biological processes
             -c   Path to file which will contain GO slim term abudances corresponding to cellular components

Other options:
             -a   Path to basic Gene Ontology file
             -s   Path to basic slim Gene Ontology file
             -u   Path to file with HUMAnN2 correspondance betwen UniRef50 and GO
             -g   Path to GoaTools scripts
             -p   Path to HUMAnN2 scripts
             -h   Print this help message
```

