---
name: bioconductor-epivizrserver
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/epivizrServer.html
---

# bioconductor-epivizrserver

## Overview
The `epivizrServer` package provides the underlying infrastructure for the Epiviz visualization ecosystem. It manages WebSocket connections using the `httpuv` library, allowing R to act as a data provider for the Epiviz JS application. It handles the complexities of asynchronous communication, message serialization, and callback registration.

## Core Workflow

### 1. Server Initialization
Create a server object. You can optionally specify a port and a path to static HTML files if you are hosting the Epiviz UI locally.

```r
library(epivizrServer)

# Create the server object (does not start it yet)
server <- createServer(port=7123, verbose=FALSE)
```

### 2. Registering Actions
Before starting the server, define how R should respond to specific requests (actions) sent from the JavaScript client.

```r
# Register a callback for a specific action (e.g., "getData")
server$register_action("getData", function(request_data) {
  # request_data contains the parameters sent from JS
  # Return a list that will be serialized to JSON for the client
  list(x=1, y=3)
})
```

### 3. Managing the Server Lifecycle
Start and stop the server using the object methods. In interactive sessions, it is best practice to ensure the server stops when the R session ends.

```r
# Start the server
server$start_server()

# On Windows, you may need to periodically call service() to process requests
# server$service()

# Stop the server to release the port
server$stop_server()

# Recommended pattern for interactive use:
server$start_server()
on.exit(server$stop_server())
```

### 4. Sending Requests to the Client
You can also initiate communication from R to the connected JavaScript client.

```r
# Send data to the client and define a callback for the response
server$send_request(list(x=2, y=5), function(response_data) {
  cat("Received from client:", response_data$x)
})
```

## Usage Tips
- **Port Conflicts**: If `start_server()` fails, ensure the port (default 7123) isn't being used by another process.
- **Windows Compatibility**: On Windows, the WebSocket server does not run in a separate thread. You must call `server$service()` or run the server within a loop to handle incoming messages.
- **Static Sites**: Use the `static_site_path` argument in `createServer` to serve the Epiviz web app directly from your local machine.

## Reference documentation
- [epivizrServer Usage (Rmd)](./references/epivizrServer.Rmd)
- [epivizrServer Usage (md)](./references/epivizrServer.md)