# mirmachine CWL Generation Report

## mirmachine_MirMachine.py

### Tool Description
Main MirMachine executable

### Metadata
- **Docker Image**: quay.io/biocontainers/mirmachine:0.3.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/sinanugur/MirMachine
- **Package**: https://anaconda.org/channels/bioconda/packages/mirmachine/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mirmachine/overview
- **Total Downloads**: 22.2K
- **Last updated**: 2025-10-23
- **GitHub**: https://github.com/sinanugur/MirMachine
- **Stars**: N/A
### Original Help Text
```text
Main MirMachine executable

Usage:
    MirMachine.py --node <text> --species <text> --genome <text> [--model <text>] [--evalue <float>] [--cpu <integer>] [--add-all-nodes|--single-node-only] [--unlock|--remove] [--touch] [--dry]
    MirMachine.py --species <text> --genome <text> --family <text> [--model <text>] [--evalue <float>] [--cpu <integer>] [--unlock|--remove] [--touch] [--dry]
    MirMachine.py --node <text> [--add-all-nodes]
    MirMachine.py --print-all-nodes
    MirMachine.py --print-all-families
    MirMachine.py --print-ascii-tree
    MirMachine.py (-h | --help)
    MirMachine.py --version

Arguments:
    -n <text>, --node <text>              Node name. (e.g. Caenorhabditis)
    -s <text>, --species <text>           Species name. (e.g. Caenorhabditis_elegans)
    -g <text>, --genome <text>            Genome fasta file location (e.g. data/genome/example.fasta)
    -m <text>, --model <text>             Model type: deutero, proto, combined [default: combined]
    -f <text>, --family <text>            Run only a single miRNA family (e.g. Let-7).
    -e <text>, --evalue <float>           Inclusion E-value. May inflate low quality hits. [default: 0.2]
    -c <integer>, --cpu <integer>         CPUs. [default: 2]

Options:
    -a, --add-all-nodes                 Move on the tree both ways. NOT required most of the time.
    -o, --single-node-only              Run only on the given node for miRNA families.
    -p, --print-all-nodes               Print all available node options and exit.
    -l, --print-all-families            Print all available families in this version and exit.
    -t, --print-ascii-tree              Print ascii tree of the tree file.
    -u, --unlock                        Rescue stalled jobs (Try this if the previous job ended prematurely).
    -r, --remove                        Clear all output files (this won't remove input files).
    -d, --dry                           Dry run.
    -h, --help                          Show this screen.
    --touch                             Touch output files (mark them up to date without really changing them).
    --version                           Show version.
```

