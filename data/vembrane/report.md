# vembrane CWL Generation Report

## vembrane_valid

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Total Downloads**: 68.3K
- **Last updated**: 2025-09-27
- **GitHub**: https://github.com/vembrane/vembrane
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: vembrane [-h] [--version]
                {filter,table,annotate,tag,structured,fhir,sort} ...
vembrane: error: argument command: invalid choice: 'valid' (choose from filter, table, annotate, tag, structured, fhir, sort)
```


## vembrane_filter

### Tool Description
Filter VCF/BCF records and annotations based on a user-defined Python
expression.Only records for which the expression evaluates to True are kept.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vembrane filter [-h] [--output OUTPUT]
                       [--output-fmt {vcf,bcf,uncompressed-bcf}]
                       [--statistics FILE] [--keep-unmatched]
                       [--preserve-order] [--annotation-key FIELDNAME]
                       [--aux NAME=PATH] [--context CONTEXT]
                       [--context-file CONTEXT_FILE] [--ontology PATH]
                       [--overwrite-number-info FIELD=NUMBER]
                       [--overwrite-number-format FIELD=NUMBER]
                       [--backend {cyvcf2,pysam}]
                       expression [vcf]

Filter VCF/BCF records and annotations based on a user-defined Python
expression.Only records for which the expression evaluates to True are kept.

positional arguments:
  expression            A python expression to filter variants. The expression
                        must evaluate to bool. All VCF/BCF fields can be
                        accessed. Additionally, annotation fields can be
                        accessed, see `--annotation-key`. If all annotations
                        of a record are filtered out, the entire record is
                        removed.
  vcf                   Path to the VCF/BCF file to be filtered. Defaults to
                        '-' for stdin. (default: -)

options:
  -h, --help            show this help message and exit
  --output OUTPUT, -o OUTPUT
                        Output file, if not specified, output is written to
                        STDOUT. (default: -)
  --output-fmt {vcf,bcf,uncompressed-bcf}, -O {vcf,bcf,uncompressed-bcf}
                        Output format. (default: vcf)
  --statistics FILE, -s FILE
                        Write statistics to this file.
  --keep-unmatched      Keep all annotations of a variant if at least one of
                        them passes the expression.
  --preserve-order      Ensures that the order of the output matches that of
                        the input. This is only useful if the input contains
                        breakends (BNDs) since the order of all other variants
                        is preserved anyway.
  --annotation-key FIELDNAME, -k FIELDNAME
                        The INFO key for the annotation field. This defaults
                        to 'ANN', but tools might use other field names. For
                        example, default VEP annotations can be parsed by
                        setting 'CSQ' here. (default: ANN)
  --aux NAME=PATH, -a NAME=PATH
                        Path to an auxiliary file containing a set of symbols
  --context CONTEXT     Python statement defining a context for given Python
                        expressions. Extends eventual definitions given via
                        --context-file. Any global variables (or functions)
                        become available in the Python expressions. Note that
                        the code you pass here is not sandboxed and should be
                        trusted. Carefully review any code you get from the
                        internet or AI.
  --context-file CONTEXT_FILE
                        Path to Python script defining a context for given
                        Python expressions. Any global variables (or
                        functions) become available in the Python expressions.
                        Note that the code you pass here is not sandboxed and
                        should be trusted. Carefully review any code you get
                        from the internet or AI.
  --ontology PATH       Path to an ontology in OBO format. May be compressed
                        with gzip, bzip2 and xz. Defaults to built-in ontology
                        (from sequenceontology.org).
  --overwrite-number-info FIELD=NUMBER
                        Overwrite the number specification for INFO fields
                        given in the VCF header. Example: `--overwrite-number
                        cosmic_CNT=.`
  --overwrite-number-format FIELD=NUMBER
                        Overwrite the number specification for FORMAT fields
                        given in the VCF header. Example: `--overwrite-number-
                        format DP=2`
  --backend {cyvcf2,pysam}, -b {cyvcf2,pysam}
                        Set the backend library. (default: cyvcf2)
```


