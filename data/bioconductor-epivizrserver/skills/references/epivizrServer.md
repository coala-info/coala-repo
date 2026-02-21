# `epivizrServer` Usage

Hector Corrada Bravo

#### 2025-10-29

# Contents

* [0.0.1 Usage](#usage)

The *[epivizrServer](https://bioconductor.org/packages/3.22/epivizrServer)* package includes methods providing WebSocket connection server and request/response message
handling for the epiviz JS application <http://epiviz.github.io>. These functions have been extracted from the *[epivizr](https://bioconductor.org/packages/3.22/epivizr)* Bioconductor package into its own package for easier use and maintenance.

It is based on the *[httpuv](https://CRAN.R-project.org/package%3Dhttpuv)* package, which provides an interface to the libuv networking library.

### 0.0.1 Usage

```
library(epivizrServer)

# create the server (but it's not started yet)
# it can serve static html files as well
# using the 'static_site_path' argument
server <- createServer(port=7123, verbose=FALSE)

# register a callback to evaluate when a request with given action
# is received
server$register_action("getData", function(request_data) {
  list(x=1,y=3)
})

# start the server
server$start_server()

# send a request with callback to evaluate when successful response is received
server$send_request(list(x=2,y=5), function(response_data) {
  cat(response_data$x)
})

# in Windows platform this is required to listen and respond to requests
#server$service()

# when done, stop the server
server$stop_server()

# in interactive sessions it is good practice
# to add a `stop_server` call to the R exit hooks
# to relase network port used
server$start_server()
on.exit(server$stop_server())
```