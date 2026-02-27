---
name: bioconductor-rcwl
description: The bioconductor-rcwl package provides an R interface to the Common Workflow Language for managing and executing command-line tools as R objects. Use when user asks to wrap command-line tools into R objects, build reproducible bioinformatics pipelines, execute workflows locally or on clusters, or convert R functions into CWL-compliant processes.
homepage: https://bioconductor.org/packages/release/bioc/html/Rcwl.html
---


# bioconductor-rcwl

name: bioconductor-rcwl
description: Comprehensive R interface for the Common Workflow Language (CWL). Use when the user needs to wrap command-line tools into R objects, build reproducible bioinformatics pipelines, execute workflows locally or on clusters, or convert R functions into CWL-compliant processes within an R environment.

# bioconductor-rcwl

## Overview
The `Rcwl` package provides an S4 interface to the Common Workflow Language (CWL), allowing users to define, manage, and execute command-line tools and complex bioinformatics pipelines entirely within R. It treats tools and workflows as R objects, enabling programmatic manipulation, parameter assignment, and execution tracking.

## Core Workflow: Wrapping a Tool
To convert a tool into an R-executable `cwlProcess` object:

1.  **Define Inputs**: Use `InputParam()` to specify the ID, type (e.g., "string", "int", "File"), and command-line prefix.
    ```r
    in1 <- InputParam(id = "msg", type = "string", prefix = "-m")
    ```
2.  **Define Outputs**: Use `OutputParam()` to capture results, often using `glob` to match file patterns.
    ```r
    out1 <- OutputParam(id = "out_file", type = "File", glob = "output.txt")
    ```
3.  **Construct Process**: Use `cwlProcess()` to bind the base command with inputs and outputs.
    ```r
    my_tool <- cwlProcess(baseCommand = "some_tool", 
                          inputs = InputParamList(in1), 
                          outputs = OutputParamList(out1))
    ```
4.  **Assign Values and Run**: Assign values directly to the object slots and execute with `runCWL()`.
    ```r
    my_tool$msg <- "Hello"
    res <- runCWL(my_tool, outdir = tempdir())
    ```

## Building Pipelines (Workflows)
Connect multiple `cwlProcess` objects into a `cwlWorkflow`:

1.  **Define Steps**: Use `cwlStep()` to define a step, mapping its inputs to workflow inputs or previous step outputs (format: `"step_id/output_id"`).
    ```r
    s1 <- cwlStep(id = "Step1", run = tool1, In = list(input1 = "workflow_input"))
    s2 <- cwlStep(id = "Step2", run = tool2, In = list(input2 = "Step1/output1"))
    ```
2.  **Initialize Workflow**: Use `cwlWorkflow()` with global inputs and outputs.
    ```r
    wf <- cwlWorkflow(inputs = InputParamList(i1), outputs = OutputParamList(o1))
    ```
3.  **Assemble**: Use the `+` operator to add steps to the workflow.
    ```r
    wf <- wf + s1 + s2
    ```

## Advanced R Integration
*   **Wrapping R Functions**: You can pass an R function directly to `baseCommand`. `Rcwl` will automatically generate a script and execute it via `Rscript`.
    ```r
    my_fun <- function(x) { print(x * 2) }
    p <- cwlProcess(baseCommand = my_fun, inputs = InputParamList(InputParam(id="x", type="int", prefix="x=", separate=F)))
    ```
*   **Parallel Execution**: Use `runCWLBatch()` alongside `BiocParallel` to submit multiple jobs to clusters (SGE, SLURM, etc.) or multicore environments.
*   **Visualization**: Use `plotCWL(wf)` to generate a flow diagram of the pipeline steps and data dependencies.
*   **Shiny Apps**: Convert a `cwlProcess` into a web interface using `cwlShiny(process)`.

## Tips for Success
*   **Input Assignment**: Access and set input values using the `$` operator (e.g., `tool$input_id <- value`).
*   **Requirements**: Use `requireDocker("container_name")` or `requireJS()` within the `requirements` or `hints` arguments of `cwlProcess` to handle environment dependencies.
*   **Path Handling**: When using `type = "File"`, ensure the path is absolute or correctly referenced relative to the working directory.
*   **Existing Tools**: Use `readCWL("path/to/tool.cwl")` to import existing CWL files into R objects.

## Reference documentation
- [Rcwl](./references/Rcwl.md)