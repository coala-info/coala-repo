---
name: hmmer2
description: HMMER2GO annotates biological sequences by translating DNA into protein domains and mapping them to functional metadata. Use when user asks to extract open reading frames, search sequences against Pfam databases, map protein domains to Gene Ontology terms, or generate Gene Association Files.
homepage: https://github.com/sestaton/HMMER2GO
metadata:
  docker_image: "biocontainers/hmmer2:v2.3.2-13-deb_cv1"
---

# hmmer2

## Overview

HMMER2GO is a comprehensive command-line solution for biological sequence annotation. It automates the process of translating DNA sequences into protein domains and assigning functional metadata. By leveraging the Pfam database and InterPro APIs, it allows researchers to infer the function of gene products in non-model organisms or expression studies. The tool is particularly useful for transforming raw FASTA sequences into structured functional mappings compatible with visualization tools like Ontologizer.

## Core Workflow

The standard HMMER2GO pipeline consists of four primary stages.

### 1. ORF Extraction
Extract the longest open reading frames (ORFs) from your DNA sequences and translate them into protein sequences.
```bash
hmmer2go getorf -i transcripts.fasta -o transcripts_orfs.faa
```

### 2. Domain Searching
Search the translated ORFs against a Pfam HMM database.
```bash
hmmer2go run -i transcripts_orfs.faa -d Pfam-A.hmm -o pfam_results.tblout
```

### 3. GO Term Mapping
Map the identified protein domains to specific Gene Ontology terms.
```bash
hmmer2go mapterms -i pfam_results.tblout -o go_mappings.tsv --map
```

### 4. GAF Generation
Convert the mapping results into a Gene Association File (GAF) for statistical analysis.
```bash
hmmer2go map2gaf -i go_mappings_GOterm_mapping.tsv -o final_annotation.gaf -s 'Species Name'
```

## Targeted Analysis with Custom Databases

Instead of searching the entire Pfam database, you can create targeted HMM databases for specific protein families to increase speed and sensitivity.

- **Search and Download**: Use keywords to find and download specific HMMs.
  ```bash
  hmmer2go pfamsearch -t "kinase,phosphatase" -o signaling_hmms.txt -d
  ```
- **Run Targeted Search**:
  ```bash
  hmmer2go run -i transcripts_orfs.faa -d kinase+phosphatase_hmms/kinase+phosphatase.hmm -o signaling_results.tblout
  ```

## Docker Usage Patterns

For environments where dependency management is difficult, use the official Docker container. Ensure you mount your current directory to `/data`.

```bash
docker run --rm -v $(pwd):/data -w /data sestaton/hmmer2go <command> <args>
```

## Expert Tips and Best Practices

- **API Modernization**: As of version 0.19.0, `pfamsearch` uses the InterPro API. Ensure you are using the latest version to avoid failures caused by the deprecated legacy Pfam API.
- **Memory Management**: When running `hmmer2go run` against the full Pfam-A database, ensure your system has sufficient RAM (at least 8GB recommended) as HMMER searches can be resource-intensive.
- **Documentation Access**: Detailed manual pages for any subcommand can be accessed directly via the CLI:
  ```bash
  hmmer2go <subcommand> --man
  ```
- **Input Validation**: Always check that your input FASTA headers do not contain complex characters or spaces that might interfere with the HMMER table output parsing.

## Reference documentation
- [HMMER2GO Main Repository](./references/github_com_sestaton_HMMER2GO.md)
- [HMMER2GO Wiki Home](./references/github_com_sestaton_HMMER2GO_wiki.md)
- [HMMER2GO Version 0.19.0 Release Notes](./references/github_com_sestaton_HMMER2GO_tags.md)