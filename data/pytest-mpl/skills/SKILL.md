---
name: pytest-mpl
description: The pytest-mpl plugin automates the comparison of Matplotlib figures against baseline images to detect visual regressions. Use when user asks to compare Matplotlib plots, generate baseline images for visual testing, or perform image-based regression tests.
homepage: https://github.com/matplotlib/pytest-mpl
---


# pytest-mpl

## Overview
The `pytest-mpl` plugin extends the pytest framework to automate the comparison of Matplotlib figures. Instead of manually inspecting plots, this tool generates an image from a test function, compares it against a known "baseline" image, and calculates the Root Mean Square (RMS) error. If the difference exceeds a defined tolerance, the test fails. It also supports image hashing for a more storage-efficient comparison method.

## Core Workflow

### 1. Test Implementation
Decorate test functions that return a Matplotlib figure with `@pytest.mark.mpl_image_compare`.

```python
import matplotlib.pyplot as plt
import pytest

@pytest.mark.mpl_image_compare
def test_my_plot():
    fig, ax = plt.subplots()
    ax.plot([0, 1, 2], [0, 1, 4])
    return fig
```

### 2. Baseline Generation
Before running comparisons, you must create the reference images that represent the "correct" output.
```bash
pytest --mpl-generate-path=tests/baseline
```

### 3. Execution and Comparison
Run the test suite with the `--mpl` flag to enable image comparison.
```bash
pytest --mpl
```

## Common CLI Patterns

| Command | Description |
| :--- | :--- |
| `pytest --mpl` | Enables image comparison (disabled by default). |
| `pytest --mpl-generate-path=path` | Saves generated figures to the specified directory as baselines. |
| `pytest --mpl-results-path=path` | Specifies where to save result images (diffs) when tests fail. |
| `pytest --mpl-generate-summary=html` | Creates a visual HTML report showing the baseline, actual, and diff images. |
| `pytest --mpl-baseline-path=path` | Explicitly defines where the plugin should look for reference images. |

## Expert Tips and Configuration

### Adjusting Tolerance
If your environment (e.g., different OS or Matplotlib versions) produces slight pixel variations that aren't meaningful regressions, increase the RMS tolerance:
```python
@pytest.mark.mpl_image_compare(tolerance=10)
def test_with_high_tolerance():
    ...
```

### Image Hashing
To avoid storing large binary images in your repository, use hashes.
1. Generate hashes: `pytest --mpl-generate-hash-library=hashes.json`
2. Compare using hashes: `pytest --mpl --mpl-hash-library=hashes.json`

### Handling Multiple Baselines
If you need to support multiple versions of Matplotlib or different operating systems that render text differently, you can organize your baseline directory with subfolders corresponding to the Matplotlib version (e.g., `baseline/3.5/`).

### Integration with pytest-xdist
Recent versions of `pytest-mpl` support parallel execution. When using `pytest -n auto --mpl`, ensure you are using a compatible summary format (like JSON or HTML) to aggregate results from different workers.

## Reference documentation
- [GitHub - matplotlib/pytest-mpl](./references/github_com_matplotlib_pytest-mpl.md)
- [Issues - Roadmap and Features](./references/github_com_matplotlib_pytest-mpl_issues.md)