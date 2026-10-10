# multiz CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| multiz | PASS |  |
| multiz_get_covered | PASS |  |
| multiz_lav2maf | PASS |  |
| multiz_maf2fasta | PASS |  |
| multiz_maf2lav | PASS | input FASTA headers must use the species:chr:start:strand:size form |
| multiz_mafFind | PASS |  |
| multiz_maf_checkThread | PASS |  |
| multiz_maf_order | PASS |  |
| multiz_maf_project | PASS |  |
| multiz_maf_sort | PASS |  |
| multiz_multic | PASS |  |
| multiz_pair2tb | PASS |  |
| multiz_single_cov2 | PASS |  |

## multiz

### Tool Description
aligning two files of alignment blocks where top rows are always the reference, reference in both files cannot have duplicats

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-05-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
multiz.v11.2:  -- aligning two files of alignment blocks where top rows are always the reference, reference in both files cannot have duplicats
args: [R=?] [M=?] file1 file2 v? [out1 out2] [nohead] [all]
	R(30) radius in dynamic programming.
	M(1) minimum output width.
	out1 out2(null) null: stdout; out1 out2: file names for collecting unused input.
	nohead(null) null: output maf header; nohead: not to output maf header.
	all(null) null: not to output single-row blocks; all: output all blocks.
```


## multiz_maf_project

### Tool Description
extract maf-file entries that name a given reference sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
maf_project.v12:  -- extract maf-file entries that name a given reference sequence.
args: file.maf reference [from to]                            [filename-for-other-mafs] [species-guid-tree] [nohead]
```

## multiz_maf2lav

### Tool Description
convert a MAF alignment to LAV

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
maf2lav.v11: args = align.maf seq1 seq2
```

## multiz_pair2tb

### Tool Description
convert a pairwise .maf file to a threaded blockset

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
pair2tb.v11: -- convert a pairwise .maf file to a threaded blockset.
args: pairwise.maf seqfile1 seqfile2
```

## multiz_mafFind

### Tool Description
find mafs intersecting a particular interval

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
mafFind.v1:  -- find mafs intersecting a particular interval.
args: file.maf beg end [species-prefix] [slice]
```

## multiz_maf_order

### Tool Description
order rows of MAF blocks according to a given species list

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
maf_order.v10:  -- order rows according to a give list.
args: maf-file species1 species2 .. [nohead] [all]
	[nohead] if nohead is turned on, there is no maf header
	[all] if all is turned on, single-row blocks are also in ouput
```

## multiz_maf2fasta

### Tool Description
convert a MAF alignment to FASTA

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
maf2fasta.v3: args = refseq-file maf-file [beg end] [fasta[2]][?] [iupac2n] [refsrc=src]
```

## multiz_get_covered

### Tool Description
get covered alignment parts of two MAF files

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
arguments: file1 file2
```

## multiz_multic

### Tool Description
align two files of alignment blocks, reference may contain duplicates

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
multic.v12.1: args: [R=?] [M=?] [C=?] file1 file2 v? [out1 out2] [nohead] [all]
	R(30) radius in dynamic programming.
	M(1) minimum output width.
	out1 out2(null) null: stdout; out1 out2: file names for collecting unused input.
	nohead(null) null: output maf header; nohead: not to output maf header.
	all(null) null: not to output single-row blocks; all: output all blocks.
```

## multiz_maf_checkThread

### Tool Description
check threading condition of an alignment for a sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
args: maf-flie
```

## multiz_maf_sort

### Tool Description
sort the blocks of a MAF file by one species

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
args: maf-file species-name [unused-ali-file]
```

## multiz_single_cov2

### Tool Description
screen out overlapped regions

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
single_cov2.v11: -- screening out overlapped regions.
args: pairwise.maf [R=species] [F=deleted.maf]
By default, single coverage is done for both species; if S=species specified, single coverage is done for the specified species only.
The first rows of all blocks must be of the same species; the second rows of all blocks must be of the same species.
```

## multiz_lav2maf

### Tool Description
convert blastz output to a maf file

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS

### Original Help Text
```text
lav2maf.v13:  -- convert blastz output to maf file.
 args: blastz.output seq-file1 seq-file2
```

## Metadata
- **Skill**: generated

## multiz

### Tool Description
aligning two files of alignment blocks where top rows are always the reference, reference in both files cannot have duplicats

### Metadata
- **Docker Image**: quay.io/biocontainers/multiz:11.2--hec16e2b_3
- **Homepage**: http://www.bx.psu.edu/miller_lab/
- **Package**: https://anaconda.org/channels/bioconda/packages/multiz/overview
- **Validation**: PASS
### Original Help Text
```text
multiz.v11.2:  -- aligning two files of alignment blocks where top rows are always the reference, reference in both files cannot have duplicats
args: [R=?] [M=?] file1 file2 v? [out1 out2] [nohead] [all]
	R(30) radius in dynamic programming.
	M(1) minimum output width.
	out1 out2(null) null: stdout; out1 out2: file names for collecting unused input.
	nohead(null) null: output maf header; nohead: not to output maf header.
	all(null) null: not to output single-row blocks; all: output all blocks.
```

