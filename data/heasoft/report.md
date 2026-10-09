# heasoft CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| heasoft_fkeyprint | PASS |  |
| heasoft_punlearn | PASS |  |

## Metadata
- **Skill**: generated

## heasoft_fkeyprint

### Tool Description
Display the value of a keyword (and its comment) in the header of a FITS file.

### Metadata
- **Docker Image**: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
- **Homepage**: https://heasarc.gsfc.nasa.gov/lheasoft/
- **Package**: https://anaconda.org/channels/bioconda/packages/heasoft/overview
- **Validation**: PASS
### Original Help Text
```text
fkeyprint: display the value of a keyword in a FITS file header.
Parameters (name=value):
  infile   Name of FITS file and [ext#]
  keynam   Enter the keyname (8 characters or less)
  outfile  Name of optional output file (default STDOUT)
  exact    Exact string or not (default no)
  clobber  Overwrite existing output file? (default no)
  mode     ql
```

## heasoft_punlearn

### Tool Description
Clobber a user parameter file by copying an unmodified (default) version from the system location.

### Metadata
- **Docker Image**: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
- **Homepage**: https://heasarc.gsfc.nasa.gov/lheasoft/
- **Package**: https://anaconda.org/channels/bioconda/packages/heasoft/overview
- **Validation**: PASS
### Original Help Text
```text
  body { margin-left: 5%; margin-right: 5%; }
  h1,h2,h3,h4 { margin-left: -5%;}
HEADAS help file
NAME
punlearn - Clobber a user (or "local") parameter file by copying
an unmodified (or default) version from the "system" location.
USAGE
punlearn [ -f ] tool-or-par-file-name [ [ -f ] tool-or-par-file-name ... ] 
DESCRIPTION
punlearn resets parameters for a specified task or parameter file by
copying an unmodified (default) version of the parameter file from
the "system" (read-only) parameter file directory into the "user"
(writeable) directory.  These locations are defined by the value
of the PFILES environment variable which is discussed further below.
Behavior of this task depends upon the value of the PFILES environment
variable, which is used to specify the location of parameter files.
The PFILES variable uses a semicolon delimiter to separate two types
of parameter directories:
     &lt;user&gt;;&lt;system&gt;
The first path ("user") is one or more "local" (writeable) parameter
directories (typically $HOME/pfiles for a default HEASoft setup),
and the second path ("system") is one or more read-only parameter
directories (typically $HEADAS/syspfiles).  When both paths are
equivalent, one may omit the semicolon and duplicate path (for
example, when developing a new task, one might set PFILES="." to
use only the current working directory).  Multiple colon-delimited
directories are allowed in both portions of the PFILES variable:
     &lt;user1&gt;:&lt;user2&gt;;&lt;system1&gt;:&lt;system2&gt;
The default values from the first "system" path are used the first
time a task is run, or whenever the default values have been updated
more recently than the user's copy of the parameters.  The user's
copy is created when a task terminates, and retains any learned
changes to the parameters.
This task will look for a copy of the specified parameter file
(or parameter file for the specified task) in the first "system"
parameter directory; if the file does not exist there, it will
then search all subsequent "system" directories listed in PFILES.
The "-f" flag may be used to disable searching of directories
listed in the PFILES variable, allowing instead for specification
of a particular parameter file (with a preceding directory path if
the file is not in the current working directory).
EXAMPLES
1. Reset the parameters for the task 'ftverify' to their default values:
   % punlearn ftverify
or
   % punlearn ftverify.par
2. Unlearn the parameters for ftverify, disabling the default search
of system directories listed in PFILES and instead providing the path
to a specific parameter file:
   % punlearn -f /local/data/test/ftverify.par
SEE ALSO
pget,
plist,
pquery,
pquery2,
pset
LAST MODIFIED
Aug 2016
```