## vembrane_table

### Tool Description
Convert VCF/BCF records to tabular format.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vembrane table [-h] [--separator CHAR] [--header TEXT]
                      [--naming-convention CONVENTION] [--wide] [--long LONG]
                      [--output OUTPUT] [--annotation-key FIELDNAME]
                      [--aux NAME=PATH] [--context CONTEXT]
                      [--context-file CONTEXT_FILE] [--ontology PATH]
                      [--overwrite-number-info FIELD=NUMBER]
                      [--overwrite-number-format FIELD=NUMBER]
                      [--backend {cyvcf2,pysam}]
                      expression [vcf]

Convert VCF/BCF records to tabular format.

positional arguments:
  expression            A comma-separated tuple of expressions that define the
                        table column contents. Use ALL to output all fields.
  vcf                   Path to the VCF/BCF file to be filtered. Defaults to
                        '-' for stdin. (default: -)

options:
  -h, --help            show this help message and exit
  --separator CHAR, -s CHAR
                        Define the field separator (default: \t). (default: )
  --header TEXT         Override the automatically generated header. Provide
                        "auto" (default) to automatically generate the header
                        from the expression. Provide a comma separated string
                        to manually set the header. Provide "none" to disable
                        any header output. (default: auto)
  --naming-convention CONVENTION
                        The naming convention to use for column names when
                        generating the header for the ALL expression.
                        (default: dictionary)
  --wide                Instead of using long format with a special SAMPLE
                        column, generate multiple columns per sample with the
                        `for_each_sample` utility function.
  --long LONG           Long format is now the default. For wide format, use
                        `--wide` instead.
  --output OUTPUT, -o OUTPUT
                        Output file, if not specified, output is written to
                        STDOUT. (default: -)
  --annotation-key FIELDNAME, -k FIELDNAME
                        The INFO key for the annotation field. This defaults
                        to 'ANN', but tools might use other field names. For
                        example, default VEP annotations can be parsed by
                        setting 'CSQ' here. (default: ANN)
  --aux NAME=PATH, -a NAME=PATH
                        Path to an auxiliary file containing a set of symbols
  --context CONTEXT     Python statement defining a context for given Python
                        expressions. Extends eventual definitions given via
                        --context-file. Any global variables (or functions)
                        become available in the Python expressions. Note that
                        the code you pass here is not sandboxed and should be
                        trusted. Carefully review any code you get from the
                        internet or AI.
  --context-file CONTEXT_FILE
                        Path to Python script defining a context for given
                        Python expressions. Any global variables (or
                        functions) become available in the Python expressions.
                        Note that the code you pass here is not sandboxed and
                        should be trusted. Carefully review any code you get
                        from the internet or AI.
  --ontology PATH       Path to an ontology in OBO format. May be compressed
                        with gzip, bzip2 and xz. Defaults to built-in ontology
                        (from sequenceontology.org).
  --overwrite-number-info FIELD=NUMBER
                        Overwrite the number specification for INFO fields
                        given in the VCF header. Example: `--overwrite-number
                        cosmic_CNT=.`
  --overwrite-number-format FIELD=NUMBER
                        Overwrite the number specification for FORMAT fields
                        given in the VCF header. Example: `--overwrite-number-
                        format DP=2`
  --backend {cyvcf2,pysam}, -b {cyvcf2,pysam}
                        Set the backend library. (default: cyvcf2)
