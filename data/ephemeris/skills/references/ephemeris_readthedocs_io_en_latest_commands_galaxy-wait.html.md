[Ephemeris](../index.html)

* [Introduction](../readme.html)
* [Installation](../installation.html)
* [Commands](../commands.html)
  + Galaxy-wait
    - [Usage](#usage)
      * [Named Arguments](#ephemeris.sleep-_parser-named-arguments)
      * [General options](#ephemeris.sleep-_parser-general-options)
      * [Galaxy connection](#ephemeris.sleep-_parser-galaxy-connection)
    - [Galaxy URL](#galaxy-url)
    - [Example Usage](#example-usage)
    - [Timeout](#timeout)
    - [Notes](#notes)
  + [Get-tool-list](get-tool-list.html)
  + [Run-data-managers](run-data-managers.html)
  + [Setup-data-libraries](setup-data-libraries.html)
  + [Shed-tools](shed-tools.html)
  + [Install-tool-deps](install-tool-deps.html)
  + [Workflow-install](workflow-install.html)
  + [Workflow-to-tools](workflow-to-tools.html)
* [Code of conduct](../conduct.html)
* [Contributing](../contributing.html)
* [Project Governance](../organization.html)
* [Release Checklist](../developing.html)
* [History](../history.html)

[Ephemeris](../index.html)

* [Commands](../commands.html)
* Galaxy-wait
* [View page source](../_sources/commands/galaxy-wait.rst.txt)

---

# Galaxy-wait[¶](#module-ephemeris.sleep "Link to this heading")

Utility to do a blocking sleep until a Galaxy instance is responsive.
This is useful in docker images, in RUN steps, where one needs to wait
for a currently starting Galaxy to be alive, before API requests can be
made successfully.
The script functions by making repeated requests to
`http(s)://fqdn/api/version`, an API which requires no authentication
to access.

## Usage[¶](#usage "Link to this heading")

Script to sleep and wait for Galaxy to be alive.

```
usage: usage: galaxy-wait <options>
```

### Named Arguments[¶](#ephemeris.sleep-_parser-named-arguments "Link to this heading")

`--timeout`
:   Galaxy startup timeout in seconds. The default value of 0 waits forever

    Default: `0`

`-a, --api-key, --api_key`
:   Sleep until key becomes available.

`--ensure-admin, --ensure_admin`
:   Default: `False`

### General options[¶](#ephemeris.sleep-_parser-general-options "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

### Galaxy connection[¶](#ephemeris.sleep-_parser-galaxy-connection "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

## Galaxy URL[¶](#galaxy-url "Link to this heading")

Valid galaxy urls look like:

* <https://example.com>
* <http://example.com/galaxy>
* <http://localhost:8080/gx>

Do not include the trailing slash.

## Example Usage[¶](#example-usage "Link to this heading")

```
$ galaxy-wait -g https://fqdn/galaxy
```

A verbose option is offered which prints out logging statements:

```
$ galaxy-wait -g http://localhost:8080 -v
[00] Galaxy not up yet... HTTPConnectionPool(host='localhost', port=8080): Max retries exceeded with url: /api/version (Caused
[01] Galaxy not up yet... HTTPConnectionPool(host='localhost', port=8080): Max retries exceeded with url: /api/version (Caused
[02] Galaxy not up yet... HTTPConnectionPool(host='localhost', port=8080): Max retries exceeded with url: /api/version (Caused
[03] Galaxy not up yet... HTTPConnectionPool(host='localhost', port=8080): Max retries exceeded with url: /api/version (Caused
[04] Galaxy not up yet... HTTPConnectionPool(host='localhost', port=8080): Max retries exceeded with url: /api/version (Caused
[05] Galaxy not up yet... HTTPConnectionPool(host='localhost', port=8080): Max retries exceeded with url: /api/version (Caused
Galaxy Version: 17.05
```

When the specified Galaxy instance is up, it exits with a code of zero
indicating success.

## Timeout[¶](#timeout "Link to this heading")

By default, the timeout value is `0`, allowing the script to sleep
forever for a Galaxy instance to be alive. This may not be desirable
behaviour. In that case you can supply the `--timeout` option, and
after waiting that number of seconds, the `galaxy-sleep` command will
exit `1` if the Galaxy instance could not be contacted.

```
$ galaxy-wait -g https://does-not-exist -v --timeout 3
[00] Galaxy not up yet... HTTPSConnectionPool(host='does-not-exist', port=443): Max retries exceeded with url: /api/version (C
[01] Galaxy not up yet... HTTPSConnectionPool(host='does-not-exist', port=443): Max retries exceeded with url: /api/version (C
[02] Galaxy not up yet... HTTPSConnectionPool(host='does-not-exist', port=443): Max retries exceeded with url: /api/version (C
[03] Galaxy not up yet... HTTPSConnectionPool(host='does-not-exist', port=443): Max retries exceeded with url: /api/version (C
Failed to contact Galaxy))))
```

## Notes[¶](#notes "Link to this heading")

If the host returns HTML content, or otherwise non-JSON content, the tool will exit with an error.

```
$ galaxy-wait -g https://example.com -v --timeout 3
Traceback (most recent call last):
File "/home/hxr/work-freiburg/ephemeris/.venv/bin/galaxy-wait", line 11, in <module>
    load_entry_point('ephemeris', 'console_scripts', 'galaxy-wait')()
File "/home/hxr/work-freiburg/ephemeris/ephemeris/sleep.py", line 34, in main
    result = requests.get(options.galaxy + '/api/version').json()
File "/home/hxr/work-freiburg/ephemeris/.venv/lib/python3.5/site-packages/requests/models.py", line 886, in json
    return complexjson.loads(self.text, **kwargs)
File "/usr/lib/python3.5/json/__init__.py", line 319, in loads
    return _default_decoder.decode(s)
File "/usr/lib/python3.5/json/decoder.py", line 339, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
File "/usr/lib/python3.5/json/decoder.py", line 357, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
```

If this behaviour presents an issue for you, please [file a bug with ephemeris.](https://github.com/galaxyproject/ephemeris/issues)

[Previous](../commands.html "Commands")
[Next](get-tool-list.html "Get-tool-list")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).