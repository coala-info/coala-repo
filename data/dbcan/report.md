# dbcan CWL Generation Report

## dbcan_run_dbcan

### Tool Description
use dbCAN tools to annotate and analyze CAZymes and CGCs.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
Usage: run_dbcan [OPTIONS] COMMAND [ARGS]...                                   
                                                                                
 use dbCAN tools to annotate and analyze CAZymes and CGCs.                      
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --verbose    -v                                Enable verbose logging        │
│                                                (equivalent to --log-level    │
│                                                DEBUG)                        │
│ --log-file       PATH                          Write logs to file in         │
│                                                addition to console           │
│ --log-level      [DEBUG|INFO|WARNING|ERROR|CR  Set logging level (default:   │
│                  ITICAL]                       WARNING, only shows warnings  │
│                                                and errors)                   │
│ --help                                         Show this message and exit.   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ CAZyme_annotation     annotate CAZyme using run_dbcan with prokaryotic,      │
│                       metagenomics, and protein sequences.                   │
│ Pfam_null_cgc         identify CAZyme Gene Clusters(CGCs)                    │
│ cgc_circle_plot       generate circular plots for CAZyme Gene                │
│                       Clusters(CGCs).                                        │
│ cgc_finder            identify CAZyme Gene Clusters(CGCs)                    │
│ database              download dbCAN databases.                              │
│ easy_CGC              Perform complete CGC analysis: CAZyme annotation, GFF  │
│                       processing, and CGC identification in one step.        │
│ easy_substrate        Perform complete CGC analysis: CAZyme annotation, GFF  │
│                       processing, CGC identification, and substrate          │
│                       prediction in one step.                                │
│ gff_process           Generate GFF for CGC identification. need --input_gff  │
│                       when --input_raw_data is protein sequence. if          │
│                       --input_gff is not provided, will set default          │
│                       <output_dir>/uniInput.gff.                             │
│ substrate_prediction                                                         │
│ version               show version information.                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```

