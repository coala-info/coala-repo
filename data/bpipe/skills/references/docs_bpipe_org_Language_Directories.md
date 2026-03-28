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
  + [Directories](./)
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
* [Previous](../Debug/)
* [Next](../Doc/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/Directories.md)

* [Directory Convenience Function](#directory-convenience-function)

## Directory Convenience Function

Sometimes a command you want requires not the name of an output file, but the name of the directory in which that file resides. This can cause a bit of confusion to Bpipe, because the real output is the file, but what you reference in your command is the directory.

To help with this, Bpipe offers a special meaning for the "dir" extension. When you reference `$output.dir` Bpipe treats it as a reference to the output **file**, but it passes the directory in which the file resides to the command that is executing.

The `$input.dir` variable also has special meaning. In this case the `dir` is taken to mean that the whole directory itself should be considered an input, and Bpipe will search for an input that is in fact a directory, rather than a file. This enables you to use the file-extension metaphor for selecting directories within your pipeline for input to your commands.

### Setting the Output Directory

While the `input.dir` is a fixed value, `output.dir` is a writeable value, so you can use it to change the value of directory to which outputs will go. Bpipe currently expects all outputs from a pipeline stage to go to the same directory, so setting this to multiple values or different values will not work.

*Note*: if you modify `output.dir`, be mindful that it must execute before the expression defining the command you wish to execute is evaluated. For example, the following will not work, because output.dir is changed after the output.txt was already evaluated.

```
hello = {
   def myOutput = output.txt
   exec "cp $input.csv $myOutput"
   output.dir="out_dir"
}
```

### Example

Here we wish to have fastqc put its output zip file into a directory called "qc\_data". However fastqc won't let us tell it the full path of the zip file, only the directory name.

```
fastqc = {
    // Start by telling Bpipe where the outputs are going to go
    output.dir = "qc_data"

    // Then tell Bpipe how the file name is getting transformed
    // Notice we don't need any reference to the output directory here!
    transform(".fastq.gz") to ("_fastqc.zip") {
        // Now in our command, Bpipe gives us the folder as the value,
        // while knowing that it is referencing the zip file output
        // specified in our transform
        exec "mkdir -p $output.dir; fastqc -o $output.dir $input.gz"
    }
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