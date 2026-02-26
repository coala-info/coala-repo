---
name: parallel
description: "This tool executes commands in parallel across multiple CPUs. Use when user asks to run commands in parallel, speed up batch processing, or execute multiple instances of the same command with different arguments."
homepage: https://github.com/PaddlePaddle/Paddle
---


# parallel

yaml
name: parallel
description: Execute commands in parallel on multiple CPUs. Use when you need to run multiple instances of the same command with different arguments simultaneously to speed up processing, especially for tasks like data processing, simulations, or batch operations.
```
## Overview
The `parallel` command-line utility is designed to execute multiple commands concurrently, leveraging available CPU cores to significantly speed up batch processing. It's particularly useful for tasks where the same operation needs to be applied to many different inputs, such as processing files, running simulations, or performing repetitive computations. By distributing these tasks across multiple cores, `parallel` can drastically reduce the overall execution time compared to sequential processing.

## Usage Instructions

The `parallel` command allows for flexible execution of commands in parallel. Here are some common and powerful patterns:

### Basic Parallel Execution

Run a command multiple times with different arguments. The arguments are typically read from standard input, one per line.

```bash
# Example: Process each file in a directory with 'process_file.sh'
find . -name "*.txt" | parallel process_file.sh {}
```

- `{}`: Represents the input line (e.g., a filename).
- `parallel command {}`: Executes `command` for each line of input, substituting `{}` with the line.

### Executing a Script with Arguments

You can also specify the command directly and have `parallel` generate the arguments.

```bash
# Example: Run 'my_script.py' with arguments 1 through 10
parallel my_script.py ::: {1..10}
```

- `::: {1..10}`: Specifies a range of arguments to be passed to `my_script.py`.

### Controlling the Number of Jobs

By default, `parallel` uses the number of CPU cores available. You can control this with the `-j` option.

```bash
# Example: Run with a maximum of 4 parallel jobs
find . -name "*.log" | parallel -j 4 analyze_log.sh {}
```

### Grouping Output

To keep the output of each parallel job distinct, you can use `--results` or `--group`.

```bash
# Example: Group output by job
find . -name "*.data" | parallel --group process_data.sh {}
```

### Remote Execution (Advanced)

`parallel` can also distribute jobs across multiple remote machines using SSH.

```bash
# Example: Run jobs on local machine and two remote machines
parallel --sshlogin user@host1,user@host2,localhost process_file.sh {}
```

### Tips and Best Practices

*   **Start Small**: Begin with a small number of parallel jobs (`-j N`) to ensure your command behaves as expected and doesn't overload your system.
*   **Idempotency**: Ensure the commands you run in parallel are idempotent (running them multiple times has the same effect as running them once) or that their outputs can be safely merged.
*   **Resource Management**: Be mindful of disk I/O, memory, and network bandwidth. Running too many I/O-intensive jobs in parallel can slow down the system.
*   **Error Handling**: Use `parallel --halt now,fail=1` to stop all jobs immediately if any single job fails.
*   **Quoting**: Pay close attention to shell quoting, especially when commands involve spaces or special characters. `parallel` often handles this well, but complex commands might require careful escaping.
*   **Input Sources**: `parallel` can read input from files (`parallel -a input.txt ...`) or directly from stdin.

## Reference documentation
- [Anaconda.org - bioconda / parallel](https://anaconda.org/bioconda/parallel)