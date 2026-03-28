* [Github](https://github.com/vembrane/vembrane)

* Python expression based VCF/BCF transformation
* Filter, tag, convert to tables, annotate, sort, and convert to structured formats like JSON, JSONL, YAML or FHIR

[Read the docs](https://github.com/vembrane/vembrane)[Read the paper](https://doi.org/10.1093/bioinformatics/btac810)

# Python expression based VCF/BCF transformation

Vembrane provides a command line interface to flexibly transform VCF/BCF files using Python expressions. The expressions can access all fields of the VCF/BCF records, including annotations. This allows for a wide range of operations, such as filtering, tagging, converting to tables, annotating, sorting, and converting to structured formats like JSON or FHIR.

[![](fb9a17395f80d6ce5653729c6bdd2d424dd806ad5962288ae68a438a049c0d03.svg)](fb9a17395f80d6ce5653729c6bdd2d424dd806ad5962288ae68a438a049c0d03.svg)

# Filter VCF/BCF files

Filter VCF/BCF files using Python expressions over elements of your VCF/BCF records, including annotations.

`vembrane filter 'CHROM == "chr3" \
and ANN["Consequence"].any_is_a("frameshift_variant")' \
variants.bcf`

# Tag VCF/BCF files

Use Python expressions to tag VCF/BCF records.

`vembrane tag \
--tag quality_at_least_30="QUAL >= 30" \
variants.vcf`

# Convert VCF/BCF to tables

Convert VCF/BCF files to tables, defining columns via Python expressions.

`vembrane table \
'CHROM, POS, 10**(-QUAL / 10), ANN["CLIN_SIG"]' \
input.vcf > table.tsv`

# Annotate VCF/BCF files

Annotate VCF/BCF files using a declarative YAML configuration file with Python expressions that describe how the fields are filled.

`vembrane annotate \
example.yaml example.bcf \
> annotated.vcf`

# Sort VCF/BCF files

Sort VCF/BCF files. The sort order can be defined via flexible Python expressions and thus be based on any field and annotation that occurs in the VCF/BCF (e.g. impact or clinical significance). The primary use case is variant prioritization.

`vembrane sort input.vcf \
'round(ANN["gnomad_AF"], 1), -ANN["REVEL"]' \
> prioritized.vcf`

# Convert VCF/BCF records into structured representations

Converts VCF records into structured formats like JSON, JSONL, or YAML using a flexible [YTE](https://yte-template-engine.github.io) template.

`vembrane structured \
template.yml input.vcf \
--output output.json`

# Convert VCF/BCF records to FHIR

Convert VCF/BCF records to [FHIR](https://www.hl7.org/fhir/index.html). The implementation is extensible by additional profiles.

`vembrane fhir \
tumor GRCh38 --profile mii_molgen_v2025.0.0 \
--output-fmt json --annotation-key ANN \
< sample.vcf > sample-tumor.fhir.json`

# Authors and Contributors ⓘ

* [Till Hartmann](https://github.com/tedil)
* [Christopher Schröder](https://github.com/christopher-schroeder)
* [Johannes Köster](https://github.com/johanneskoester)
* [Jan Forster](https://github.com/jafors)
* [Felix Mölder](https://github.com/FelixMoelder)
* [David Laehnemann](https://github.com/dlaehnemann)
* [Elias Kuthe](https://github.com/EQt)
* [Marcel Bargull](https://github.com/mbargull)

# Groups, Institutes, Companies, and Organizations ⓘ

* @bihealth
* University of Duisburg Essen
* University of Duisburg-Essen