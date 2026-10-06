# bubblegun CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bubblegun_bchains | PASS |  |
| bubblegun_bfs | PASS |  |
| bubblegun_biggestcomp | PASS |  |
| bubblegun_chainout | PASS |  |
| bubblegun_compact | PASS |  |

## bubblegun_bchains

### Tool Description
Command for detecting bubble chains

### Metadata
- **Docker Image**: quay.io/biocontainers/bubblegun:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Package**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Total Downloads**: 571
- **Last updated**: 2026-02-18
- **GitHub**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Stars**: N/A
### Original Help Text
```text
usage: BubbleGun bchains [-h] [--bubble_json OUT_JSON] [--only_simple]
                         [--only_super] [--save_memory]
                         [--chains_gfa CHAINS_GFA] [--fasta FASTA]
                         [--out_haplos]

options:
  -h, --help            show this help message and exit
  --bubble_json OUT_JSON
                        Outputs Bubbles, Superbubbles, and Chains as a JSON
                        file
  --only_simple         If used then only simple bubbles are detected
  --only_super          If used then only simple bubbles are detected
  --save_memory         Identifies bubble chain with less memory. No
                        statistics outputted
  --chains_gfa CHAINS_GFA
                        Output only bubble chains as a GFA file
  --fasta FASTA         Outputs the bubble branches as fasta file (doesn't
                        work with memory saving)
  --out_haplos          output randomly two haplotypes for each chain (doesn't
                        work with memory saving)

Global arguments (BubbleGun -h):
usage: BubbleGun [-h] [-g GRAPH_PATH] [-v] [--log_file LOG_FILE]
                 [--log LOG_LEVEL]
                 {bchains,compact,biggestcomp,bfs,chainout} ...

Find Bubble Chains.

Subcommands:
  {bchains,compact,biggestcomp,bfs,chainout}
                        Available subcommands
    bchains             Command for detecting bubble chains
    compact             Command for compacting graphs
    biggestcomp         Command for separating biggest component
    bfs                 Command for separating neighborhood
    chainout            Outputs certain chain(s) given by their id as a GFA
                        file

Global Arguments:
  -h, --help            show this help message and exit
  -g, --in_graph GRAPH_PATH
                        graph file path (GFA or VG)
  -v, --version         outputs version
  --log_file LOG_FILE   The name/path of the log file. Default: log.log
  --log LOG_LEVEL       The logging level [DEBUG, INFO, WARNING, ERROR,
                        CRITICAL]
```

## bubblegun_compact

### Tool Description
Command for compacting graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/bubblegun:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Package**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Total Downloads**: 571
- **Last updated**: 2026-02-18
- **GitHub**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Stars**: N/A
### Original Help Text
```text
usage: BubbleGun compact [-h] PATH_COMPACTED

positional arguments:
  PATH_COMPACTED  Compacted graph output path

options:
  -h, --help      show this help message and exit

Global arguments (BubbleGun -h):
usage: BubbleGun [-h] [-g GRAPH_PATH] [-v] [--log_file LOG_FILE]
                 [--log LOG_LEVEL]
                 {bchains,compact,biggestcomp,bfs,chainout} ...

Find Bubble Chains.

Subcommands:
  {bchains,compact,biggestcomp,bfs,chainout}
                        Available subcommands
    bchains             Command for detecting bubble chains
    compact             Command for compacting graphs
    biggestcomp         Command for separating biggest component
    bfs                 Command for separating neighborhood
    chainout            Outputs certain chain(s) given by their id as a GFA
                        file

Global Arguments:
  -h, --help            show this help message and exit
  -g, --in_graph GRAPH_PATH
                        graph file path (GFA or VG)
  -v, --version         outputs version
  --log_file LOG_FILE   The name/path of the log file. Default: log.log
  --log LOG_LEVEL       The logging level [DEBUG, INFO, WARNING, ERROR,
                        CRITICAL]
```

## bubblegun_biggestcomp

### Tool Description
Command for separating biggest component

