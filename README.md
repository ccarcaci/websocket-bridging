# Websocket Bridging

## What's that?

This project contains the sources related with [this article]().

## Article

Imagine you have a front-end application that works in tandem with a backend for frontend service.
Then your front-end app opens a new heavy load websocket connection with the backend service.
The backend service could fall into heavy load of his thread making the service unable to work.

Now imagine that you have the possibility to redirect the websocket connection to another service freeing the main one.

```
+-------------+                         +-------------+
|            X|     HTTP REST API       |             |
+-------------------------------------->+     BFF     |
|             |     WS Connection       |             |
|             +------------------------>+             |
+-------------+    |                    +-------------+
   Frontend        |
                   |
                   |
                   |
                   |                    +-------------+
                   |                    |             |
                   +------------------->+  WS Service |
                    WS Connection       |             |
                    Redirected          |             |
                                        +-------------+
```

How to implement that redirection?

WS works [using the HTTP protocol specifications](https://tools.ietf.org/html/rfc6455) to establish and maintain connections.
The HTTP specification states the possibility to use the response code [3XX for redirections](https://tools.ietf.org/html/rfc2616#page-61). But this functionality is available during the handshake.

What to do if we want to redirect the websocket connection when data are sent back-and-forth between the client and server?

The idea is to provide a compositions that shows the Websocket (WS) redirection.
