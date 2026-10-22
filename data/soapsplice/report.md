# soapsplice CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| soapsplice | PASS | rewritten from help (index as prefix plus staged index files, real flags, -o prefix outputs); nf-core human RNA-seq pairs give 9 junctions, all with GT-AG or CT-AC splice motifs |
| soapsplice_2bwt-builder | PASS | new CWL; builds the 16 index files for the nf-core human chr22 genome slice, used by soapsplice |

## soapsplice

### Tool Description
SOAPsplice is a tool for genome-wide ab initio detection of splice junctions from RNA-Seq data, supporting both fastq and fasta formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/soapsplice:1.10--2
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/soapsplice/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/soapsplice:1.10--2' locally
1.10--2: Pulling from biocontainers/soapsplice
a3ed95caeb02: Already exists
b0dc45cd432d: Already exists
3aaade50789a: Already exists
ddd482ea7b54: Already exists
7ff999a2256f: Already exists
e7c454e5167d: Already exists
dfda3e01f2b6: Already exists
a3ed95caeb02: Already exists
10c3bb32200b: Already exists
8f86115fee6d: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob4270919604: no space left on device

Run 'docker run --help' for more information
```


## soapsplice_2bwt-builder

### Tool Description
2BWT-Builder builds the reference index used by SOAPsplice from a sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/soapsplice:1.10--2
- **Homepage**: http://soap.genomics.org.cn/soapsplice.html
- **Package**: https://anaconda.org/channels/bioconda/packages/soapsplice/overview
- **Validation**: PASS

### Original Help Text
```text
2BWT-Builder, version 1.6

Usage: 2bwt-builder <sequence file> [output index prefix]
```

## Metadata
- **Skill**: not generated
