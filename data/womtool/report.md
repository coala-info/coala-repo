# womtool CWL Generation Report

## womtool_validate

### Tool Description
A tool for validating and manipulating WDL workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Total Downloads**: 203.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Error: Missing value after -h
Error: Missing argument workflow-source
Try --help for more information.
womtool 61-unknown-SNAP
Usage: java -jar womtool.jar [validate|inputs|outputs|parse|highlight|graph|upgrade|womgraph] [options] workflow-source

  workflow-source          Path to workflow file.
  -i, --inputs <value>     Workflow inputs file.
  -h, --highlight-mode <value>
                           Highlighting mode, one of 'html', 'console' (used only with 'highlight' command)
  -o, --optional-inputs <value>
                           If set, optional inputs are also included in the inputs set. Default is 'true' (used only with the inputs command)
  -l, --list-dependencies  An optional flag to list files referenced in import statements (used only with 'validate' command)
  --help
  --version

Command: validate
Validate a workflow source file. If inputs are provided then 'validate' also checks that the inputs file is a valid set of inputs for the workflow.

Command: inputs
Generate and output a new inputs JSON for this workflow.

Command: outputs
Generate and output a list of output types in JSON for this workflow.

Command: parse
(Deprecated; WDL draft 2 only) Print out the Hermes parser's abstract syntax tree for the source file.

Command: highlight
(Deprecated; WDL draft 2 only) Print out the Hermes parser's abstract syntax tree for the source file. Requires at least one of 'html' or 'console'

Command: graph
Generate and output a graph visualization of the workflow in .dot format

Command: upgrade
Automatically upgrade the WDL to version 1.0 and output the result.

Command: womgraph
(Advanced) Generate and output a graph visualization of Cromwell's internal Workflow Object Model structure for this workflow in .dot format
```

