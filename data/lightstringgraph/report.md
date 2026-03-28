# lightstringgraph CWL Generation Report

## lightstringgraph_lsg

### Tool Description
Light String Graph tool

### Metadata
- **Docker Image**: quay.io/biocontainers/lightstringgraph:0.4.0--h9948957_7
- **Homepage**: http://lsg.algolab.eu
- **Package**: https://anaconda.org/channels/bioconda/packages/lightstringgraph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lightstringgraph/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: lsg -B <basename> [-G <GSAFilename>] [-T <TAU>] [-C <CycNum>] [-l <readLenght>]

Options:
	-B, --basename    <basename>     # (required)
	-G, --GSA         <GSAFilename>  # (default: '<basename>.pairSA')
	-T, --TAU         <TAU>          # (default: 0)
	-C, --CycNum      <CycNum>       # (default: 0)
	-l, --read-length <readLength>   # 0 if unknown or not fixed (default: 0)
```


## lightstringgraph_redbuild

### Tool Description
Builds a light string graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/lightstringgraph:0.4.0--h9948957_7
- **Homepage**: http://lsg.algolab.eu
- **Package**: https://anaconda.org/channels/bioconda/packages/lightstringgraph/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: redbuild  -b <basename>  -m <max_arc_length>  [-g <bucket_length>]  [-r] 

Parameters:
	-b <basename>        # (required)
	-m <max_arc_length>  # (required)
	[-g <bucket length>] # (optional) % default = 1000000
	[-r]                 # (optional) % default = 1
```


## lightstringgraph_graph2asqg

### Tool Description
Converts a string graph to ASQG format.

### Metadata
- **Docker Image**: quay.io/biocontainers/lightstringgraph:0.4.0--h9948957_7
- **Homepage**: http://lsg.algolab.eu
- **Package**: https://anaconda.org/channels/bioconda/packages/lightstringgraph/overview
- **Validation**: PASS

### Original Help Text
```text
* ERROR(parse_cmds        :d/graph2asqg.cpp:114 ) 12:43:43 | Can't parse argument: --help
Usage: graph2asqg  -b <basename>  [-r <read_filename>]  -l <read_length>  [-n]

Parameters:
	-b <basename>        # (required)
	-r <read_filename>   # (optional, default: <basename>) 
	-l <read_length>     # (required) 
	-n                   # (optional) use numeric IDs instead of FASTA IDs
```


## Metadata
- **Skill**: generated
