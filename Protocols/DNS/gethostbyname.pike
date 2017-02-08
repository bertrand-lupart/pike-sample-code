#!/usr/bin/env pike

int main(int argc, array(string) argv)
{
  // which name we'd like to resolve ?
  string name = "pike.lysator.liu.se";
  if(argc>1)
  {
    name = argv[1];
  }

  // actually doing a synchronous DNS resolution
  array results = Protocols.DNS.gethostbyname(name);

  // getting IP addresses out of the results. (IPv6 Pike 7.8+)
  array ips = results[1] || ({});
  // getting aliases out of the results
  array aliases = results[2] || ({});


  // print
  if(sizeof(ips))
  {
    write("IPs for %s are:\n\t%s", name, ips*"\n\t");
  }

  if(sizeof(aliases))
  {
    write("Aliases for %s are:\n\t%s", name, aliases*"\n\t");
  }

  return 0;
}
