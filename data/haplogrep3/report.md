# haplogrep3 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| haplogrep3_align | PASS | aligned FASTA of the tool's L3i2 test sequence has the expected length and the L3i2 header |
| haplogrep3_annotation-index | PASS | index written for a bgzip-compressed real VCF; positions in the index match the VCF |
| haplogrep3_build-tree | Not completed | needs a large Nextstrain tree.json and a variants-of-concern file; no small real input found |
| haplogrep3_classify | PASS | matches the expected H100 results (top 10 hits and qc table) from the tool's own tests |
| haplogrep3_cluster-haplogroups | PASS | 5435 haplogroup to super-haplogroup rows for phylotree-rcrs@17.2 |
| haplogrep3_distance | PASS | synthetic data: two small planted clade tables; distances 2, 5 and 1 agree with haplogrep v2 |

## haplogrep3_classify

### Tool Description
Classify mtDNA profiles (VCF, FASTA or HSD) into haplogroups.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
- **Homepage**: https://github.com/genepi/haplogrep3
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep3/overview
- **Validation**: PASS

### Original Help Text
```text
Haplogrep 3 3.2.2
(c) 2022-2024 Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer
Missing required options [--input=<input>, --tree=<phylotreeId>, --output=<output>]
Usage: haplogrep classify [--chip] [--extend-report] [--skip-alignment-rules]
                          [--write-fasta] [--write-fasta-msa] [--write-qc]
                          [--hetLevel=<hetLevel>] [--hits=<hits>] --in=<input>
                          [--metric=<distance>] --out=<output>
                          --tree=<phylotreeId>
      --chip                 VCF data from a genotype chip
                               Default: false
      --extend-report        Add flag for a extended final output
                               Default: false
      --hetLevel=<hetLevel>  Add heteroplasmies with a level > X from the VCF
                               file to the profile (default: 0.9)
      --hits=<hits>          Calculate best n hits
      --in, --input=<input>  Input file (vcf, fasta, hsd)
      --metric, --distance=<distance>
                             Distance
      --out, --output=<output>
                             Output file location
      --skip-alignment-rules Skip nomenclature fixes based on rules for FASTA
                               import
                               Default: false
      --tree=<phylotreeId>   Tree Id
      --write-fasta          Write results in fasta format
                               Default: false
      --write-fasta-msa      Write multiple sequence alignment (_MSA.fasta)
                               Default: false
      --write-qc             Write quality control results into csvfile
                               Default: false
```

## haplogrep3_align

### Tool Description
Align a FASTA file to the reference of a phylotree.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
- **Homepage**: https://github.com/genepi/haplogrep3
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep3/overview
- **Validation**: PASS

### Original Help Text
```text
Haplogrep 3 3.2.2
(c) 2022-2024 Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer
Missing required options [--fasta=<fasta>, --tree=<phylotreeId>, --output=<output>]
Usage: haplogrep align --fasta=<fasta> --output=<output> --tree=<phylotreeId>
      --fasta=<fasta>        input haplogroups
      --output=<output>      output aligned fasta file
      --tree=<phylotreeId>   Tree Id
```

## haplogrep3_distance

### Tool Description
Calculate the distance between the haplogroups of two classification files.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
- **Homepage**: https://github.com/genepi/haplogrep3
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep3/overview
- **Validation**: PASS

### Original Help Text
```text
Haplogrep 3 3.2.2
(c) 2022-2024 Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer
Missing required options [--file1=<file1>, --file2=<file2>, --tree=<phylotreeId>, --output=<output>]
Usage: haplogrep distance --file1=<file1> --file2=<file2> --output=<output>
                          --tree=<phylotreeId>
      --file1=<file1>        input haplogroups
      --file2=<file2>        input haplogroups
      --output=<output>      output haplogroups including distance
      --tree=<phylotreeId>   Tree Id
```

## haplogrep3_build-tree

### Tool Description
Build a haplogrep phylotree XML file from a Nextstrain tree.json file.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
- **Homepage**: https://github.com/genepi/haplogrep3
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep3/overview
- **Validation**: PASS

### Original Help Text
```text
Haplogrep 3 3.2.2
(c) 2022-2024 Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer
Missing required options [--input=<input>, --output=<output>, --output-weights=<outputWeights>, --voc=<inputVOC>]
Usage: haplogrep build-tree --input=<input> --output=<output>
                            --output-weights=<outputWeights> --voc=<inputVOC>
      --input=<input>     input nextstrain tree.json file
      --output=<output>   output haplogrep xml file
      --output-weights=<outputWeights>
                          output haplogrep xml file
      --voc=<inputVOC>    variants of concerns
```

## haplogrep3_cluster-haplogroups

### Tool Description
Cluster the haplogroups of a phylotree.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
- **Homepage**: https://github.com/genepi/haplogrep3
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep3/overview
- **Validation**: PASS

### Original Help Text
```text
Haplogrep 3 3.2.2
(c) 2022-2024 Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer
Missing required options [--tree=<tree>, --output=<output>]
Usage: haplogrep cluster-haplogroups --output=<output> --tree=<tree>
      --output=<output>   output haplogrpups (txt)
      --tree=<tree>       tree name
```

## haplogrep3_annotation-index

### Tool Description
Build an index file for an annotation table.

### Metadata
- **Docker Image**: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
- **Homepage**: https://github.com/genepi/haplogrep3
- **Package**: https://anaconda.org/channels/bioconda/packages/haplogrep3/overview
- **Validation**: PASS

### Original Help Text
```text
Haplogrep 3 3.2.2
(c) 2022-2024 Sebastian Schönherr, Hansi Weissensteiner, Lukas Forer
Missing required options [--file=<input>, --start=<start>, --skip=<skip>]
Usage: haplogrep annotation-index --file=<input> -s=<start> -S=<skip>
      --file=<input>    file
  -s, --start=<start>   start column
  -S, --skip=<skip>     skip n lines
```

