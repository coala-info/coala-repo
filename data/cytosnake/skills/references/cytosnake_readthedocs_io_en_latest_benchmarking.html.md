Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

Toggle site navigation sidebar

[CytoSnake 0.0.1 documentation](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[![Logo](_static/just-icon.svg)

CytoSnake 0.0.1 documentation](index.html)

* [CytoSnake Tutorial](tutorial.html)[ ]
* [CytoSnake Workflows](workflows.html)[ ]
* [Workflow Modules](workflow-modules.html)[ ]
* [CytoSnake API](modules.html)[ ]
* [Testing Framework](testing.html)[ ]

  Toggle navigation of Testing Framework

  + [Functional Tests](func-tests.html)
  + [Unittest documentation](unit-tests.html)
  + [Workflow tests](workflow-tests.html)
* Benchmarking Workflows[x]

  Toggle navigation of Benchmarking Workflows

Back to top

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/benchmarking.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Benchmarking Workflows[#](#benchmarking-workflows "Permalink to this heading")

## Introduction to Benchmarking with Cytosnake[#](#introduction-to-benchmarking-with-cytosnake "Permalink to this heading")

Cytosnake is a Python package known for its collection of workflows designed for performing image-based profiling.
To ensure these workflows perform at their best, it’s essential to conduct benchmarking.
Benchmarking allows us to assess and optimize the efficiency and reliability of Cytosnake’s image analysis processes.
This tutorial will guide you through the benchmarking process, helping you gauge and improve the performance of these image-based profiling workflows.
Whether you’re a developer seeking to enhance Cytosnake’s functionalities or a user interested in its performance, this guide will equip you with the necessary knowledge.

Here in Cytosnake, we use Memray to benchmark our workflows, making it a great tool for tackling memory usage issues, identifying memory leaks, and pinpointing code hotspots that result in excessive allocations.
Memray’s notable features include tracing every function call, handling native calls in C/C++ libraries, minimal application slowdown during profiling, diverse report generation like flame graphs, compatibility with Python threads, and support for native threads.
Howwever, using the `memray` command-line interface directly on the workflows is not effective, as all workflows are executed through Snakemake.
The workflow itself doesn’t directly engage in image-based profiling but acts as an orchestrator for various scripts involved in the process.
Consequently, memory allocation and resource utilization are delegated to the scripts orchestrated by the workflows, rather than being directly handled by the workflow.

In this guide, you’ll gain an understanding of how to conduct benchmarks with Cytosnake.
You’ll learn not only on how to execute benchmarking but also how to interpret and make the most of the benchmarking outputs.

## Enable benchmarking in cytosnake[#](#enable-benchmarking-in-cytosnake "Permalink to this heading")

To enable benchmarking, modify the `config/configurational.yaml` file and opening it using your preferred text editor.
Once inside the config file, set the `enable_memory_tracking` to `True`, informing CytoSnake that you intend to perform benchmarking on the workflow.

```
enable_profiling: True
```

## Executing benchmarking[#](#executing-benchmarking "Permalink to this heading")

This steps assumes that you’ve already initialized your data using the `cytosnake init` mode.
To execute benchmarking, the process is as the same as running a typical workflow:

```
cytosnake run cp_process
```

Behind the scenes, benchmarking will be automatically initialized, and it will start benchmarking each step within the workflow.

## Examining the Benchmarks[#](#examining-the-benchmarks "Permalink to this heading")

Upon completion of the benchmarks, a `benchmarks/` folder will be generated in your `ProjectDirectory`. To understand more about the `ProjectDirectory`, refer to CytoSnake’s documentation available [here](https://cytosnake.readthedocs.io/en/latest/tutorial.html#setting-up-files).

Two methods are available for analyzing the generated benchmark files:

### Method 1: Using Memray[#](#method-1-using-memray "Permalink to this heading")

You can employ the `memray` command-line tool to extract information from the binarized files and convert them into `.json` files. Execute the following command:

```
memray stats <BINFILE> --json --output <JSON_OUT_NAME>
```

For detailed instructions on extracting binarized `memray` benchmark outputs, visit [this link](https://bloomberg.github.io/memray/stats.html). The resulting JSON files contain benchmarking information captured within the workflow.

### Method 2: Using CytoSnake-Benchmark[#](#method-2-using-cytosnake-benchmark "Permalink to this heading")

Another approach to analyze the generated `benchmarks/` folder is by utilizing the dedicated benchmarking directory available at [CytoSnake-Benchmarks](https://github.com/WayScience/CytoSnake-Benchmarks).

Requirements include the `benchmarks/` folder and the path where all your data is stored. If you have executed `cytosnake run`, then the path you provide should be the `data` folder. Refer to the documentation there for guidance on conducting benchmarking.

[Previous

Workflow tests](workflow-tests.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Benchmarking Workflows
  + [Introduction to Benchmarking with Cytosnake](#introduction-to-benchmarking-with-cytosnake)
  + [Enable benchmarking in cytosnake](#enable-benchmarking-in-cytosnake)
  + [Executing benchmarking](#executing-benchmarking)
  + [Examining the Benchmarks](#examining-the-benchmarks)
    - [Method 1: Using Memray](#method-1-using-memray)
    - [Method 2: Using CytoSnake-Benchmark](#method-2-using-cytosnake-benchmark)