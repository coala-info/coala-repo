[Bpipe](../..)

* Overview
  + [Introduction](./)
  + [Comparison To Workflow Tools](../ComparisonToWorkflowTools/)
  + [Install Instructions](../InstallInstructions/)
* Language
  + [About](../../Language/About/)
  + [Check](../../Language/Check/)
  + [Chr](../../Language/Chr/)
  + [Cleanup](../../Language/CleanupStatement/)
  + [Config](../../Language/Config/)
  + [Debug](../../Language/Debug/)
  + [Directories](../../Language/Directories/)
  + [Doc](../../Language/Doc/)
  + [Exec](../../Language/Exec/)
  + [Fail](../../Language/Fail/)
  + [File](../../Language/File/)
  + [Filter](../../Language/Filter/)
  + [Forward](../../Language/Forward/)
  + [From](../../Language/From/)
  + [Glob](../../Language/Glob/)
  + [Grep](../../Language/Grep/)
  + [Load](../../Language/Load/)
  + [Merge Point Operator](../../Language/MergePoints/)
  + [Multi](../../Language/Multi/)
  + [Output](../../Language/Output/)
  + [Options](../../Language/Options/)
  + [Prefix](../../Language/Prefix/)
  + [Produce](../../Language/Produce/)
  + [R](../../Language/R/)
  + [Segments](../../Language/Segments/)
  + [Send](../../Language/Send/)
  + [Succeed](../../Language/Succeed/)
  + [Transform](../../Language/Transform/)
  + [Using](../../Language/Using/)
  + [Preserve in pipeline](../../Language/PreserveInPipeline/)
  + [requires](../../Language/requires/)
  + [uses](../../Language/uses/)
  + [var](../../Language/var/)
* Commands
  + [Using the bpipe command](../../Commands/Commands/)
  + [cleanup](../../Commands/cleanup/)
  + [execute](../../Commands/execute/)
  + [history](../../Commands/history/)
  + [jobs](../../Commands/jobs/)
  + [log](../../Commands/log/)
  + [preserve](../../Commands/preserve/)
  + [query](../../Commands/query/)
  + [retry](../../Commands/retry/)
  + [run](../../Commands/run/)
  + [status](../../Commands/status/)
  + [stop](../../Commands/stop/)
  + [test](../../Commands/test/)
* Tutorials
  + [Hello, World](../../Tutorials/Hello-World/)
  + [Example With Inputs And Outputs](../../Tutorials/ExampleWithInputsAndOutputs/)
  + [Real Pipeline Tutorial](../../Tutorials/RealPipelineTutorial/)
* Guides
  + [Configuration Support](../../Guides/Configuration/)
  + [Variables](../../Guides/Variables/)
  + [Parallel Tasks](../../Guides/ParallelTasks/)
  + [Branch Variables](../../Guides/BranchVariables/)
  + [Extension Syntax](../../Guides/ExtensionSyntax/)
  + [Logging](../../Guides/Logging/)
  + [Modules](../../Guides/Modules/)
  + [Notifications](../../Guides/Notifications/)
  + [Working with Genomic Regions](../../Guides/Regions/)
  + [Reports](../../Guides/Reports/)
  + [Resource Managers](../../Guides/ResourceManagers/)
  + [Tool Version Database](../../Guides/ToolVersionDatabase/)
  + [Trash](../../Guides/Trash/)
  + [Development Setup](../../Guides/DevelopmentSetup/)
  + [Documentation Style](../../Guides/DocumentationStyle/)
  + [Implementing A Resource Manager](../../Guides/ImplementingAResourceManager/)
  + [Troubleshooting](../../Guides/Troubleshooting/)
  + [Listening for Pipeline Events](../../Guides/PipelineEvents/)
  + [Advanced Settings](../../Guides/AdvancedSettings/)
  + [Adding to Class Path](../../Guides/ExtendingClassPath/)
  + [Pre-allocating Resources for Jobs](../../Guides/PreallocatedJobs/)
  + [Integration with Gitlab](../../Guides/Gitlab/)
  + [Integration with JMS / Queuing Systems](../../Guides/JMS/)
  + [Using Bpipe with Amazon Web Services (AWS/EC2)](../../Guides/AWS/)
  + [Using Bpipe with Google Cloud (GCS)](../../Guides/GoogleCloud/)
  + [Using generic SSH to execute commands](../../Guides/SSHExecutor/)
  + [Running Commands in Containers](../../Guides/Containers/)
* Examples
  + [Paired End Alignment](../../Examples/PairedEndAlignment/)
  + [RNA Seq Corset](../../Examples/RNASeqCorset/)
  + [WGS Variant Calling](../../Examples/WGSVariantCalling/)

* Search
* Previous
* [Next](../ComparisonToWorkflowTools/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Overview/Introduction.md)

* [Introduction](#introduction)
* [The Bpipe Language](#the-bpipe-language)
* [The Bpipe Command Line Utility](#the-bpipe-command-line-utility)

## Introduction

Bpipe is two things:

* A small language for defining pipeline stages and linking them together to make pipelines
* A utility for running and managing the pipelines you define

Bpipe does not replace the commands you run within your pipeline, but rather it helps you to run them better - more safely, more reliably and more conveniently.

## The Bpipe Language

The Bpipe language is a minimal syntax for declaring how to run your pipeline stages. Bpipe is actually a [Domain Specific Language](http://en.wikipedia.org/wiki/Domain-specific_language) based on Groovy, a scripting language that inherits syntax from Java. All Bpipe scripts are valid Groovy scripts, and most Java syntax works in Bpipe scripts. However you don't need to know either Java or Groovy to use Bpipe.

For Bpipe to run your pipeline you need to give each part of the pipeline (each *stage*) a name. In Bpipe naming a pipeline stage looks like this:

```
stage_name = {
  exec "shell command to execute your pipeline stage"
}
```

The shell command is the same command you would run from the command line to execute that part of your pipeline, placed in quotes.

You can define many pipeline stages in one file:

```
stage_one = {
  exec "shell command to execute stage one"
}

stage_two = {
  exec "shell command to execute stage two"
}
```

Once you define your pipeline stages you can build and run your pipeline by *joining* the stages using the *plus* operator:

```
Bpipe.run {
 stage_one + stage_two
}
```

Putting this all together, here is the whole Bpipe script:

```
stage_one = {
  exec "shell command to execute stage one"
}

stage_two = {
  exec "shell command to execute stage two"
}

Bpipe.run {
 stage_one + stage_two
}
```

## The Bpipe Command Line Utility

Bpipe comes with a tool to run and manage your scripts called *bpipe* (surprise!). The most basic use of the bpipe command is to run your pipelines. To do that, you simply save your pipeline definition in a file and then run the pipeline:

```
  bpipe run your_pipeline_file
```

The bpipe command line tool can perform other functions that are useful for managing your pipeline as well:

To rerun the last pipeline that was run in the local directory from where it left off:

```
  bpipe retry
```

To see what a pipeline will do without actually executing it:

```
  bpipe test your_pipeline_file
```

To see the history of jobs run in the local directory:

```
  bpipe history
```

To see what bpipe jobs you currently have running:

```
  bpipe jobs
```

### Next Steps

To learn more about how Bpipe works, take a look at the [Hello, World](/Tutorials/Hello-World) turorial where you can work through creating a very simple pipeline. Or if you are already comfortable with the basics of how bpipe is working you can jump straight to an example of a [real bioinformatics pipeline](/Tutorials/RealPipelineTutorial).

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