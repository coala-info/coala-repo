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
  + [Merge Point Operator](./)
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
* [Previous](../Load/)
* [Next](../Multi/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/MergePoints.md)

* [Merge points](#merge-points)
* [Synopsis](#synopsis)

## Merge points

## Synopsis

```
   <branch definition> * [ <stage1>,<stage2>,...] >>> <merge stage>
```

### Behavior

Defines a stage that is identified as a merge point for a preceding set of parallel stages.
This is nearly the same as using the `+` operator, however it causes Bpipe to name the outputs
of the merge stage differently. Specifically, ordinarily, the merge stage would name
its output according to the first input by default. However this often leads to misleadingly
named outputs that appear to be derived only from the first parallel branch of the parallel segment.
When the mergepoint operator is used, Bpipe will still derive the output name from the first input,
however it will excise the branch name from the file name of that input and replace it with "merge",
so that the output is clearly identified as a merge of previous inputs.

The merge point operator is particularly useful when dynamic branching constructs are used such
that you cannot anticipate exactly what the branch names will be beforehand.

### Examples

**Merge Outputs from Three Pipeline Branches Together**

Here a pipeline branches three ways with with branches called
`foo`, `bar` and `baz`. If the `>>>` operator was not used, the final output
would end with `foo.there.world.xml`. However because the merge point
operator is applied, the final output ends with `.merge.there.world.xml`

```
hello = {
    exec """
        cp -v $input.txt $output.csv
    """
}

there = {
    exec """
        cp -v $input.csv $output.tsv
    """
}

world = {
    exec """
        cat $inputs.tsv > $output.xml
    """
}

run {
    hello + ['foo','bar','baz'] * [ there ] >>> world
}
```

**Split hg19 500 ways and merge the results back together**

Note that here we make use of Bpipe's automatic region splitting and magic
`$region.bed` variable.

```
genome 'hg19'

compute_gc_content = {
    exec """gc_content -L $region.bed $input.txt > $output.gc.txt"""
}

calculate_mean = {
    exec """
        cat $inputs.txt | gngs 'println(graxxia.Stats.mean())' > $output.mean.txt
    """
}

run {
    hg19.split(500) [ compute_gc_content ] + calculate_mean
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