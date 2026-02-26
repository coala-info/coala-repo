# seqspec CWL Generation Report

## seqspec_build

### Tool Description
Generate a complete seqspec with natural language.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/sbooeshaghi/seqspec
- **Stars**: N/A
### Original Help Text
```text
usage: seqspec build [-h] -n NAME -m MODALITIES [--doi DOI]
                     [--description DESCRIPTION] [--date DATE]
                     [--trace TRACE_JSONL] [--verbose [{simple,extended,all}]]
                     [-o OUT]

Generate a complete seqspec with natural language.

Example:
seqspec build -o spec.yaml --description "An extensive description of the assay and sequencing reads" -n "seqspec generated with LLM" -m rna

options:
  -h, --help            show this help message and exit
  --doi DOI             DOI of the assay
  --description DESCRIPTION
                        Short description
  --date DATE           Date (YYYY-MM-DD)
  --trace TRACE_JSONL   Write OpenTelemetry spans to this JSONL file for later viewing
  --verbose [{simple,extended,all}]
                        Enable console tracing. Default mode is 'simple' if no value is given. Modes: simple | extended | all
  -o OUT, --output OUT  Output YAML (default stdout)

required arguments:
  -n NAME, --name NAME  Assay name
  -m MODALITIES, --modalities MODALITIES
                        Comma-separated list of modalities (e.g. rna,atac)
```


## seqspec_check

### Tool Description
Validate seqspec file against the specification schema.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec check [-h] [-o OUT] [-s SKIP] yaml

Validate seqspec file against the specification schema.

Examples:
seqspec check spec.yaml
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
  -s SKIP, --skip SKIP  Skip checks
```


## seqspec_find

### Tool Description
Find objects in the spec.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec find [-h] [-o OUT] [-s SELECTOR] -m MODALITY [-i ID] yaml

Find objects in the spec.

Examples:
seqspec find -m rna -s read -i rna_R1 spec.yaml         # Find reads by id
seqspec find -m rna -s region-type -i barcode spec.yaml # Find regions with barcode region type
seqspec find -m rna -s file -i r1.fastq.gz spec.yaml    # Find files with id r1.fastq.gz
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
  -s SELECTOR, --selector SELECTOR
                        Selector, [read,region,file,region-type] (default: region)

required arguments:
  -m MODALITY, --modality MODALITY
                        Modality
  -i ID, --id ID        ID to search for
```


## seqspec_file

### Tool Description
List files present in seqspec file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec file [-h] [-o OUT] [-i IDs] -m MODALITY [-s SELECTOR]
                    [-f FORMAT] [-k KEY] [--fullpath]
                    yaml

List files present in seqspec file.

Examples:
seqspec file -m rna spec.yaml                                          # List paired read files
seqspec file -m rna -f interleaved spec.yaml                           # List interleaved read files
seqspec file -m rna -f list -k url spec.yaml                           # List urls of all read files
seqspec file -m rna -f list -s region -k all spec.yaml                 # List all files in regions
seqspec file -m rna -f json -s region-type -k all -i barcode spec.yaml # List files for barcode regions in json
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
  -i IDs, --ids IDs     Ids to list
  -s SELECTOR, --selector SELECTOR
                        Selector for ID, [read, region, file, region-type] (default: read)
  -f FORMAT, --format FORMAT
                        Format, [paired, interleaved, index, list, json], default: paired
  -k KEY, --key KEY     Key, [file_id, filename, filetype, filesize, url, urltype, md5, all], default: file_id
  --fullpath            Use full path for local files

required arguments:
  -m MODALITY, --modality MODALITY
                        Modality
```


## seqspec_format

### Tool Description
Automatically fill in missing fields in the spec.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec format [-h] [-o OUT] yaml

Automatically fill in missing fields in the spec.

Examples:
seqspec format spec.yaml              # Format spec and write to stdout
seqspec format -o spec.yaml spec.yaml # Format and overwrite the spec
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
```


## seqspec_index

### Tool Description
Identify the position of elements in a spec for use in downstream tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec index [-h] [-o OUT] [-t TOOL] [-s SELECTOR] [--rev] -m MODALITY
                     [-i IDs] [--no-overlap]
                     yaml

Identify the position of elements in a spec for use in downstream tools.

