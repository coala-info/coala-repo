---
name: xunit-wrapper
description: `xunit-wrapper` is a lightweight Python utility that provides a simple interface for generating XUnit XML reports.
homepage: https://github.com/TAMU-CPT/xunit-python-decorator
---

# xunit-wrapper

## Overview

`xunit-wrapper` is a lightweight Python utility that provides a simple interface for generating XUnit XML reports. Unlike heavy testing frameworks, it allows you to wrap specific blocks of code using a context manager to automatically track execution duration and capture tracebacks if an error occurs. It is particularly useful for data processing scripts, bioinformatics pipelines, or custom automation tasks where you want to report success or failure of specific steps to a CI/CD dashboard without refactoring the entire script into a formal test suite.

## Installation

Install the package via Conda or Pip:

```bash
# Via Bioconda
conda install bioconda::xunit-wrapper

# Via Pip
pip install xunit-wrapper
```

## Core Usage Patterns

### Basic Test Case Capture
The primary way to use the tool is through the `xunit` context manager. It captures the start time, end time, and any exceptions raised within the block.

```python
from xunit_wrapper import xunit, xunit_suite, xunit_dump

# 1. Define a test case using a context manager
with xunit('Task Name', 'category.subcategory') as tc1:
    # Your logic here
    result = 10 / 2
    print(f"Processed: {result}")

# 2. Group test cases into a suite
suite = xunit_suite('My Pipeline Suite', [tc1])

# 3. Generate the XML string
xml_output = xunit_dump([suite])

# 4. Save to a file for CI consumption
with open('results.xml', 'w') as f:
    f.write(xml_output)
```

### Handling Failures
The wrapper automatically handles exceptions. If the code inside the `with` block fails, the exception type and traceback are formatted into the `<failure>` section of the XUnit XML.

```python
with xunit('Division Task', 'math.operations') as tc2:
    # This will be captured as a failure in the XML
    val = 1 / 0 
```

## Best Practices

- **Descriptive Classnames**: Use the second argument of `xunit()` (the classname) to group related tasks. CI tools often use this field to create folder structures in the UI.
- **Suite Aggregation**: You can collect multiple test case objects throughout a long-running script and aggregate them into a single `xunit_suite` at the end.
- **Standard Output Redirection**: Since `xunit_dump` returns a string, always ensure your script writes this to a file (usually `results.xml` or `nosetests.xml`) so that CI agents can find and parse the report.
- **Granularity**: Wrap logical "steps" of a script rather than the whole script. This allows you to see exactly which part of a pipeline failed in your CI dashboard.

## Reference documentation
- [xunit-wrapper Overview](./references/anaconda_org_channels_bioconda_packages_xunit-wrapper_overview.md)
- [xunit-python-decorator README](./references/github_com_TAMU-CPT_xunit-python-decorator.md)