```


## vembrane_annotate

### Tool Description
Add new INFO field annotations to a VCF/BCF from other data sources, using a configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vembrane annotate [-h] [--output OUTPUT]
                         [--output-fmt {vcf,bcf,uncompressed-bcf}]
                         [--annotation-key FIELDNAME] [--aux NAME=PATH]
                         [--context CONTEXT] [--context-file CONTEXT_FILE]
                         [--ontology PATH]
                         [--overwrite-number-info FIELD=NUMBER]
                         [--overwrite-number-format FIELD=NUMBER]
                         [--backend {cyvcf2,pysam}]
                         config [vcf]

Add new INFO field annotations to a VCF/BCF from other data sources, using a
configuration file.

positional arguments:
  config                The configuration file.
  vcf                   Path to the VCF/BCF file to be filtered. Defaults to
                        '-' for stdin. (default: -)

options:
  -h, --help            show this help message and exit
  --output OUTPUT, -o OUTPUT
                        Output file, if not specified, output is written to
                        STDOUT. (default: -)
  --output-fmt {vcf,bcf,uncompressed-bcf}, -O {vcf,bcf,uncompressed-bcf}
                        Output format. (default: vcf)
  --annotation-key FIELDNAME, -k FIELDNAME
                        The INFO key for the annotation field. This defaults
                        to 'ANN', but tools might use other field names. For
                        example, default VEP annotations can be parsed by
                        setting 'CSQ' here. (default: ANN)
  --aux NAME=PATH, -a NAME=PATH
                        Path to an auxiliary file containing a set of symbols
  --context CONTEXT     Python statement defining a context for given Python
                        expressions. Extends eventual definitions given via
                        --context-file. Any global variables (or functions)
                        become available in the Python expressions. Note that
                        the code you pass here is not sandboxed and should be
                        trusted. Carefully review any code you get from the
                        internet or AI.
  --context-file CONTEXT_FILE
                        Path to Python script defining a context for given
                        Python expressions. Any global variables (or
                        functions) become available in the Python expressions.
                        Note that the code you pass here is not sandboxed and
                        should be trusted. Carefully review any code you get
                        from the internet or AI.
  --ontology PATH       Path to an ontology in OBO format. May be compressed
                        with gzip, bzip2 and xz. Defaults to built-in ontology
                        (from sequenceontology.org).
  --overwrite-number-info FIELD=NUMBER
                        Overwrite the number specification for INFO fields
                        given in the VCF header. Example: `--overwrite-number
                        cosmic_CNT=.`
  --overwrite-number-format FIELD=NUMBER
                        Overwrite the number specification for FORMAT fields
                        given in the VCF header. Example: `--overwrite-number-
                        format DP=2`
  --backend {cyvcf2,pysam}, -b {cyvcf2,pysam}
                        Set the backend library. (default: cyvcf2)
```


## vembrane_data

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: vembrane [-h] [--version]
                {filter,table,annotate,tag,structured,fhir,sort} ...