Examples:
seqspec index -m rna -s file -t kb spec.yaml                              # Index file elements in kallisto bustools format
seqspec index -m rna -s file spec.yaml                                    # Index file elements corresponding to reads
seqspec index -m rna -s read -i rna_R1 spec.yaml                          # Index read elements in rna_R1
seqspec index -m rna -s file -i rna_R1.fastq.gz,rna_R2.fastq.gz spec.yaml # Index file elements in rna reads
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
  -t TOOL, --tool TOOL  Tool, [chromap, kb, kb-single, relative, seqkit, simpleaf, starsolo, splitcode, tab, zumis] (default: tab)
  -s SELECTOR, --selector SELECTOR
                        Selector for ID, [read, region, file] (default: read)
  --rev                 Returns 3'->5' region order
  --no-overlap          Disable overlap (default: False)

required arguments:
  -m MODALITY, --modality MODALITY
                        Modality
  -i IDs, --ids IDs     IDs
```


## seqspec_info

### Tool Description
Get information about spec.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec info [-h] [-k KEY] [-f FORMAT] [-o OUT] yaml

Get information about spec.

Examples:
seqspec info -k modalities spec.yaml            # Get the list of modalities
seqspec info -f json spec.yaml                  # Get meta information in json format
seqspec info -f json -k library_spec spec.yaml  # Get library spec in json format
seqspec info -f json -k sequence_spec spec.yaml # Get sequence spec in json format
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -k KEY, --key KEY     Object to display, [modalities, meta, sequence_spec, library_spec] (default: meta)
  -f FORMAT, --format FORMAT
                        The output format, [tab, json] (default: tab)
  -o OUT, --output OUT  Path to output file
```


## seqspec_init

### Tool Description
Generate a new *empty* seqspec draft (meta-Regions only).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec init [-h] -n NAME -m MODALITIES [--doi DOI]
                    [--description DESCRIPTION] [--date DATE] [-o OUT]

Generate a new *empty* seqspec draft (meta-Regions only).

Example:
    seqspec init -n myassay -m rna,atac -o spec.yaml

options:
  -h, --help            show this help message and exit
  --doi DOI             DOI of the assay
  --description DESCRIPTION
                        Short description
  --date DATE           Date (YYYY-MM-DD)
  -o OUT, --output OUT  Output YAML (default stdout)

required arguments:
  -n NAME, --name NAME  Assay name
  -m MODALITIES, --modalities MODALITIES
                        Comma-separated list of modalities (e.g. rna,atac)
```


## seqspec_insert

### Tool Description
Draft spec to modify

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec insert [-h] -m MODALITY -s {region,read} -r IN [--after ID]
                      [-o OUT]
                      yaml

positional arguments:
  yaml                  Draft spec to modify

options:
  -h, --help            show this help message and exit
  --after ID            Insert after region ID (only for --selector region)
  -o OUT, --output OUT  Write updated spec (default stdout)

required arguments:
  -m MODALITY, --modality MODALITY
                        Target modality
  -s {region,read}, --selector {region,read}
                        Section to insert into
  -r IN, --resource IN  Path or inline JSON. For reads, expects a list of objects like '[{"read_id": "R1", "files": ["r1.fastq.gz"]}]'.
```


## seqspec_methods

### Tool Description
Convert seqspec file into methods section.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec methods [-h] -m MODALITY [-o OUT] yaml

Convert seqspec file into methods section.

Examples:
seqspec methods -m rna -o methods.txt spec.yaml  # Save methods section to file
seqspec methods -m rna spec.yaml                 # Print methods section to stdout
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file

required arguments:
  -m MODALITY, --modality MODALITY
                        Modality
