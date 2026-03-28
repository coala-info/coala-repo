### Navigation

* [index](../../genindex.html "General Index")
* [next](display.html "Displaying images and metadata") |
* [previous](../imagej/options.html "Bio-Formats plugin configuration options") |
* [Bio-Formats 5.7.1 documentation](../../index.html) »
* [User Information](../index.html) »

# Command line tools introduction[¶](#command-line-tools-introduction "Permalink to this headline")

There are several scripts for using Bio-Formats on the command
line.

## Installation[¶](#installation "Permalink to this headline")

Download [bftools.zip](http://downloads.openmicroscopy.org/latest/bio-formats5.6/artifacts/bftools.zip), unzip it into a new
folder.

Note

As of Bio-Formats 5.0.0, this zip now contains the bundled jar
and you no longer need to download loci\_tools.jar or the new
bioformats\_package.jar separately.

The zip file contains both Unix scripts and Windows batch files.

## Tools available[¶](#tools-available "Permalink to this headline")

Currently available tools include:

showinf
:   Prints information about a given image file to the console, and
    displays the image itself in the Bio-Formats image viewer (see
    [*Displaying images and metadata*](display.html) for more information).

ijview
:   Displays the given image file in ImageJ using the Bio-Formats Importer
    plugin. See [*Display file in ImageJ*](ijview.html) for details.

bfconvert
:   Converts an image file from one format to another. Bio-Formats must
    support writing to the output file (see [*Converting a file to different format*](conversion.html) for more
    information).

formatlist
:   Displays a list of supported file formats in HTML, plaintext or XML.
    See [*List supported file formats*](formatlist.html) for details.

xmlindent
:   A simple XML prettifier similar to **xmllint –format** but more
    robust in that it attempts to produce output regardless of syntax
    errors in the XML. See [*Format XML data*](xmlindent.html) for details.

xmlvalid
:   A command-line XML validation tool, useful for checking an OME-XML
    document for compliance with the OME-XML schema.

tiffcomment
:   Dumps the comment from the given TIFF file’s first IFD entry; useful
    for examining the OME-XML block in an OME-TIFF file (also see
    [*Editing XML in an OME-TIFF*](edit.html)).

domainlist
:   Displays a list of imaging domains and the supported formats
    associated with each domain. See [*List formats by domain*](domainlist.html) for more
    information.

mkfake
:   Creates a “fake” high-content screen with configurable dimensions.
    This is useful for testing how HCS metadata is handled, without
    requiring real image data from an acquired screen. See [*Create a high-content screen for testing*](mkfake.html)
    for more information.

Some of these tools also work in combination, for example
[*Validating XML in an OME-TIFF*](xml-validation.html) uses both **tiffcomment** and **xmlvalid**.

Running any of these commands without any arguments will print usage
information to help you. When run with the -version argument, **showinf**
and **bfconvert** will display the version of Bio-Formats that is being used
(version number, build date, and Git commit reference).

## Using the tools directly from source[¶](#using-the-tools-directly-from-source "Permalink to this headline")

Firstly, obtain a copy of the sources and build them (see
[*Obtaining and building Bio-Formats*](../../developers/building-bioformats.html#source-obtain-and-build)). You can configure the scripts to use
your source tree instead of **bioformats\_package.jar** in the same
directory by following these steps:

1. Point your CLASSPATH to the checked-out directory and the JAR files
   in the **jar** folder.
   * E.g. on Windows with Java 1.7 or later, if you have checked out
     the source at C:\code\bio-formats, set your CLASSPATH environment
     variable to the value C:\code\bio-formats\jar\\*;C:\code\bio-formats. You can
     access the environment variable configuration area by
     right-clicking on My Computer, choosing Properties, Advanced tab,
     Environment Variables button.
2. Compile the source with ant compile.
3. Set the BF\_DEVEL environment variable to any value (the
   variable just needs to be defined).

## Version checker[¶](#version-checker "Permalink to this headline")

If you run bftools outside of the OMERO environment, you may encounter an
issue with the automatic version checker causing a tool to crash when trying
to connect to upgrade.openmicroscopy.org.uk. The error message will look
something like this:

```
Failed to compare version numbers
java.io.IOException: Server returned HTTP response code: 400 for URL:
http://upgrade.openmicroscopy.org.uk?version=4.4.8;os.name=Linux;os.
version=2.6.32-358.6.2.el6.x86_64;os.arch=amd64;java.runtime.version=
1.6.0_24-b24;java.vm.vendor=Sun+Microsystems+Inc.;bioformats.caller=
Bio-Formats+utilities
```

To avoid this issue, call the tool with the -no-upgrade parameter.

## Profiling[¶](#profiling "Permalink to this headline")

For debugging errors or investigating performance issues, it can be useful to
use profiling tools while running Bio-Formats. The command-line tools can
invoke the [HPROF](http://docs.oracle.com/javase/7/docs/technotes/samples/hprof.html) agent library to profile Heap and CPU usage. Setting the
BF\_PROFILE environment variable allows to turn profiling on, e.g.:

```
BF_PROFILE=true showinf -nopix -no-upgrade myfile
```

[![OME Home](../../_static/ome.svg)

### [Bio-Formats](../../index.html)

[Downloads by version](http://downloads.openmicroscopy.org/bio-formats/)
[Documentation by version](http://docs.openmicroscopy.org/bio-formats/)
[Licensing](https://www.openmicroscopy.org/licensing/)

### [Page Contents](../../index.html)

* Command line tools introduction
  + [Installation](#installation)
  + [Tools available](#tools-available)
  + [Using the tools directly from source](#using-the-tools-directly-from-source)
  + [Version checker](#version-checker)
  + [Profiling](#profiling)

#### Previous topic

[Bio-Formats plugin configuration options](../imagej/options.html "previous chapter")

#### Next topic

[Displaying images and metadata](display.html "next chapter")

### Quick search

Enter search terms or a module, class or function name.

### This Page

* [Show Source](../../_sources/users/comlinetools/index.txt)
* [Show on GitHub](https://github.com/openmicroscopy/bioformats/blob/develop/docs/sphinx/users/comlinetools/index.rst)
* [Edit on GitHub](https://github.com/openmicroscopy/bioformats/edit/develop/docs/sphinx/users/comlinetools/index.rst)](https://www.openmicroscopy.org)

### Navigation

* [index](../../genindex.html "General Index")
* [next](display.html "Displaying images and metadata") |
* [previous](../imagej/options.html "Bio-Formats plugin configuration options") |
* [Bio-Formats 5.7.1 documentation](../../index.html) »
* [User Information](../index.html) »

© Copyright 2000-2017, The Open Microscopy Environment .
Last updated on Sep 20, 2017.
Created using [Sphinx](http://sphinx-doc.org/) 1.2.3.