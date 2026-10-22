# tqdm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tqdm | PASS |  |

## tqdm

### Tool Description
A fast, extensible progress bar for Python and CLI

### Metadata
- **Docker Image**: quay.io/biocontainers/tqdm:4.7.2--py36_0
- **Homepage**: https://github.com/tqdm/tqdm
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tqdm/overview
- **Total Downloads**: 49.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tqdm/tqdm
- **Stars**: N/A
### Original Help Text
```text
Usage:
  tqdm [--help | options]

Options:
  -h, --help     Print this help and exit
  -v, --version  Print version and exit

  --desc=<desc>  : str, optional
            Prefix for the progressbar.
  --total=<total>  : int, optional
            The number of expected iterations. If unspecified,
            len(iterable) is used if possible. As a last resort, only basic
            progress statistics are displayed (no ETA, no progressbar).
            If `gui` is True and this parameter needs subsequent updating,
            specify an initial arbitrary large positive integer,
            e.g. int(9e9).
  --leave=<leave>  : bool, optional
            If [default: True], keeps all traces of the progressbar
            upon termination of iteration.
  --ncols=<ncols>  : int, optional
            The width of the entire output message. If specified,
            dynamically resizes the progressbar to stay within this bound.
            If unspecified, attempts to use environment width. The
            fallback is a meter width of 10 and no limit for the counter and
            statistics. If 0, will not print any meter (only stats).
  --mininterval=<mininterval>  : float, optional
            Minimum progress update interval, in seconds [default: 0.1].
  --maxinterval=<maxinterval>  : float, optional
            Maximum progress update interval, in seconds [default: 10.0].
  --miniters=<miniters>  : int, optional
            Minimum progress update interval, in iterations.
            If specified, will set `mininterval` to 0.
  --ascii=<ascii>  : bool, optional
            If unspecified or False, use unicode (smooth blocks) to fill
            the meter. The fallback is to use ASCII characters `1-9 #`.
  --disable=<disable>  : bool, optional
            Whether to disable the entire progressbar wrapper
            [default: False].
  --unit=<unit>  : str, optional
            String that will be used to define the unit of each iteration
            [default: it].
  --unit_scale=<unit_scale>  : bool, optional
            If set, the number of iterations will be reduced/scaled
            automatically and a metric prefix following the
            International System of Units standard will be added
            (kilo, mega, etc.) [default: False].
  --dynamic_ncols=<dynamic_ncols>  : bool, optional
            If set, constantly alters `ncols` to the environment (allowing
            for window resizes) [default: False].
  --smoothing=<smoothing>  : float, optional
            Exponential moving average smoothing factor for speed estimates
            (ignored in GUI mode). Ranges from 0 (average speed) to 1
            (current/instantaneous speed) [default: 0.3].
  --bar_format=<bar_format>  : str, optional
            Specify a custom bar string formatting. May impact performance.
            If unspecified, will use '{l_bar}{bar}{r_bar}', where l_bar is
            '{desc}{percentage:3.0f}%|' and r_bar is
            '| {n_fmt}/{total_fmt} [{elapsed_str}<{remaining_str}, {rate_fmt}]'
            Possible vars: bar, n, n_fmt, total, total_fmt, percentage,
            rate, rate_fmt, elapsed, remaining, l_bar, r_bar, desc.
  --initial=<initial>  : int, optional
            The initial counter value. Useful when restarting a progress
            bar [default: 0].
  --position=<position>  : int, optional
            Specify the line offset to print this bar (starting from 0)
            Automatic if unspecified.
            Useful to manage multiple bars at once (eg, from threads).
  --delim=<delim>  : chr, optional
            Delimiting character [default: '\n']. Use '\0' for null.
            N.B.: on Windows systems, Python converts '\n' to '\r\n'.
  --buf_size=<buf_size>  : int, optional
            String buffer size in bytes [default: 256]
            used when `delim` is specified.
```


## Metadata
- **Skill**: generated