vembrane: error: argument command: invalid choice: 'data' (choose from filter, table, annotate, tag, structured, fhir, sort)
```


## vembrane_tag

### Tool Description
Flag records by adding a tag to their FILTER field based on one or more expressions. This is a non-destructive alternative to `filter`, as it keeps all records.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vembrane tag [-h] --tag TAG=EXPRESSION [--output OUTPUT]
                    [--output-fmt {vcf,bcf,uncompressed-bcf}]
                    [--tag-mode {pass,fail}] [--annotation-key FIELDNAME]
                    [--aux NAME=PATH] [--context CONTEXT]
                    [--context-file CONTEXT_FILE] [--ontology PATH]
                    [--overwrite-number-info FIELD=NUMBER]
                    [--overwrite-number-format FIELD=NUMBER]
                    [--backend {cyvcf2,pysam}]
                    [vcf]

Flag records by adding a tag to their FILTER field based on one or more
expressions. This is a non-destructive alternative to `filter`, as it keeps
all records.

positional arguments:
  vcf                   Path to the VCF/BCF file to be filtered. Defaults to
                        '-' for stdin. (default: -)

options:
  -h, --help            show this help message and exit
  --tag TAG=EXPRESSION, -t TAG=EXPRESSION
                        Tag records using the FILTER field. Note: tag names
                        cannot contain `;` or whitespace and must not be '0'.
                        Example: `--tag q_above_30="not (QUAL<=30)"`
  --output OUTPUT, -o OUTPUT
                        Output file, if not specified, output is written to
                        STDOUT. (default: -)
  --output-fmt {vcf,bcf,uncompressed-bcf}, -O {vcf,bcf,uncompressed-bcf}
                        Output format. (default: vcf)
  --tag-mode {pass,fail}, -m {pass,fail}
                        Set, whether to tag records that pass the tag
                        expression(s), or records that fail them.By default,
                        vembrane tags records for which the tag expression(s)
                        pass. This allows for descriptive tag names such as
                        `q_at_least_30`, which would correspond to an
                        expression `QUAL >= 30`. However, the VCF
                        specification (`v4.4`) defines tags to be set when a
                        filter expression is failed, so vembrane also offers
                        the `fail` mode. (default: pass)
  --annotation-key FIELDNAME, -k FIELDNAME
                        The INFO key for the annotation field. This defaults
                        to 'ANN', but tools might use other field names. For
                        example, default VEP annotations can be parsed by
                        setting 'CSQ' here. (default: ANN)
  --aux NAME=PATH, -a NAME=PATH
                        Path to an auxiliary file containing a set of symbols
  --context CONTEXT     Python statement defining a context for given Python
                        expressions. Extends eventual definitions given via
                        --context-file. Any global variables (or functions)
                        become available in the Python expressions. Note that
                        the code you pass here is not sandboxed and should be
                        trusted. Carefully review any code you get from the
                        internet or AI.
  --context-file CONTEXT_FILE
                        Path to Python script defining a context for given
                        Python expressions. Any global variables (or
                        functions) become available in the Python expressions.
                        Note that the code you pass here is not sandboxed and
                        should be trusted. Carefully review any code you get
                        from the internet or AI.
  --ontology PATH       Path to an ontology in OBO format. May be compressed
                        with gzip, bzip2 and xz. Defaults to built-in ontology
                        (from sequenceontology.org).
  --overwrite-number-info FIELD=NUMBER
                        Overwrite the number specification for INFO fields
                        given in the VCF header. Example: `--overwrite-number
                        cosmic_CNT=.`
  --overwrite-number-format FIELD=NUMBER
                        Overwrite the number specification for FORMAT fields
                        given in the VCF header. Example: `--overwrite-number-
                        format DP=2`
  --backend {cyvcf2,pysam}, -b {cyvcf2,pysam}
                        Set the backend library. (default: cyvcf2)
```


## vembrane_without

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: vembrane [-h] [--version]
                {filter,table,annotate,tag,structured,fhir,sort} ...
