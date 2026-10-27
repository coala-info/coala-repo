# womtool CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| womtool_graph | PASS | real draft-2 hello.wdl: prints a DOT digraph wf_hello with node CALL_hello; no workflow run |
| womtool_highlight | PASS | real draft-2 hello.wdl with --highlight-mode console: prints the WDL source with ANSI colour codes on keywords and types; no workflow run |
| womtool_inputs | PASS | real draft-2 hello.wdl: prints the inputs JSON {"wf_hello.hello.addressee": "String"}; no workflow run |
| womtool_outputs | PASS | real draft-2 hello.wdl: prints the outputs JSON {"wf_hello.hello.salutation": "String"}; no workflow run |
| womtool_parse | PASS | real draft-2 hello.wdl: prints the parse tree (Namespace with task hello, declaration addressee, raw command); no workflow run |
| womtool_upgrade | PASS | real draft-2 scatter2.wdl and hello_in.wdl: prints valid WDL 1.0 with input blocks and typed outputs (Array[Int] ints = printInt.out kept); note: the shorthand draft-2 workflow output in hello.wdl (hello.salutation) is dropped; no workflow run |
| womtool_validate | PASS | Static validation of a small real WDL file only; no workflow was run. |
| womtool_womgraph | PASS | real draft-2 hello.wdl: prints a DOT digraph with call wf_hello.hello and its String addressee and hello.salutation ports; no workflow run |

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

## womtool_inputs

### Tool Description
Generate and output a new inputs JSON for this workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

### Original Help Text
```text
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

## womtool_outputs

### Tool Description
Generate and output a list of output types in JSON for this workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

### Original Help Text
```text
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

## womtool_parse

### Tool Description
Print the Hermes parser abstract syntax tree (WDL draft 2).

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

### Original Help Text
```text
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

## womtool_highlight

### Tool Description
Print the highlighted WDL source (WDL draft 2; html or console).

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

### Original Help Text
```text
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

## womtool_graph

### Tool Description
Generate a graph visualization of the workflow in .dot format.

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

### Original Help Text
```text
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

## womtool_upgrade

### Tool Description
Automatically upgrade the WDL to version 1.0 and output the result.

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

### Original Help Text
```text
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

## womtool_womgraph

### Tool Description
Generate a graph of Cromwell's internal Workflow Object Model in .dot format.

### Metadata
- **Docker Image**: quay.io/biocontainers/womtool:61--hdfd78af_0
- **Homepage**: https://cromwell.readthedocs.io/en/develop/WOMtool/
- **Package**: https://anaconda.org/channels/bioconda/packages/womtool/overview
- **Validation**: PASS

### Original Help Text
```text
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

