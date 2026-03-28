[Bpipe](../..)

* Overview
  + [Introduction](../Introduction/)
  + [Comparison To Workflow Tools](../ComparisonToWorkflowTools/)
  + [Install Instructions](./)
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
* [Previous](../ComparisonToWorkflowTools/)
* [Next](../../Language/About/)
* [Edit on GitHub](https://github.com/ssadedin/bpipe/edit/master/docs/Overview/InstallInstructions.md)

* [Install Instructions](#install-instructions)
  + [Installation](#installation)
  + [Supported Operating Systems](#supported-operating-systems)
  + [Building from source](#building-from-source)

# Install Instructions

## Installation

Bpipe is entirely self contained and doesn't require any installation.
Download the zip archive from the release page. Unzip your Bpipe
download to a convenient location and place the "bin" directory in
your PATH.

## Supported Operating Systems

Bpipe is tested and maintained on:
- Linux RHEL, Centos and Ubuntu
- Mac OS X Snow Leopard or later
- Windows using Cygwin (`**`)

(`**`) Windows support may be limited in some instances due to limitations of Cygwin.

Although other Unix-like operating systems are welcome and very
likely will run Bpipe without problems, you are encouraged to check
bugs on one of the above OSes before asking for help. Volunteers
to maintain more operating systems are welcome!

## Building from source

On Linux, Bpipe can be built from source provided the Java 8 JDK
is installed. Once you have the source code (from git, or having
downloaded a released source archive), you can build it by invoking
`gradlew` from the top level directory of the source:

```
cd bpipe
./gradlew build
```

This will download all the necessary dependencies and build the jar
files. You can then put bpipe in your PATH, and you're all set!

If you get unit test failures that you wish to ignore, you can
disable the tests by invoking:

```
./gradlew build -x test
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