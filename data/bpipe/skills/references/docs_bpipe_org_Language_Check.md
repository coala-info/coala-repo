[Bpipe](../..)

* Overview
  + [Introduction](../../Overview/Introduction/)
  + [Comparison To Workflow Tools](../../Overview/ComparisonToWorkflowTools/)
  + [Install Instructions](../../Overview/InstallInstructions/)
* Language
  + [About](../About/)
  + [Check](./)
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
* [Previous](../About/)
* [Next](../Chr/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/Check.md)

* [The check statement](#the-check-statement)

## The check statement

### Synopsis

```
1.    check {
         < statements to validate results >
      }

2.    check(<check name>) {
         < statements to validate results >
      }

3.    check {
         < statements to validate results >
      } otherwise {
          <statements to execute on failure >
      }

4.    check(<check name>) {
         < statements to validate results >
      } otherwise {
          <statements to execute on failure >
      }
```

### Availability

0.9.8.6\_beta\_2 + (without `otherwise` clause, 0.9.9.5+).

### Behavior

The *check* statement gives a convenient way to implement validation of a
pipeline's outputs or progress and implement an alternative action if the
validation fails. The `check` clause is executed and any `exec` or other
statements inside are processed. If one of these fails, then the `otherwise`
clause executes.

The *check* statement is stateful. Bpipe remembers the result and does not
re-execute a check unless the input files are updated. Thus it is possible to
implement long-running, intensive tasks to perform checks as just like normal
Bpipe commands, they will not be re-executed if the pipeline is re-executed.
The state is remembered by files that are created in the `.bpipe/checks`
directory in the pipeline directory. Effectively, the created check file is
treated as an implicit output of the `check` clause.

A convenient use of `check` is in conjunction with [succeed](/Language/Succeed),
[fail](/Language/Fail) and [send](/Language/Send) commands.

*Note*: a check does not have to result in aborting of the pipeline. You may
choose to do nothing in the otherwise clause of the check (it must still exist
though), in which case the check is merely informational.
Alternatively, the `succeed` command will cause the current branch to terminate
and not produce any output files, but leave other branches running. To fail the
whole pipeline, use the `fail` command.

*Note 2*: due to a quirk of Groovy syntax, the *otherwise* command **must** be
placed on the same line as the preceding curly bracket of the `check` clause.

### Examples

**Check that there are 38 lines in the output file**

```
check {
    exec """
        [ ` wc -l $output` -eq 38 ]
    """
}
```

**Check that output file is non-zero length and fail the whole pipeline if it is not**

```
  check {
        exec "[ -s $output ]"
  } otherwise {
        fail "The output file had zero length"
  }
```

**Check that output file is non-zero length and terminate only this branch if it is not**

```
  check {
        exec "[ -s $output ]"
  } otherwise {
        succeed "The output file had zero length"
  }
```

**Check that output file is non-zero length and notify by email if it is not**

```
  check {
        exec "[ -s $output ]"
  } otherwise {
        send "Output file $output had zero size" to gmail
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