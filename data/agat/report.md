# agat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| agat_agat_convert_sp_gff2bed.pl | PASS |  |
| agat_agat_sp_keep_longest_isoform.pl | PASS |  |
| agat_agat_sp_manage_functional_annotation.pl | PASS |  |
| agat_agat_sp_manage_ids.pl | PASS |  |
| agat_agat_sp_manage_utrs.pl | PASS |  |

## Metadata
- **Skill**: generated

## agat_agat_convert_sp_gff2bed.pl

### Tool Description
The script takes a GFF file as input and converts it to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/NBISweden/AGAT
- **Package**: https://anaconda.org/channels/bioconda/packages/agat/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ab8a291519026841d8a554fc6d5b127b1f9b84eabdd8465ad4e043233c533294: unpack entry: usr/local/docs/api_reference/CXX/envset_thread_count.html: unpack to regular file: short write: write /tmp/build-temp-2448182072/rootfs/usr/local/docs/api_reference/CXX/envset_thread_count.html: no space left on device
```

## agat_agat_sp_keep_longest_isoform.pl

### Tool Description
This script filters a GFF file to keep only the longest isoform (based on CDS or exon length) for each gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/NBISweden/AGAT
- **Package**: https://anaconda.org/channels/bioconda/packages/agat/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ab8a291519026841d8a554fc6d5b127b1f9b84eabdd8465ad4e043233c533294: unpack entry: usr/local/docs/api_reference/CXX/envset_shm_key.html: unpack to regular file: short write: write /tmp/build-temp-2177751285/rootfs/usr/local/docs/api_reference/CXX/envset_shm_key.html: no space left on device
```

## agat_agat_sp_manage_utrs.pl

### Tool Description
This script allows to extend UTRs, or to add UTRs when they are missing. It uses the protein_coding information to define the UTRs.

### Metadata
- **Docker Image**: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/NBISweden/AGAT
- **Package**: https://anaconda.org/channels/bioconda/packages/agat/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ab8a291519026841d8a554fc6d5b127b1f9b84eabdd8465ad4e043233c533294: unpack entry: usr/local/docs/api_reference/CXX/envset_metadata_dir.html: unpack to regular file: short write: write /tmp/build-temp-1028394148/rootfs/usr/local/docs/api_reference/CXX/envset_metadata_dir.html: no space left on device
```

## agat_agat_sp_manage_ids.pl

### Tool Description
This script allows to manage IDs in a GFF file. It can be used to add, remove, or change IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/NBISweden/AGAT
- **Package**: https://anaconda.org/channels/bioconda/packages/agat/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ab8a291519026841d8a554fc6d5b127b1f9b84eabdd8465ad4e043233c533294: unpack entry: usr/local/docs/api_reference/CXX/envset_region_dir.html: unpack to regular file: short write: write /tmp/build-temp-2071833480/rootfs/usr/local/docs/api_reference/CXX/envset_region_dir.html: no space left on device
```

## agat_agat_sp_manage_functional_annotation.pl

### Tool Description
This tool allows managing functional annotations within a GFF file, such as adding information from BLAST or InterProScan results or cleaning existing annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
- **Homepage**: https://github.com/NBISweden/AGAT
- **Package**: https://anaconda.org/channels/bioconda/packages/agat/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:ab8a291519026841d8a554fc6d5b127b1f9b84eabdd8465ad4e043233c533294: unpack entry: usr/local/docs/api_reference/CXX/envset_region_dir.html: unpack to regular file: short write: write /tmp/build-temp-1073452540/rootfs/usr/local/docs/api_reference/CXX/envset_region_dir.html: no space left on device
```

