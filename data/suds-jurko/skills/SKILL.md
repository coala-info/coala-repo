---
name: suds-jurko
description: Suds is a lightweight, dynamic SOAP client for Python that simplifies the process of consuming web services.
homepage: https://github.com/suds-community/suds
---

# suds-jurko

## Overview
Suds is a lightweight, dynamic SOAP client for Python that simplifies the process of consuming web services. Unlike traditional SOAP libraries that require static code generation from WSDL files, Suds inspects the WSDL at runtime to provide a virtualized service interface. This allows developers to call remote methods as if they were local Python functions and interact with complex XML structures as native Python objects.

## Core Usage Patterns

### Initializing the Client
To begin interacting with a service, point the `Client` to the target WSDL URL.
```python
from suds.client import Client

url = 'http://example.com/service?wsdl'
client = Client(url)
```

### Service Inspection
Suds provides a built-in way to discover the available methods, ports, and data types defined in the WSDL. Simply printing the client object outputs a comprehensive summary.
```python
# Print available methods and types
print(client)
```

### Invoking Methods
Methods are accessed via the `service` namespace. Suds automatically handles the translation between Python arguments and SOAP XML.
```python
# Simple call
result = client.service.getPersonByName("John Doe")

# Call with multiple arguments
result = client.service.addNumbers(10, 20)
```

### Handling Complex Types
When a method requires a complex object defined in the WSDL schema, use the `factory` namespace to create a local instance of that type.
```python
# Create a complex object defined in the WSDL
person = client.factory.create('Person')
person.name = "Jane Doe"
person.age = 30

# Pass the object to the service
client.service.updatePerson(person)
```

## Expert Tips and Best Practices

### Debugging SOAP Traffic
To see the raw XML being sent and received, configure the standard Python logging module. This is essential for troubleshooting signature mismatches or transport errors.
```python
import logging

# Enable detailed logging for the client and transport
logging.basicConfig(level=logging.INFO)
logging.getLogger('suds.client').setLevel(logging.DEBUG)
logging.getLogger('suds.transport').setLevel(logging.DEBUG)
```

### Handling Namespaces
If a WSDL uses multiple namespaces, the `factory.create` method can be prefixed with the namespace alias (e.g., `ns0:Person`) to ensure the correct type is instantiated.

### Performance Considerations
Since Suds parses the WSDL at runtime, the initial `Client(url)` call can be slow for large or complex WSDLs. In long-running applications, cache the client instance or ensure the WSDL is hosted on a high-availability endpoint.

### Working with Arrays
Suds typically handles lists automatically. If a schema defines an element as a sequence, you can pass a standard Python list, and Suds will wrap it in the appropriate XML tags.

## Reference documentation
- [Suds Community README](./references/github_com_suds-community_suds.md)