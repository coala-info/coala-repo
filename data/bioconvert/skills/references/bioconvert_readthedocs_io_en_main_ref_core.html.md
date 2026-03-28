[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
  + 7.1. Core functions
    - [7.1.1. Base](#module-bioconvert.core.base)
      * [`ConvArg`](#bioconvert.core.base.ConvArg)
      * [`ConvBase`](#bioconvert.core.base.ConvBase)
      * [`ConvMeta`](#bioconvert.core.base.ConvMeta)
      * [`make_chain()`](#bioconvert.core.base.make_chain)
    - [7.1.2. Benchmark](#module-bioconvert.core.benchmark)
      * [`Benchmark`](#bioconvert.core.benchmark.Benchmark)
      * [`plot_multi_benchmark_max()`](#bioconvert.core.benchmark.plot_multi_benchmark_max)
    - [7.1.3. Converter](#module-bioconvert.core.converter)
      * [`Bioconvert`](#bioconvert.core.converter.Bioconvert)
    - [7.1.4. Decorators](#module-bioconvert.core.decorators)
      * [`compressor()`](#bioconvert.core.decorators.compressor)
      * [`in_gz()`](#bioconvert.core.decorators.in_gz)
      * [`make_in_gz_tester()`](#bioconvert.core.decorators.make_in_gz_tester)
      * [`out_compressor()`](#bioconvert.core.decorators.out_compressor)
      * [`requires()`](#bioconvert.core.decorators.requires)
      * [`requires_nothing()`](#bioconvert.core.decorators.requires_nothing)
    - [7.1.5. Downloader](#module-bioconvert.core.downloader)
    - [7.1.6. Extensions](#module-bioconvert.core.extensions)
      * [`AttrDict`](#bioconvert.core.extensions.AttrDict)
      * [`extensions`](#bioconvert.core.extensions.extensions)
    - [7.1.7. Graph](#module-bioconvert.core.graph)
      * [`create_graph()`](#bioconvert.core.graph.create_graph)
      * [`create_graph_for_cytoscape()`](#bioconvert.core.graph.create_graph_for_cytoscape)
    - [7.1.8. Registry](#module-bioconvert.core.registry)
      * [`Registry`](#bioconvert.core.registry.Registry)
    - [7.1.9. Utils](#module-bioconvert.core.utils)
      * [`TempFile`](#bioconvert.core.utils.TempFile)
      * [`Timer`](#bioconvert.core.utils.Timer)
      * [`generate_outfile_name()`](#bioconvert.core.utils.generate_outfile_name)
      * [`get_extension()`](#bioconvert.core.utils.get_extension)
      * [`get_format_from_extension()`](#bioconvert.core.utils.get_format_from_extension)
      * [`md5()`](#bioconvert.core.utils.md5)
  + [7.2. Reference converters](ref_converters.html)
  + [7.3. IO functions](ref_io.html)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* [7. References](references.html)
* 7.1. Core functions
* [View page source](_sources/ref_core.rst.txt)

---

# 7.1. Core functions[](#core-functions "Link to this heading")

|  |  |
| --- | --- |
| [`bioconvert.core.base`](#module-bioconvert.core.base "bioconvert.core.base") | Main factory of Bioconvert |
| [`bioconvert.core.benchmark`](#module-bioconvert.core.benchmark "bioconvert.core.benchmark") | Tools for benchmarking |
| [`bioconvert.core.converter`](#module-bioconvert.core.converter "bioconvert.core.converter") |  |
| [`bioconvert.core.decorators`](#module-bioconvert.core.decorators "bioconvert.core.decorators") | Provides a general tool to perform pre/post compression |
| [`bioconvert.core.downloader`](#module-bioconvert.core.downloader "bioconvert.core.downloader") | Download singularity image |
| [`bioconvert.core.extensions`](#module-bioconvert.core.extensions "bioconvert.core.extensions") | List of formats and associated extensions |
| [`bioconvert.core.graph`](#module-bioconvert.core.graph "bioconvert.core.graph") | Network tools to manipulate the graph of conversion |
| [`bioconvert.core.registry`](#module-bioconvert.core.registry "bioconvert.core.registry") | Main bioconvert registry that fetches automatically the relevant converter |
| `bioconvert.core.shell` | Simplified version of shell.py module from snakemake package |
| [`bioconvert.core.utils`](#module-bioconvert.core.utils "bioconvert.core.utils") | misc utility functions |

## 7.1.1. Base[](#module-bioconvert.core.base "Link to this heading")

Main factory of Bioconvert

*class* bioconvert.core.base.ConvArg(*names*, *help*, *\*\*kwargs*)[[source]](_modules/bioconvert/core/base.html#ConvArg)[](#bioconvert.core.base.ConvArg "Link to this definition")
:   This class can be used to add specific extra arguments to any converter

    For instance, imagine a conversion named **A2B** that requires the
    user to provide a reference. Then, you may want to provide the
    –reference extra argument. This is possible by adding a class
    method named get\_additional\_arguments that will yield instance of
    this class for each extra argument.

    ```
    @classmethod
    def get_additional_arguments(cls):
        yield ConvArg(
            names="--reference",
            default=None,
            help="the referenc"
        )
    ```

    Then, when calling bioconvert as follows,:

    ```
    bioconvert A2B --help
    ```

    the new argument will be shown in the list of arguments.

    Methods

    |  |  |
    | --- | --- |
    | **add\_to\_sub\_parser** |  |
    | **file** |  |

*class* bioconvert.core.base.ConvBase(*infile*, *outfile*)[[source]](_modules/bioconvert/core/base.html#ConvBase)[](#bioconvert.core.base.ConvBase "Link to this definition")
:   Base class for all converters.

    To build a new converter, create a new class which inherits from
    [`ConvBase`](#bioconvert.core.base.ConvBase "bioconvert.core.base.ConvBase") and implement method that performs the conversion.
    The name of the converter method must start with `_method_`.

    For instance:

    ```
    class FASTQ2FASTA(ConvBase):

        def _method_python(self, *args, **kwargs):
            # include your code here. You can use the infile and outfile
            # attributes.
            self.infile
            self.outfile
    ```

    Attributes:
    :   **default**

        **input\_ext**

        [`name`](#bioconvert.core.base.ConvBase.name "bioconvert.core.base.ConvBase.name")
        :   The name of the class

        **output\_ext**

    Methods

    |  |  |
    | --- | --- |
    | `__call__`(\*args[, method\_name]) |  |
    | [`boxplot_benchmark`](#bioconvert.core.base.ConvBase.boxplot_benchmark "bioconvert.core.base.ConvBase.boxplot_benchmark")([rot\_xticks, ...]) | This function plots the benchmark computed in [`compute_benchmark()`](#bioconvert.core.base.ConvBase.compute_benchmark "bioconvert.core.base.ConvBase.compute_benchmark") |
    | [`compute_benchmark`](#bioconvert.core.base.ConvBase.compute_benchmark "bioconvert.core.base.ConvBase.compute_benchmark")([N, to\_exclude, to\_include]) | Simple wrapper to call `Benchmark` |
    | `get_IO_arguments`() |  |
    | [`install_tool`](#bioconvert.core.base.ConvBase.install_tool "bioconvert.core.base.ConvBase.install_tool")(executable) | Install the given tool, using the script: bioconvert/install\_script/install\_executable.sh if the executable is not already present |

    |  |  |
    | --- | --- |
    | **add\_argument\_to\_parser** |  |
    | **execute** |  |
    | **get\_additional\_arguments** |  |
    | **get\_common\_arguments** |  |
    | **get\_common\_arguments\_for\_converter** |  |
    | **get\_description** |  |
    | **shell** |  |

    constructor

    Parameters:
    :   * **infile** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – the path of the input file.
        * **outfile** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – the path of The output file

    Attributes:
    :   **default**

        **input\_ext**

        [`name`](#bioconvert.core.base.ConvBase.name "bioconvert.core.base.ConvBase.name")
        :   The name of the class

        **output\_ext**

    Methods

    |  |  |
    | --- | --- |
    | `__call__`(\*args[, method\_name]) |  |
    | [`boxplot_benchmark`](#bioconvert.core.base.ConvBase.boxplot_benchmark "bioconvert.core.base.ConvBase.boxplot_benchmark")([rot\_xticks, ...]) | This function plots the benchmark computed in [`compute_benchmark()`](#bioconvert.core.base.ConvBase.compute_benchmark "bioconvert.core.base.ConvBase.compute_benchmark") |
    | [`compute_benchmark`](#bioconvert.core.base.ConvBase.compute_benchmark "bioconvert.core.base.ConvBase.compute_benchmark")([N, to\_exclude, to\_include]) | Simple wrapper to call `Benchmark` |
    | `get_IO_arguments`() |  |
    | [`install_tool`](#bioconvert.core.base.ConvBase.install_tool "bioconvert.core.base.ConvBase.install_tool")(executable) | Install the given tool, using the script: bioconvert/install\_script/install\_executable.sh if the executable is not already present |

    |  |  |
    | --- | --- |
    | **add\_argument\_to\_parser** |  |
    | **execute** |  |
    | **get\_additional\_arguments** |  |
    | **get\_common\_arguments** |  |
    | **get\_common\_arguments\_for\_converter** |  |
    | **get\_description** |  |
    | **shell** |  |

    boxplot\_benchmark(*rot\_xticks=90*, *boxplot\_args={}*, *mode='time'*)[[source]](_modules/bioconvert/core/base.html#ConvBase.boxplot_benchmark)[](#bioconvert.core.base.ConvBase.boxplot_benchmark "Link to this definition")
    :   This function plots the benchmark computed in [`compute_benchmark()`](#bioconvert.core.base.ConvBase.compute_benchmark "bioconvert.core.base.ConvBase.compute_benchmark")

    compute\_benchmark(*N=5*, *to\_exclude=[]*, *to\_include=[]*)[[source]](_modules/bioconvert/core/base.html#ConvBase.compute_benchmark)[](#bioconvert.core.base.ConvBase.compute_benchmark "Link to this definition")
    :   Simple wrapper to call `Benchmark`

        This function computes the benchmark

        see [`Benchmark`](#bioconvert.core.benchmark.Benchmark "bioconvert.core.benchmark.Benchmark") for details.

    install\_tool(*executable*)[[source]](_modules/bioconvert/core/base.html#ConvBase.install_tool)[](#bioconvert.core.base.ConvBase.install_tool "Link to this definition")
    :   Install the given tool, using the script:
        bioconvert/install\_script/install\_executable.sh
        if the executable is not already present

        Parameters:
        :   **executable** – executable to install

        Returns:
        :   nothing

    *property* name[](#bioconvert.core.base.ConvBase.name "Link to this definition")
    :   The name of the class

*class* bioconvert.core.base.ConvMeta(*name*, *bases*, *namespace*, */*, *\*\*kwargs*)[[source]](_modules/bioconvert/core/base.html#ConvMeta)[](#bioconvert.core.base.ConvMeta "Link to this definition")
:   This metaclass checks that the converter classes have

    > * an attribute input\_ext
    > * an attribute output\_ext

    This is a meta class used by [`ConvBase`](#bioconvert.core.base.ConvBase "bioconvert.core.base.ConvBase") class. For developers
    only.

    Methods

    |  |  |
    | --- | --- |
    | `__call__`(\*args, \*\*kwargs) | Call self as a function. |
    | `mro`(/) | Return a type's method resolution order. |
    | `register`(subclass) | Register a virtual subclass of an ABC. |

    |  |  |
    | --- | --- |
    | **lower\_tuple** |  |
    | **split\_converter\_to\_format** |  |

bioconvert.core.base.make\_chain(*converter\_map*)[[source]](_modules/bioconvert/core/base.html#make_chain)[](#bioconvert.core.base.make_chain "Link to this definition")
:   Create a class performing step-by-step conversions following a path.
    *converter\_map* is a list of pairs ((in\_fmt, out\_fmt), converter).
    It describes the conversion path.

## 7.1.2. Benchmark[](#module-bioconvert.core.benchmark "Link to this heading")

Tools for benchmarking

*class* bioconvert.core.benchmark.Benchmark(*obj*, *N=5*, *to\_exclude=None*, *to\_include=None*)[[source]](_modules/bioconvert/core/benchmark.html#Benchmark)[](#bioconvert.core.benchmark.Benchmark "Link to this definition")
:   Convenient class to benchmark several methods for a given converter

    ```
    c = BAM2COV(infile, outfile)
    b = Benchmark(c, N=5)
    b.run_methods()
    b.plot()
    ```

    Methods

    |  |  |
    | --- | --- |
    | [`plot`](#bioconvert.core.benchmark.Benchmark.plot "bioconvert.core.benchmark.Benchmark.plot")([rerun, ylabel, rot\_xticks, ...]) | Plots the benchmark results, running the benchmarks if needed or if *rerun* is True. |
    | [`run_methods`](#bioconvert.core.benchmark.Benchmark.run_methods "bioconvert.core.benchmark.Benchmark.run_methods")() | Runs the benchmarks, and stores the timings in *self.results*. |

    |  |  |
    | --- | --- |
    | **monitor\_usage** |  |

    Constructor

    Parameters:
    :   * **obj** – can be an instance of a converter class or a class name
        * **N** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – number of replicates
        * **to\_exclude** ([*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")) – methods to exclude from the benchmark
        * **to\_include** ([*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")) – methods to include ONLY

    Use one of *to\_exclude* or *to\_include*.
    If both are provided, only the *to\_include* one is used.

    Methods

    |  |  |
    | --- | --- |
    | [`plot`](#bioconvert.core.benchmark.Benchmark.plot "bioconvert.core.benchmark.Benchmark.plot")([rerun, ylabel, rot\_xticks, ...]) | Plots the benchmark results, running the benchmarks if needed or if *rerun* is True. |
    | [`run_methods`](#bioconvert.core.benchmark.Benchmark.run_methods "bioconvert.core.benchmark.Benchmark.run_methods")() | Runs the benchmarks, and stores the timings in *self.results*. |

    |  |  |
    | --- | --- |
    | **monitor\_usage** |  |

    plot(*rerun=False*, *ylabel=None*, *rot\_xticks=0*, *boxplot\_args={}*, *mode='time'*)[[source]](_modules/bioconvert/core/benchmark.html#Benchmark.plot)[](#bioconvert.core.benchmark.Benchmark.plot "Link to this definition")
    :   Plots the benchmark results, running the benchmarks
        if needed or if *rerun* is True.

        Parameters:
        :   * **rot\_xlabel** – rotation of the xticks function
            * **boxplot\_args** – dictionary with any of the pylab.boxplot arguments
            * **mode** – either time, CPU or memory

        Returns:
        :   dataframe with all results

    run\_methods()[[source]](_modules/bioconvert/core/benchmark.html#Benchmark.run_methods)[](#bioconvert.core.benchmark.Benchmark.run_methods "Link to this definition")
    :   Runs the benchmarks, and stores the timings in *self.results*.

bioconvert.core.benchmark.plot\_multi\_benchmark\_max(*path\_json*, *output\_filename='multi\_benchmark.png'*, *min\_ylim=0*, *mode=None*)[[source]](_modules/bioconvert/core/benchmark.html#plot_multi_benchmark_max)[](#bioconvert.core.benchmark.plot_multi_benchmark_max "Link to this definit