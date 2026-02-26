# bpipe CWL Generation Report

## bpipe_run

### Tool Description
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Total Downloads**: 131.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -delay,--delay <arg>             Delay in seconds before starting pipeline
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## bpipe_test

### Tool Description
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -delay,--delay <arg>             Delay in seconds before starting pipeline
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## bpipe_debug

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
ERROR: Bpipe was unable to read its startup PID file from /.bpipe/launch/1
ERROR: This may indicate you are in a read-only directory or one to which you do not have full permissions
```


## bpipe_touch

### Tool Description
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -delay,--delay <arg>             Delay in seconds before starting pipeline
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## bpipe_execute

### Tool Description
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -delay,--delay <arg>             Delay in seconds before starting pipeline
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## bpipe_retry

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No previous Bpipe command seems to have been run in this directory.
```


## bpipe_remake

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No previous Bpipe command seems to have been run in this directory.
```


## bpipe_resume

### Tool Description
bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Could not understand command resume or find it as a file

usage: bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...
             retry [job id] [test]
             remake <file1> <file2>...
             resume
             stop [preallocated]
             history
             log [-n <lines>] [job id]
             jobs
             checks [options]
             override
             status
             cleanup
             query <file>
             preallocate
             archive [--delete] <zip file path>
             autoarchive
             preserve
             register <pipeline> <in1> <in2>...
             diagram <pipeline> <in1> <in2>...
             diagrameditor <pipeline> <in1> <in2>...

Options:

 -a,--autoarchive <arg>           clean up all internal files after run into given archive
 -b,--branch <arg>                Comma separated list of branches to limit execution to
 -d,--dir <arg>                   output directory
 -delay,--delay <arg>             Delay in seconds before starting pipeline
 -e,--env <arg>                   Environment to select from alternate configurations in
                                  bpipe.config
 -f,--filename <arg>              output file name of report
 -h,--help                        usage information
 -l,--resource <resource=value>   place limit on named resource
 -L,--interval <arg>              the default genomic interval to execute pipeline for (samtools
                                  format)
 -m,--memory <arg>                maximum memory in MB, or specified as <n>GB or <n>MB
 -n,--threads <arg>               maximum threads
 -p,--param <param=value>         defines a pipeline parameter, or file of parameters via @<file>
 -r,--report                      generate an HTML report / documentation for pipeline
 -R,--report <arg>                generate report using named template
 -s,--source <arg>                Load the given pipeline file(s) before running / executing
 -t,--test                        test mode
 -u,--until <arg>                 run until stage given
 -v,--verbose                     print internal logging to standard error
 -y,--yes                         answer yes to any prompts or questions
```


## bpipe_stop

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No bpipe pipeline found running in this directory.

PID of last job is -1
```


## bpipe_history

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No history found
```


## bpipe_log

### Tool Description
Show log output from bpipe jobs

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: log <options> [<jobid>]
 -c,--command <arg>     command id to show output for
 -e,--errors            show output for commands that failed in the last
                        run
 -f,--follow            keep following file until user presses Ctrl+C
 -h,--help              show help
 -n,--lines <arg>       number of lines to log
 -s,--stageid <arg>     stage id to show output for
 -t,--threads <arg>     thread id to track
 -v,--verbose           enable verbose logging
 -x,--completed <arg>   show in context of completed pipeline with given
                        pid
```


## bpipe_jobs

### Tool Description
List and manage Bpipe jobs

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bpipe jobs <options>
 -all           Show completed  as well as running jobs
 -h,--help      Show help
 -sleep <arg>   Sleep time when watching continuously
 -watch         Show continuously updated display
```


## bpipe_checks

### Tool Description
Check Report

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
=====================================================
|                   Check Report                    |
=====================================================
-------------------------------------
 Check |  Branch |  Status |  Details
-------|---------|---------|---------

Enter a number of a check to override, * for all, Ctrl-C to exit:
```


## bpipe_override

### Tool Description
Override specified check to force it to pass

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
error: Missing argument for option: o
usage: bpipe override | bpipe checks
 -c <arg>    comment to add to given operation
 -f <arg>    fail specified check
 -h,--help   show help
 -l          list checks and exit, non-interactive mode
 -o <arg>    override specified check to force it to pass
```


## bpipe_status

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Error: no result file exists for the most recent Bpipe run.
                
                    This may indicate that the Bpipe process was terminated in an unexpected manner.
```


## bpipe_cleanup

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No matching files were found as eligible outputs to clean up.

You may mark a file as disposable by using @intermediate annotations
in your Bpipe script.
```


## bpipe_query

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Error: cannot locate output --help in output dependency graph
```


## bpipe_preallocate

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No preallocate section was found in configuration (bpipe.config). To preallocate resources,
first declare a preallocate section in your configuration.
```


## bpipe_archive

### Tool Description
Archiving to computed file path

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
MSG: Archiving to computed file path --help/bpipe_archive_20260225_162818.zip
usage: archive <zip file>
 -d,--delete        Remove archived files
 -dir,--dir <arg>   Directory of Bpipe run to archive
```


## bpipe_autoarchive

### Tool Description
Archiving to computed file path

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
MSG: Archiving to computed file path --help/bpipe_archive_20260225_162851.zip
usage: archive <zip file>
 -d,--delete        Remove archived files
 -dir,--dir <arg>   Directory of Bpipe run to archive
```


## bpipe_preserve

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
0 files were preserved
```


## bpipe_register

### Tool Description
Register a pipeline with Bpipe

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Bpipe Version null   Built on Wed Feb 25 16:30:19 GMT 2026

usage: bpipe register [-e] [-f <format>] <pipeline> <input1> <input2> ...
```


## bpipe_diagram

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
No previous Bpipe command seems to have been run in this directory.
```


## bpipe_diagrameditor

### Tool Description
Generate a diagram of a Bpipe pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
- **Homepage**: http://docs.bpipe.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/bpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Bpipe Version null   Built on Wed Feb 25 16:31:16 GMT 2026

usage: bpipe diagram [-e] [-f <format>] <pipeline> <input1> <input2> ...
```

