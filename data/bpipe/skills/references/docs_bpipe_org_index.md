[Bpipe](.)

* Overview
  + [Introduction](Overview/Introduction/)
  + [Comparison To Workflow Tools](Overview/ComparisonToWorkflowTools/)
  + [Install Instructions](Overview/InstallInstructions/)
* Language
  + [About](Language/About/)
  + [Check](Language/Check/)
  + [Chr](Language/Chr/)
  + [Cleanup](Language/CleanupStatement/)
  + [Config](Language/Config/)
  + [Debug](Language/Debug/)
  + [Directories](Language/Directories/)
  + [Doc](Language/Doc/)
  + [Exec](Language/Exec/)
  + [Fail](Language/Fail/)
  + [File](Language/File/)
  + [Filter](Language/Filter/)
  + [Forward](Language/Forward/)
  + [From](Language/From/)
  + [Glob](Language/Glob/)
  + [Grep](Language/Grep/)
  + [Load](Language/Load/)
  + [Merge Point Operator](Language/MergePoints/)
  + [Multi](Language/Multi/)
  + [Output](Language/Output/)
  + [Options](Language/Options/)
  + [Prefix](Language/Prefix/)
  + [Produce](Language/Produce/)
  + [R](Language/R/)
  + [Segments](Language/Segments/)
  + [Send](Language/Send/)
  + [Succeed](Language/Succeed/)
  + [Transform](Language/Transform/)
  + [Using](Language/Using/)
  + [Preserve in pipeline](Language/PreserveInPipeline/)
  + [requires](Language/requires/)
  + [uses](Language/uses/)
  + [var](Language/var/)
* Commands
  + [Using the bpipe command](Commands/Commands/)
  + [cleanup](Commands/cleanup/)
  + [execute](Commands/execute/)
  + [history](Commands/history/)
  + [jobs](Commands/jobs/)
  + [log](Commands/log/)
  + [preserve](Commands/preserve/)
  + [query](Commands/query/)
  + [retry](Commands/retry/)
  + [run](Commands/run/)
  + [status](Commands/status/)
  + [stop](Commands/stop/)
  + [test](Commands/test/)
* Tutorials
  + [Hello, World](Tutorials/Hello-World/)
  + [Example With Inputs And Outputs](Tutorials/ExampleWithInputsAndOutputs/)
  + [Real Pipeline Tutorial](Tutorials/RealPipelineTutorial/)
* Guides
  + [Configuration Support](Guides/Configuration/)
  + [Variables](Guides/Variables/)
  + [Parallel Tasks](Guides/ParallelTasks/)
  + [Branch Variables](Guides/BranchVariables/)
  + [Extension Syntax](Guides/ExtensionSyntax/)
  + [Logging](Guides/Logging/)
  + [Modules](Guides/Modules/)
  + [Notifications](Guides/Notifications/)
  + [Working with Genomic Regions](Guides/Regions/)
  + [Reports](Guides/Reports/)
  + [Resource Managers](Guides/ResourceManagers/)
  + [Tool Version Database](Guides/ToolVersionDatabase/)
  + [Trash](Guides/Trash/)
  + [Development Setup](Guides/DevelopmentSetup/)
  + [Documentation Style](Guides/DocumentationStyle/)
  + [Implementing A Resource Manager](Guides/ImplementingAResourceManager/)
  + [Troubleshooting](Guides/Troubleshooting/)
  + [Listening for Pipeline Events](Guides/PipelineEvents/)
  + [Advanced Settings](Guides/AdvancedSettings/)
  + [Adding to Class Path](Guides/ExtendingClassPath/)
  + [Pre-allocating Resources for Jobs](Guides/PreallocatedJobs/)
  + [Integration with Gitlab](Guides/Gitlab/)
  + [Integration with JMS / Queuing Systems](Guides/JMS/)
  + [Using Bpipe with Amazon Web Services (AWS/EC2)](Guides/AWS/)
  + [Using Bpipe with Google Cloud (GCS)](Guides/GoogleCloud/)
  + [Using generic SSH to execute commands](Guides/SSHExecutor/)
  + [Running Commands in Containers](Guides/Containers/)