```


## seqspec_modify

### Tool Description
Modify attributes of various elements in a seqspec file using JSON objects.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec modify [-h] -k KEYS [-o OUT] [-s SELECTOR] -m MODALITY yaml

Modify attributes of various elements in a seqspec file using JSON objects.

Examples:
seqspec modify -m rna -o mod_spec.yaml -s read -k '[{"read_id": "rna_R1", "name": "renamed_rna_R1"}]' spec.yaml
seqspec modify -m rna -o mod_spec.yaml -s region -k '[{"region_id": "rna_cell_bc", "name": "renamed_rna_cell_bc"}]' spec.yaml
seqspec modify -m rna -o mod_spec.yaml -s file -k '[{"file_id": "R1.fastq.gz", "url": "./fastq/R1.fastq.gz"}]' spec.yaml
seqspec modify -m rna -o mod_spec.yaml -s seqkit -k '[{"kit_id": "NovaSeq_kit", "name": "Updated NovaSeq Kit"}]' spec.yaml
seqspec modify -m rna -o mod_spec.yaml -s seqprotocol -k '[{"protocol_id": "Illumina_NovaSeq", "name": "Updated Protocol"}]' spec.yaml
seqspec modify -m rna -o mod_spec.yaml -s libkit -k '[{"kit_id": "Truseq_kit", "name": "Updated Truseq Kit"}]' spec.yaml
seqspec modify -m rna -o mod_spec.yaml -s libprotocol -k '[{"protocol_id": "10x_protocol", "name": "Updated 10x Protocol"}]' spec.yaml
seqspec modify -m rna -o mod_spec.yaml -s assay -k '[{"assay_id": "my_assay", "name": "Updated Assay Name"}]' spec.yaml
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
  -s SELECTOR, --selector SELECTOR
                        Selector for ID, [read, region, file, seqkit, seqprotocol, libkit, libprotocol, assay] (default: read)

required arguments:
  -k KEYS, --keys KEYS  JSON array of objects to modify. Each object must include an id field (read_id, region_id, file_id, kit_id, protocol_id, or assay_id).
  -m MODALITY, --modality MODALITY
                        Modality of the assay
```


## seqspec_onlist

### Tool Description
Get onlist file for specific region. Onlist is a list of permissible sequences for a region.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec onlist [-h] [-o OUT] [-s SELECTOR] [-f FORMAT] [-i ID] -m
                      MODALITY
                      yaml

Get onlist file for specific region. Onlist is a list of permissible sequences for a region.

Examples:
seqspec onlist -m rna -s read -i rna_R1 spec.yaml                           # Get onlist URLs for the element in the R1.fastq.gz read
seqspec onlist -m rna -s region-type -i barcode spec.yaml                   # Get onlist URLs for barcode region type
seqspec onlist -m rna -s read -i rna_R1 -o output.txt spec.yaml             # Download and save onlist files
seqspec onlist -m rna -s read -i rna_R1 -f product -o joined.txt spec.yaml  # Join multiple onlists
---
        

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file (required for download/join operations)
  -s SELECTOR, --selector SELECTOR
                        Selector for ID, [read, region, region-type] (default: read)
  -f FORMAT, --format FORMAT
                        Format for combining multiple onlists (product, multi)

required arguments:
  -i ID, --id ID        ID to search for
  -m MODALITY, --modality MODALITY
                        Modality
```


## seqspec_print

### Tool Description
Print sequence and/or library structure as ascii, png, or html.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec print [-h] [-o OUT] [-f FORMAT] yaml

Print sequence and/or library structure as ascii, png, or html.

Examples:
seqspec print spec.yaml                            # Print the library structure as ascii
seqspec print -f seqspec-ascii spec.yaml           # Print the sequence and library structure as ascii
seqspec print -f seqspec-html spec.yaml            # Print the sequence and library structure as html
seqspec print -o spec.png -f seqspec-png spec.yaml # Print the library structure as a png
---
        

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
  -f FORMAT, --format FORMAT
                        Format (library-ascii, seqspec-html, seqspec-png, seqspec-ascii), default: library-ascii
```


## seqspec_split

### Tool Description
Split seqspec file into one file per modality.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec split [-h] -o OUT yaml

Split seqspec file into one file per modality.

Examples:
seqspec split -o split spec.yaml  # Split spec into modalities
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit

required arguments:
  -o OUT, --output OUT  Path to output files
```


## seqspec_upgrade

### Tool Description
Upgrade seqspec file from older versions to the current version.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec upgrade [-h] [-o OUT] yaml

Upgrade seqspec file from older versions to the current version.

Examples:
seqspec upgrade -o upgraded.yaml spec.yaml  # Upgrade and save to new file
seqspec upgrade spec.yaml                   # Upgrade and print to stdout
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
```


## seqspec_version

### Tool Description
Get seqspec version and seqspec file version.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/sbooeshaghi/seqspec
- **Package**: https://anaconda.org/channels/bioconda/packages/seqspec/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seqspec version [-h] [-o OUT] yaml

Get seqspec version and seqspec file version.

Examples:
seqspec version -o version.txt spec.yaml  # Save version info to file
seqspec version spec.yaml                 # Print version info to stdout
---

positional arguments:
  yaml                  Sequencing specification yaml file

options:
  -h, --help            show this help message and exit
  -o OUT, --output OUT  Path to output file
```

