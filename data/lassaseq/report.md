# lassaseq CWL Generation Report

## lassaseq

### Tool Description
Download and filter Lassa virus sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/lassaseq:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/DaanJansen94/LassaSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/lassaseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lassaseq/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DaanJansen94/LassaSeq
- **Stars**: N/A
### Original Help Text
```text
usage: lassaseq [-h] -o OUTDIR [--genome {1,2,3}]
                [--completeness COMPLETENESS] [--host {1,2,3,4}]
                [--metadata {1,2,3,4}] [--countries COUNTRIES]
                [--remove REMOVE] [--phylogeny] [--consensus_L CONSENSUS_L]
                [--consensus_S CONSENSUS_S] [--lineage LINEAGE]
                [--sublineage SUBLINEAGE] [--l_sublineage L_SUBLINEAGE]
                [--s_sublineage S_SUBLINEAGE]

Download and filter Lassa virus sequences

options:
  -h, --help            show this help message and exit
  -o, --outdir OUTDIR   Output directory for sequences
  --genome {1,2,3}      Genome completeness filter: 1 = Complete genomes only
                        (>99 percent of reference length) 2 = Partial genomes
                        (specify minimum percent with --completeness) 3 = No
                        completeness filter
  --completeness COMPLETENESS
                        Minimum sequence completeness (1-100 percent) Required
                        when --genome=2
  --host {1,2,3,4}      Host filter: 1 = Human sequences only 2 = Rodent
                        sequences only 3 = Both human and rodent sequences 4 =
                        No host filter
  --metadata {1,2,3,4}  Metadata completeness filter: 1 = Keep only sequences
                        with known location 2 = Keep only sequences with known
                        date 3 = Keep only sequences with both known location
                        and date 4 = No metadata filter
  --countries COUNTRIES
                        Comma-separated list of countries to filter sequences
                        Examples: "Sierra Leone, Guinea" or "Nigeria, Mali"
                        Available: Nigeria, Sierra Leone, Liberia, Guinea,
                        Mali, Ghana, Benin, Burkina Faso, Ivory Coast, Togo
  --remove REMOVE       (Optional) File containing accession numbers to remove
                        One accession number per line, lines starting with #
                        are ignored
  --phylogeny           (Optional) Create concatenated FASTA files for
                        phylogenetic analysis Creates directories for MSA,
                        recombination detection, and tree building
  --consensus_L CONSENSUS_L
                        (Optional) Path to custom consensus sequence for L
                        segment The sequence should be in FASTA format
  --consensus_S CONSENSUS_S
                        (Optional) Path to custom consensus sequence for S
                        segment The sequence should be in FASTA format
  --lineage LINEAGE     (Optional) Filter sequences by lineage Example:
                        --lineage IV
  --sublineage SUBLINEAGE
                        (Optional) Filter sequences by sublineage (applies to
                        both segments) Example: --sublineage III
  --l_sublineage L_SUBLINEAGE
                        (Optional) Filter L segment sequences by sublineage
                        Example: --l_sublineage III
  --s_sublineage S_SUBLINEAGE
                        (Optional) Filter S segment sequences by sublineage
                        Example: --s_sublineage II

example: # Download complete genomes from human hosts with known location and
date from multiple countries: lassaseq -o lassa_output --genome 1 --host 1
--metadata 3 --countries "Sierra Leone, Guinea" # Filter by different
sublineages for L and S segments: lassaseq -o lassa_output --genome 1
--l_sublineage III --s_sublineage II
```

