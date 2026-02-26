# scala CWL Generation Report

## scala

### Tool Description
Run Scala scripts, classes, objects, or jars, or start the interactive shell.

### Metadata
- **Docker Image**: quay.io/biocontainers/scala:2.11.8--1
- **Homepage**: https://github.com/binhnguyennus/awesome-scalability
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scala/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/binhnguyennus/awesome-scalability
- **Stars**: N/A
### Original Help Text
```text
Usage: scala <options> [<script|class|object|jar> <arguments>]
   or  scala -help

All options to scalac (see scalac -help) are also allowed.

The first given argument other than options to scala designates
what to run.  Runnable targets are:

  - a file containing scala source
  - the name of a compiled class
  - a runnable jar file with a valid Main-Class attribute
  - or if no argument is given, the repl (interactive shell) is started

Options to scala which reach the java runtime:

 -Dname=prop  passed directly to java to set system properties
 -J<arg>      -J is stripped and <arg> passed to java as-is
 -nobootcp    do not put the scala jars on the boot classpath (slower)

Other startup options:

 -howtorun    what to run <script|object|jar|guess> (default: guess)
 -i <file>    preload <file> before starting the repl
 -e <string>  execute <string> as if entered in the repl
 -save        save the compiled script in a jar for future use
 -nc          no compilation daemon: do not use the fsc offline compiler

A file argument will be run as a scala script unless it contains only
self-contained compilation units (classes and objects) and exactly one
runnable main method.  In that case the file will be compiled and the
main method invoked.  This provides a bridge between scripts and standard
scala source.

When running a script or using -e, an already running compilation daemon
(fsc) is used, or a new one started on demand.  The -nc option can be
used to prevent this.
```


## Metadata
- **Skill**: generated
