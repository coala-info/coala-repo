# perl-local-lib CWL Generation Report

## perl-local-lib

### Tool Description
FAIL to generate CWL: perl-local-lib not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-local-lib:2.000029--pl5321hdfd78af_0
- **Homepage**: http://metacpan.org/pod/local::lib
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-local-lib/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-local-lib/overview
- **Total Downloads**: 19.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-local-lib not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-local-lib not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## perl-local-lib_perl

### Tool Description
The Perl 5 language interpreter

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-local-lib:2.000029--pl5321hdfd78af_0
- **Homepage**: http://metacpan.org/pod/local::lib
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-local-lib/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/perl [switches] [--] [programfile] [arguments]
  -0[octal]         specify record separator (\0, if no argument)
  -a                autosplit mode with -n or -p (splits $_ into @F)
  -C[number/list]   enables the listed Unicode features
  -c                check syntax only (runs BEGIN and CHECK blocks)
  -d[:debugger]     run program under debugger
  -D[number/list]   set debugging flags (argument is a bit mask or alphabets)
  -e program        one line of program (several -e's allowed, omit programfile)
  -E program        like -e, but enables all optional features
  -f                don't do $sitelib/sitecustomize.pl at startup
  -F/pattern/       split() pattern for -a switch (//'s are optional)
  -i[extension]     edit <> files in place (makes backup if extension supplied)
  -Idirectory       specify @INC/#include directory (several -I's allowed)
  -l[octal]         enable line ending processing, specifies line terminator
  -[mM][-]module    execute "use/no module..." before executing program
  -n                assume "while (<>) { ... }" loop around program
  -p                assume loop like -n but print line also, like sed
  -s                enable rudimentary parsing for switches after programfile
  -S                look for programfile using PATH environment variable
  -t                enable tainting warnings
  -T                enable tainting checks
  -u                dump core after parsing program
  -U                allow unsafe operations
  -v                print version, patchlevel and license
  -V[:variable]     print configuration summary (or a single Config.pm variable)
  -w                enable many useful warnings
  -W                enable all warnings
  -x[directory]     ignore text before #!perl line (optionally cd to directory)
  -X                disable all warnings
  
Run 'perldoc perl' for more help with Perl.
```

## perl-local-lib_cpan

### Tool Description
CPAN.pm is used to query, download, build, and install Perl modules from CPAN sites. This specific instance appears to be configuring a local::lib environment for managing Perl dependencies without root privileges.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-local-lib:2.000029--pl5321hdfd78af_0
- **Homepage**: http://metacpan.org/pod/local::lib
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-local-lib/overview
- **Validation**: PASS
### Original Help Text
```text
Loading internal logger. Log::Log4perl recommended for better logging

CPAN.pm requires configuration, but most of it can be done automatically.
If you answer 'no' below, you will enter an interactive dialog for each
configuration option instead.

Would you like to configure as much as possible automatically? [yes] CPAN build and cache directory? [/user/qianghu/.cpan] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-exporter-formethods] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-exporter-progressive] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-identify] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-info] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-install] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-name] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-quote] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sub-uplevel] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-super] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-svg] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-svg-graph] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-symbol] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-symbol-util] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sys-info] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sys-info-base] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sys-info-driver-linux] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-sys-sigaction] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tap-harness-env] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-task-weaken] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-template-toolkit] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-term-app-roles] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-term-detect-software] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-term-encoding] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-term-progressbar] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-term-table] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-termreadkey] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-base] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-builder-tester] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-class-moose] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-classapi] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-cleannamespaces] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-cpan-meta] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-deep] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-differences] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-eol] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-exception] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-exec] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-fatal] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-file] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-file-contents] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-files] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-fork] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-harness] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-inter] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-leaktrace] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-lectrotest] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-longstring] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-memory-cycle] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-mockmodule] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-more] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-most] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-needs] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-notabs] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-nowarnings] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-object] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-output] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-pod] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-pod-coverage] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-prereq] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-requires] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-requiresinternet] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-script] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-simple] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-subcalls] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-sys-info] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-taint] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-toolbox] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-trap] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-unit-lite] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-utf8] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-warn] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-warnings] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-without-module] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-xml] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test-yaml] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test2] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test2-plugin-nowarnings] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-test2-suite] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-abbrev] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-ansitable] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-asciitable] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-balanced] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-csv] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-csv_xs] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-diff] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-format] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-glob] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-levenshtein] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-levenshteinxs] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-nsp] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-parsewords] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-soundex] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-tabs] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-tabs-wrap] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-template] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-template-simple] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-text-wrap] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-threaded] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-cache] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-cacher] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-hash] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-hash-indexed] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-ixhash] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-log4perl] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-refhash] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-refhash-weak] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tie-toobject] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-time-hires] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-time-local] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-time-piece] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-timedate] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-tree-dag_node] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-try-tiny] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-try-tiny-retry] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-type-tiny] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-types-serialiser] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-types-standard] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-unicode-map] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-unicode-normalize] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-unicode-stringprep] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-unicode-utf8] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-uri] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-uri-db] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-uri-nested] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-url-encode] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-util-properties] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-variable-magic] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-vars] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-vcftools-vcf] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-velvetoptimiser] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-version] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-version-next] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-want] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-warnings-register] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-www-mechanize] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-www-robotrules] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-dom] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-dom-xpath] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-entities] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-filter-buffertext] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-libxml] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-libxslt] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-namespacesupport] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-parser] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-parser-lite] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-regexp] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-sax] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-sax-base] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-sax-expat] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-sax-writer] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-semanticdiff] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-simple] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-twig] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-writer] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-xpath] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xml-xpathengine] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xsloader] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-xxx] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-yaml] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-yaml-libyaml] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-yaml-pp] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perl-yaml-tiny] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perlprimer] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/perm] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pfam_scan] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pfp] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pftools] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgap2] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgcgap] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgdspider] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgenlib] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pggb] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pglite] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgma-simple] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgr-tk] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgrc] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgsa] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgscatalog-utils] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgscatalog.calc] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgscatalog.core] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgscatalog.match] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgx-pipe-helper] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgx-variant-tools] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pgzip] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phables] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phabox] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phamb] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phame] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phanotate] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phantasm] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phantompeakqualtools] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pharokka] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phaser] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phasius] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phast] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phastaf] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phate] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phava] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phcue-ck] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/pheniqs] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phenix] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phenograph] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phenomenal-portal] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phertilizer] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phiercc] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phigaro] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/philosopher] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phip-stat] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phipack] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phirbo] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phispy] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phist] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phizz] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phlame] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phnml-jupyter] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phold] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phonenumbers] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phu] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phybin] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phyclone] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phykit] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylics] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phyling] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylip] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phyloacc] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phyloaln] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylobayes-mpi] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylocsf] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylocsfpp] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep] CPAN build and cache directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd] /projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd
Download target directory? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/sources] /projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/sources
Directory where the build process takes place? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/build] /projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/build
Store and re-use state information about distributions between
CPAN.pm sessions? [no] no
Directory where to store default options/environment/dialogs for
building modules that need some customization? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/prefs] /projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/prefs
Always commit changes to config variables to disk? [no] no
Cache size for build directory (in MB)? [100] 100
Let the index expire after how many days? [1] 1
Perform cache scanning ('atstart', 'atexit' or 'never')? [atstart] atstart
Remove build directory after a successful install? (yes/no)? [no] no
Cache metadata (yes/no)? [yes] yes
Use CPAN::SQLite if available? (yes/no)? [no] no
Policy on building prerequisites (follow, ask or ignore)? [follow] follow
Policy on installing 'build_requires' modules (yes, no, ask/yes,
ask/no)? [yes] yes
Include recommended modules? [yes] yes
Include suggested modules? [no] no
Always try to check and verify signatures if a SIGNATURE file is in
the package and Module::Signature is installed (yes/no)? [no] no
Generate test reports if CPAN::Reporter is installed (yes/no)? [no] no
Do you want to rely on the test report history (yes/no)? [no] no
Which YAML implementation would you prefer? [YAML] YAML
Do you want to enable code deserialisation (yes/no)? [no] no
Where is your make program? [] 
Where is your bzip2 program? [/usr/bin/bzip2] /usr/bin/bzip2
Where is your gzip program? [/bin/gzip] /bin/gzip
Where is your tar program? [/bin/tar] /bin/tar
Where is your unzip program? [/usr/bin/unzip] /usr/bin/unzip
Where is your gpg program? [] 
Where is your patch program? [/usr/bin/patch] /usr/bin/patch
Where is your applypatch program? [] 
Where is your wget program? [/usr/bin/wget] /usr/bin/wget
What is your favorite pager program? [/usr/bin/less] /usr/bin/less
What is your favorite shell? [/bin/bash] /bin/bash
Use the external tar program instead of Archive::Tar? [yes] yes
Tar command verbosity level (none or v or vv)? [none] none
Verbosity level for loading modules (none or v)? [none] none
Verbosity level for PERL5LIB changes (none or v)? [none] none
Do you want to turn this message off? [no] no
In case you can choose between running a Makefile.PL or a Build.PL,
which installer would you prefer (EUMM or MB or RAND)? [MB] MB
Parameters for the 'perl Makefile.PL' command? [] 
Your choice: [] 
or some such. Your choice: [] 
Your choice: [] 
Parameters for the 'perl Build.PL' command? [] 
Your choice: [] 
or some such. Your choice: [./Build] ./Build
Your choice: [] 
Do you want to allow installing distros that are not indexed as the
highest distro-version for all contained modules (yes, no, ask/yes,
ask/no)? [ask/no] ask/no
Do you want to allow installing distros with decreasing module
versions compared to what you have installed (yes, no, ask/yes,
ask/no)? [ask/no] ask/no
Do you want to use prompt defaults (yes/no)? [no] no
Timeout for inactivity during {Makefile,Build}.PL? [0] 0
Timeout for parsing module versions? [15] 15
Do you want to halt on failure (yes/no)? [no] no
Your ftp_proxy? [] 
Your http_proxy? [] 
Your no_proxy? [] 
Shall we always set the FTP_PASSIVE environment variable when dealing
with ftp download (yes/no)? [yes] yes
Preferred method for determining the current working directory? [cwd] cwd
Do you want the command number in the prompt (yes/no)? [yes] yes
Do you want to turn ornaments on? [yes] yes
Do you want to turn on colored output? [no] no
Your terminal expects ISO-8859-1 (yes/no)? [yes] yes
File to save your history? [/projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/histfile] /projects/rpci/songliu/qhu/projects/cwlrepo/TOOLS/phylodeep_data_bd/histfile
Number of lines to save? [100] 100
Always try to show upload date with 'd' and 'm' command (yes/no)? [no] no
Show all individual modules that have no $VERSION? [no] no
Show all individual modules that have a $VERSION of zero? [no] no
If no urllist has been chosen yet, would you prefer CPAN.pm to connect
to the built-in default sites without asking? (yes/no)? [yes] yes

Would you like me to automatically choose some CPAN mirror
sites for you? (This means connecting to the Internet) [yes] yes
```

