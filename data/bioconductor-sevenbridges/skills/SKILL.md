---
name: bioconductor-sevenbridges
description: The sevenbridges package provides an R interface to interact programmatically with Seven Bridges genomic analysis platforms via their Public API. Use when user asks to authenticate with the platform, manage projects, upload or download files, copy apps, and execute or monitor analysis tasks.
homepage: https://bioconductor.org/packages/release/bioc/html/sevenbridges.html
---

# bioconductor-sevenbridges

name: bioconductor-sevenbridges
description: Expert guidance for using the sevenbridges R package to interact with Seven Bridges platforms (Seven Bridges Platform, CGC, Cavatica). Use this skill when you need to authenticate, manage projects, upload/download files, copy apps, and execute/monitor tasks using the R API client.

# bioconductor-sevenbridges

## Overview

The `sevenbridges` package provides an R interface to the Seven Bridges Public API v2. It allows bioinformaticians to programmatically manage the lifecycle of genomic analyses on the Seven Bridges Platform, Cancer Genomics Cloud (CGC), and Cavatica. The package uses an object-oriented approach (Reference Classes) where most actions are performed as methods on objects like `Auth`, `Project`, `File`, and `Task`.

## Core Workflows

### 1. Authentication

Authentication is the entry point for all operations. You can authenticate directly or via environment variables/configuration files.

```r
library(sevenbridges)

# Direct authentication (recommended for interactive use)
# Platforms: "aws-us", "aws-eu", "cgc", "cavatica", "f4c"
a <- Auth(platform = "cgc", token = "your_auth_token")

# Check your user info and rate limits
a$user()
a$rate_limit()
```

### 2. Project Management

Projects are containers for data and analysis.

```r
# List all projects
a$project()

# Create a new project
# Get billing group ID first
bid <- a$billing()$id[1]
p <- a$project_new(name = "My_New_Project", billing_group_id = bid, description = "Analysis of RNA-seq data")

# Get a specific project by ID
p <- a$project(id = "username/project-short-name")
```

### 3. File Operations

Files can be searched by name, metadata, or tags.

```r
# List files in a project (first 100)
p$file()

# Search for specific files using exact match or metadata
fastqs <- p$file(name = "sample1.fastq", exact = TRUE)
samples <- p$file(metadata = list(sample_id = "Sample123"))

# Upload a local file
p$upload(path = "path/to/local_file.fastq", metadata = list(library_id = "LIB1"))

# Download a file
f <- p$file(id = "file_id")
f$download(destfile = "~/Downloads/data.fastq")
```

### 4. App Management

Apps (Tools and Workflows) can be copied from public repositories to your project.

```r
# Search for a public app
star_app <- a$public_app(name = "STAR", complete = TRUE)

# Copy a public app to your project
a$copy_app(id = "admin/sbg-public-data/rna-seq-alignment-star/5", 
           project = p$id, 
           name = "STAR_Alignment")
```

### 5. Task Execution and Monitoring

Tasks are executions of apps with specific inputs.

```r
# Get the app object from your project
app <- p$app(id = "username/project/app_name")

# Draft a task
tsk <- p$task_add(
  name = "STAR Alignment Run 1",
  app = app$id,
  inputs = list(
    fastq = list(p$file(id = "file_id_1"), p$file(id = "file_id_2")),
    genomeFastaFiles = p$file(id = "ref_id")
  )
)

# Run the task
tsk$run()

# Monitor status
tsk$update()
tsk$status
```

## Tips and Best Practices

- **Pagination**: By default, listing functions return 100 items. Use `complete = TRUE` to retrieve all items.
- **Object Methods**: Most objects (Project, File, Task) have their own methods. Use `p$file()` instead of `a$file(project = p$id)` for cleaner code.
- **Batching**: Use `batch()` within `task_add` to run multiple samples in parallel based on metadata (e.g., `batch = batch(input = "fastq", criteria = "metadata.sample_id")`).
- **Spot Instances**: To save costs, projects and tasks can be configured to use interruptible (spot) instances via the `use_interruptible` argument.

## Reference documentation

- [Seven Bridges API Reference](./references/api.md)
- [CWL App Integration](./references/apps.md)
- [Bioconductor Workflows](./references/bioc-workflow.md)
- [CGC Datasets Usage](./references/cgc-datasets.md)
- [Docker Integration](./references/docker.md)
- [RStudio Integration](./references/rstudio.md)