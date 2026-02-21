# perl-task-weaken CWL Generation Report

## perl-task-weaken

### Tool Description
Task::Weaken - ensure that Scalar::Util's weaken is available

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-task-weaken:1.06--pl526_0
- **Homepage**: http://metacpan.org/pod/Task-Weaken
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-task-weaken/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-task-weaken/overview
- **Total Downloads**: 190.2K
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
2026/02/14 18:36:22  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-task-weaken": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## perl-task-weaken_perl

### Tool Description
The Perl 5 language interpreter

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-task-weaken:1.06--pl526_0
- **Homepage**: http://metacpan.org/pod/Task-Weaken
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-task-weaken/overview
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

## perl-task-weaken_cpan

### Tool Description
easily interact with CPAN from the command line

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-task-weaken:1.06--pl526_0
- **Homepage**: http://metacpan.org/pod/Task-Weaken
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-task-weaken/overview
- **Validation**: PASS
### Original Help Text
```text
[1mNAME[m
    cpan - easily interact with CPAN from the command line

[1mSYNOPSIS[m
            # with arguments and no switches, installs specified modules
            cpan module_name [ module_name ... ]

            # with switches, installs modules with extra behavior
            cpan [-cfFimtTw] module_name [ module_name ... ]

            # use local::lib
            cpan -I module_name [ module_name ... ]

            # one time mirror override for faster mirrors
            cpan -p ...

            # with just the dot, install from the distribution in the
            # current directory
            cpan .

            # without arguments, starts CPAN.pm shell
            cpan

            # without arguments, but some switches
            cpan [-ahpruvACDLOPX]

[1mDESCRIPTION[m
    This script provides a command interface (not a shell) to CPAN. At the moment it uses CPAN.pm to do the work, but it is not a one-shot command runner for CPAN.pm.

  [1mOptions[m
    -a  Creates a CPAN.pm autobundle with CPAN::Shell->autobundle.

    -A module [ module ... ]
        Shows the primary maintainers for the specified modules.

    -c module
        Runs a `make clean` in the specified module's directories.

    -C module [ module ... ]
        Show the Changes files for the specified modules

    -D module [ module ... ]
        Show the module details. This prints one line for each out-of-date module (meaning, modules locally installed but have newer versions on CPAN). Each line has three columns: module
        name, local version, and CPAN version.

    -f  Force the specified action, when it normally would have failed. Use this to install a module even if its tests fail. When you use this option, -i is not optional for installing a
        module when you need to force it:

                % cpan -f -i Module::Foo

    -F  Turn off CPAN.pm's attempts to lock anything. You should be careful with this since you might end up with multiple scripts trying to muck in the same directory. This isn't so much
        of a concern if you're loading a special config with "-j", and that config sets up its own work directories.

    -g module [ module ... ]
        Downloads to the current directory the latest distribution of the module.

    -G module [ module ... ]
        UNIMPLEMENTED

        Download to the current directory the latest distribution of the modules, unpack each distribution, and create a git repository for each distribution.

        If you want this feature, check out Yanick Champoux's "Git::CPAN::Patch" distribution.

    -h  Print a help message and exit. When you specify "-h", it ignores all of the other options and arguments.

    -i module [ module ... ]
        Install the specified modules. With no other switches, this switch is implied.

    -I  Load "local::lib" (think like "-I" for loading lib paths). Too bad "-l" was already taken.

    -j Config.pm
        Load the file that has the CPAN configuration data. This should have the same format as the standard CPAN/Config.pm file, which defines $CPAN::Config as an anonymous hash.

    -J  Dump the configuration in the same format that CPAN.pm uses. This is useful for checking the configuration as well as using the dump as a starting point for a new, custom
        configuration.

    -l  List all installed modules with their versions

    -L author [ author ... ]
        List the modules by the specified authors.

    -m  Make the specified modules.

    -M mirror1,mirror2,...
        A comma-separated list of mirrors to use for just this run. The "-P" option can find them for you automatically.

    -n  Do a dry run, but don't actually install anything. (unimplemented)

    -O  Show the out-of-date modules.

    -p  Ping the configured mirrors and print a report

    -P  Find the best mirrors you could be using and use them for the current session.

    -r  Recompiles dynamically loaded modules with CPAN::Shell->recompile.

    -s  Drop in the CPAN.pm shell. This command does this automatically if you don't specify any arguments.

    -t module [ module ... ]
        Run a `make test` on the specified modules.

    -T  Do not test modules. Simply install them.

    -u  Upgrade all installed modules. Blindly doing this can really break things, so keep a backup.

    -v  Print the script version and CPAN.pm version then exit.

    -V  Print detailed information about the cpan client.

    -w  UNIMPLEMENTED

        Turn on cpan warnings. This checks various things, like directory permissions, and tells you about problems you might have.

    -x module [ module ... ]
        Find close matches to the named modules that you think you might have mistyped. This requires the optional installation of Text::Levenshtein or Text::Levenshtein::Damerau.

    -X  Dump all the namespaces to standard output.

  [1mExamples[m
            # print a help message
            cpan -h

            # print the version numbers
            cpan -v

            # create an autobundle
            cpan -a

            # recompile modules
            cpan -r

            # upgrade all installed modules
            cpan -u

            # install modules ( sole -i is optional )
            cpan -i Netscape::Booksmarks Business::ISBN

            # force install modules ( must use -i )
            cpan -fi CGI::Minimal URI

            # install modules but without testing them
            cpan -Ti CGI::Minimal URI

  [1mEnvironment variables[m
    There are several components in CPAN.pm that use environment variables. The build tools, ExtUtils::MakeMaker and Module::Build use some, while others matter to the levels above them.
    Some of these are specified by the Perl Toolchain Gang:

    Lancaster Concensus: <https://github.com/Perl-Toolchain-Gang/toolchain-site/blob/master/lancaster-consensus.md>

    Oslo Concensus: <https://github.com/Perl-Toolchain-Gang/toolchain-site/blob/master/oslo-consensus.md>

    NONINTERACTIVE_TESTING
        Assume no one is paying attention and skips prompts for distributions that do that correctly. cpan(1) sets this to 1 unless it already has a value (even if that value is false).

    PERL_MM_USE_DEFAULT
        Use the default answer for a prompted questions. cpan(1) sets this to 1 unless it already has a value (even if that value is false).

    CPAN_OPTS
        As with "PERL5OPTS", a string of additional cpan(1) options to add to those you specify on the command line.

    CPANSCRIPT_LOGLEVEL
        The log level to use, with either the embedded, minimal logger or Log::Log4perl if it is installed. Possible values are the same as the "Log::Log4perl" levels: "TRACE", "DEBUG",
        "INFO", "WARN", "ERROR", and "FATAL". The default is "INFO".

    GIT_COMMAND
        The path to the "git" binary to use for the Git features. The default is "/usr/local/bin/git".

[1mEXIT VALUES[m
    The script exits with zero if it thinks that everything worked, or a positive number if it thinks that something failed. Note, however, that in some cases it has to divine a failure by
    the output of things it does not control. For now, the exit codes are vague:

            1       An unknown error

            2       The was an external problem

            4       There was an internal problem with the script

            8       A module failed to install

[1mTO DO[m
    * one shot configuration values from the command line

[1mBUGS[m
    * none noted

[1mSEE ALSO[m
    Most behaviour, including environment variables and configuration, comes directly from CPAN.pm.

[1mSOURCE AVAILABILITY[m
    This code is in Github in the CPAN.pm repository:

            https://github.com/andk/cpanpm

    The source used to be tracked separately in another GitHub repo, but the canonical source is now in the above repo.

[1mCREDITS[m
    Japheth Cleaver added the bits to allow a forced install (-f).

    Jim Brandt suggest and provided the initial implementation for the up-to-date and Changes features.

    Adam Kennedy pointed out that exit() causes problems on Windows where this script ends up with a .bat extension

[1mAUTHOR[m
    brian d foy, "<bdfoy@cpan.org>"

[1mCOPYRIGHT[m
    Copyright (c) 2001-2015, brian d foy, All Rights Reserved.

    You may redistribute this under the same terms as Perl itself.
```

