# bubblegun CWL Generation Report

## bubblegun_BubbleGun

### Tool Description
Find Bubble Chains.

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