vembrane: error: argument command: invalid choice: 'without' (choose from filter, table, annotate, tag, structured, fhir, sort)
```


## vembrane_structured

### Tool Description
Create structured output from a VCF/BCF and a YTE template.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vembrane structured [-h] [--output-fmt {json,jsonl,yaml}]
                           [--output OUTPUT] [--annotation-key FIELDNAME]
                           [--aux NAME=PATH] [--context CONTEXT]
                           [--context-file CONTEXT_FILE] [--ontology PATH]
                           [--overwrite-number-info FIELD=NUMBER]
                           [--overwrite-number-format FIELD=NUMBER]
                           [--backend {cyvcf2,pysam}]
                           template [vcf]

Create structured output from a VCF/BCF and a YTE template.

positional arguments:
  template              File containing a YTE template with the desired
                        structure per record and expressions that retrieve
                        data from the VCF/BCF record.
  vcf                   Path to the VCF/BCF file to be filtered. Defaults to
                        '-' for stdin. (default: -)

options:
  -h, --help            show this help message and exit
  --output-fmt {json,jsonl,yaml}
                        Output format. If not specified, can be automatically
                        determined from the --output file extension.
  --output OUTPUT, -o OUTPUT
                        Output file, if not specified, output is written to
                        STDOUT. (default: -)
  --annotation-key FIELDNAME, -k FIELDNAME
                        The INFO key for the annotation field. This defaults
                        to 'ANN', but tools might use other field names. For
                        example, default VEP annotations can be parsed by
                        setting 'CSQ' here. (default: ANN)
  --aux NAME=PATH, -a NAME=PATH
                        Path to an auxiliary file containing a set of symbols
  --context CONTEXT     Python statement defining a context for given Python
                        expressions. Extends eventual definitions given via
                        --context-file. Any global variables (or functions)
                        become available in the Python expressions. Note that
                        the code you pass here is not sandboxed and should be
                        trusted. Carefully review any code you get from the
                        internet or AI.
  --context-file CONTEXT_FILE
                        Path to Python script defining a context for given
                        Python expressions. Any global variables (or
                        functions) become available in the Python expressions.
                        Note that the code you pass here is not sandboxed and
                        should be trusted. Carefully review any code you get
                        from the internet or AI.
  --ontology PATH       Path to an ontology in OBO format. May be compressed
                        with gzip, bzip2 and xz. Defaults to built-in ontology
                        (from sequenceontology.org).
  --overwrite-number-info FIELD=NUMBER
                        Overwrite the number specification for INFO fields
                        given in the VCF header. Example: `--overwrite-number
                        cosmic_CNT=.`
  --overwrite-number-format FIELD=NUMBER
                        Overwrite the number specification for FORMAT fields
                        given in the VCF header. Example: `--overwrite-number-
                        format DP=2`
  --backend {cyvcf2,pysam}, -b {cyvcf2,pysam}
                        Set the backend library. (default: cyvcf2)
```


## vembrane_fhir

### Tool Description
Generate FHIR records from VCF/BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vembrane fhir [-h] [--url URL] [--status STATUS] --profile
                     {mii_molgen_v2025.0.0} [--id-source ID_SOURCE]
                     [--genomic-source-class GENOMIC_SOURCE_CLASS]
                     [--sample-allelic-frequency SAMPLE_ALLELIC_FREQUENCY]
                     [--sample-allelic-read-depth SAMPLE_ALLELIC_READ_DEPTH]
                     [--confidence-status CONFIDENCE_STATUS]
                     [--detection-limit DETECTION_LIMIT]
                     [--output-fmt {json,jsonl,yaml}] [--output OUTPUT]
                     [--annotation-key FIELDNAME] [--aux NAME=PATH]
                     [--context CONTEXT] [--context-file CONTEXT_FILE]
                     [--ontology PATH] [--overwrite-number-info FIELD=NUMBER]
                     [--overwrite-number-format FIELD=NUMBER]
                     [--backend {cyvcf2,pysam}]
                     [vcf] sample {GRCh37,GRCh38}

Generate FHIR records from VCF/BCF files.

positional arguments:
  vcf                   Path to the VCF/BCF file to be filtered. Defaults to
                        '-' for stdin. (default: -)
  sample                The sample to use for generating FHIR output.
  {GRCh37,GRCh38}       The reference assembly used for read mapping.

