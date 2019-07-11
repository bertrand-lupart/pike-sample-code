#!/usr/bin/env pike

string host_to_resolve = "pike.lysator.liu.se";

int main(int argc, array(string) argv)
{
	// Protocols.DNS.async_host_to_ip() is a downsized shortcut
	// to Protocols.DNS.async_client()
	Protocols.DNS.async_host_to_ip(host_to_resolve, callback_function);

	// Don't exit here, await callback function to be called
	return -1;
}

void callback_function(string host, int|string ip)
{
	// ip is int in case resolution failed
	if(intp(ip))
	{
		werror("DNS resolution of %O failed\n", host);
		return;
	}

	write("%O is %O\n", host, ip);

	exit(0);
}
