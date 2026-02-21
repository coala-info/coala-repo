JSON RPC server for R

Alex Couture-Beil

September 16, 2024

1

Introduction

Remote proceedure calls (RPC) provide inter-process communication which al-
low programs to call other program’s subroutines. JSON-RPC is a RPC proto-
col built on top of JSON. JSON-RPC provides a nice way to interface di(cid:27)erent
languages. Sample code for creating an JSON-RPC server for R is supplied
with the rjson library. For this example, a client wishing to execute R code
will (cid:28)rst execute a new instance of R, and will communicate over standard IO
(stdin/stdout). After the client executes any number of calls, it will terminate
the R session with an end of (cid:28)le (ctrl-D).

2 Sample Code

Sample code can be found in the ..../library/rjson/rpc_server directory. The
server is started with ./start_server (unix), or with start_server.bat (windows).
An optional paramater speci(cid:28)es a user supplied source (cid:28)le to be loaded by the
server, thus allowing the client to execute some user supplied functions.

Note that this code posses serious security risks if the client accecpts input
from anyone. (i.e. the client redirects IO from some tcp port to the R json-rpc
interface). If this is the case, you’ll likely want to avoid allowing anyone to pass
anything to eval.

1

