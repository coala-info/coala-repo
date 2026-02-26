# pytest-workflow CWL Generation Report

## pytest-workflow_pytest

### Tool Description
pytest: a plugin for pytest to manage workflows

### Metadata
- **Docker Image**: quay.io/biocontainers/pytest-workflow:1.2.0--py_0
- **Homepage**: https://github.com/LUMC/pytest-workflow
- **Package**: https://anaconda.org/channels/bioconda/packages/pytest-workflow/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pytest-workflow/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LUMC/pytest-workflow
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/pytest", line 11, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/_pytest/config/__init__.py", line 79, in main
    return config.hook.pytest_cmdline_main(config=config)
  File "/usr/local/lib/python3.7/site-packages/pluggy/hooks.py", line 289, in __call__
    return self._hookexec(self, self.get_hookimpls(), kwargs)
  File "/usr/local/lib/python3.7/site-packages/pluggy/manager.py", line 68, in _hookexec
    return self._inner_hookexec(hook, methods, kwargs)
  File "/usr/local/lib/python3.7/site-packages/pluggy/manager.py", line 62, in <lambda>
    firstresult=hook.spec.opts.get("firstresult") if hook.spec else False,
  File "/usr/local/lib/python3.7/site-packages/pluggy/callers.py", line 208, in _multicall
    return outcome.get_result()
  File "/usr/local/lib/python3.7/site-packages/pluggy/callers.py", line 80, in get_result
    raise ex[1].with_traceback(ex[2])
  File "/usr/local/lib/python3.7/site-packages/pluggy/callers.py", line 187, in _multicall
    res = hook_impl.function(*args)
  File "/usr/local/lib/python3.7/site-packages/_pytest/helpconfig.py", line 137, in pytest_cmdline_main
    config._do_configure()
  File "/usr/local/lib/python3.7/site-packages/_pytest/config/__init__.py", line 663, in _do_configure
    self.hook.pytest_configure.call_historic(kwargs=dict(config=self))
  File "/usr/local/lib/python3.7/site-packages/pluggy/hooks.py", line 311, in call_historic
    res = self._hookexec(self, self.get_hookimpls(), kwargs)
  File "/usr/local/lib/python3.7/site-packages/pluggy/manager.py", line 68, in _hookexec
    return self._inner_hookexec(hook, methods, kwargs)
  File "/usr/local/lib/python3.7/site-packages/pluggy/manager.py", line 62, in <lambda>
    firstresult=hook.spec.opts.get("firstresult") if hook.spec else False,
  File "/usr/local/lib/python3.7/site-packages/pluggy/callers.py", line 208, in _multicall
    return outcome.get_result()
  File "/usr/local/lib/python3.7/site-packages/pluggy/callers.py", line 80, in get_result
    raise ex[1].with_traceback(ex[2])
  File "/usr/local/lib/python3.7/site-packages/pluggy/callers.py", line 187, in _multicall
    res = hook_impl.function(*args)
  File "/usr/local/lib/python3.7/site-packages/pytest_workflow/plugin.py", line 143, in pytest_configure
    "directory.".format(workflow_temp_dir, rootdir))
ValueError: '/tmp/pytest_workflow_hhx3u9x0' is a subdirectory of '/'. Please select a --basetemp that is not in pytest's current working directory.
```