### Metadata
- **Docker Image**: quay.io/biocontainers/bubblegun:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Package**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Total Downloads**: 571
- **Last updated**: 2026-02-18
- **GitHub**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Stars**: N/A
### Original Help Text
```text
usage: BubbleGun biggestcomp [-h] PATH_BIG_COMP

positional arguments:
  PATH_BIG_COMP  Biggest component output path

options:
  -h, --help     show this help message and exit

Global arguments (BubbleGun -h):
usage: BubbleGun [-h] [-g GRAPH_PATH] [-v] [--log_file LOG_FILE]
                 [--log LOG_LEVEL]
                 {bchains,compact,biggestcomp,bfs,chainout} ...

Find Bubble Chains.

Subcommands:
  {bchains,compact,biggestcomp,bfs,chainout}
                        Available subcommands
    bchains             Command for detecting bubble chains
    compact             Command for compacting graphs
    biggestcomp         Command for separating biggest component
    bfs                 Command for separating neighborhood
    chainout            Outputs certain chain(s) given by their id as a GFA
                        file

Global Arguments:
  -h, --help            show this help message and exit
  -g, --in_graph GRAPH_PATH
                        graph file path (GFA or VG)
  -v, --version         outputs version
  --log_file LOG_FILE   The name/path of the log file. Default: log.log
  --log LOG_LEVEL       The logging level [DEBUG, INFO, WARNING, ERROR,
                        CRITICAL]
```

## bubblegun_bfs

### Tool Description
Command for separating neighborhood

### Metadata
- **Docker Image**: quay.io/biocontainers/bubblegun:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Package**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Total Downloads**: 571
- **Last updated**: 2026-02-18
- **GitHub**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Stars**: N/A
### Original Help Text
```text
usage: BubbleGun bfs [-h] [--start START_NODES [START_NODES ...]]
                     [--neighborhood_size SIZE] [--output_neighborhood OUTPUT]

options:
  -h, --help            show this help message and exit
  --start START_NODES [START_NODES ...]
                        Give the starting node(s) for neighborhood extraction
  --neighborhood_size SIZE
                        With -s --start option, size of neighborhood to
                        extract
  --output_neighborhood OUTPUT
                        Output neighborhood file

Global arguments (BubbleGun -h):
usage: BubbleGun [-h] [-g GRAPH_PATH] [-v] [--log_file LOG_FILE]
                 [--log LOG_LEVEL]
                 {bchains,compact,biggestcomp,bfs,chainout} ...

Find Bubble Chains.

Subcommands:
  {bchains,compact,biggestcomp,bfs,chainout}
                        Available subcommands
    bchains             Command for detecting bubble chains
    compact             Command for compacting graphs
    biggestcomp         Command for separating biggest component
    bfs                 Command for separating neighborhood
    chainout            Outputs certain chain(s) given by their id as a GFA
                        file

Global Arguments:
  -h, --help            show this help message and exit
  -g, --in_graph GRAPH_PATH
                        graph file path (GFA or VG)
  -v, --version         outputs version
  --log_file LOG_FILE   The name/path of the log file. Default: log.log
  --log LOG_LEVEL       The logging level [DEBUG, INFO, WARNING, ERROR,
                        CRITICAL]
```

## bubblegun_chainout

### Tool Description
Outputs certain chain(s) given by their id as a GFA file

### Metadata
- **Docker Image**: quay.io/biocontainers/bubblegun:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Package**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bubblegun/overview
- **Total Downloads**: 571
- **Last updated**: 2026-02-18
- **GitHub**: https://github.com/fawaz-dabbaghieh/bubble_gun
- **Stars**: N/A
### Original Help Text
```text
usage: BubbleGun chainout [-h] [--json_file JSON_FILE]
                          [--chain_ids CHAIN_IDS [CHAIN_IDS ...]]
                          [--output_chain OUTPUT]

options:
  -h, --help            show this help message and exit
  --json_file JSON_FILE
                        The JSON file wtih bubble chains information
  --chain_ids CHAIN_IDS [CHAIN_IDS ...]
                        Give the chain Id(s) to be outputted
  --output_chain OUTPUT
                        Output path for the chains chosen

Global arguments (BubbleGun -h):
usage: BubbleGun [-h] [-g GRAPH_PATH] [-v] [--log_file LOG_FILE]
                 [--log LOG_LEVEL]
                 {bchains,compact,biggestcomp,bfs,chainout} ...

Find Bubble Chains.

Subcommands:
  {bchains,compact,biggestcomp,bfs,chainout}
                        Available subcommands
    bchains             Command for detecting bubble chains
    compact             Command for compacting graphs
    biggestcomp         Command for separating biggest component
    bfs                 Command for separating neighborhood
    chainout            Outputs certain chain(s) given by their id as a GFA
                        file

Global Arguments:
  -h, --help            show this help message and exit
  -g, --in_graph GRAPH_PATH
                        graph file path (GFA or VG)
  -v, --version         outputs version
  --log_file LOG_FILE   The name/path of the log file. Default: log.log
  --log LOG_LEVEL       The logging level [DEBUG, INFO, WARNING, ERROR,
                        CRITICAL]
```


## Metadata
- **Skill**: generated
