#!/usr/bin/env pike

                             /* Global variables */

// Basic types
// http://pike.lysator.liu.se/docs/tutorial/data_types/basic_types.xml
int answer = 42;
float pi = 3.14;
string foo = "bar";
mixed anything;

// Container types
// http://pike.lysator.liu.se/docs/tutorial/data_types/container_types.xml
array x = ({ 1, "y" });
mapping ident = ([ "first":"John", "middle":"K", "last":"Doe" ]);
multiset m = (< "alpha", "beta", "gamma", "delta" >);


                            /* Script entry point*/

int main(int argc, array(string) argv)
{
  // Do your stuff here
  write("Hello, world!\n"); 

  return 0;
}
