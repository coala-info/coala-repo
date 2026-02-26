# goenrichment CWL Generation Report

## goenrichment

### Tool Description
GOEnrichment analyses a set of gene products for GO term enrichment

### Metadata
- **Docker Image**: quay.io/biocontainers/goenrichment:2.0.1--0
- **Homepage**: https://github.com/DanFaria/GOEnrichment
- **Package**: https://anaconda.org/channels/bioconda/packages/goenrichment/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/goenrichment/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DanFaria/GOEnrichment
- **Stars**: N/A
### Original Help Text
```text
GOEnrichment analyses a set of gene products for GO term enrichment

Usage: 'java -jar GOEnrichment.jar OPTIONS'

Options:
-g, --go FILE_PATH	Path to the Gene Ontology OBO or OWL file
-a, --annotation FILE_PATH	Path to the tabular annotation file (GAF, BLAST2GO or 2-column table format
-s, --study FILE_PATH	Path to the file listing the study set gene products
[-p, --population FILE_PATH	Path to the file listing the population set gene products]
[-c, --correction OPTION	Multiple test correction strategy (Bonferroni, Bonferroni-Holm, Sidak, SDA, or Benjamini-Hochberg)]
[-gf, --graph_format OPTION	Output graph format (PNG,SVG,TXT)]
[-so, --summarize_output	Summarizes the list of enriched GO terms by removing closely related terms]
[-e, --exclude_singletons	Exclude GO terms that are annotated to a single gene product in the study set]
[-o, --cut_off	q-value (or corrected p-value) cut-off to apply for the graph output]
[-r, --use_all_relations	Infer annotations through 'part_of' and other non-hierarchical relations]
[-mfr, --mf_result FILE_PATH	Path to the output MF result file]
[-bpr, --bp_result FILE_PATH	Path to the output BP result file]
[-ccr, --cc_result FILE_PATH	Path to the output CC result file]
[-mfg, --mf_graph FILE_PATH	Path to the output MF graph file]
[-bpg, --bp_graph FILE_PATH	Path to the output BP graph file]
[-ccg, --cc_graph FILE_PATH	Path to the output CC graph file]
```

