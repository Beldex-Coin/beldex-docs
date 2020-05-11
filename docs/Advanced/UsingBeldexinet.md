# Using BeldexNET

// TODO: overview for beldexnet cli guide

* `--no-igd` on the command line or `no-igd=1` in beldexd.conf to disable IGD
  (UPnP port forwarding negotiation).
  
* `--p2p-bind-ifname=beldextun0` to bind to just the beldexnet tun interface 


// TODO: note which version of beldexd has `--p2p-bind-ifname` option
  
Example command line to start beldexd for JUST beldexnet traffic

    beldexd --no-igd --p2p-bind-ifname=beldextun0
