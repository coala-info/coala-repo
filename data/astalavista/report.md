# astalavista CWL Generation Report

## astalavista_astalavista

### Tool Description
The Barna library comes with a set of tools for alternative splicing analysis. AStalavista is the default tool for event retrieval.

### Metadata
- **Docker Image**: quay.io/biocontainers/astalavista:4.0--0
- **Homepage**: https://github.com/divyavewall/astalavista-frontend
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/astalavista/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/divyavewall/astalavista-frontend
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[INFO] Astalavista v4.0 (Flux Library: 1.30)

-------Documentation & Issue Tracker-------
Barna Wiki (Docs): http://sammeth.net/confluence
Barna JIRA (Bugs): http://sammeth.net/jira

Please feel free to create an account in the public
JIRA and reports any bugs or feature requests.
-------------------------------------------

The Barna library comes with a set of tools.
You can switch tools with the -t option. The general options
change the behaviour of all the packaged tools.

General Flux Options: 

  [(-t|--tool) <tool>]
        Select a tool (default: astalavista)

  [-h|--help]
        Show help

  [--list-tools]
        List available tools

  [--threads <threads>]
        Maximum number of threads to use. Default 2 (default: 2)

  [--log <level>]
        Log level (NONE|INFO|ERROR|DEBUG) (default: INFO)

  [--force]
        Disable interactivity. No questions will be asked

  [-v|--version]
        Show version information


The Barna library consists of a set of tools bundled with the package.
The current bundle uses 'astalavista' as the default tool.
You can switch tools with the -t option and get help for a specific
tool with -t <toolname> --help. This will print the usage and description of the specified tool

List of available tools
	sortGTF - Sort a GTF file. If no output file is specified, result is printed to standard out
	sortBED - Sort a BED file. If no output file is specified, result is printed to standard out
	scorer - Splice site scorer
	asta - AStalavista event retriever
	subsetter - Extract a random subset of lines from a file
	astafunk - Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.
```


## astalavista_sortgtf

### Tool Description
Sort a GTF file. If no output file is specified, result is printed to standard out.

### Metadata
- **Docker Image**: quay.io/biocontainers/astalavista:4.0--0
- **Homepage**: https://github.com/divyavewall/astalavista-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[INFO] Astalavista v4.0 (Flux Library: 1.30)

-------Documentation & Issue Tracker-------
Barna Wiki (Docs): http://sammeth.net/confluence
Barna JIRA (Bugs): http://sammeth.net/jira

Please feel free to create an account in the public
JIRA and reports any bugs or feature requests.
-------------------------------------------

The Barna library comes with a set of tools.
You can switch tools with the -t option. The general options
change the behaviour of all the packaged tools.

General Flux Options: 

  [(-t|--tool) <tool>]
        Select a tool (default: astalavista)

  [-h|--help]
        Show help

  [--list-tools]
        List available tools

  [--threads <threads>]
        Maximum number of threads to use. Default 2 (default: 2)

  [--log <level>]
        Log level (NONE|INFO|ERROR|DEBUG) (default: INFO)

  [--force]
        Disable interactivity. No questions will be asked

  [-v|--version]
        Show version information


The Barna library consists of a set of tools bundled with the package.
The current bundle uses 'astalavista' as the default tool.
You can switch tools with the -t option and get help for a specific
tool with -t <toolname> --help. This will print the usage and description of the specified tool

List of available tools
	sortGTF - Sort a GTF file. If no output file is specified, result is printed to standard out
	sortBED - Sort a BED file. If no output file is specified, result is printed to standard out
	scorer - Splice site scorer
	asta - AStalavista event retriever
	astafunk - Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.
	subsetter - Extract a random subset of lines from a file
```


## astalavista_sortbed

### Tool Description
Sort a BED file. If no output file is specified, result is printed to standard out.

### Metadata
- **Docker Image**: quay.io/biocontainers/astalavista:4.0--0
- **Homepage**: https://github.com/divyavewall/astalavista-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[INFO] Astalavista v4.0 (Flux Library: 1.30)

