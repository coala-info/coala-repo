# flexi-formatter CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| flexi-formatter_main | Failed | tool bug: with current flexiplex read names (BARCODE_UMI#READID) the CB tag is set to the read id instead of the barcode; only names without a UMI give a correct CB |

## flexi-formatter_main

### Tool Description
Move the flexiplex barcode and UMI from the read name of a SAM file to the CB and UR tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexi-formatter:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/VIB-CCB-BioIT/flexiplex_tag_formatter
- **Package**: https://anaconda.org/channels/bioconda/packages/flexi-formatter/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: flexi_formatter main [OPTIONS] INFILE                                   
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    infile      TEXT  [default: None] [required]                            │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

