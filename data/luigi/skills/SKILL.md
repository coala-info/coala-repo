---
name: luigi
description: Manages complex batch job pipelines by handling dependency resolution, workflow management, and visualization. Use when user asks to define, schedule, and monitor multi-step data processing workflows.
homepage: https://github.com/spotify/luigi
---


# luigi

luigi/SKILL.md
---
name: luigi
description: |
  Manages complex batch job pipelines by handling dependency resolution, workflow management, and visualization. Use when you need to define, schedule, and monitor multi-step data processing workflows, especially those involving Hadoop, Python scripts, or database operations. This skill is ideal for orchestrating sequences of tasks where the output of one task is the input for another.
---
## Overview
Luigi is a Python module designed to help you build and manage complex pipelines of batch jobs. It excels at defining tasks, their dependencies, and ensuring they are executed in the correct order. Luigi handles the complexities of workflow management, including dependency resolution, scheduling, and visualizing your pipeline's progress. It's particularly useful for data engineering tasks that involve chaining together various processes, such as data extraction, transformation, and loading, especially when dealing with large datasets or distributed computing environments like Hadoop.

## Core Usage and Best Practices

Luigi's primary interface is through its Python API for defining tasks and its command-line interface (CLI) for running and visualizing workflows.

### Defining Tasks

Tasks are the fundamental building blocks in Luigi. They represent a unit of work and have dependencies on other tasks.

```python
import luigi

class MyTask(luigi.Task):
    # Parameters for the task
    date = luigi.DateParameter()
    input_file = luigi.Parameter()

    def output(self):
        # Define the output target for this task
        return luigi.LocalTarget(f'output/{self.date}/{self.input_file}.processed')

    def requires(self):
        # Define the dependencies for this task
        return AnotherTask(date=self.date, input_file=self.input_file)

    def run(self):
        # The actual logic of the task
        with self.input().open('r') as infile, self.output().open('w') as outfile:
            data = infile.read()
            processed_data = data.upper() # Example processing
            outfile.write(processed_data)

class AnotherTask(luigi.Task):
    date = luigi.DateParameter()
    input_file = luigi.Parameter()

    def output(self):
        return luigi.LocalTarget(f'intermediate/{self.date}/{self.input_file}.intermediate')

    def run(self):
        with self.output().open('w') as outfile:
            outfile.write("intermediate data")
```

### Running Tasks via CLI

The Luigi CLI is used to trigger task execution, visualize workflows, and manage the scheduler.

**Basic Execution:**

To run a specific task and all its dependencies:

```bash
luigi --module your_module MyTask --date 2023-10-27 --input-file data.txt
```

*   `--module your_module`: Specifies the Python module containing your tasks.
*   `MyTask`: The name of the task to run.
*   `--date 2023-10-27`, `--input-file data.txt`: These are task parameters.

**Running with the Central Scheduler:**

For managing complex workflows and monitoring, it's recommended to run Luigi with a central scheduler.

1.  **Start the scheduler:**
    ```bash
    luigid
    ```
    This will start the scheduler, typically on port 8082.

2.  **Run tasks pointing to the scheduler:**
    ```bash
    luigi --module your_module MyTask --date 2023-10-27 --input-file data.txt --scheduler-host localhost --scheduler-port 8082
    ```

**Visualization:**

The Luigi scheduler provides a web interface (usually at `http://localhost:8082`) that visualizes the dependency graph of your tasks. Completed tasks are shown in green, and pending tasks in yellow. This is invaluable for understanding workflow status and debugging.

### Expert Tips

*   **Idempotency:** Ensure your tasks are idempotent. Running a task multiple times should produce the same result without side effects. Luigi's `output()` method helps achieve this by checking if the output already exists.
*   **Parameterization:** Use Luigi's parameter types (`DateParameter`, `IntParameter`, `Parameter`, etc.) to make your tasks flexible and configurable.
*   **Target Management:** Luigi supports various `Target` types (e.g., `LocalTarget`, `S3Target`, `HdfsTarget`). Choose the appropriate target for your storage needs.
*   **Error Handling:** Luigi automatically handles task retries and failure reporting. Monitor the scheduler's UI for failed tasks.
*   **Modularity:** Break down complex workflows into smaller, manageable tasks. This improves readability, testability, and reusability.
*   **`luigi.build`:** For programmatic execution within Python scripts, use `luigi.build()`.

```python
import luigi

luigi.build([MyTask(date=datetime.date(2023, 10, 27), input_file='data.txt')], local_scheduler=True)
```

## Reference documentation
- [Luigi Documentation](https://luigi.readthedocs.io/)
- [GitHub Repository](https://github.com/spotify/luigi)