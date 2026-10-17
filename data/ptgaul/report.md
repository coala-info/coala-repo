# ptgaul CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ptgaul_combine_gfa.py | PASS |  |
| ptgaul_ptGAUL.sh | PASS |  |

## ptgaul_ptGAUL.sh

### Tool Description
this pipeline is used for plastome assembly using long read data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Bean061/ptgaul
- **Stars**: N/A
### Original Help Text
```text
Usage: ptGAUL.sh -r (REFERENCE FILE) -l (LONG READ FILE)

                 [-t threads int] [-g genome size int]
                 [-c coverage int] [-f filter threshold int]
                 [-o output directory string]

this pipeline is used for plastome assembly using long read data.

optional arguments: 
-h, --help            <show this help message and exit>
-r, --reference       <MANDATORY: reference contigs or scaffolds in fasta format>
-l, --longreads       <MANDATORY: raw long reads in fasta/fastq/fq.gz format>
-t, --threads         <number of threads, default:1>
-g, --genomesize      <expected genome size of plastome (bp), default:160000>
-c, --coverage        <a rough coverage of data used for plastome assembly, default:50>
-f, --filtered        <the raw long reads will be filtered if the lengths are less than this number (bp); default: 3000>
-o, --outputdir       <output directory of results, defult is current directory>


                     _____           _        _         _    _
  ___      _       /  ___  \       / _ \     | |       | |  | |
 / _ \    | |     / /     \ \     / / \ \    | |       | |  | |
/ / \ \ __| |__  | |       \_|    / / \ \    | |       | |  | |
||   |||__   __| | |             / / _ \ \   | |       | |  | |
| \_/ /   | |    | |      ___    /  ___  \   | |       | |  | |
|  __/    | |_   | |     |__ |  / /     \ \  \ \       / /  | |        _
| |       |   |   \ \ ___ / /   / /     \ \   \ \ ___ / /   | | _____ | |
|_|       |__/     \ _____ /   /_/       \_\   \ _____ /    | _________ |






                     _____           _        _         _    _
  ___      _       /  ___  \       / _ \     | |       | |  | |
 / _ \    | |     / /     \ \     / / \ \    | |       | |  | |
/ / \ \ __| |__  | |       \_|    / / \ \    | |       | |  | |
||   |||__   __| | |             / / _ \ \   | |       | |  | |
| \_/ /   | |    | |      ___    /  ___  \   | |       | |  | |
|  __/    | |_   | |     |__ |  / /     \ \  \ \       / /  | |        _
| |       |   |   \ \ ___ / /   / /     \ \   \ \ ___ / /   | | _____ | |
|_|       |__/     \ _____ /   /_/       \_\   \ _____ /    | _________ |
```


## ptgaul_combine_gfa.py

### Tool Description
This script is used to merge the edges from assembly graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

### Original Help Text
```text
usage: combine_gfa.py [-h] [-e INPUT_EDGES] [-d SORTED_DEPTH_FILE]
                      [-o OUTPUTDIR]

This script is used to merge the edges from assembly graph.

optional arguments:
  -h, --help            show this help message and exit
  -e INPUT_EDGES, --input_edges_file INPUT_EDGES
                        input edge fasta file
  -d SORTED_DEPTH_FILE, --sorted_depth SORTED_DEPTH_FILE
                        input depth file
  -o OUTPUTDIR, --outputdir OUTPUTDIR
                        output directory
```


## Metadata
- **Skill**: generated
