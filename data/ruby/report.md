# ruby CWL Generation Report

## ruby

### Tool Description
Execute a Ruby script

### Metadata
- **Docker Image**: quay.io/biocontainers/ruby:2.2.3--1
- **Homepage**: https://github.com/krahets/hello-algo
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ruby/overview
- **Total Downloads**: 60.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/krahets/hello-algo
- **Stars**: N/A
### Original Help Text
```text
Usage: ruby [switches] [--] [programfile] [arguments]
  -0[octal]       specify record separator (\0, if no argument)
  -a              autosplit mode with -n or -p (splits $_ into $F)
  -c              check syntax only
  -Cdirectory     cd to directory before executing your script
  -d, --debug     set debugging flags (set $DEBUG to true)
  -e 'command'    one line of script. Several -e's allowed. Omit [programfile]
  -Eex[:in], --encoding=ex[:in]
                  specify the default external and internal character encodings
  -Fpattern       split() pattern for autosplit (-a)
  -i[extension]   edit ARGV files in place (make backup if extension supplied)
  -Idirectory     specify $LOAD_PATH directory (may be used more than once)
  -l              enable line ending processing
  -n              assume 'while gets(); ... end' loop around your script
  -p              assume loop like -n but print line also like sed
  -rlibrary       require the library before executing your script
  -s              enable some switch parsing for switches after script name
  -S              look for the script using PATH environment variable
  -T[level=1]     turn on tainting checks
  -v, --verbose   print version number, then turn on verbose mode
  -w              turn warnings on for your script
  -W[level=2]     set warning level; 0=silence, 1=medium, 2=verbose
  -x[directory]   strip off text before #!ruby line and perhaps cd to directory
  --copyright     print the copyright
  --enable=feature[,...], --disable=feature[,...]
                  enable or disable features
  --external-encoding=encoding, --internal-encoding=encoding
                  specify the default external or internal character encoding
  --version       print the version
  --help          show this message, -h for short message
Features:
  gems            rubygems (default: enabled)
  rubyopt         RUBYOPT environment variable (default: enabled)
```


## Metadata
- **Skill**: generated

## ruby_gem

### Tool Description
RubyGems is a sophisticated package manager for Ruby. This is a basic help message containing pointers to more information.

### Metadata
- **Docker Image**: quay.io/biocontainers/ruby:2.2.3--1
- **Homepage**: https://github.com/krahets/hello-algo
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
RubyGems is a sophisticated package manager for Ruby.  This is a
basic help message containing pointers to more information.

  Usage:
    gem -h/--help
    gem -v/--version
    gem command [arguments...] [options...]

  Examples:
    gem install rake
    gem list --local
    gem build package.gemspec
    gem help install

  Further help:
    gem help commands            list all 'gem' commands
    gem help examples            show some examples of usage
    gem help gem_dependencies    gem dependencies file guide
    gem help platforms           gem platforms guide
    gem help <COMMAND>           show help on COMMAND
                                   (e.g. 'gem help install')
    gem server                   present a web page at
                                 http://localhost:8808/
                                 with info about installed gems
  Further information:
    http://guides.rubygems.org
```