* Examples
  + [Paired End Alignment](Examples/PairedEndAlignment/)
  + [RNA Seq Corset](Examples/RNASeqCorset/)
  + [WGS Variant Calling](Examples/WGSVariantCalling/)

* Search
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/index.md)

* [Welcome to Bpipe](#welcome-to-bpipe)

# Welcome to Bpipe ![Tests](https://github.com/ssadedin/bpipe/actions/workflows/ci-build.yml/badge.svg)

Bpipe provides a platform for running data analytic workgflows that consist of a series of processing stages - known as 'pipelines'. Bpipe has special features to help with
specific challenges in Bioinformatics and computational biology.

* August 2024 - New! [Bpipe 0.9.13](https://github.com/ssadedin/bpipe/releases/tag/0.9.13) released!
* [Documentation](https://docs.bpipe.org)
* [Mailing List](https://groups.google.com/forum/#!forum/bpipe-discuss) (Google Group)

Bpipe has been published in [Bioinformatics](http://bioinformatics.oxfordjournals.org/content/early/2012/04/11/bioinformatics.bts167.abstract)! If you use Bpipe, please cite:

*Sadedin S, Pope B & Oshlack A, Bpipe: A Tool for Running and Managing Bioinformatics Pipelines, Bioinformatics*

**Example**

```
 hello = {
    exec """
        echo "hello world" > $output.txt
    """
 }
 run { hello }
```

**Why Bpipe?**

Many people working in data science end up running jobs as custom shell (or similar)
scripts. While this makes running them easy it has a lot of limitations.
By turning your shell scripts into Bpipe scripts, here are some of the features
you can get:

* **Dependency Tracking** - Like `make` and similar tools, Bpipe knows what you already did and won't do it again
* **Simple definition of tasks to run** - Bpipe runs shell commands almost as-is : super low friction between what works in your command line and what you need to put into your script
* **Transactional management of tasks** - commands that fail get outputs cleaned up, log files saved and the pipeline cleanly aborted. No out of control jobs going crazy.
* **Automatic Connection of Pipeline Stages** - Bpipe manages the file names for input and output of each stage in a systematic way so that you don't need to think about it. Removing or adding new stages "just works" and never breaks the flow of data.
* **Job Management** - know what jobs are running, start, stop, manage whole workflows with simple commands
* **Easy Parallelism** - split jobs into many pieces and run them all in parallel whether on a cluster, cloud or locally. Separate configuration of parallelism from the definition of the tasks.
* **Audit Trail** - keeps a journal of exactly which commands executed, when and what their inputs and outputs were.
* **Integration with Compute Providers** - pure Bpipe scripts can run unchanged whether locally, on
  your server, or in cloud or traditional HPC back ends such as Torque, SLURM GridEngine or others.
* **Deep Integretation Options** - Bpipe integrates well with other systems: receive alerts to tell you when your pipeline finishes or even as each stage completes, call REST APIs, send messages to queueing systems and easily use any type of integration available within the Java ecosystem.
* See how Bpipe compares to [similar tools](https://docs.bpipe.org/Overview/ComparisonToWorkflowTools/)

**Ready for More?**

Take a look at the [Overview](https://docs.bpipe.org/Overview/Introduction/) to
see Bpipe in action, work through the [Basic Tutorial](https://docs.bpipe.org/Tutorials/Hello-World/)
for simple first steps, see a step by step example of a [realistic
pipeline](http://docs.bpipe.org/Tutorials/RealPipelineTutorial/) made using Bpipe, or
take a look at the [Reference](http://docs.bpipe.org) to see all the documentation.

---

Documentation built with [MkDocs](https://www.mkdocs.org/).

#### Search

From here you can search these documents. Enter your search terms below.

#### Keyboard Shortcuts

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |