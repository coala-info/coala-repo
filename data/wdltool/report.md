# wdltool CWL Generation Report

## wdltool_validate

### Tool Description
Validates a WDL file.

### Metadata
- **Docker Image**: quay.io/biocontainers/wdltool:0.14--1
- **Homepage**: https://github.com/broadinstitute/wdltool
- **Package**: https://anaconda.org/channels/bioconda/packages/wdltool/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wdltool/overview
- **Total Downloads**: 23.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/wdltool
- **Stars**: N/A
### Original Help Text
```text
Exception in thread "main" java.nio.file.NoSuchFileException: /--help
	at sun.nio.fs.UnixException.translateToIOException(UnixException.java:86)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:102)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:107)
	at sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:214)
	at java.nio.file.Files.newByteChannel(Files.java:361)
	at java.nio.file.Files.newByteChannel(Files.java:407)
	at java.nio.file.Files.readAllBytes(Files.java:3152)
	at better.files.File.loadBytes(File.scala:171)
	at better.files.File.byteArray(File.scala:174)
	at better.files.File.contentAsString(File.scala:214)
	at wdl4s.wdl.WdlNamespace$.readFile(WdlNamespace.scala:538)
	at wdl4s.wdl.WdlNamespace$.loadUsingPath(WdlNamespace.scala:171)
	at wdltool.Main$.loadWdl(Main.scala:115)
	at wdltool.Main$.$anonfun$validate$2(Main.scala:45)
	at wdltool.Main$.continueIf(Main.scala:112)
	at wdltool.Main$.validate(Main.scala:45)
	at wdltool.Main$.dispatchCommand(Main.scala:33)
	at wdltool.Main$.delayedEndpoint$wdltool$Main$1(Main.scala:176)
	at wdltool.Main$delayedInit$body.apply(Main.scala:12)
	at scala.Function0.apply$mcV$sp(Function0.scala:34)
	at scala.Function0.apply$mcV$sp$(Function0.scala:34)
	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)
	at scala.App.$anonfun$main$1$adapted(App.scala:76)
	at scala.collection.immutable.List.foreach(List.scala:378)
	at scala.App.main(App.scala:76)
	at scala.App.main$(App.scala:74)
	at wdltool.Main$.main(Main.scala:12)
	at wdltool.Main.main(Main.scala)
```


## wdltool_inputs

### Tool Description
Generate JSON inputs for a WDL workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/wdltool:0.14--1
- **Homepage**: https://github.com/broadinstitute/wdltool
- **Package**: https://anaconda.org/channels/bioconda/packages/wdltool/overview
- **Validation**: PASS

### Original Help Text
```text
Exception in thread "main" java.nio.file.NoSuchFileException: /--help
	at sun.nio.fs.UnixException.translateToIOException(UnixException.java:86)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:102)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:107)
	at sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:214)
	at java.nio.file.Files.newByteChannel(Files.java:361)
	at java.nio.file.Files.newByteChannel(Files.java:407)
	at java.nio.file.Files.readAllBytes(Files.java:3152)
	at better.files.File.loadBytes(File.scala:171)
	at better.files.File.byteArray(File.scala:174)
	at better.files.File.contentAsString(File.scala:214)
	at wdl4s.wdl.WdlNamespace$.readFile(WdlNamespace.scala:538)
	at wdl4s.wdl.WdlNamespace$.loadUsingPath(WdlNamespace.scala:171)
	at wdltool.Main$.loadWdl(Main.scala:115)
	at wdltool.Main$.$anonfun$inputs$2(Main.scala:60)
	at wdltool.Main$.continueIf(Main.scala:112)
	at wdltool.Main$.inputs(Main.scala:60)
	at wdltool.Main$.dispatchCommand(Main.scala:35)
	at wdltool.Main$.delayedEndpoint$wdltool$Main$1(Main.scala:176)
	at wdltool.Main$delayedInit$body.apply(Main.scala:12)
	at scala.Function0.apply$mcV$sp(Function0.scala:34)
	at scala.Function0.apply$mcV$sp$(Function0.scala:34)
	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)
	at scala.App.$anonfun$main$1$adapted(App.scala:76)
	at scala.collection.immutable.List.foreach(List.scala:378)
	at scala.App.main(App.scala:76)
	at scala.App.main$(App.scala:74)
	at wdltool.Main$.main(Main.scala:12)
	at wdltool.Main.main(Main.scala)
```


