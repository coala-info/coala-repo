[Bpipe](../..)

* Overview
  + [Introduction](../../Overview/Introduction/)
  + [Comparison To Workflow Tools](../../Overview/ComparisonToWorkflowTools/)
  + [Install Instructions](../../Overview/InstallInstructions/)
* Language
  + [About](./)
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
  + [R](../R/)
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
* [Previous](../../Overview/InstallInstructions/)
* [Next](../Check/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/About.md)

* [The about statement](#the-about-statement)

## The about statement

### Synopsis

```
    about title: <title for pipeline>
```

### Behavior

The *about* statement defines pipeline level documentation for a pipeline file. It can be used any where at the top level of a pipeline file. At the moment, *title* is the only supported attribute for pipeline documentation.

Pipeline documentation is used in the HTML report that can be generated using the [run](/Commands/run) command.

### Examples

**Add a title to a pipeline**

```
about title: "Exome Variant Calling Pipeline"

run { align_bwa + picard_dedupe + gatk_call_variants }
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