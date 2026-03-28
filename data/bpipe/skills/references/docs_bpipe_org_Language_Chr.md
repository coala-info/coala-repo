[Bpipe](../..)

* Overview
  + [Introduction](../../Overview/Introduction/)
  + [Comparison To Workflow Tools](../../Overview/ComparisonToWorkflowTools/)
  + [Install Instructions](../../Overview/InstallInstructions/)
* Language
  + [About](../About/)
  + [Check](../Check/)
  + [Chr](./)
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
* [Previous](../Check/)
* [Next](../CleanupStatement/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Language/Chr.md)

* [The chr statement](#the-chr-statement)

## The chr statement

### Synopsis

```
  chr(<digit|letter> sequence, <digit|letter> sequence) * [ <stage1> + <stage2> + ..., ... ]
```

### Behavior

The `chr` statement splits execution into parallel paths based on chromosome. For the general case, all the files supplied as input are forwarded to every set of parallel stages supplied in the following list. (See below for an exception to this).

The stages that are executed in parallel receive a special implicit variable, 'chr' that can be used to reference the chromosome that should be processed. This is typically passed through to tools that can confine their operations to a genomic region as an argument.

*Note*: Bpipe doesn't do anything to split the input data by chromosome: all the receiving stages get the whole data set. Thus for this to work, the tools that are executed need to support operations on genomic subregions.

### = File Naming Conventions =

When executing inside a chromosomal specific parallel branch of the pipeline, output files are automatically created with the name of the chromosome embedded. This ensures that different parallel branches do not try to write to the same output file. For example, instead of an output file being named "hello.txt" it would be named "hello.chr1.txt" if it was in a parallel branch processing chromosome 1.

If files that are supplied as inputs contain chromosomal segments as part of their file name then the inputs are filtered so that only inputs containing the corresponding chromosome name are forwarded to the parallel segment containing that name. This behavior can be disabled by adding `filterInputs: false` as an additional argument to `chr`.

### Examples

\*\* Call variants on a bam file of human reads from each chromosome in parallel \*\*

```
gatk_call_variants = {
      exec """
        java -Xmx5g -jar GenomeAnalysisTK.jar -T UnifiedGenotyper
            -R hg19.fa
            -D dbsnp_132.hg19.vcf
            -glm BOTH
            -I $input.bam
            -stand_call_conf 5
            -stand_emit_conf 5
            -o $output.vcf
            -metrics ${output}.metrics
            -L $chr
        """
    }
}

chr(1..22,'X','Y') * [ gatk_call_variants ]
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