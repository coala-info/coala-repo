## Crate crux\_http

## [crux\_http](../crux_http/index.html)0.14.0

* [All Items](all.html)

### [Crate Items](#reexports)

* [Re-exports](#reexports "Re-exports")
* [Modules](#modules "Modules")
* [Structs](#structs "Structs")
* [Enums](#enums "Enums")
* [Type Aliases](#types "Type Aliases")

# Crate crux\_http Copy item path

[Source](../src/crux_http/lib.rs.html#1-307)

Expand description

A HTTP client for use with Crux

`crux_http` allows Crux apps to make HTTP requests by asking the Shell to perform them.

This is still work in progress and large parts of HTTP are not yet supported.

## Re-exports[§](#reexports)

`pub use http_types as http;`

## Modules[§](#modules)

[client](client/index.html "mod crux_http::client")

[command](command/index.html "mod crux_http::command")
:   The Command based API for `crux_http`

[middleware](middleware/index.html "mod crux_http::middleware")
:   Middleware types

[protocol](protocol/index.html "mod crux_http::protocol")
:   The protocol for communicating with the shell

[testing](testing/index.html "mod crux_http::testing")

## Structs[§](#structs)

[Config](struct.Config.html "struct crux_http::Config")
:   Configuration for `crux_http::Http`s and their underlying HTTP client.

[Http](struct.Http.html "struct crux_http::Http")
:   The Http capability API.

[Request](struct.Request.html "struct crux_http::Request")
:   An HTTP request, returns a `Response`.

[RequestBuilder](struct.RequestBuilder.html "struct crux_http::RequestBuilder")
:   Request Builder

[Response](struct.Response.html "struct crux_http::Response")
:   An HTTP Response that will be passed to in a message to an apps update function

[ResponseAsync](struct.ResponseAsync.html "struct crux_http::ResponseAsync")
:   An HTTP response that exposes async methods. This is to support async
    use and middleware.

## Enums[§](#enums)

[HttpError](enum.HttpError.html "enum crux_http::HttpError")

## Type Aliases[§](#types)

[Result](type.Result.html "type crux_http::Result")