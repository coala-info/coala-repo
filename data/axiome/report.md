# axiome CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| axiome_process | PASS |  |
| axiome_utility | PASS |  |

## axiome_process

### Tool Description
Axiome process command for data processing

### Metadata
- **Docker Image**: quay.io/biocontainers/axiome:2.0.4--py27_0
- **Homepage**: https://github.com/ujjwalredd/Axiomeer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
usage: axiome process [-h] -i input
axiome process: error: argument -h/--help: ignored explicit argument 'elp'
```

## axiome_utility

### Tool Description
Generates a file mapping template or copies AXIOME sample data into the current directory

### Metadata
- **Docker Image**: quay.io/biocontainers/axiome:2.0.4--py27_0
- **Homepage**: https://github.com/ujjwalredd/Axiomeer
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: axiome utility [-h] {mapping_template,sample_data}

positional arguments:
  {mapping_template,sample_data}
                        mapping_template: generates a file mapping template in
                        the current directory, which can be opened in a
                        spreadsheet program; sample_data: copies AXIOME sample
                        data into the current directory

optional arguments:
  -h, --help            show this help message and exit
```

## Metadata
- **Skill**: generated
