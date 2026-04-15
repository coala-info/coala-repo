---
name: bpipe
description: Bpipe is a tool for defining and running modular, large-scale computational pipelines using a Groovy-based domain-specific language. Use when user asks to define pipeline stages, manage bioinformatics file flows, parallelize tasks across chromosomes, or resume failed workflows.
homepage: http://docs.bpipe.org/
metadata:
  docker_image: "quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0"
---

# bpipe

## Overview

Bpipe is a specialized tool designed for defining and running large-scale computational pipelines, primarily in the field of bioinformatics. It provides a Groovy-based Domain Specific Language (DSL) that allows users to wrap shell commands into modular "stages." Bpipe's primary value lies in its ability to handle the "plumbing" of a pipeline—such as automatic file naming, tracking of intermediate files, and resource management—without requiring the user to write complex boilerplate code. It supports sophisticated parallelization patterns and provides robust mechanisms for restarting failed pipelines from the point of failure.

## Core Workflow Patterns

### 1. Defining Pipeline Stages
Stages are the building blocks of Bpipe. Define them as closures and use the `exec` statement to run shell commands.

```groovy
align_bwa = {
    doc "Align reads using BWA"
    exec "bwa mem reference.fa $input > $output"
}
```

### 2. Managing Inputs and Outputs
Bpipe uses implicit variables to manage data flow.
- **`$input`**: The primary input file from the previous stage.
- **`$output`**: The expected output file (automatically named based on the input).
- **`transform`**: Use when the file extension changes (e.g., .sam to .bam).
- **`filter`**: Use when the format stays the same but the content is modified (e.g., .bam to .dedupe.bam).
- **`produce`**: Use when you want to explicitly name the output file.

```groovy
sam_to_bam = {
    transform("bam") {
        exec "samtools view -bS $input > $output"
    }
}
```

### 3. Parallel Execution
Bpipe excels at parallelizing tasks across chromosomes or samples.
- **Chromosome Parallelism**: Use the `chr()` function to split execution.
- **Merge Points**: Use the `>>>` operator to merge parallel branches back into a single stream.

```groovy
// Run variant calling on chromosomes 1-22, X, and Y in parallel
run {
    chr(1..22, 'X', 'Y') * [ call_variants ] >>> merge_vcf
}
```

### 4. Validation and Error Handling
Use the `check` statement to verify that a stage produced valid results before proceeding.

```groovy
check_output = {
    check {
        exec "[ -s $output ]" // Check if file is non-zero size
    } otherwise {
        fail "Output file was empty"
    }
}
```

## CLI Usage Patterns

- **Run a pipeline**: `bpipe run <script.groovy> <input_files>`
- **Dry run**: `bpipe test <script.groovy> <input_files>` (Shows what would be executed without running it).
- **Resume after failure**: `bpipe retry` (Automatically picks up from the last successful stage).
- **Stop execution**: `bpipe stop`
- **View status**: `bpipe status`
- **Cleanup intermediates**: `bpipe cleanup` (Removes intermediate files that are no longer needed).

## Expert Tips

- **Modularity**: Use the `load` statement to import stages from external files, allowing you to build a library of reusable bioinformatics components.
- **Directory Management**: Use `$output.dir` to direct outputs to specific folders while maintaining Bpipe's file tracking.
- **Resource Configuration**: Define memory and CPU requirements in a `bpipe.config` file or within a `config { ... }` block inside the script to ensure the pipeline scales correctly on clusters (Torque, SLURM, etc.).
- **Documentation**: Always include a `doc` attribute in your stages. Bpipe uses these to generate detailed HTML reports of the pipeline run.



## Subcommands

| Command | Description |
|---------|-------------|
| archive | Archiving to computed file path |
| bpipe | Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024 |
| bpipe | bpipe [run\|test\|debug\|touch\|execute] [options] <pipeline> <in1> <in2>...              retry [job id] [test]              remake <file1> <file2>...              resume              stop [preallocated]              history              log [-n <lines>] [job id]              jobs              checks [options]              override              status              cleanup              query <file>              preallocate              archive [--delete] <zip file path>              autoarchive              preserve              register <pipeline> <in1> <in2>...              diagram <pipeline> <in1> <in2>...              diagrameditor <pipeline> <in1> <in2>... |
| bpipe | Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024 |
| bpipe | Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024 |
| bpipe | Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024 |
| bpipe diagram | Generate a diagram of a Bpipe pipeline |
| bpipe jobs | List and manage Bpipe jobs |
| bpipe override | Override specified check to force it to pass |
| bpipe register | Register a pipeline with Bpipe |
| bpipe_archive | Archiving to computed file path |
| bpipe_checks | Check Report |
| bpipe_log | Show log output from bpipe jobs |

## Reference documentation
- [The exec statement](./references/docs_bpipe_org_Language_Exec.md)
- [The chr statement](./references/docs_bpipe_org_Language_Chr.md)
- [The check statement](./references/docs_bpipe_org_Language_Check.md)
- [The produce statement](./references/docs_bpipe_org_Language_Produce.md)
- [Merge points](./references/docs_bpipe_org_Language_MergePoints.md)
- [The load statement](./references/docs_bpipe_org_Language_Load.md)