-------Documentation & Issue Tracker-------
Barna Wiki (Docs): http://sammeth.net/confluence
Barna JIRA (Bugs): http://sammeth.net/jira

Please feel free to create an account in the public
JIRA and reports any bugs or feature requests.
-------------------------------------------

The Barna library comes with a set of tools.
You can switch tools with the -t option. The general options
change the behaviour of all the packaged tools.

General Flux Options: 

  [(-t|--tool) <tool>]
        Select a tool (default: astalavista)

  [-h|--help]
        Show help

  [--list-tools]
        List available tools

  [--threads <threads>]
        Maximum number of threads to use. Default 2 (default: 2)

  [--log <level>]
        Log level (NONE|INFO|ERROR|DEBUG) (default: INFO)

  [--force]
        Disable interactivity. No questions will be asked

  [-v|--version]
        Show version information


The Barna library consists of a set of tools bundled with the package.
The current bundle uses 'astalavista' as the default tool.
You can switch tools with the -t option and get help for a specific
tool with -t <toolname> --help. This will print the usage and description of the specified tool

List of available tools
	sortGTF - Sort a GTF file. If no output file is specified, result is printed to standard out
	sortBED - Sort a BED file. If no output file is specified, result is printed to standard out
	scorer - Splice site scorer
	asta - AStalavista event retriever
	astafunk - Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.
	subsetter - Extract a random subset of lines from a file
```


## astalavista_scorer

### Tool Description
Splice site scorer tool from the Barna library

### Metadata
- **Docker Image**: quay.io/biocontainers/astalavista:4.0--0
- **Homepage**: https://github.com/divyavewall/astalavista-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[INFO] Astalavista v4.0 (Flux Library: 1.30)

-------Documentation & Issue Tracker-------
Barna Wiki (Docs): http://sammeth.net/confluence
Barna JIRA (Bugs): http://sammeth.net/jira

Please feel free to create an account in the public
JIRA and reports any bugs or feature requests.
-------------------------------------------

The Barna library comes with a set of tools.
You can switch tools with the -t option. The general options
change the behaviour of all the packaged tools.

General Flux Options: 

  [(-t|--tool) <tool>]
        Select a tool (default: astalavista)

  [-h|--help]
        Show help

  [--list-tools]
        List available tools

  [--threads <threads>]
        Maximum number of threads to use. Default 2 (default: 2)

  [--log <level>]
        Log level (NONE|INFO|ERROR|DEBUG) (default: INFO)

  [--force]
        Disable interactivity. No questions will be asked

  [-v|--version]
        Show version information


The Barna library consists of a set of tools bundled with the package.
The current bundle uses 'astalavista' as the default tool.
You can switch tools with the -t option and get help for a specific
tool with -t <toolname> --help. This will print the usage and description of the specified tool

List of available tools
	sortGTF - Sort a GTF file. If no output file is specified, result is printed to standard out
	sortBED - Sort a BED file. If no output file is specified, result is printed to standard out
	scorer - Splice site scorer
	asta - AStalavista event retriever
	astafunk - Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.
	subsetter - Extract a random subset of lines from a file
```


## astalavista_asta

### Tool Description
AStalavista event retriever. The Barna library comes with a set of tools for alternative splicing analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/astalavista:4.0--0
- **Homepage**: https://github.com/divyavewall/astalavista-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[INFO] Astalavista v4.0 (Flux Library: 1.30)

-------Documentation & Issue Tracker-------
Barna Wiki (Docs): http://sammeth.net/confluence
Barna JIRA (Bugs): http://sammeth.net/jira

Please feel free to create an account in the public
JIRA and reports any bugs or feature requests.
-------------------------------------------

The Barna library comes with a set of tools.
You can switch tools with the -t option. The general options
change the behaviour of all the packaged tools.

General Flux Options: 

  [(-t|--tool) <tool>]
        Select a tool (default: astalavista)

  [-h|--help]
        Show help

  [--list-tools]
        List available tools

  [--threads <threads>]
        Maximum number of threads to use. Default 2 (default: 2)

  [--log <level>]
        Log level (NONE|INFO|ERROR|DEBUG) (default: INFO)

  [--force]
        Disable interactivity. No questions will be asked

  [-v|--version]
        Show version information


