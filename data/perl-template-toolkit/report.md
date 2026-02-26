# perl-template-toolkit CWL Generation Report

## perl-template-toolkit_tpage

### Tool Description
Process Template Toolkit templates from command line

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-template-toolkit:3.102--pl5321h7b50bb2_1
- **Homepage**: https://metacpan.org/pod/Template::Toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-template-toolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-template-toolkit/overview
- **Total Downloads**: 190.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
tpage 2.7 (Template Toolkit version 3.102)

usage: tpage [options] [files]

Options:
   --define var=value       Define template variable
   --interpolate            Interpolate '$var' references in text
   --anycase                Accept directive keywords in any case.
   --pre_chomp              Chomp leading whitespace 
   --post_chomp             Chomp trailing whitespace
   --trim                   Trim blank lines around template blocks
   --eval_perl              Evaluate [% PERL %] ... [% END %] code blocks
   --load_perl              Load regular Perl modules via USE directive
   --absolute               Allow ABSOLUTE directories (enabled by default)
   --relative               Allow RELATIVE directories (enabled by default)
   --include_path=DIR       Add directory to INCLUDE_PATH 
   --pre_process=TEMPLATE   Process TEMPLATE before each main template
   --post_process=TEMPLATE  Process TEMPLATE after each main template
   --process=TEMPLATE       Process TEMPLATE instead of main template
   --wrapper=TEMPLATE       Process TEMPLATE wrapper around main template
   --default=TEMPLATE       Use TEMPLATE as default
   --error=TEMPLATE         Use TEMPLATE to handle errors
   --debug=STRING           Set TT DEBUG option to STRING
   --start_tag=STRING       STRING defines start of directive tag
   --end_tag=STRING         STRING defined end of directive tag
   --tag_style=STYLE        Use pre-defined tag STYLE    
   --plugin_base=PACKAGE    Base PACKAGE for plugins            
   --compile_ext=STRING     File extension for compiled template files
   --compile_dir=DIR        Directory for compiled template files
   --perl5lib=DIR           Specify additional Perl library directories
   --template_module=MODULE Specify alternate Template module
   --while_max=INTEGER      Change '$Template::Directive::WHILE_MAX' default
   --envvars                Set the 'env' variable to the environment (%ENV)

See 'perldoc tpage' for further information.
```


## perl-template-toolkit_ttree

### Tool Description
Process entire directory trees of templates using the Template Toolkit

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-template-toolkit:3.102--pl5321h7b50bb2_1
- **Homepage**: https://metacpan.org/pod/Template::Toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-template-toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
Do you want me to create a sample '.ttreerc' file for you?
(file: /root/.ttreerc)   [y/n]: ttree 2.91 (Template Toolkit version 3.102)

usage: ttree [options] [files]

Options:
   -a      (--all)          Process all files, regardless of modification
   -r      (--recurse)      Recurse into sub-directories
   -p      (--preserve)     Preserve file ownership and permission
   -n      (--nothing)      Do nothing, just print summary (enables -v)
   -v      (--verbose)      Verbose mode. Use twice for more verbosity: -v -v
   -h      (--help)         This help
   -s DIR  (--src=DIR)      Source directory
   -d DIR  (--dest=DIR)     Destination directory
   -c DIR  (--cfg=DIR)      Location of configuration files
   -l DIR  (--lib=DIR)      Library directory (INCLUDE_PATH)  (multiple)
   -f FILE (--file=FILE)    Read named configuration file     (multiple)

Display options:
   --colour / --color       Enable colo(u)rful verbose output.
   --summary                Show processing summary.

File search specifications (all may appear multiple times):
   --ignore=REGEX           Ignore files matching REGEX
   --copy=REGEX             Copy files matching REGEX
   --link=REGEX             Link files matching REGEX
   --copy_dir=DIR           Copy files in dir DIR (recursive)
   --accept=REGEX           Process only files matching REGEX

File Dependencies Options:
   --depend foo=bar,baz     Specify that 'foo' depends on 'bar' and 'baz'.
   --depend_file FILE       Read file dependancies from FILE.
   --depend_debug           Enable debugging for dependencies

File suffix rewriting (may appear multiple times)
   --suffix old=new         Change any '.old' suffix to '.new'

File encoding options
   --binmode=value          Set binary mode of output files
   --encoding=value         Set encoding of input files

Additional options to set Template Toolkit configuration items:
   --define var=value       Define template variable
   --interpolate            Interpolate '$var' references in text
   --anycase                Accept directive keywords in any case.
   --pre_chomp              Chomp leading whitespace
   --post_chomp             Chomp trailing whitespace
   --trim                   Trim blank lines around template blocks
   --eval_perl              Evaluate [% PERL %] ... [% END %] code blocks
   --load_perl              Load regular Perl modules via USE directive
   --absolute               Enable the ABSOLUTE option
   --relative               Enable the RELATIVE option
   --pre_process=TEMPLATE   Process TEMPLATE before each main template
   --post_process=TEMPLATE  Process TEMPLATE after each main template
   --process=TEMPLATE       Process TEMPLATE instead of main template
   --wrapper=TEMPLATE       Process TEMPLATE wrapper around main template
   --default=TEMPLATE       Use TEMPLATE as default
   --error=TEMPLATE         Use TEMPLATE to handle errors
   --debug=STRING           Set TT DEBUG option to STRING
   --start_tag=STRING       STRING defines start of directive tag
   --end_tag=STRING         STRING defined end of directive tag
   --tag_style=STYLE        Use pre-defined tag STYLE
   --plugin_base=PACKAGE    Base PACKAGE for plugins
   --compile_ext=STRING     File extension for compiled template files
   --compile_dir=DIR        Directory for compiled template files
   --perl5lib=DIR           Specify additional Perl library directories
   --template_module=MODULE Specify alternate Template module

See 'perldoc ttree' for further information.
```

