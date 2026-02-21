---
name: ebisearch
description: The ebisearch skill facilitates programmatic access to the European Bioinformatics Institute's search engine.
homepage: https://github.com/ebi-wp/EBISearch-webservice-clients
---

# ebisearch

## Overview
The ebisearch skill facilitates programmatic access to the European Bioinformatics Institute's search engine. It leverages a collection of specialized web service clients to execute queries against biological data domains. Instead of constructing manual REST calls, this skill provides the patterns for using pre-built scripts to fetch metadata, domain hierarchies, and search results directly from the command line.

## CLI Usage Patterns

The EBI Search clients are organized by language. Choose the implementation that matches your environment's available runtimes.

### Python Client (Recommended)
The Python client uses the `requests` library and is the most straightforward for modern workflows.
- **Dependency**: `pip install requests`
- **Pattern**: `python python/ebeye_requests.py <method> [arguments]`
- **Example**: `python python/ebeye_requests.py getDomainDetails chebi`

### Perl Client
Useful for legacy bioinformatics pipelines or environments where Perl is the primary language.
- **Dependencies**: `LWP`, `XML::Simple`, `LWP::Protocol::https`
- **Pattern**: `perl ./perl/ebeye_lwp.pl <method> [arguments]`
- **Example**: `perl ./perl/ebeye_lwp.pl getDomainDetails chebi`

### Java Client
Requires OpenJDK 8 (Note: Java 9 and above are currently not supported).
- **Pattern**: `java -Djava.ext.dirs=java/lib/ -jar java/jar/EBeye_JAXRS.jar --<method> [arguments]`
- **Example**: `java -Djava.ext.dirs=java/lib/ -jar java/jar/EBeye_JAXRS.jar --getDomainDetails chebi`

## Common Methods and Operations

While the specific arguments depend on the target domain, the following methods are standard across the clients:

- `getDomainDetails`: Retrieves metadata about a specific database domain (e.g., `chebi`, `uniprot`).
- `listDomains`: Lists all available domains within the EBI Search index.
- `getResults`: Executes a search query and returns matching entries.

## Best Practices and Tips

- **Prefer REST over SOAP**: The EBI Search team recommends using these RESTful clients exclusively, as the older SOAP-based services are no longer maintained.
- **Domain Identification**: Always verify the exact domain ID (like `chebi` or `embl_release`) before running queries to avoid empty results.
- **Dependency Management**: If using the Python client, ensure `requests` is installed in your active virtual environment to prevent execution errors.
- **Java Environment**: If using the Java client, you must explicitly set the extension directory using `-Djava.ext.dirs=java/lib/` to ensure the JAR can find its required dependencies.

## Reference documentation
- [EBI Search Web Service Clients README](./references/github_com_ebi-wp_EBISearch-webservice-clients.md)