The Barna library consists of a set of tools bundled with the package.
The current bundle uses 'astalavista' as the default tool.
You can switch tools with the -t option and get help for a specific
tool with -t <toolname> --help. This will print the usage and description of the specified tool

List of available tools
	sortGTF - Sort a GTF file. If no output file is specified, result is printed to standard out
	sortBED - Sort a BED file. If no output file is specified, result is printed to standard out
	scorer - Splice site scorer
	asta - AStalavista event retriever
	astafunk - Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.
	subsetter - Extract a random subset of lines from a file
```


## astalavista_astafunk

### Tool Description
Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/astalavista:4.0--0
- **Homepage**: https://github.com/divyavewall/astalavista-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[INFO] Astalavista v4.0 (Flux Library: 1.30)

-------Documentation & Issue Tracker-------
Barna Wiki (Docs): http://sammeth.net/confluence
Barna JIRA (Bugs): http://sammeth.net/jira

Please feel free to create an account in the public
JIRA and reports any bugs or feature requests.
-------------------------------------------

The Barna library comes with a set of tools.
You can switch tools with the -t option. The general options
change the behaviour of all the packaged tools.

General Flux Options: 

  [(-t|--tool) <tool>]
        Select a tool (default: astalavista)

  [-h|--help]
        Show help

  [--list-tools]
        List available tools

  [--threads <threads>]
        Maximum number of threads to use. Default 2 (default: 2)

  [--log <level>]
        Log level (NONE|INFO|ERROR|DEBUG) (default: INFO)

  [--force]
        Disable interactivity. No questions will be asked

  [-v|--version]
        Show version information


The Barna library consists of a set of tools bundled with the package.
The current bundle uses 'astalavista' as the default tool.
You can switch tools with the -t option and get help for a specific
tool with -t <toolname> --help. This will print the usage and description of the specified tool

List of available tools
	sortGTF - Sort a GTF file. If no output file is specified, result is printed to standard out
	sortBED - Sort a BED file. If no output file is specified, result is printed to standard out
	scorer - Splice site scorer
	asta - AStalavista event retriever
	astafunk - Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.
	subsetter - Extract a random subset of lines from a file
```


## astalavista_subsetter

### Tool Description
Extract a random subset of lines from a file

### Metadata
- **Docker Image**: quay.io/biocontainers/astalavista:4.0--0
- **Homepage**: https://github.com/divyavewall/astalavista-frontend
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[INFO] Astalavista v4.0 (Flux Library: 1.30)

-------Documentation & Issue Tracker-------
Barna Wiki (Docs): http://sammeth.net/confluence
Barna JIRA (Bugs): http://sammeth.net/jira

Please feel free to create an account in the public
JIRA and reports any bugs or feature requests.
-------------------------------------------

The Barna library comes with a set of tools.
You can switch tools with the -t option. The general options
change the behaviour of all the packaged tools.

General Flux Options: 

  [(-t|--tool) <tool>]
        Select a tool (default: astalavista)

  [-h|--help]
        Show help

  [--list-tools]
        List available tools

  [--threads <threads>]
        Maximum number of threads to use. Default 2 (default: 2)

  [--log <level>]
        Log level (NONE|INFO|ERROR|DEBUG) (default: INFO)

  [--force]
        Disable interactivity. No questions will be asked

  [-v|--version]
        Show version information


The Barna library consists of a set of tools bundled with the package.
The current bundle uses 'astalavista' as the default tool.
You can switch tools with the -t option and get help for a specific
tool with -t <toolname> --help. This will print the usage and description of the specified tool

List of available tools
	sortGTF - Sort a GTF file. If no output file is specified, result is printed to standard out
	sortBED - Sort a BED file. If no output file is specified, result is printed to standard out
	scorer - Splice site scorer
	asta - AStalavista event retriever
	astafunk - Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search Pfam HMMs against alternatively spliced regions.
	subsetter - Extract a random subset of lines from a file
```


## Metadata
- **Skill**: not generated
