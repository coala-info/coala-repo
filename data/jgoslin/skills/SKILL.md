---
name: jgoslin
description: jgoslin parses and normalizes lipid shorthand notation into a consistent structural format. Use when user asks to parse lipid names, normalize lipid nomenclature, or extract structural metadata from lipid shorthand strings.
homepage: https://github.com/lifs-tools/jgoslin
metadata:
  docker_image: "quay.io/biocontainers/jgoslin:2.2.0--hdfd78af_0"
---

# jgoslin

## Overview
jgoslin is a specialized tool designed to resolve the ambiguity in lipid shorthand notation. It acts as a parser and normalizer that translates diverse lipid naming conventions into a consistent, structural format based on the Grammar of Succinct Lipid Nomenclature (Goslin). Use this skill to automate the validation of lipid lists, generate normalized names for publication, or extract structural metadata from shorthand strings.

## CLI Usage and Patterns

The jgoslin command-line interface (CLI) is the primary method for batch processing and validation.

### Basic Parsing
To parse a single lipid name directly from the terminal:
```bash
java -jar jgoslin-cli-<VERSION>.jar -n "Cer(d31:1/20:1)"
```

### Batch Processing
To process a text file containing one lipid name per line:
```bash
java -jar jgoslin-cli-<VERSION>.jar -f lipid_list.txt
```

### Output Management
To save the results to a tab-separated (TSV) file named `goslin-out.tsv`:
```bash
java -jar jgoslin-cli-<VERSION>.jar -f lipid_list.txt -o
```

### Grammar Selection
If you know the specific dialect of your lipid names, you can force the parser to use a specific grammar (e.g., GOSLIN, LipidMaps, SwissLipids) to improve accuracy and performance:
```bash
java -jar jgoslin-cli-<VERSION>.jar -f lipid_list.txt -g GOSLIN
```

## Docker Integration
For environments where Java 17 is not natively installed, use the Docker container. Ensure you mount your local data directory to the container's internal path.

```bash
docker run -v /path/to/your/data:/home/data:rw lifs/jgoslin-cli:<VERSION> -f /home/data/lipidnames.txt
```

## Expert Tips
- **Java Requirement**: jgoslin requires Java 17 (LTS) or higher. If building from source, use `./mvnw install` to generate the CLI JAR in the `cli/target` directory.
- **Dialect Handling**: If a lipid name fails to parse with the default settings, try specifying different grammars using the `-g` flag, as shorthand notations often vary significantly between different databases and software tools.
- **Normalization**: The tool's primary strength is normalization. Always use the `-o` flag when processing large datasets to ensure you have a structured record of the normalized names and structural components for downstream analysis.

## Reference documentation
- [jgoslin GitHub Repository](./references/github_com_lifs-tools_jgoslin.md)
- [jgoslin Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_jgoslin_overview.md)