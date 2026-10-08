# taranys CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| taranys_allele-calling | PASS |  |
| taranys_analyze-schema | PASS |  |
| taranys_distance-matrix | PASS |  |
| taranys_reference-alleles | PASS |  |

## taranys_analyze-schema

### Tool Description
Analyze a core gene schema: allele statistics, optional removal of subset, duplicated and no-CDS alleles, and Prokka annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/taranys
- **Package**: https://anaconda.org/channels/bioconda/packages/taranys/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: taranys analyze-schema [OPTIONS]

Options:
  -i, --input PATH                Directory where the schema with the core
                                  gene files are located.  [required]
  -o, --output PATH               Output folder to save analyze schema
                                  [required]
  --remove-subset / --no-remove-subset
                                  Remove allele subsequences from the schema.
                                  [default: no-remove-subset]
  --remove-duplicated / --no-remove-duplicated
                                  Remove duplicated subsequences from the
                                  schema.  [default: no-remove-duplicated]
  --remove-no-cds / --no-remove-no-cds
                                  Remove no CDS alleles from the schema.
                                  [default: no-remove-no-cds]
  --output-allele-annot / --no-output-allele-annot
                                  output prokka/allele annotation for all
                                  alleles in locus.  [default: output-allele-
                                  annot]
  --genus TEXT                    Genus name for Prokka schema genes
                                  annotation.  [default: Genus]
  --species TEXT                  Species name for Prokka schema genes
                                  annotation.  [default: species]
  --usegenus TEXT                 Use genus-specific BLAST databases for
                                  Prokka schema genes annotation (needs
                                  --genus).  [default: Genus]
  --cpus INTEGER                  Number of cpus used for execution.
                                  [default: 1]
  --help                          Show this message and exit.
```

## taranys_reference-alleles

### Tool Description
Select the representative reference alleles of each locus in a core gene schema.

### Metadata
- **Docker Image**: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/taranys
- **Package**: https://anaconda.org/channels/bioconda/packages/taranys/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: taranys reference-alleles [OPTIONS]

Options:
  -s, --schema PATH               Directory where the schema with the core
                                  gene files are located.   [required]
  -o, --output PATH               Output folder to save reference alleles
                                  [required]
  --eval-cluster / --no-eval-cluster
                                  Evaluate if the reference alleles match
                                  against blast with the identity set in eval-
                                  identity param  [default: eval-cluster]
  -k, --kmer-size INTEGER         Mash parameter for K-mer size.  [default:
                                  21]
  -S, --sketch-size INTEGER       Mash parameter for Sketch size  [default:
                                  2000]
  -r, --cluster-resolution FLOAT  Resolution value used for clustering.
                                  [default: 0.75]
  -e, --eval-identity FLOAT       Blast percentage identity to use for
                                  evaluation of identification.  [default: 85]
  --seed INTEGER                  Seed value for clustering
  --cpus INTEGER                  Number of cpus used for execution  [default:
                                  1]
  --force / --no-force            Overwrite the output folder if it exists
                                  [default: no-force]
  --help                          Show this message and exit.
```

## taranys_allele-calling

### Tool Description
Call the alleles of each locus of a core gene schema in assemblies using BLAST.

### Metadata
- **Docker Image**: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/taranys
- **Package**: https://anaconda.org/channels/bioconda/packages/taranys/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: taranys allele-calling [OPTIONS] ASSEMBLIES...

Options:
  -s, --schema PATH               Directory where the schema with the core
                                  gene files are located.   [required]
  -r, --reference PATH            Directory where the schema reference allele
                                  files are located.   [required]
  -a, --annotation PATH           Annotation file.   [required]
  -t, --hit_lenght_perc FLOAT     Threshold value to consider in blast hit
                                  percentage regarding the reference length.
                                  Values from 0 to 1.  [default: 0.8]
  -p, --perc-identity INTEGER     Percentage of identity to consider in blast.
                                  [default: 85]
  -o, --output PATH               Output folder to save reference alleles
                                  [required]
  --force / --no-force            Overwrite the output folder if it exists
                                  [default: no-force]
  --snp / --no-snp                Create SNP file for alleles in assembly in
                                  relation with reference allele  [default:
                                  no-snp]
  --alignment / --no-alignment    Create alignment files  [default: no-
                                  alignment]
  -q, --proteine-threshold INTEGER
                                  Threshold of protein coverage to consider as
                                  TPR  [default: 80]
  -i, --increase-sequence INTEGER
                                  Increase the number of triplet sequences to
                                  find the stop codon  [default: 20]
  --cpus INTEGER                  Number of cpus used for execution  [default:
                                  1]
  --help                          Show this message and exit.
```

## taranys_distance-matrix

### Tool Description
Calculate the Hamming distance matrix between samples from an allele matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/taranys
- **Package**: https://anaconda.org/channels/bioconda/packages/taranys/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: taranys distance-matrix [OPTIONS]

Options:
  -a, --alleles PATH              Alleles matrix file from which to obtain
                                  distances between samples  [required]
  -o, --output PATH               Output folder to save distance matrix
                                  [required]
  --force / --no-force            Overwrite the output folder if it exists
                                  [default: no-force]
  -l, --locus-missing-threshold INTEGER
                                  Maximum percentaje of missing values a locus
                                  can have, otherwise is filtered. By default
                                  core genome is calculated, locus must be
                                  found in all samples.  [default: 0]
  -s, --sample-missing-threshold INTEGER
                                  Maximum percentaje for missing values a
                                  sample can have, otherwise it is filtered
                                  [default: 20]
  --paralog-filter / --no-paralog-filter
                                  Consider paralog tags (NIPH, NIPHEM) as
                                  missing values.  [default: paralog-filter]
  --lnf-filter / --no-lnf-filter  Consider LNF as missing values.  [default:
                                  lnf-filter]
  --plot-filter / --no-plot-filter
                                  Consider PLOT as missing values.  [default:
                                  plot-filter]
  --help                          Show this message and exit.
```

## Metadata
- **Skill**: generated
