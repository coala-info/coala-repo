# perl-xml-twig CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-xml-twig_xml_grep | PASS | NCBI GenBank XML of 2 phage genomes; fixed file position after options; locus names and counts correct |
| perl-xml-twig_xml_merge | PASS | merged the xml_split output back; same content as the original; fixed -o flag and staging of parts |
| perl-xml-twig_xml_pp | PASS | new CWL; pretty printed GenBank XML with record style, same 2 records |
| perl-xml-twig_xml_split | PASS | NCBI GenBank XML of 2 phage genomes; fixed read-only output, removed -m (man); split into 45 files |

## Metadata
- **Skill**: generated

## perl-xml-twig_xml_grep

### Tool Description
Search for and extract XML chunks from files using XPath-like expressions.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
- **Homepage**: http://metacpan.org/pod/XML-Twig
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-xml-twig/overview
- **Validation**: PASS
### Original Help Text
```text
Options:
    --help
        brief help message

    --man
        full documentation

    --Version
        display the tool version

    --root <cond>
        look for and return xml chunks matching <cond>

        if neither "--root" nor "--file" are used then the element(s) that
        trigger the "--cond" option is (are) used. If "--cond" is not used
        then all elements matching the <cond> are returned

        several "--root" can be provided

    --cond <cond>
        return the chunks (or file names) only if they contain elements
        matching <cond>

        several "--cond" can be provided (in which case they are OR'ed)

    --files
        return only file names (do not generate an XML output)

        usage of this option precludes using any of the options that define
        the XML output: "--roots", "--encoding", "--wrap", "--group_by_file"
        or "--pretty_print"

    --count
        return only the number of matches in each file

        usage of this option precludes using any of the options that define
        the XML output: "--roots", "--encoding", "--wrap", "--group_by_file"
        or "--pretty_print"

    --strict
        without this option parsing errors are reported to STDOUT and the
        file skipped

    --date
        when on (by default) the wrapping element get a "date" attribute
        that gives the date the tool was run.

        with "--nodate" this attribute is not added, which can be useful if
        you need to compare 2 runs.

    --encoding <enc>
        encoding of the xml output (utf-8 by default)

    --nb_results <nb>
        output only <nb> results

    --by_file
        output only <nb> results by file

    --wrap <tag>
        wrap the xml result in the provided tag (defaults to 'xml_grep')

        If wrap is set to an empty string ("--wrap ''") then the xml result
        is not wrapped at all.

    --nowrap
        same as using "--wrap ''": the xml result is not wrapped.

    --descr <string>
        attributes of the wrap tag (defaults to "version="<VERSION>"
        date="<date>"")

    --group_by_file <optional_tag>
        wrap results for each files into a separate element. By default that
        element is named "file". It has an attribute named "filename" that
        gives the name of the file.

        the short version of this option is -g

    --exclude <condition>
        same as using "-v" in grep: the elements that match the condition
        are excluded from the result, the input file(s) is (are) otherwise
        unchanged

        the short form of this option is -v

    --pretty_print <optional_style>
        pretty print the output using XML::Twig styles ('"indented"',
        '"record"' or '"record_c"' are probably what you are looking for)

        if the option is used but no style is given then '"indented"' is
        used

        short form for this argument is -s

    --text_only
        Displays the text of the results, one by line.

    --html
        Allow HTML input, files are converted using HTML::TreeBuilder

    --Tidy
        Allow HTML input, files are converted using HTML::Tidy

  Condition Syntax:
    <cond> is an XPath-like expression as allowed by XML::Twig to trigger
    handlers.

    examples: 'para' 'para[@compact="compact"]' '*[@urgent]'
    '*[@urgent="1"]' 'para[string()="WARNING"]'

    see XML::Twig for a more complete description of the <cond> syntax

    options are processed by Getopt::Long so they can start with '-' or '--'
    and can be abbreviated ("-r" instead of "--root" for example)
```

## perl-xml-twig_xml_split

