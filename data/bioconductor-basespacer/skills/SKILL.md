---
name: bioconductor-basespacer
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BaseSpaceR.html
---

# bioconductor-basespacer

## Overview
BaseSpaceR provides an S4-class-based R interface to the Illumina BaseSpace cloud platform. It allows users to manage genomic data, retrieve metadata, and integrate BaseSpace resources directly into Bioconductor analysis workflows. The package uses a persistent connection via an `AppAuth` handler and supports vectorized operations for querying multiple items simultaneously.

## Authentication
Communication with the BaseSpace server requires an `AppAuth` object.

```r
library(BaseSpaceR)

# Option 1: Using a pre-generated access token (Recommended for scripts)
aAuth <- AppAuth(access_token = "your_32_char_access_token")

# Option 2: OAuth2 Workflow (Requires browser interaction)
aAuth <- AppAuth(client_id = "your_id", client_secret = "your_secret", scope = "browse global")
# Follow the URI printed in the console to authorize
# Then request the token:
requestAccessToken(aAuth)
```

## Data Model and Accessors
BaseSpaceR uses two primary response types:
- **Item**: A single resource (e.g., one Project).
- **Collection**: A list of items (e.g., all Projects).

Common accessors for all objects: `Id()`, `Name()`, `Href()`, `DateCreated()`, `Status()`. Use the `$` operator to access specific JSON keys (e.g., `obj$Email`).

## Common Workflows

### 1. Querying Users and Genomes
```r
# Get current user info
u <- Users(aAuth)
Id(u)

# List available reference genomes
g <- listGenomes(aAuth, Limit = 10)
TotalCount(g)
# Get details for a specific genome (e.g., ID 4 for hg19)
hg19 <- Genomes(aAuth, id = 4, simplify = TRUE)
```

### 2. Browsing Runs and Projects
```r
# List runs and filter by status
runs <- listRuns(aAuth, Statuses = "Complete")
run_ids <- Id(runs)

# List projects
projs <- listProjects(aAuth)
# Select a specific project by ID
my_proj <- Projects(aAuth, id = "123456", simplify = TRUE)
```

### 3. Working with Samples and AppResults
Samples usually contain input data (FASTQ), while AppResults contain output data (BAM, VCF).
```r
# List samples in a project
samps <- listSamples(aAuth, projectId = Id(my_proj))

# List AppResults in a project
results <- listAppResults(aAuth, projectId = Id(my_proj))
```

### 4. File Management
Files are associated with Runs, Samples, or AppResults.
```r
# List BAM files from a specific AppResult
bam_files <- listFiles(aAuth, appResultId = "987654", Extensions = ".bam")

# Get file metadata
file_info <- Files(bam_files)

# Download files (Requires appropriate 'read' permissions)
# getFile(aAuth, id = Id(bam_files)[1], destDir = "./data")
```

### 5. Genomic Features (Coverage and Variants)
For BAM and VCF files, you can query specific genomic windows.
```r
# Get coverage stats for a BAM file
stats <- getCoverageStats(aAuth, id = "file_id", chrom = "chr1")

# Query variants in a VCF file
vars <- getVariants(aAuth, id = "vcf_id", chrom = "chr1", EndPos = 1000000L, Limit = 5)
```

## Tips
- **Vectorization**: Most functions like `Genomes()`, `Runs()`, and `Projects()` accept vectors of IDs.
- **Pagination**: Use `Limit` and `Offset` parameters in `list*` functions to manage large collections.
- **Simplification**: Use `simplify = TRUE` in resource calls (e.g., `Runs(..., simplify = TRUE)`) to return a single object instead of a list when querying one ID.
- **Permissions**: If a call returns `NULL` or an error, verify your `scope` (e.g., `read global`, `write global`) matches the required action.

## Reference documentation
- [BaseSpaceR](./references/BaseSpaceR.md)