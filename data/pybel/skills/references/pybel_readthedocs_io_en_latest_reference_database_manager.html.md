[PyBEL
![Logo](../../_static/PyBEL-square-100.png)](../../index.html)

latest

Getting Started

* [Overview](../../introduction/overview.html)
* [Installation](../../introduction/installation.html)

Data Structure

* [Data Model](../struct/datamodel.html)
* [Example Networks](../struct/examples.html)
* [Filters](../struct/filters.html)
* [Grouping](../struct/grouping.html)
* [Operations](../struct/operators.html)
* [Pipeline](../struct/pipeline.html)
* [Query](../struct/query.html)
* [Summary](../struct/summary.html)

Mutations

* [Mutations](../mutations/mutations.html)
* [Collapse](../mutations/collapse.html)
* [Deletion](../mutations/deletion.html)
* [Expansion](../mutations/expansion.html)
* [Induction](../mutations/induction.html)
* [Induction and Expansion](../mutations/induction_expansion.html)
* [Inference](../mutations/inference.html)
* [Metadata](../mutations/metadata.html)

Conversion

* [Input and Output](../io.html)

Database

* Manager
  + [Manager API](#manager-api)
  + [Manager Components](#manager-components)
* [Models](models.html)

Topic Guide

* [Cookbook](../../topics/cookbook.html)
* [Command Line Interface](../../topics/cli.html)

Reference

* [Constants](../constants.html)
* [Parsers](../parser.html)
* [Internal Domain Specific Language](../dsl.html)
* [Logging Messages](../logging.html)

Project

* [References](../../meta/references.html)
* [Current Issues](../../meta/postmortem.html)
* [Technology](../../meta/technology.html)

[PyBEL](../../index.html)

* »
* Manager
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/database/manager.rst)

---

# Manager[](#manager "Permalink to this headline")

## Manager API[](#manager-api "Permalink to this headline")

The BaseManager takes care of building and maintaining the connection to the database via SQLAlchemy.

*class* pybel.manager.BaseManager(*engine*, *session*)[[source]](../../_modules/pybel/manager/base_manager.html#BaseManager)[](#pybel.manager.BaseManager "Permalink to this definition")
:   A wrapper around a SQLAlchemy engine and session.

    Instantiate a manager from an engine and session.

    base[](#pybel.manager.BaseManager.base "Permalink to this definition")
    :   alias of [`sqlalchemy.orm.decl_api.Base`](models.html#pybel.manager.models.Base "sqlalchemy.orm.decl_api.Base")

    create\_all(*checkfirst=True*)[[source]](../../_modules/pybel/manager/base_manager.html#BaseManager.create_all)[](#pybel.manager.BaseManager.create_all "Permalink to this definition")
    :   Create the PyBEL cache’s database and tables.

        Parameters
        :   **checkfirst** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Check if the database exists before trying to re-make it

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    drop\_all(*checkfirst=True*)[[source]](../../_modules/pybel/manager/base_manager.html#BaseManager.drop_all)[](#pybel.manager.BaseManager.drop_all "Permalink to this definition")
    :   Drop all data, tables, and databases for the PyBEL cache.

        Parameters
        :   **checkfirst** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Check if the database exists before trying to drop it

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    bind()[[source]](../../_modules/pybel/manager/base_manager.html#BaseManager.bind)[](#pybel.manager.BaseManager.bind "Permalink to this definition")
    :   Bind the metadata to the engine and session.

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

The Manager collates multiple groups of functions for interacting with the database. For sake of code clarity, they
are separated across multiple classes that are documented below.

*class* pybel.manager.Manager(*connection=None*, *engine=None*, *session=None*, *\*\*kwargs*)[[source]](../../_modules/pybel/manager/cache_manager.html#Manager)[](#pybel.manager.Manager "Permalink to this definition")
:   Bases: `pybel.manager.cache_manager._Manager`

    A manager for the PyBEL database.

    Create a connection to database and a persistent session using SQLAlchemy.

    A custom default can be set as an environment variable with the name `pybel.constants.PYBEL_CONNECTION`,
    using an [RFC-1738](http://rfc.net/rfc1738.html) string. For example, a MySQL string can be given with the
    following form:

    `mysql+pymysql://<username>:<password>@<host>/<dbname>?charset=utf8[&<options>]`

    A SQLite connection string can be given in the form:

    `sqlite:///~/Desktop/cache.db`

    Further options and examples can be found on the SQLAlchemy documentation on
    [engine configuration](http://docs.sqlalchemy.org/en/latest/core/engines.html).

    Parameters
    :   * **connection** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]) – An RFC-1738 database connection string. If `None`, tries to load from the
          environment variable `PYBEL_CONNECTION` then from the config file `~/.config/pybel/config.json` whose
          value for `PYBEL_CONNECTION` defaults to `pybel.constants.DEFAULT_CACHE_CONNECTION`.
        * **engine** – Optional engine to use. Must be specified with a session and no connection.
        * **session** – Optional session to use. Must be specified with an engine and no connection.
        * **echo** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Turn on echoing sql
        * **autoflush** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")*]*) – Defaults to True if not specified in kwargs or configuration.
        * **autocommit** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")*]*) – Defaults to False if not specified in kwargs or configuration.
        * **expire\_on\_commit** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")*]*) – Defaults to False if not specified in kwargs or configuration.
        * **scopefunc** – Scoped function to pass to `sqlalchemy.orm.scoped_session()`

    From the Flask-SQLAlchemy documentation:

    An extra key `'scopefunc'` can be set on the `options` dict to
    specify a custom scope function. If it’s not provided, Flask’s app
    context stack identity is used. This will ensure that sessions are
    created and removed with the request/response cycle, and should be fine
    in most cases.

    Allowed Usages:

    Instantiation with connection string as positional argument

    ```
    >>> my_connection = 'sqlite:///~/Desktop/cache.db'
    >>> manager = Manager(my_connection)
    ```

    Instantiation with connection string as positional argument with keyword arguments

    ```
    >>> my_connection = 'sqlite:///~/Desktop/cache.db'
    >>> manager = Manager(my_connection, echo=True)
    ```

    Instantiation with connection string as keyword argument

    ```
    >>> my_connection = 'sqlite:///~/Desktop/cache.db'
    >>> manager = Manager(connection=my_connection)
    ```

    Instantiation with connection string as keyword argument with keyword arguments

    ```
    >>> my_connection = 'sqlite:///~/Desktop/cache.db'
    >>> manager = Manager(connection=my_connection, echo=True)
    ```

    Instantiation with user-supplied engine and session objects as keyword arguments

    ```
    >>> my_engine, my_session = ...  # magical creation! See SQLAlchemy documentation
    >>> manager = Manager(engine=my_engine, session=my_session)
    ```

## Manager Components[](#manager-components "Permalink to this headline")

*class* pybel.manager.NetworkManager(*engine*, *session*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager)[](#pybel.manager.NetworkManager "Permalink to this definition")
:   Groups functions for inserting and querying networks in the database’s network store.

    Instantiate a manager from an engine and session.

    count\_networks()[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.count_networks)[](#pybel.manager.NetworkManager.count_networks "Permalink to this definition")
    :   Count the networks in the database.

        Return type
        :   [`int`](https://docs.python.org/3/library/functions.html#int "(in Python v3.10)")

    list\_networks()[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.list_networks)[](#pybel.manager.NetworkManager.list_networks "Permalink to this definition")
    :   List all networks in the database.

        Return type
        :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Network`](models.html#pybel.manager.models.Network "pybel.manager.models.Network")]

    list\_recent\_networks()[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.list_recent_networks)[](#pybel.manager.NetworkManager.list_recent_networks "Permalink to this definition")
    :   List the most recently created version of each network (by name).

        Return type
        :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Network`](models.html#pybel.manager.models.Network "pybel.manager.models.Network")]

    has\_name\_version(*name*, *version*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.has_name_version)[](#pybel.manager.NetworkManager.has_name_version "Permalink to this definition")
    :   Check if there exists a network with the name/version combination in the database.

        Return type
        :   [`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")

    drop\_networks()[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.drop_networks)[](#pybel.manager.NetworkManager.drop_networks "Permalink to this definition")
    :   Drop all networks.

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    drop\_network\_by\_id(*network\_id*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.drop_network_by_id)[](#pybel.manager.NetworkManager.drop_network_by_id "Permalink to this definition")
    :   Drop a network by its database identifier.

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    drop\_network(*network*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.drop_network)[](#pybel.manager.NetworkManager.drop_network "Permalink to this definition")
    :   Drop a network, while also cleaning up any edges that are no longer part of any network.

        Return type
        :   [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.10)")

    query\_singleton\_edges\_from\_network(*network*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.query_singleton_edges_from_network)[](#pybel.manager.NetworkManager.query_singleton_edges_from_network "Permalink to this definition")
    :   Return a query selecting all edge ids that only belong to the given network.

        Return type
        :   [`Query`](https://docs.sqlalchemy.org/en/14/orm/query.html#sqlalchemy.orm.Query "(in SQLAlchemy v1.4)")

    get\_network\_versions(*name*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.get_network_versions)[](#pybel.manager.NetworkManager.get_network_versions "Permalink to this definition")
    :   Return all of the versions of a network with the given name.

        Return type
        :   [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]

    get\_network\_by\_name\_version(*name*, *version*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.get_network_by_name_version)[](#pybel.manager.NetworkManager.get_network_by_name_version "Permalink to this definition")
    :   Load the network with the given name and version if it exists.

        Return type
        :   [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Network`](models.html#pybel.manager.models.Network "pybel.manager.models.Network")]

    get\_graph\_by\_name\_version(*name*, *version*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.get_graph_by_name_version)[](#pybel.manager.NetworkManager.get_graph_by_name_version "Permalink to this definition")
    :   Load the BEL graph with the given name, or allows for specification of version.

        Return type
        :   [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")]

    get\_networks\_by\_name(*name*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.get_networks_by_name)[](#pybel.manager.NetworkManager.get_networks_by_name "Permalink to this definition")
    :   Get all networks with the given name. Useful for getting all versions of a given network.

        Return type
        :   [`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`Network`](models.html#pybel.manager.models.Network "pybel.manager.models.Network")]

    get\_most\_recent\_network\_by\_name(*name*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.get_most_recent_network_by_name)[](#pybel.manager.NetworkManager.get_most_recent_network_by_name "Permalink to this definition")
    :   Get the most recently created network with the given name.

        Return type
        :   [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Network`](models.html#pybel.manager.models.Network "pybel.manager.models.Network")]

    get\_graph\_by\_most\_recent(*name*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.get_graph_by_most_recent)[](#pybel.manager.NetworkManager.get_graph_by_most_recent "Permalink to this definition")
    :   Get the most recently created network with the given name as a [`pybel.BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.BELGraph").

        Return type
        :   [`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`BELGraph`](../struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")]

    get\_network\_by\_id(*network\_id*)[[source]](../../_modules/pybel/manager/cache_manager.html#NetworkManager.get_network_by_id)[](#pybel.manager.NetworkManager.get_network_by_id 