### Tool Description
Split an XML file into several smaller files

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
- **Homepage**: http://metacpan.org/pod/XML-Twig
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-xml-twig/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
xml_split [-l <level> [-s <size> | -g <nb_grouped>] | -c <cond>] [-b <base>] [-n <nb>] [-e <ext>] [-p <plugin>] [-I <plugin_dir>] [-i] [-d] [-v] [-h] [-m] [-V] <files>
```

## perl-xml-twig_xml_merge

### Tool Description
Merge XML files using the XML::Twig module.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
- **Homepage**: http://metacpan.org/pod/XML-Twig
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-xml-twig/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").

no element found at line 1, column 0, byte 0 at /usr/local/lib/site_perl/5.26.2/x86_64-linux-thread-multi/XML/Parser.pm line 187.
 at /usr/local/bin/xml_merge line 62.
```


## perl-xml-twig_xml_pp

### Tool Description
XML pretty printer using XML::Twig.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
- **Homepage**: http://metacpan.org/pod/XML-Twig
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-xml-twig/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    xml_pp - xml pretty-printer

SYNOPSYS
    xml_pp [options] [<files>]

DESCRIPTION
    XML pretty printer using XML::Twig

OPTIONS
    -i[<extension>]
        edits the file(s) in place, if an extension is provided (no space
        between "-i" and the extension) then the original file is backed-up
        with that extension

        The rules for the extension are the same as Perl's (see perldoc
        perlrun): if the extension includes no "*" then it is appended to
        the original file name, If the extension does contain one or more
        "*" characters, then each "*" is replaced with the current filename.

    -s <style>
        the style to use for pretty printing: none, nsgmls, nice, indented,
        record, or record_c (see XML::Twig docs for the exact description of
        those styles), 'indented' by default

    -p <tag(s)>
        preserves white spaces in tags. You can use several "-p" options or
        quote the tags if you need more than one

    -e <encoding>
        use XML::Twig output_encoding (based on Text::Iconv or Unicode::Map8
        and Unicode::String) to set the output encoding. By default the
        original encoding is preserved.

        If this option is used the XML declaration is updated (and created
        if there was none).

        Make sure that the encoding is supported by the parser you use if
        you want to be able to process the pretty_printed file (XML::Parser
        does not support 'latin1' for example, you have to use 'iso-8859-1')

    -l  loads the documents in memory instead of outputting them as they are
        being parsed.

        This prevents a bug (see BUGS) but uses more memory

    -f <file>
        read the list of files to process from <file>, one per line

    -v  verbose (list the current file being processed)

    --  stop argument processing (to process files that start with -)

    -h  display help

EXAMPLES
      xml_pp foo.xml > foo_pp.xml           # pretty print foo.xml 
      xml_pp < foo.xml > foo_pp.xml         # pretty print from standard input

      xml_pp -v -i.bak *.xml                # pretty print .xml files, with backups
      xml_pp -v -i'orig_*' *.xml            # backups are named orig_<filename>

      xml_pp -i -p pre foo.xhtml            # preserve spaces in pre tags
  
      xml_pp -i.bak -p 'pre code' foo.xml   # preserve spaces in pre and code tags
      xml_pp -i.bak -p pre -p code foo.xml  # same

      xml_pp -i -s record mydb_export.xml   # pretty print using the record style

      xml_pp -e utf8 -i foo.xml             # output will be in utf8
      xml_pp -e iso-8859-1 -i foo.xml       # output will be in iso-8859-1

      xml_pp -v -i.bak -f lof               # pretty print in place files from lof
  
      xml_pp -- -i.xml                      # pretty print the -i.xml file

      xml_pp -l foo.xml                     # loads the entire file in memory 
                                            # before pretty printing it

      xml_pp -h                             # display help

BUGS
    Elements with mixed content that start with an embedded element get an
    extra \n

      <elt><b>b</b>toto<b>bold</b></elt>

    will be output as

      <elt>
        <b>b</b>toto<b>bold</b></elt>

    Using the "-l" option solves this bug (but uses more memory)

TODO
    update XML::Twig to use Encode with perl 5.8.0

AUTHOR
    Michel Rodriguez <mirod@xmltwig.com>

```
