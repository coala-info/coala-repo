---
name: bioconductor-systempiper
description: systemPipeR automates the construction, management, and execution of complex data analysis workflows in R. Use when user asks to initialize a workflow project, manage sample metadata via targets files, append R-based or command-line analysis steps, execute workflows, and generate reproducible reports.
homepage: https://bioconductor.org/packages/release/bioc/html/systemPipeR.html
---

# bioconductor-systempiper

name: bioconductor-systempiper
description: Expert guidance for using the Bioconductor package systemPipeR to build, manage, and execute automated data analysis workflows in R. Use this skill when you need to initialize a workflow project, append R-based or command-line analysis steps, manage sample metadata via targets files, execute workflows, and generate reproducible reports.

# bioconductor-systempiper

## Overview
`systemPipeR` is a powerful environment for managing data analysis workflows. It uses a central `SYSargsList` (SAL) object to track analysis steps, input/output file relationships, and execution status. It excels at handling large numbers of samples by using "targets" files to map metadata to analysis parameters, ensuring high reproducibility and scalability for complex bioinformatics pipelines.

## Core Workflow

### 1. Project Initialization
Every workflow starts by creating a project directory and a `SYSargsList` container.
```r
library(systemPipeR)
# Initialize a new project (creates .SPRproject log directory)
sal <- SPRproject(projPath = getwd())
```

### 2. Managing Metadata (Targets)
Targets files are tab-separated files defining sample names and file paths.
- **Single-end:** Columns `FileName`, `SampleName`, `Factor`.
- **Paired-end:** Columns `FileName1`, `FileName2`, `SampleName`, `Factor`.
- **Comparisons:** Defined in header lines starting with `# <CMP>`.

### 3. Adding Workflow Steps
Steps are appended to the `sal` object.

**R-based Steps (LineWise):**
Use for data transformation, statistical analysis, or plotting within R.
```r
appendStep(sal) <- LineWise(
    code = {
        data <- read.csv("data.csv")
        results <- mean(data$value)
        saveRDS(results, "results.rds")
    },
    step_name = "analysis_step"
)
```

**Command-Line Steps (SYSargsList):**
Use for external software. Requires CWL (`.cwl`) and input (`.yml`) files.
```r
appendStep(sal) <- SYSargsList(
    step_name = "align",
    targets = "targets.txt",
    wf_file = "param/cwl/tool.cwl",
    input_file = "param/cwl/tool.yml",
    inputvars = c(FileName = "_FILE_PATH_", SampleName = "_SampleName_"),
    dependency = "previous_step"
)
```

### 4. Executing the Workflow
Run the entire workflow or specific steps.
```r
# Run all pending steps
sal <- runWF(sal)

# Run specific steps by index or name
sal <- runWF(sal, steps = c(1:3))

# Force re-run of successful steps
sal <- runWF(sal, force = TRUE)
```

### 5. Monitoring and Visualization
```r
# Check status of all steps
sal

# View workflow topology
plotWF(sal)

# Access output files of a specific step
outfiles(sal)["step_name"]
```

### 6. Reporting
Generate scientific or technical (log) reports.
```r
# Scientific report (requires Rmd template)
sal <- renderReport(sal)

# Technical log report
sal <- renderLogs(sal)
```

## Key Functions
- `SPRproject()`: Initializes or resumes a workflow project.
- `importWF()`: Imports an entire workflow from an R Markdown file.
- `appendStep()`: Adds a new analysis step to the SAL object.
- `runWF()`: Executes the workflow steps.
- `getColumn()`: Extracts specific columns (like output paths) from previous steps.
- `subset()`: Subsets a workflow by steps or samples.

## Best Practices
- **Self-Contained Steps:** Ensure R code chunks in `LineWise` steps load necessary libraries.
- **Dependencies:** Always define `dependency` in `appendStep` to maintain the correct execution order.
- **Resuming:** Use `sal <- SPRproject(resume = TRUE)` to pick up a workflow where it left off after restarting R.
- **Environment Management:** Use `viewEnvir(sal)` to see objects created during the workflow run.

## Reference documentation
- [systemPipeR: Workflow Environment for Data Analysis and Report Generation](./references/systemPipeR.md)
- [systemPipeR Workflows](./references/systemPipeR_workflows.md)