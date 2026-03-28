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
  + [From](./)
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
* [Previous](../Forward/)
* [Next](../Glob/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/From.md)

* [The from statement](#the-from-statement)

## The from statement

### Synopsis

```
  from(<pattern>,<pattern>,...|[<pattern1>, <pattern2>, ...]) {
     < statements to process files matching patterns >
  }

  from(<pattern>,<pattern>,...|[<pattern1>, <pattern2>, ...])  [filter|transform|produce](...) {
     < statements to process files matching patterns >
  }
```

### Behavior

The *from* statement reshapes the inputs to be the most recent output file(s) matching the given pattern for the following block. This is useful when a task needs an input that was produced earlier in the pipeline than the previous stage, or other similar cases where your inputs don't match the defaults that Bpipe assumes.

Often a *from* would be embedded inside a *produce*, *transform*, or *filter*
block, but that is not required. In such a case, *from* can be joined directly
to the same block by preceding the transform or filter directly with the 'from'
statement.

The patterns accepted by *from* are glob-like expression using `*` to represent
a wildcard. A pattern with no wild card is treated as a file extension, so for
example "`csv`" is treated as "`*.csv`", **but will only match the first (most
recent) CSV file**. By contrast, using `*.csv` directly will cause all
CSV files from the last stage that output a CSV file to match the first
parameter. This latter form is particularly useful for gathering all the files
of the same type output by different parallel stages.

When provided as a list, *from* will accumulate multiple files with different
extensions. When multiple files match a single extension they are used
sequentially each time that extension appears in the list given.

**Note**: using `from` in a nested way (within an existing `from` clause) is not supported and
may result in undefined behavior.

### Examples

**Use most recent CSV file to produce an XML file**

```
  create_excel = {
    transform("xml") {
      from("csv") {
        exec "csv2xml $input > $output"
      }
    }
  }
```

**Use 2 text and CSV files to produce an XML file**

```
  // Here we are assuming that some previous stage is supplying
  // two text files (.txt) and some stage (possibly the same, not necessarily)
  // is supplying a CSV file (.csv).
  create_excel = {
      from("txt","txt","csv") {
        exec "some_command $input1 $input2 $input3 > $output.xml" // input1 and input2 will be .txt, input3 will be .csv
      }
  }
```

**Match all CSV files from the last stage that produces a XML file**

```
  from("*.csv") transform("xml") {
        exec "csv2xml $inputs.csv > $output"
  }
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