## wdltool_highlight

### Tool Description
Performs various operations on WDL files.

### Metadata
- **Docker Image**: quay.io/biocontainers/wdltool:0.14--1
- **Homepage**: https://github.com/broadinstitute/wdltool
- **Package**: https://anaconda.org/channels/bioconda/packages/wdltool/overview
- **Validation**: PASS

### Original Help Text
```text
java -jar wdltool.jar <action> <parameters>

Actions:
validate <WDL file>

  Performs full validation of the WDL file including syntax
  and semantic checking

inputs <WDL file>

  Print a JSON skeleton file of the inputs needed for this
  workflow.  Fill in the values in this JSON document and
  pass it in to the 'run' subcommand.

highlight <WDL file> <html|console>

  Reformats and colorizes/tags a WDL file. The second
  parameter is the output type.  "html" will output the WDL
  file with <span> tags around elements.  "console" mode
  will output colorized text to the terminal

parse <WDL file>

  Compares a WDL file against the grammar and prints out an
  abstract syntax tree if it is valid, and a syntax error
  otherwise.  Note that higher-level AST checks are not done
  via this sub-command and the 'validate' subcommand should
  be used for full validation.

graph <WDL file>

  Reads a WDL file against the grammar and prints out a
  .dot of the DAG if it is valid, and a syntax error
  otherwise.

womgraph <WDL or CWL file> [ancillary files]

  Reads a WDL or CWL file from the first argument and
  converts it to a WOM representation then prints out a graph
  of the WOM produced.
  Any imported files can be supplied as subsequent arguments.
```


## wdltool_parse

### Tool Description
Parses a WDL file and prints its Abstract Syntax Tree (AST).

### Metadata
- **Docker Image**: quay.io/biocontainers/wdltool:0.14--1
- **Homepage**: https://github.com/broadinstitute/wdltool
- **Package**: https://anaconda.org/channels/bioconda/packages/wdltool/overview
- **Validation**: PASS

### Original Help Text
```text
Exception in thread "main" java.nio.file.NoSuchFileException: /--help
	at sun.nio.fs.UnixException.translateToIOException(UnixException.java:86)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:102)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:107)
	at sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:214)
	at java.nio.file.Files.newByteChannel(Files.java:361)
	at java.nio.file.Files.newByteChannel(Files.java:407)
	at java.nio.file.Files.readAllBytes(Files.java:3152)
	at better.files.File.loadBytes(File.scala:171)
	at better.files.File.byteArray(File.scala:174)
	at better.files.File.contentAsString(File.scala:214)
	at wdl4s.wdl.AstTools$.getAst(AstTools.scala:200)
	at wdltool.Main$.$anonfun$parse$2(Main.scala:74)
	at wdltool.Main$.continueIf(Main.scala:112)
	at wdltool.Main$.parse(Main.scala:74)
	at wdltool.Main$.dispatchCommand(Main.scala:36)
	at wdltool.Main$.delayedEndpoint$wdltool$Main$1(Main.scala:176)
	at wdltool.Main$delayedInit$body.apply(Main.scala:12)
	at scala.Function0.apply$mcV$sp(Function0.scala:34)
	at scala.Function0.apply$mcV$sp$(Function0.scala:34)
	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)
	at scala.App.$anonfun$main$1$adapted(App.scala:76)
	at scala.collection.immutable.List.foreach(List.scala:378)
	at scala.App.main(App.scala:76)
	at scala.App.main$(App.scala:74)
	at wdltool.Main$.main(Main.scala:12)
	at wdltool.Main.main(Main.scala)
```


## wdltool_graph

### Tool Description
Generate a graphviz DOT representation of a WDL workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/wdltool:0.14--1
- **Homepage**: https://github.com/broadinstitute/wdltool
- **Package**: https://anaconda.org/channels/bioconda/packages/wdltool/overview
- **Validation**: PASS

