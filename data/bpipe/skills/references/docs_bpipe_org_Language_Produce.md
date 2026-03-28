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
  + [Produce](./)
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
* [Previous](../Prefix/)
* [Next](../R/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/Produce.md)

* [The Produce Statement](#the-produce-statement)

## The Produce Statement

```
    produce(<outputs>|[output1,output2,...]) {
      < statements that produce outputs >
    }
```

### Behavior

The *produce* statement declares a block of statements that will be executed
*transactionally* to create a given set of outputs. In this context,
"transactional" means that all the statements either succeed together or
fail together so that outputs are either fully created, or none are created
(in reality, some outputs may be created but Bpipe will move such outputs
to the [trash folder](/Guides/Trash). Although you do not need to use *produce*
to use Bpipe, using *produce* adds robustness and clarity to your Bpipe
scripts by making explicit the outputs that are created from a particular
pipeline stage. This causes the following behavior:

* If a statement in the enclosed block fails or is interrupted, the specified outputs will be
  "cleaned up", ie. moved to the [trash folder](/Guides/Trash)
* The implicit variable 'output' will be defined as the specified value(s), allowing it to be
  used in the enclosing block. Derivative implicit variables based on file extensions appended
  to the output variable will also resolve to the output.
* The specified output will become the default input to the next stage
  in the pipeline, unless another input is indicated.
* If the specified output already exists and is newer than all the input files
  then executable statements (`exec` or `python` for example) within the produce block will
  not be executed. Note that the block itself may be executed, since Bpipe may evaluate it to
  probe for any references to inputs or outputs not declared in the `produce` section.

*Note*: in most cases it will make more sense to use the convenience wrappers [filter](/Language/Filter) or [transform](/Language/Transform) rather than using *produce* directly as these statements will automatically determine an appropriate file name for the output based on the file name of the input.

A wildcard pattern can also be provided as input to `produce`. In such a case, the `$output` variable is not assigned a value, but after the `produce` block executes, the file system is scanned for files matching the wild card pattern and any files found that were not present before running the command are treated as outputs of the block.

*Note*: as Bpipe assumes ALL matching new files are outputs from the `produce` block, using a wild card pattern inside a parallel block should be treated with caution, as multiple executing pathways may "see" each other's files.

### Examples

**Produce a single output**

```
produce("foo.txt") {
  exec "echo 'Hello World' > $output"
}
```

**Produce multiple outputs**

```
produce("foo.txt", "bar.txt") {
  exec "echo Hello > $output1"
  exec "echo World > $output2"
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