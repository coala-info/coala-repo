# perl-xml-twig CWL Generation Report

## perl-xml-twig

### Tool Description
The provided text does not contain help information as the executable was not found in the environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
- **Homepage**: http://metacpan.org/pod/XML-Twig
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-xml-twig/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-xml-twig/overview
- **Total Downloads**: 192.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 21:22:00  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-xml-twig": executable file not found in $PATH
```


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

