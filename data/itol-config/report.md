# itol-config CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| itol-config_binary_data | PASS | 0/1 matrix derived from real nf-core sample metadata gave a correct DATASET_BINARY file; without --colour-conf the tool crashes (tool bug). |
| itol-config_colour_strip | PASS | Real nf-core sample metadata CSV gave one colour strip file per column with correct sample colours. |
| itol-config_text_label | PASS | Real nf-core sample metadata CSV gave one text label file per column with the right labels. |

## itol-config_colour_strip

### Tool Description
Generates an iTOL configuration file for colouring tree branches based on sequence metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/itol-config:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/itol-config
- **Package**: https://anaconda.org/channels/bioconda/packages/itol-config/overview
- **Validation**: PASS

### Original Help Text
```text
usage: itol_config colour_strip [-h] --input INPUT --output OUTPUT [--id ID]
                                [--colour-conf COLOUR_CONF]

options:
  -h, --help            show this help message and exit
  --input INPUT         Input file containing a csv file with sequence
                        metadata
  --output OUTPUT       Output file name for the iTOL configuration file
  --id ID               Column name matching the sequence IDs used in the tree
  --colour-conf COLOUR_CONF
                        Colour configuration file
```


## itol-config_text_label

### Tool Description
Generates an iTOL text label configuration file from a CSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/itol-config:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/itol-config
- **Package**: https://anaconda.org/channels/bioconda/packages/itol-config/overview
- **Validation**: PASS

### Original Help Text
```text
usage: itol_config text_label [-h] --input INPUT --output OUTPUT [--id ID]
                              [--colour-conf COLOUR_CONF]

options:
  -h, --help            show this help message and exit
  --input INPUT         Input file containing a csv file with sequence
                        metadata
  --output OUTPUT       Output file name for the iTOL configuration file
  --id ID               Column name matching the sequence IDs used in the tree
  --colour-conf COLOUR_CONF
                        Colour configuration file
```


## itol-config_binary_data

### Tool Description
Generates an iTOL configuration file for binary data from a CSV input.

### Metadata
- **Docker Image**: quay.io/biocontainers/itol-config:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/jodyphelan/itol-config
- **Package**: https://anaconda.org/channels/bioconda/packages/itol-config/overview
- **Validation**: PASS

### Original Help Text
```text
usage: itol_config binary_data [-h] --input INPUT --output OUTPUT [--id ID]
                               [--colour-conf COLOUR_CONF]
                               [--symbol {1,2,3,4,5,6}]

options:
  -h, --help            show this help message and exit
  --input INPUT         Input file containing a csv file with sequence
                        metadata
  --output OUTPUT       Output file name for the iTOL configuration file
  --id ID               Column name matching the sequence IDs used in the tree
  --colour-conf COLOUR_CONF
                        Colour configuration file
  --symbol {1,2,3,4,5,6}
                        The symbol to use for the binary data (1: square, 2:
                        circle, 3: star, 4: right triangle, 5: left triangle,
                        6: checkmark)
```


## Metadata
- **Skill**: generated
