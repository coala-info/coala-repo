# parallel CWL Generation Report

## parallel

### Tool Description
Run jobs in parallel

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel:20180322-0
- **Homepage**: https://github.com/PaddlePaddle/Paddle
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parallel/overview
- **Total Downloads**: 176.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PaddlePaddle/Paddle
- **Stars**: N/A
### Original Help Text
```text
Usage:

parallel [options] [command [arguments]] < list_of_arguments
parallel [options] [command [arguments]] (::: arguments|:::: argfile(s))...
cat ... | parallel --pipe [options] [command [arguments]]

-j n            Run n jobs in parallel
-k              Keep same order
-X              Multiple arguments with context replace
--colsep regexp Split input on regexp for positional replacements
{} {.} {/} {/.} {#} {%} {= perl code =} Replacement strings
{3} {3.} {3/} {3/.} {=3 perl code =}    Positional replacement strings
With --plus:    {} = {+/}/{/} = {.}.{+.} = {+/}/{/.}.{+.} = {..}.{+..} =
                {+/}/{/..}.{+..} = {...}.{+...} = {+/}/{/...}.{+...}

-S sshlogin     Example: foo@server.example.com
--slf ..        Use ~/.parallel/sshloginfile as the list of sshlogins
--trc {}.bar    Shorthand for --transfer --return {}.bar --cleanup
--onall         Run the given command with argument on all sshlogins
--nonall        Run the given command with no arguments on all sshlogins

--pipe          Split stdin (standard input) to multiple jobs.
--recend str    Record end separator for --pipe.
--recstart str  Record start separator for --pipe.

See 'man parallel' for details

Academic tradition requires you to cite works you base your article on.
If you use programs that use GNU Parallel to process data for an article in a
scientific publication, please cite:

  O. Tange (2011): GNU Parallel - The Command-Line Power Tool,
  ;login: The USENIX Magazine, February 2011:42-47.

This helps funding further development; AND IT WON'T COST YOU A CENT.
If you pay 10000 EUR you should feel free to use GNU Parallel without citing.
```


## Metadata
- **Skill**: generated
