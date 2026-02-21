---
name: dreamtools
description: The `dreamtools` skill provides a specialized interface for scoring collaborative DREAM (Dialogue on Reverse Engineering Assessment and Methods) challenges.
homepage: https://github.com/dreamtools/dreamtools
---

# dreamtools

## Overview

The `dreamtools` skill provides a specialized interface for scoring collaborative DREAM (Dialogue on Reverse Engineering Assessment and Methods) challenges. It transforms Claude into an expert capable of evaluating systems biology models using the same scoring functions employed in official competitions. This skill is essential for researchers who need to benchmark their algorithms against historical DREAM data, retrieve gold standard datasets, or generate submission templates for specific challenges ranging from DREAM2 to DREAM9.5.

## CLI Usage Patterns

The primary interface for `dreamtools` is its standalone command-line application.

### Scoring a Submission
To evaluate a specific submission file against a challenge's scoring metric:
`dreamtools --challenge <CHALLENGE_ID> --submission <PATH_TO_FILE>`

### Retrieving Challenge Resources
Before scoring, you often need the official templates or gold standards:
- **Download Template**: `dreamtools --challenge <CHALLENGE_ID> --download-template`
- **Download Gold Standard**: `dreamtools --challenge <CHALLENGE_ID> --download-gold-standard`

### Common Challenge IDs
The tool supports approximately 80% of challenges from DREAM2 through DREAM9.5. Examples include:
- `D6C3` (DREAM6 Challenge 3)
- `D9C4` (TCGA)
- `D9.5C2` (Prostate Cancer)

## Python API Integration

For more complex workflows or batch processing, `dreamtools` can be used directly within Python scripts.

### Basic Scoring Workflow
```python
from dreamtools import D6C3
s = D6C3()
# Download and score the template as a test
results = s.score(s.download_template())
print(results)
```

## Expert Tips and Best Practices

- **Synapse Integration**: Many scoring functions require data hosted on Synapse. Ensure you are registered at [synapse.org](https://www.synapse.org) and have accepted the specific terms of agreement for the challenge data you are accessing.
- **Challenge Discovery**: If a specific challenge ID is unknown, refer to the F1000Research publication (doi: 10.12688/f1000research.7118.1) which contains a comprehensive table of supported challenges.
- **Environment Setup**: `dreamtools` requires `cython` to be installed prior to the main package installation for proper compilation of scoring modules.
- **Data Persistence**: Once downloaded via the CLI, gold standards and templates are stored locally. Use the `--download` flags to find the local path of these files for use in your own analysis pipelines.

## Reference documentation
- [dreamtools GitHub Overview](./references/github_com_dreamtools_dreamtools.md)
- [dreamtools Issues and Challenges](./references/github_com_dreamtools_dreamtools_issues.md)