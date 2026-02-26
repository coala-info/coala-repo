---
name: junit-xml
description: The junit-xml library creates JUnit XML documents by defining test cases and grouping them into test suites for CI server reporting. Use when user asks to generate JUnit XML reports, create test suites and cases in Python, or export test results to XML files.
homepage: https://github.com/kyrus/python-junit-xml
---


# junit-xml

## Overview
The `junit-xml` library allows you to construct JUnit XML documents by defining test cases and grouping them into test suites. This is essential for Python developers who want to leverage the reporting and graphing capabilities of CI servers without using standard frameworks like `unittest` or `pytest`, or when building wrappers for external tools. The library handles the complexities of the XML schema, including the automatic removal of illegal Unicode characters that often break XML parsers.

## Installation
Install the package via pip or conda:
```bash
pip install junit-xml
# OR
conda install bioconda::junit-xml
```

## Core Workflow
To generate a report, follow these three steps:
1.  **Define Test Cases**: Create `TestCase` objects for every test executed.
2.  **Group into Suites**: Aggregate test cases into one or more `TestSuite` objects.
3.  **Export**: Convert the suites into an XML string or write them directly to a file.

### Basic Usage
```python
from junit_xml import TestSuite, TestCase

# Define a successful test case
# Args: name, classname, elapsed_sec, stdout, stderr
test_case = TestCase('Test1', 'my.package.Class', 1.5, 'Output log', 'Error log')

# Create the suite
ts = TestSuite("Functional Tests", [test_case])

# Output as XML string
print(TestSuite.to_xml_string([ts]))
```

## Handling Test Results
You can specify different outcomes by providing additional arguments to the `TestCase` constructor or by setting attributes on the object.

### Failures and Errors
*   **Failure**: Use when the test logic fails (e.g., assertion failure).
*   **Error**: Use when the test fails to run correctly (e.g., unhandled exception).

```python
# A failed test
tc_fail = TestCase('Test2', 'my.package.Class', 0.5)
tc_fail.add_failure_info(message="Assertion failed", output="Expected A but got B")

# An error test
tc_err = TestCase('Test3', 'my.package.Class', 0.1)
tc_err.add_error_info(message="Connection timeout", output="Traceback...")

# A skipped test
tc_skip = TestCase('Test4', 'my.package.Class', 0)
tc_skip.add_skipped_info(message="Feature not supported on this OS")
```

## Expert Tips and Best Practices
*   **Writing to Files**: Use `TestSuite.to_file(file_handle, [suites])` for efficient writing. By default, this uses pretty-printing.
*   **Disabling Pretty-Print**: For large reports where file size matters, set `prettyprint=False` in `to_xml_string` or `to_file`.
*   **Multiple Suites**: The export methods accept a list of suites. You can generate a single XML file containing multiple `<testsuite>` elements by passing them in the list.
*   **Unicode Safety**: The library automatically strips "illegal or discouraged" Unicode characters. You do not need to manually sanitize `stdout` or `stderr` strings before passing them to `TestCase`.
*   **Time Precision**: The `time` attribute accepts floats. While the library handles high precision, some older Jenkins plugins prefer standard decimal formatting; the library handles this conversion automatically.

## Reference documentation
- [junit-xml Overview](./references/anaconda_org_channels_bioconda_packages_junit-xml_overview.md)
- [python-junit-xml README](./references/github_com_kyrus_python-junit-xml.md)
- [Commit History (Feature details)](./references/github_com_kyrus_python-junit-xml_commits_master.md)