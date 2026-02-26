# sierrapy CWL Generation Report

## sierrapy_fasta

### Tool Description
Run alignment, drug resistance and other analysis for one or more FASTA-format files contained DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
- **Homepage**: https://github.com/hivdb/sierra-client/tree/master/python
- **Package**: https://anaconda.org/channels/bioconda/packages/sierrapy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sierrapy/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hivdb/sierra-client
- **Stars**: N/A
### Original Help Text
```text
Usage: sierrapy fasta [OPTIONS] FASTA...

  Run alignment, drug resistance and other analysis for one or more FASTA-
  format files contained DNA sequences.

Options:
  --url TEXT                 URL of Sierra GraphQL Web Service.  [default:
                             production URL varied by virus]
  --virus [HIV1|HIV2|SARS2]  Specify virus to be analyzed.  [default: HIV1]
  -q, --query FILENAME       A file contains GraphQL fragment definition on
                             `SequenceAnalysis`.
  -o, --output FILE          File path to store the JSON result.
  --sharding INTEGER         Save JSON result files per n sequences.
  --no-sharding              Save JSON result to a single file.
  --step INTEGER             Send batch requests per n sequences.
  --skip INTEGER             Skip first n sequences.
  --total INTEGER            Total number of sequences; specify one to
                             visualize a progress bar.
  --ugly                     Output compressed JSON result.
  --help                     Show this message and exit.
```


## sierrapy_introspection

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
- **Homepage**: https://github.com/hivdb/sierra-client/tree/master/python
- **Package**: https://anaconda.org/channels/bioconda/packages/sierrapy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sierrapy", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sierrapy/cmds.py", line 5, in main
    cli(obj={})
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1130, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1055, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1657, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 1404, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/core.py", line 760, in invoke
    return __callback(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/click/decorators.py", line 26, in new_func
    return f(get_current_context(), *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sierrapy/commands/introspection.py", line 16, in introspection
    result: Dict[str, Any] = ctx.obj['CLIENT'].get_introspection()
                             ~~~~~~~^^^^^^^^^^
KeyError: 'CLIENT'
```


## sierrapy_mutations

### Tool Description
Run drug resistance and other analysis for PR, RT and/or IN mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
- **Homepage**: https://github.com/hivdb/sierra-client/tree/master/python
- **Package**: https://anaconda.org/channels/bioconda/packages/sierrapy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sierrapy mutations [OPTIONS] MUTATIONS...

  Run drug resistance and other analysis for PR, RT and/or IN mutations. For
  Example:

  sierrapy mutations PR:E35E_D RT:T67- IN:M50MI

  Use command "sierrapy patterns" instead if you want to run multiple sets of
  mutations in one request.

Options:
  --url TEXT                 URL of Sierra GraphQL Web Service.  [default:
                             production URL varied by virus]
  --virus [HIV1|HIV2|SARS2]  Specify virus to be analyzed.  [default: HIV1]
  -q, --query FILENAME       A file contains GraphQL fragment definition on
                             `MutationsAnalysis`.
  -o, --output FILENAME      File path to store the JSON result.
  --ugly                     Output compressed JSON result.
  --help                     Show this message and exit.
```


## sierrapy_patterns

### Tool Description
Run drug resistance and other analysis for one or more files contains lines of PR, RT and/or IN mutations based on HIV-1 type B consensus. Each line is treated as a unique pattern.

### Metadata
- **Docker Image**: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
- **Homepage**: https://github.com/hivdb/sierra-client/tree/master/python
- **Package**: https://anaconda.org/channels/bioconda/packages/sierrapy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sierrapy patterns [OPTIONS] PATTERNS...

  Run drug resistance and other analysis for one or more files contains lines
  of PR, RT and/or IN mutations based on HIV-1 type B consensus. Each line is
  treated as a unique pattern. For example:

  >set1
  RT:M41L + RT:M184V + RT:L210W + RT:T215Y
  >set2
  PR:L24I + PR:M46L + PR:I54V + PR:V82A

  The following delimiters are supported: commas (,), plus signs (+),
  semicolon(;), whitespaces and tabs. The consensus sequences can be retrieved
  from HIVDB website: <https://goo.gl/ZBthkt>.

Options:
  --url TEXT                 URL of Sierra GraphQL Web Service.  [default:
                             production URL varied by virus]
  --virus [HIV1|HIV2|SARS2]  Specify virus to be analyzed.  [default: HIV1]
  -q, --query FILENAME       A file contains GraphQL fragment definition on
                             `MutationsAnalysis`.
  -o, --output FILE          File path to store the JSON result.
  --sharding INTEGER         Save JSON result files per n patterns.
  --no-sharding              Save JSON result to a single file.
  --step INTEGER             Send batch requests per n patterns.
  --skip INTEGER             Skip first n patterns.
  --total INTEGER            Total number of patterns; specify one to
                             visualize a progress bar.
  --ugly                     Output compressed JSON result.
  --help                     Show this message and exit.
```


## sierrapy_recipe

### Tool Description
Post process Sierra web service output.

### Metadata
- **Docker Image**: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
- **Homepage**: https://github.com/hivdb/sierra-client/tree/master/python
- **Package**: https://anaconda.org/channels/bioconda/packages/sierrapy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sierrapy recipe [OPTIONS] COMMAND [ARGS]...

  Post process Sierra web service output.

Options:
  --input FILENAME   JSON result from Sierra web service.
  --output FILENAME  File path to store the result.
  --help             Show this message and exit.

Commands:
  alignment    Export aligned pol sequences from Sierra result.
  mutationtsv  Export mutation set of each sequences from Sierra result.
  sequencetsv  Export mutation set of each sequences from Sierra result.
```


## sierrapy_seqreads

### Tool Description
Run alignment, drug resistance and other analysis for one or more tab-delimited text files contained codon reads of HIV-1 pol DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
- **Homepage**: https://github.com/hivdb/sierra-client/tree/master/python
- **Package**: https://anaconda.org/channels/bioconda/packages/sierrapy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sierrapy seqreads [OPTIONS] SEQREADS

  Run alignment, drug resistance and other analysis for one or more tab-
  delimited text files contained codon reads of HIV-1 pol DNA sequences.

Options:
  --url TEXT                      URL of Sierra GraphQL Web Service.
                                  [default: production URL varied by virus]
  --virus [HIV1|HIV2|SARS2]       Specify virus to be analyzed.  [default:
                                  HIV1]
  -p, --pcnt-cutoff FLOAT         Minimal prevalence cutoff for this sequence
                                  reads (range: 0-1.0)  [default: 0.1]
  -m, --mixture-cutoff FLOAT      Maximum mixture rate for this sequence reads
                                  (range: 0-1.0)  [default: 0.0005]
  -d, --min-codon-reads INTEGER   Minimal read depth applied to each codon of
                                  this sequence  [default: 1]
  -D, --min-position-reads INTEGER
                                  Minimal read depth applied to each position
                                  of this sequence  [default: 1]
  -q, --query FILENAME            A file contains GraphQL fragment definition
                                  on `SequenceAnalysis`
  --ugly                          Output compressed JSON result
  --help                          Show this message and exit.
```

