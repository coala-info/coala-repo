Source: https://pep.databio.org/eido/filters/ and https://pep.databio.org/eido/writing-a-filter/

**Filters are an experimental feature and may change in future versions of `eido`.**

# Using eido filters

Eido provides a CLI to convert a PEP into different output formats. These include some built-in formats, like _csv_ (which produces a processed csv file, with project/sample already modified), _yaml_, and a few others. It also provides a plugin system so that you can write your own Python functions to provide custom output formats. You access filters through the `eido convert` command.

## View available filters

To list available filters:

```console
eido convert --list
```

You'll see some output like this. There are a few built-in filters available:


```console
Available filters:
 - basic
 - csv
 - yaml
 - yaml-samples
```

You can add to this list by [writing a custom filter](writing-a-filter.md), which will write your PEP into whatever format you need.

## Convert a PEP into an alternative format with a filter

To convert a PEP into an output format, do this:

```console
eido convert config.yaml -f basic
running plugin pep
Project 'pepconvert' (/home/nsheff/code/pepconvert/config.yaml)
5 samples: WT_REP1, WT_REP2, RAP1_UNINDUCED_REP1, RAP1_UNINDUCED_REP2, RAP1_IAA_30M_REP1
Sections: pep_version, sample_table, subsample_table
...
```

This *basic* format just lists the config file, the number of samples and their names, and identifies the sections in the project config file. Another format is `-f yaml`,

```console
eido convert config.yaml -f yaml
```

This will output your samples in yaml format.

### Parametrizing filters

Filter functions are parameterizable. Some filters may request or require parameters. To learn more about a filter's parameters, use `-d` or `--describe`: `eido convert -f <filter_name> -d`, which displays the plugin documentation. For example:

```console
eido convert -f yaml-samples -d

    YAML samples PEP filter, that returns only Sample object representations.

    This filter can save the YAML to file, if kwargs include `path`.

    :param peppy.Project p: a Project to run filter on
```

In this case, the argument `path` can be provided as an output file. Like this: 

```console
eido convert config.yaml -f yaml-samples -a path=output.yaml
```

More generally, the form to provide parameters is like this

```console
eido convert config.yaml -f <filter_name> -a argument1=value1 argument2=value2
```

**Filters are an experimental feature and may change in future versions of `eido`**

# How to write a custom eido filter

One of `eido`'s tasks is to provide a CLI to convert a PEP into alternative formats. These include some built-in formats, like `csv` (which spits out a processed `csv` file, with project/sample modified), `yaml`, and a few others. It also provides a plugin system so that you can write your own Python functions to provide custom output formats.

## Custom filters

To write a custom filter, start by writing a Python package. You will need to include a function that takes a `peppy.Project` object as input, and prints out the custom file format. The filter functions also can require additional keyword arguments.

### 1. Write functions to call

The package contain one or more functions. The filter function **must take a peppy.Project object and `**kwargs` as parameters**. Example:

```python
import peppy

def my_custom_filter(p, **kwargs):
    import re
    import sys
    import yaml

    for s in p.samples:
        sys.stdout.write("- ")
        out = re.sub('\n', '\n  ', yaml.safe_dump(s.to_dict(), default_flow_style=False))
        sys.stdout.write(out + "\n")
```
For reference you can check the signatures of the functions in [Built-in `eido` Plugins Documentation](code/plugin-api-docs.md). Importantly, if the function *requires* any arguments (always provided via `**kwargs`), the creator of the function should take care of handling missing/faulty input.

Next, we need to link that function in to the `eido` filter plugin system.

### 2. Add entry_points to setup.py

The `setup.py` file uses `entry_points` to specify a mapping of eido hooks to functions to call.

```python
entry_points={
    "pep.filters": [
        "basic=eido.conversion_plugins:basic_pep_filter",
        "yaml=eido.conversion_plugins:yaml_pep_filter",
        "csv=eido.conversion_plugins:csv_pep_filter",
        "yaml-samples=eido.conversion_plugins:yaml_samples_pep_filter",
    ],
},
```

The format is: `'pep.filters': 'FILTER_NAME=PLUGIN_PACKAGE_NAME:FUNCTION_NAME'`.

- "FILTER_NAME" can be any unique identifier for your plugin
- "PLUGIN_PACKAGE_NAME" must be the name of python package the holds your plugin.
- "FUNCTION_NAME" must match the name of the function in your package

### 3. Install package

If you install this package, any filters provided by it will be available for use with eido, which you can see using `eido filters`.
