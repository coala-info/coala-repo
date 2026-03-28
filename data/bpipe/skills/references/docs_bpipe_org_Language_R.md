[Bpipe](../..)

* Overview
  + [Introduction](../../Overview/Introduction/)
  + [Comparison To Workflow Tools](../../Overview/ComparisonToWorkflowTools/)
  + [Install Instructions](../../Overview/InstallInstructions/)
* Language
  + [About](../About/)
  + [Check](../Check/)
  + [Chr](../Chr/)
  + [Cleanup](../CleanupStatement/)
  + [Config](../Config/)
  + [Debug](../Debug/)
  + [Directories](../Directories/)
  + [Doc](../Doc/)
  + [Exec](../Exec/)
  + [Fail](../Fail/)
  + [File](../File/)
  + [Filter](../Filter/)
  + [Forward](../Forward/)
  + [From](../From/)
  + [Glob](../Glob/)
  + [Grep](../Grep/)
  + [Load](../Load/)
  + [Merge Point Operator](../MergePoints/)
  + [Multi](../Multi/)
  + [Output](../Output/)
  + [Options](../Options/)
  + [Prefix](../Prefix/)
  + [Produce](../Produce/)
  + [R](./)
  + [Segments](../Segments/)
  + [Send](../Send/)
  + [Succeed](../Succeed/)
  + [Transform](../Transform/)
  + [Using](../Using/)
  + [Preserve in pipeline](../PreserveInPipeline/)
  + [requires](../requires/)
  + [uses](../uses/)
  + [var](../var/)
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
* [Previous](../Produce/)
* [Next](../Segments/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/R.md)

* [Executing Inline R Code](#executing-inline-r-code)

## Executing Inline R Code

### Synopsis

```
R {"""
    < R code >

   """}
```

### Behavior

Executes the embedded `R` code by passing it to the `Rscript` utility. Tokens preceded with `$` that match known Bpipe variables are evaluated as Bpipe variables before passing the script through. Other such tokens are passed through unmodified. This has the effect that you can reference your Bpipe variables such as `$input` and `$output` directly inside your R code.

*Note*: Any variable defined in the Bpipe / Groovy namespace will get evaluated, including pipeline stages, parameters passed to the script, and others. So it is important to understand that this can lead to unexpected evaluation of variables inside the R code. This feature is intended as a simple way to inline small R scripts, for example, to quickly create a plot of some results. Larger R programs should be executed by saving them as files and running them directly using Rscript.

*Note*: By default Bpipe uses the R executable (or actually, the Rscript executable) that it finds in your path. If you want to set a custom R executable, you can do so by adding a bpipe.config file with an entry such as the following:

```
R {
    executable = "/usr/local/R/3.1.1/bin/Rscript"
}
```

### Examples

**Plot the values from a tab separated file**

```
R {"""
  values = read.table('$input.tsv');
  png('$output.png')
  plot(values)
  dev.off()
"""}
```

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