== POST Proxy

At work my machine is protected by a firewall. I was working on some payment processing scripts and wanted the payment gateways to be able to send my app IPNs in development mode and this is how I accomplished it.

Important: you'll need a machine with outside access no matter what.

1. Run *proxy_listen.rb* on the "host" machine.

You can use the *-p XXXX* flag to get it to run on an alternate port. It's a tiny Sinatra app and this is where you'll want to point other services to. The app remembers only the last request it received and displays it when it receives a GET request.

2. Run *proxy_check.rb* on a machine that is able to access your "target" machine.

  ./proxy_check.rb host.com target.org

This Ruby script checks the host every 5 seconds for new POST data and then posts it to the target URL.

3. Enjoy!