### Original Help Text
```text
Exception in thread "main" java.nio.file.NoSuchFileException: --help
	at sun.nio.fs.UnixException.translateToIOException(UnixException.java:86)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:102)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:107)
	at sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:214)
	at java.nio.file.Files.newByteChannel(Files.java:361)
	at java.nio.file.Files.newByteChannel(Files.java:407)
	at java.nio.file.spi.FileSystemProvider.newInputStream(FileSystemProvider.java:384)
	at java.nio.file.Files.newInputStream(Files.java:152)
	at java.nio.file.Files.newBufferedReader(Files.java:2784)
	at java.nio.file.Files.readAllLines(Files.java:3202)
	at java.nio.file.Files.readAllLines(Files.java:3242)
	at wdltool.graph.GraphPrint$.generateWorkflowDigraph(GraphPrint.scala:20)
	at wdltool.Main$.$anonfun$graph$2(Main.scala:83)
	at wdltool.Main$.continueIf(Main.scala:112)
	at wdltool.Main$.graph(Main.scala:79)
	at wdltool.Main$.dispatchCommand(Main.scala:37)
	at wdltool.Main$.delayedEndpoint$wdltool$Main$1(Main.scala:176)
	at wdltool.Main$delayedInit$body.apply(Main.scala:12)
	at scala.Function0.apply$mcV$sp(Function0.scala:34)
	at scala.Function0.apply$mcV$sp$(Function0.scala:34)
	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)
	at scala.App.$anonfun$main$1$adapted(App.scala:76)
	at scala.collection.immutable.List.foreach(List.scala:378)
	at scala.App.main(App.scala:76)
	at scala.App.main$(App.scala:74)
	at wdltool.Main$.main(Main.scala:12)
	at wdltool.Main.main(Main.scala)
```


## wdltool_womgraph

### Tool Description
Generate a DOT graph of a WDL workflow or CWL document.

### Metadata
- **Docker Image**: quay.io/biocontainers/wdltool:0.14--1
- **Homepage**: https://github.com/broadinstitute/wdltool
- **Package**: https://anaconda.org/channels/bioconda/packages/wdltool/overview
- **Validation**: PASS

### Original Help Text
```text
Exception in thread "main" java.nio.file.NoSuchFileException: --help
	at sun.nio.fs.UnixException.translateToIOException(UnixException.java:86)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:102)
	at sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:107)
	at sun.nio.fs.UnixFileSystemProvider.newByteChannel(UnixFileSystemProvider.java:214)
	at java.nio.file.Files.newByteChannel(Files.java:361)
	at java.nio.file.Files.newByteChannel(Files.java:407)
	at java.nio.file.spi.FileSystemProvider.newInputStream(FileSystemProvider.java:384)
	at java.nio.file.Files.newInputStream(Files.java:152)
	at java.nio.file.Files.newBufferedReader(Files.java:2784)
	at java.nio.file.Files.readAllLines(Files.java:3202)
	at java.nio.file.Files.readAllLines(Files.java:3242)
	at wdltool.graph.WomGraphPrint$.readFile(WomGraphPrint.scala:23)
	at wdltool.graph.WomGraphPrint$.womExecutableFromCwl(WomGraphPrint.scala:31)
	at wdltool.graph.WomGraphPrint$.generateWorkflowDigraph(WomGraphPrint.scala:51)
	at wdltool.Main$.$anonfun$womGraph$2(Main.scala:100)
	at wdltool.Main$.continueIf(Main.scala:112)
	at wdltool.Main$.womGraph(Main.scala:96)
	at wdltool.Main$.dispatchCommand(Main.scala:38)
	at wdltool.Main$.delayedEndpoint$wdltool$Main$1(Main.scala:176)
	at wdltool.Main$delayedInit$body.apply(Main.scala:12)
	at scala.Function0.apply$mcV$sp(Function0.scala:34)
	at scala.Function0.apply$mcV$sp$(Function0.scala:34)
	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)
	at scala.App.$anonfun$main$1$adapted(App.scala:76)
	at scala.collection.immutable.List.foreach(List.scala:378)
	at scala.App.main(App.scala:76)
	at scala.App.main$(App.scala:74)
	at wdltool.Main$.main(Main.scala:12)
	at wdltool.Main.main(Main.scala)
```

