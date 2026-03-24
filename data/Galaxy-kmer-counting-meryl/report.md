# kmer counting - meryl CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.org.au/
- **Package**: https://workflowhub.eu/workflows/223
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/223/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 809
- **Last updated**: 2023-01-30
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-kmer_counting.ga` (Main Workflow)
- **Project**: Galaxy Australia
- **Views**: 9621
- **Creators**: Anna Syme

## Description

Kmer counting step, can run alone or as part of a combined workflow for large genome assembly. 

* What it does: Estimates genome size and heterozygosity based on counts of kmers
* Inputs: One set of short reads: e.g. R1.fq.gz
* Outputs: GenomeScope graphs
* Tools used: Meryl, GenomeScope
* Input parameters: None required
* Workflow steps: The tool meryl counts kmers in the input reads (k=21), then converts this into a histogram. GenomeScope: runs a model on the histogram; reports estimates. k-mer size set to 21. 
* Options: Use a different kmer counting tool. e.g. khmer.


Infrastructure_deployment_metadata: Galaxy Australia (Galaxy)