options:
  -h, --help            show this help message and exit
  --url URL, -u URL     Generic url used as identifier by FHIR e.g.
                        http://<institute>/<department>/VCF
  --status STATUS, -s STATUS
                        Status of findings. E.g. final, preliminary, ...
  --profile {mii_molgen_v2025.0.0}
                        The FHIR profile to use for generating the output, see
                        https://github.com/vembrane/vembrane/tree/main/vembran
                        e/modules/assets/fhir/profiles for available profiles
                        and the degree of support.
  --id-source ID_SOURCE
                        URL to the source of IDs found in the ID column of the
                        VCF/BCF file. IDs are only used if this is given.
  --genomic-source-class GENOMIC_SOURCE_CLASS
                        The genomic source class of the given variants as
                        defined by LOINC: https://loinc.org/48002-0. Either
                        provide the name as a string or a Python expression
                        that evaluates to the name, e.g., for Varlociraptor
                        '"Somatic" if INFO["PROB_SOMATIC"] > 0.95 else ...'.
  --sample-allelic-frequency SAMPLE_ALLELIC_FREQUENCY
                        Python expression calculating the the samples allelic
                        frequencyas percentage. E.g. "FORMAT['AF'][sample][0]
                        * 100"
  --sample-allelic-read-depth SAMPLE_ALLELIC_READ_DEPTH
                        Python expression accessing the the samples allelic
                        read depth.Default is: "FORMAT['AD'][sample][1]"
                        (default: FORMAT['AD'][sample][1])
  --confidence-status CONFIDENCE_STATUS
                        Python expression for calculating the variants
                        confidence status being High, Intermediate or Low.
                        E.g. "'High' if QUAL >= 20 else ('Intermediate' if
                        QUAL >= 10 else 'Low')"
  --detection-limit DETECTION_LIMIT
                        Detection limit / sensitivity of the analysis in
                        percent (e.g. 95).
  --output-fmt {json,jsonl,yaml}
                        Output format. If not specified, can be automatically
                        determined from the --output file extension.
  --output OUTPUT, -o OUTPUT
                        Output file, if not specified, output is written to
                        STDOUT. (default: -)
  --annotation-key FIELDNAME, -k FIELDNAME
                        The INFO key for the annotation field. This defaults
                        to 'ANN', but tools might use other field names. For
                        example, default VEP annotations can be parsed by
                        setting 'CSQ' here. (default: ANN)
  --aux NAME=PATH, -a NAME=PATH
                        Path to an auxiliary file containing a set of symbols
  --context CONTEXT     Python statement defining a context for given Python
                        expressions. Extends eventual definitions given via
                        --context-file. Any global variables (or functions)
                        become available in the Python expressions. Note that
                        the code you pass here is not sandboxed and should be
                        trusted. Carefully review any code you get from the
                        internet or AI.
  --context-file CONTEXT_FILE
                        Path to Python script defining a context for given
                        Python expressions. Any global variables (or
                        functions) become available in the Python expressions.
                        Note that the code you pass here is not sandboxed and
                        should be trusted. Carefully review any code you get
                        from the internet or AI.
  --ontology PATH       Path to an ontology in OBO format. May be compressed
                        with gzip, bzip2 and xz. Defaults to built-in ontology
                        (from sequenceontology.org).
  --overwrite-number-info FIELD=NUMBER
                        Overwrite the number specification for INFO fields
                        given in the VCF header. Example: `--overwrite-number
                        cosmic_CNT=.`
  --overwrite-number-format FIELD=NUMBER
                        Overwrite the number specification for FORMAT fields
                        given in the VCF header. Example: `--overwrite-number-
                        format DP=2`
  --backend {cyvcf2,pysam}, -b {cyvcf2,pysam}
                        Set the backend library. (default: cyvcf2)
