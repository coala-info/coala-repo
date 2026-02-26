---
name: phytest
description: phytest is a testing framework designed to automate quality control and validation for phylogenetic trees and sequence alignments. Use when user asks to validate sequence alignments, check phylogenetic tree topology, or generate quality control reports for biological data.
homepage: https://github.com/phytest-devs/phytest
---


# phytest

## Overview
phytest is a specialized testing framework built on top of pytest designed to automate quality control for phylogenetic analyses. It allows researchers to define rigorous constraints for sequence alignments and phylogenetic trees, ensuring that data meets specific biological and structural requirements before proceeding with downstream analysis. By leveraging Python-based test files, it provides a programmatic way to catch outliers, invalid characters, or structural inconsistencies in Newick trees and FASTA alignments.

## Installation
Install phytest via pip or conda:
```bash
pip install phytest
# OR
conda install -c bioconda phytest
```

## Core Workflow
1. **Define Tests**: Create a Python file (e.g., `qc_tests.py`) using phytest's specialized classes.
2. **Execute**: Run the `phytest` command pointing to your test file and data sources.
3. **Review**: Examine the CLI output or the generated HTML report.

## Common CLI Patterns
Run tests against a sequence alignment and a tree:
```bash
phytest qc_tests.py -s alignment.fasta -t phylogeny.tree
```

Generate a shareable HTML quality control report:
```bash
phytest qc_tests.py -s alignment.fasta -t phylogeny.tree --report qc_report.html
```

Run tests in parallel to speed up large datasets (requires `pytest-xdist`):
```bash
phytest qc_tests.py -s alignment.fasta -n auto
```

## Writing Effective Tests
Import the necessary fixtures (`Alignment`, `Sequence`, `Tree`) to access specialized assertion methods.

### Alignment and Sequence Validation
Use these to ensure data cleanliness and correct dimensions.
```python
from phytest import Alignment, Sequence

def test_alignment_dimensions(alignment: Alignment):
    alignment.assert_length(10)  # Number of sequences
    alignment.assert_width(1000) # Alignment length

def test_sequence_quality(sequence: Sequence):
    # Ensure only valid DNA characters and gaps are present
    sequence.assert_valid_alphabet(alphabet="ATGCN-")
    # Limit the number of missing bases (Ns)
    sequence.assert_longest_stretch_Ns(max=15)
```

### Tree Topology and Integrity
Validate the structure of Newick files and their consistency with alignments.
```python
from phytest import Tree, Alignment

def test_tree_structure(tree: Tree):
    tree.assert_is_bifurcating()
    tree.assert_number_of_tips(10)
    # Ensure no extremely short internal branches
    tree.assert_internal_branch_lengths(min=1e-6)

def test_tree_alignment_sync(tree: Tree, alignment: Alignment):
    # Verify that the tree tips match the alignment sequence IDs
    names = [s.name for s in alignment]
    tree.assert_tip_names(names)
```

## Expert Tips
- **Custom Assertions**: Since phytest is built on pytest, you can write standard Python logic within tests to handle complex QC, such as calculating branch length statistics using `statistics` or `numpy`.
- **Selective Testing**: Use pytest markers or naming conventions to run specific subsets of QC tests when dealing with massive datasets.
- **Fixture Injection**: The `alignment`, `sequence`, and `tree` arguments in your test functions are automatically populated by the files provided via the `-s` and `-t` CLI flags.

## Reference documentation
- [Phytest GitHub Repository](./references/github_com_phytest-devs_phytest.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phytest_overview.md)