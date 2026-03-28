* [Skip to primary navigation](#nav-primary)
* [Skip to main content](#main)
* [Skip to footer](#site-footer)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

[![Arvados Logo](/images/arvados/logo.png)](/)

[![Arvados Logo](/images/arvados/logo.png)](/)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

# Technology

The Arvados [architecture](https://doc.arvados.org/architecture/index.html) provides a modern open source platform for organizing, managing and processing terabytes to petabytes of data. It allows you to track your methods and datasets, share them securely, and easily re-run analyses.

[![](/images/technology/arvados-video-thumbnail.webp)](https://jutro-4zz18-p4pkm4tv4l7zu72.collections.jutro.arvadosapi.com/Arvados%20technical%20video.mp4)

## Key Components

The platform’s key components are a content addressable storage system and a containerized workflow engine.

### Keep

[Keep](https://doc.arvados.org/architecture/storage.html) is the Arvados storage system for managing and storing large collections of files. Keep combines content addressing and a distributed storage architecture resulting in both high reliability and high throughput. Every file stored in Keep can be accurately verified every time it is retrieved. Keep supports the creation of collections as a flexible way to define data sets without having to re-organize or needlessly copy data. Keep works on a wide range of underlying filesystems and object stores.

![Keep Logo](/images/technology/keep.webp)

### Crunch

[Crunch](https://doc.arvados.org/api/execution.html) is the orchestration system for running CWL workflows. It is designed to maintain data provenance and workflow reproducibility. Crunch automatically tracks data inputs and outputs through Keep and executes workflow processes in Docker containers. In a cloud environment, Crunch optimizes costs by scaling compute on demand.

![Keep Logo](/images/technology/crunch.webp)

## Security

Arvados has [features to help you comply with data protection regulations](/compliance) for authentication, access and audit
controls, data integrity, and transmission security. Arvados is a
multi-user system. All endpoints are secured by access tokens, data
can be encrypted at rest and in transit, and Arvados
[integrates with a variety of external authentication systems](https://doc.arvados.org/main/install/setup-login.html),
including Active Directory, Google accounts, LDAP, and OpenID Connect.

## Working Environment

You can interact with Arvados functionality using the Workbench web application, the command line, or via the REST API and SDKs.

### Workbench

The Workbench web application allows users to interactively access Arvados functionality. It is especially helpful for querying and browsing data, visualizing provenance, and tracking the progress of workflows.

![Workbench Dashboard](/images/technology/workbench2-dashboard.webp)

### Command Line

The command line interface (CLI) provides convenient access to the Arvados functionality in the Arvados platform from the command line.

### API and SDKs

Arvados is designed to be integrated with existing infrastructure. All the services in Arvados are accessed through a [RESTful API](https://doc.arvados.org/api/index.html). [SDKs](https://doc.arvados.org/sdk/index.html) are available for Python, Go, R, Perl, Ruby, and Java.

## Arvados

* [About](/about/)
* [Development](https://github.com/arvados/arvados)
* [Community](/community/)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog/)

[![Link to Arvados Github](/images/social/github.svg "Github icon")](https://github.com/arvados/arvados)
[![Link to Arvados Twitter](/images/social/twitter.svg "Twitter icon")](https://twitter.com/arvados)

©2024 Arvados Project. Unless otherwise noted, site content licensed under Creative Commons Attribution-ShareAlike 4.0 International licensed.

[Privacy Policy](/privacy)