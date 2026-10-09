# jq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| jq | PASS | 13 options tested; outputs identical to the Galaxy expected files; rewrote --arg style inputs as name/value records |

## jq

### Tool Description
jq is a tool for processing JSON inputs, applying the given filter to its JSON text inputs and producing the filter's results as JSON on standard output.

### Metadata
- **Docker Image**: quay.io/biocontainers/jq:1.6
- **Homepage**: https://github.com/jquery/jquery
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jq/overview
- **Total Downloads**: 147.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jquery/jquery
- **Stars**: N/A
### Original Help Text
```text
jq - commandline JSON processor [version 1.6]

Usage:	/usr/local/bin/jq [options] <jq filter> [file...]
	/usr/local/bin/jq [options] --args <jq filter> [strings...]
	/usr/local/bin/jq [options] --jsonargs <jq filter> [JSON_TEXTS...]

jq is a tool for processing JSON inputs, applying the given filter to
its JSON text inputs and producing the filter's results as JSON on
standard output.

The simplest filter is ., which copies jq's input to its output
unmodified (except for formatting, but note that IEEE754 is used
for number representation internally, with all that that implies).

For more advanced filters see the jq(1) manpage ("man jq")
and/or https://stedolan.github.io/jq

Example:

	$ echo '{"foo": 0}' | jq .
	{
		"foo": 0
	}

Some of the options include:
  -c               compact instead of pretty-printed output;
  -n               use `null` as the single input value;
  -e               set the exit status code based on the output;
  -s               read (slurp) all inputs into an array; apply filter to it;
  -r               output raw strings, not JSON texts;
  -R               read raw strings, not JSON texts;
  -C               colorize JSON;
  -M               monochrome (don't colorize JSON);
  -S               sort keys of objects on output;
  --tab            use tabs for indentation;
  --arg a v        set variable $a to value <v>;
  --argjson a v    set variable $a to JSON value <v>;
  --slurpfile a f  set variable $a to an array of JSON texts read from <f>;
  --rawfile a f    set variable $a to a string consisting of the contents of <f>;
  --args           remaining arguments are string arguments, not files;
  --jsonargs       remaining arguments are JSON arguments, not files;
  --               terminates argument processing;

Named arguments are also available as $ARGS.named[], while
positional arguments are available as $ARGS.positional[].

See the manpage for more options.
2026/10/01 20:20:19  warn rootless{dev/console} creating empty file in place of device 5:1
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
```
## Metadata
- **Skill**: not generated