```


## vembrane_sort

### Tool Description
Sort VCF/BCF records by one or multiple Python expressions that encode keys for the desired order. This feature is primarily meant to prioritizing records for the human eye. For large unfiltered VCF/BCF files, the only relevant sorting is usually by position, which is better done with e.g. bcftools (and usually the standard sorting that variant callers output). Expects the VCF/BCF file to be single-allelic, i.e., one ALT allele per record.

### Metadata
- **Docker Image**: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/vembrane/vembrane
- **Package**: https://anaconda.org/channels/bioconda/packages/vembrane/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vembrane sort [-h] [--output OUTPUT]
                     [--output-fmt {vcf,bcf,uncompressed-bcf}]
                     [--preserve-annotation-order]
                     [--max-in-mem-records MAX_IN_MEM_RECORDS]
                     [--annotation-key FIELDNAME] [--aux NAME=PATH]
                     [--context CONTEXT] [--context-file CONTEXT_FILE]
                     [--ontology PATH] [--overwrite-number-info FIELD=NUMBER]
                     [--overwrite-number-format FIELD=NUMBER]
                     [--backend {cyvcf2,pysam}]
                     expression [vcf]

Sort VCF/BCF records by one or multiple Python expressions that encode keys
for the desired order. This feature is primarily meant to prioritizing records
for the human eye. For large unfiltered VCF/BCF files, the only relevant
sorting is usually by position, which is better done with e.g. bcftools (and
usually the standard sorting that variant callers output). Expects the VCF/BCF
file to be single-allelic, i.e., one ALT allele per record.

positional arguments:
  expression            Python expression (or tuple of expressions) returning
                        orderable values (keys) to sort the VCF/BCF records
                        by. By default keys are considered in ascending order.
                        To sort by descending order, use `desc(<expression>)`
                        on the entire expression or on individual items of the
                        tuple. If multiple expressions are provided as a
                        tuple, they are prioritized from left to right with
                        lowest priority on the right. NA/NaN values are always
                        sorted to the end. Expressions on annotation entries
                        (there can be multiple annotations per record) will
                        cause the annotation with the minimum key value (or
                        maximum if descending) to be considered to sort the
                        record.
  vcf                   The VCF/BCF file containing the variants. If not
                        specified, reads from STDIN. (default: -)

options:
  -h, --help            show this help message and exit
  --output OUTPUT, -o OUTPUT
                        Output file, if not specified, output is written to
                        STDOUT. (default: -)
  --output-fmt {vcf,bcf,uncompressed-bcf}, -O {vcf,bcf,uncompressed-bcf}
                        Output format. (default: vcf)
  --preserve-annotation-order
                        If set, annotations are not sorted within the records,
                        but kept in the same order as in the input VCF/BCF
                        file. If not set (default), annotations are sorted
                        within the record according to the given keys if any
                        of the sort keys given in the python expression refers
                        to an annotation.
  --max-in-mem-records MAX_IN_MEM_RECORDS
                        Number of VCF/BCF records to sort in memory. If the
                        VCF/BCF file exceeds this number of records, external
                        sorting is used. (default: 100000)
  --annotation-key FIELDNAME, -k FIELDNAME
                        The INFO key for the annotation field. This defaults
                        to 'ANN', but tools might use other field names. For
                        example, default VEP annotations can be parsed by
                        setting 'CSQ' here. (default: ANN)
  --aux NAME=PATH, -a NAME=PATH
                        Path to an auxiliary file containing a set of symbols
  --context CONTEXT     Python statement defining a context for given Python
                        expressions. Extends eventual definitions given via
                        --context-file. Any global variables (or functions)
                        become available in the Python expressions. Note that
                        the code you pass here is not sandboxed and should be
                        trusted. Carefully review any code you get from the
                        internet or AI.
  --context-file CONTEXT_FILE
                        Path to Python script defining a context for given
                        Python expressions. Any global variables (or
                        functions) become available in the Python expressions.
                        Note that the code you pass here is not sandboxed and
                        should be trusted. Carefully review any code you get
                        from the internet or AI.
  --ontology PATH       Path to an ontology in OBO format. May be compressed
                        with gzip, bzip2 and xz. Defaults to built-in ontology
                        (from sequenceontology.org).
  --overwrite-number-info FIELD=NUMBER
                        Overwrite the number specification for INFO fields
                        given in the VCF header. Example: `--overwrite-number
                        cosmic_CNT=.`
  --overwrite-number-format FIELD=NUMBER
                        Overwrite the number specification for FORMAT fields
                        given in the VCF header. Example: `--overwrite-number-
                        format DP=2`
  --backend {cyvcf2,pysam}, -b {cyvcf2,pysam}
                        Set the backend library. (default: cyvcf2)
```


## Metadata
- **Skill**: generated
