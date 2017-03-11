#!/usr/bin/env pike

// Simple HTTP Server
//
// 2017 - Bertrand LUPART


// Global variables
int listen_port = 8080;
string listen_iface ="en1";


int main(int argc, array(string) argv)
{
  // 3 alternate ways to start a server, given you'd like to specify listening port and interface 
  //Protocols.HTTP.Server.Port server = Protocols.HTTP.Server.Port(http_callback);
  Protocols.HTTP.Server.Port server = Protocols.HTTP.Server.Port(http_callback, listen_port);
  //Protocols.HTTP.Server.Port server = Protocols.HTTP.Server.Port(http_callback, listen_port, listen_iface);

  return -1;
}

// Callback invoked for each HTTP request
void http_callback(Protocols.HTTP.Server.Request request)
{
  // Prepare the response mapping for Protocols.HTTP.Server.Request()->response_and_finish()
  mapping response = ([ ]);

  // Here, you can observe the Protocols.HTTP.Server.Request object
  // For example :
  string not_query = request->not_query;

  // Let's output all request data available on stdout
  foreach(indices(request), string req)
  {
    write("%O: %O\n", req, request[req]);
  }

  // Have fun with response
  response->error="200";
  response->type="text/html";
  response->extra_heads += ([ "Server":"Simplest HTTP Server ever" ]);
  response->data = sprintf("<html><body>You requested <strong>%s</strong></body></html>", not_query);

  // Return a properly formatted response to the HTTP client
  request->response_and_finish(response);

  return;
}
