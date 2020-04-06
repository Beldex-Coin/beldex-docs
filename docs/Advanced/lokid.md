# `beldexd` - Reference

## Overview

### Connects you to Beldex network

The Beldex daemon `beldexd` keeps your computer synced up with the Beldex network.

It downloads and validates the blockchain from the p2p network.

### Not aware of your private keys

`beldexd` is entirely decoupled from your wallet.

`beldexd` does not access your private keys - it is not aware of your transactions and balance.

This allows you to run `beldexd` on a separate computer or in the cloud.

In fact, you can connect to a remote `beldexd` instance provided by a semi-trusted 3rd party. Such 3rd party will not be able to steal your funds. This is very handy for learning and experimentation.

However, there are privacy and reliability implications to using a remote, untrusted node. For any real business **you should be running your own full node**.

## Syntax

`./beldexd [options] [command]` 

Options define how the daemon should be working. Their names follow the `--option-name` pattern.

Commands give access to specific services provided by the daemon. Commands are executed against the running daemon.
Their names follow the `command_name` pattern.

## Running

Go to directory where you unpacked Beldex.

The stagenet is what your should be using for learning and experimentation.

```
./beldexd --stagenet --detach                # run as a daemon in background
tail -f ~/.beldex/stagenet/beldex.log  # watch the logs
./beldexd --stagenet exit                    # ask daemon to exit gracefully
```

The mainnnet is when you want to deal with the real $beldex.

```
./beldexd --detach                           # run as a daemon in background
tail -f ~/.beldex/beldex.log           # watch the logs
./beldexd exit                               # ask daemon to exit gracefully
```

## Options

Options define how the daemon should be working. Their names follow the `--option-name` pattern.

The following groups are only to make reference easier to follow. The daemon itself does not group options in any way.

#### Help and version

| Option              | Description
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--help`            | Enlist available options.
| `--version`         | Show `beldexd` version to stdout. Example: <br /> ` Beldex 'Festive Freya' (v2.0.2-68397db6)`
| `--os-version`      | Show build timestamp and target operating system. Example output:<br />`OS: Linux #46-Ubuntu SMP Thu Dec 6 14:45:28 UTC 2018 4.15.0-43-generic`.

#### Pick network

| Option           | Description                                                                                    
|------------------|------------------------------------------------------------------------------------------------
| (missing)        | By default `beldexd` assumes mainnet                                              
| `--stagenet`     | Run on stagenet. Remember to run your wallet with `--stagenet` as well.           
| `--testnet`      | Run on testnet. Remember to run your wallet with `--testnet` as well.             

#### Logging

| Option                | Description                                                                                    
|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------
| `--log-file`          | Full path to the log file. Example (mind file permissions): <br/>`./beldexd --log-file=/var/log/beldex/mainnet/beldexd.log`
| `--log-level`         | `0-4` with `0` being minimal logging and `4` being full tracing. Defaults to `0`. These are general presets and do not directly map to severity levels. For example, even with minimal `0`, you may see some most important `INFO` entries. Temporarily changing to `1` allows for much better understanding of how the full node operates. Example: <br />`./beldexd --log-level=1`
| `--max-log-file-size` | Soft limit in bytes for the log file (=104850000 by default, which is just under 100MB). Once log file grows past that limit, `beldexd` creates the next log file with a UTC timestamp postfix `-YYYY-MM-DD-HH-MM-SS`.<br /><br />In production deployments, you would probably prefer to use established solutions like logrotate instead. In that case, set `--max-log-file-size=0` to prevent `beldexd` from managing the log files. 
| `--max-log-files`     | Limit on the number of log files (=50 by default). The oldest log files are removed. In production deployments, you would probably prefer to use established solutions like logrotate instead.

#### Server

`beldexd` defaults are adjusted for running it occasionally on the same computer as your Beldex wallet.

The following options will be helpful if you intend to have an always running node &mdash; most likely on a remote server or your own separate PC.

| Option              | Description
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--config-file`     | Full path to the configuration file. By default `beldex` looks for `beldex.conf` in Beldex data directory.
| `--data-dir`        | Full path to data directory. This is where the blockchain, log files, and p2p network memory are stored. For defaults and details see data directory.
| `--pidfile`         | Full path to the PID file. Works only with `--detach`. Example: <br />`./beldexd --detach --pidfile=/run/beldex/beldexd.pid`
| `--detach`          | Go to background (decouple from the terminal). This is useful for long-running / server scenarios. Typically, you will also want to manage `beldexd` daemon with systemd or similar. By default `beldexd` runs in a foreground.
| `--non-interactive` | Do not require tty in a foreground mode. Helpful when running in a container. By default `beldexd` runs in a foreground and opens stdin for reading. This breaks containerization because no tty gets assigned and `beldexd` process crashes. You can make it run in a background with `--detach` but this is inconvenient in a containerized environment because the canonical usage is that the container waits on the main process to exist (forking makes things more complicated).
| `--no-igd`          | Disable UPnP port mapping on the router ("Internet Gateway Device"). Add this option to improve security if you are **not** behind a NAT (you can bind directly to public IP or you run through Tor).
| `--max-txpool-weight`         | Set maximum transactions pool size in bytes. By default 648000000 (~618MB). These are transactions pending for confirmations (not included in any block).

#### P2P network

The following options define how your node participates in Beldex peer-to-peer network.
This is for node-to-node communication. The following options do **not** affect [wallet-to-node](#node-rpc-api) interface.

The node and peer words are used interchangeably.

| Option                 | Description
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--p2p-bind-ip`        | Network interface to bind to for p2p network protocol. Default value `0.0.0.0` binds to all network interfaces. This is typically what you want. <br /><br />You must change this if you want to constrain binding, for example to configure connection through Tor via torsocks: <br />`DNS_PUBLIC=tcp://1.1.1.1 TORSOCKS_ALLOW_INBOUND=1 torsocks ./beldexd --p2p-bind-ip 127.0.0.1 --no-igd --hide-my-port`
| `--p2p-bind-port`      | TCP port to listen for p2p network connections. Defaults to `22022` for mainnet, `38156` for testnet, and `38153` for stagenet. You normally wouldn't change that. This is helpful to run several nodes on your machine to simulate private Beldex p2p network (likely using private Testnet). Example: <br/>`./beldexd --p2p-bind-port=48080`
| `--p2p-bind-port-ipv6` | TCP port to listen for p2p network connections. Defaults to `22022` for mainnet, `38156` for testnet, and `38153` for stagenet.|
| `--p2p-bind-ipv6-address`|  Interface for p2p network protocol. |
| `--p2p-use-ipv6` | Enable IPv6 for p2p. |
|
| `--p2p-external-port`  | TCP port to listen for p2p network connections on your router. Relevant if you are behind a NAT and still want to accept incoming connections. You must then set this to relevant port on your router. This is to let `beldexd` know what to advertise on the network. Default is `0`.
| `--hide-my-port`       | `beldexd` will still open and listen on the p2p port. However, it will not announce itself as a peer list candidate. Technically, it will return port `0` in a response to p2p handshake (`node_data.my_port = 0` in `get_local_node_data` function). In effect nodes you connect to won't spread your IP to other nodes. To sum up, it is not really hiding, it is more like "do not advertise".
| `--seed-node`          | Connect to a node to retrieve other nodes' addresses, and disconnect. If not specified, `beldexd` will use hardcoded seed nodes on the first run, and peers cached on disk on subsequent runs.  
| `--add-peer`           | Manually add node to local peer list.
| `--add-priority-node`  | Specify list of nodes to connect to and then attempt to keep the connection open. <br /><br />To add multiple nodes use the option several times. Example: <br />`./beldexd --add-priority-node=178.128.192.138:19091 --add-priority-node=144.76.202.167:19091`
| `--add-exclusive-node` | Specify list of nodes to connect to only. If this option is given the options `--add-priority-node` and `--seed-node` are ignored. <br /><br />To add multiple nodes use the option several times. Example: <br />`./beldexd --add-exclusive-node=178.128.192.138:19091 --add-exclusive-node=144.76.202.167:19091`
| `--out-peers`          | Set max number of outgoing connections to other nodes. By default 8. Value `-1` represents the code default.
| `--in-peers`           | Set max number of incoming connections (nodes actively connecting to you). By default unlimited. Value `-1` represents the code default.
| `--limit-rate-up`      | Set outgoing data transfer limit [kB/s]. By default 2048 kB/s. Value `-1` represents the code default.
| `--limit-rate-down`    | Set incoming data transfer limit [kB/s]. By default 8192 kB/s. Value `-1` represents the code default.
| `--limit-rate`         | Set the same limit value for incoming and outgoing data transfer. By default (`-1`) the individual up/down default limits will be used. It is better to use `--limit-rate-up` and `--limit-rate-down` instead to avoid confusion.
| `--offline`            | Do not listen for peers, nor connect to any. Useful for working with a local, archival blockchain.
| `--allow-local-ip`     | Allow adding local IP to peer list. Useful mostly for debug purposes when you may want to have multiple nodes on a single machine.
| `--service-node`       | Generate a Master Node pubkey that identifies your Node to the network. This flag allows the ability to stake Beldex

#### Node RPC API

`beldexd` node offers powerful API. It serves 3 purposes:

* provides network data (stats, blocks, transactions, ...)
* provides local node information (peer list, hash rate if mining, ...)
* provides interface for wallets (send transactions, ...)

This API is typically referred to as "RPC" because it is mostly based on JSON/RPC standard.

The following options define how the API behaves.

| Option                          | Description
|---------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--rpc-bind-ip`                 | IP to listen on. By default `127.0.0.1` because API gives full administrative capabilities over the node. Set it to `0.0.0.0` to listen on all interfaces - but only in connection with one of `*-restricted-*` options **and**  `--confirm-external-bind`.
| `--rpc-bind-port`               | TCP port to listen on. By default `22023` (mainnet), `38157` (testnet), `38154` (stagenet).
| `--rpc-restricted-bind-port`    | TCP port to listen on with the limited version of API. The limited API can be made public to create an Open Node. At the same time, you may firewall the full API port to still enjoy local querying and administration.
| `--confirm-external-bind`       | Confirm you consciously set `--rpc-bind-ip` to non-localhost IP and you understand the consequences.
| `--restricted-rpc`              | Restrict API to view only commands and do not return privacy sensitive data. Note this does not make sense with `--rpc-restricted-bind-port` because you would end up with two restricted APIs.
| `--rpc-login`                   | Specify `username[:password]` required to connect to API. Practical usage seems limited because API communication is in plain text over HTTP.
| `--rpc-access-control-origins`  | Specify a comma separated list of origins to allow cross origin resource sharing. This is useful if you want to use `beldexd` API directly from a web browser via JavaScript (say in a pure-fronted web appp scenario). With this option `beldexd` will put proper HTTP CORS headers to its responses. You will also need to set `--rpc-login` if you use this option. Normally though, the API is used by backend app and this option isn't necessary.
| `--rpc-bind-ipv6-address` | Specify IPv6 address to bind RPC server |
| `--rpc-use-ipv6`| Allow IPv6 for RPC |

#### Accepting Beldex

| Option           | Description
|------------------|------------------------------------------------------------------------------------------------
| `--block-notify` | Run a program for each new block. The argument must be a **full path**. If the argument contains `%s` it will be replaced by the block hash. Example: <br />`./beldexd --block-notify="/usr/bin/echo %s"`<br /><br />Couple of notes:<br />1) Block notifications are good for immediate reaction. However, you should always assume you will miss some block notifications and you should independently poll the API to cover this up.<br />2) Mind blockchain reorganizations. Block notifications can revert to same and past heights. This actually happens pretty often.<br />3) See also `--tx-notify` option of `beldex-wallet-rpc` daemon [here](https://github.com/monero-project/monero/pull/4333). 

#### Performance

These are advanced options that allow you to optimize performance of your `beldexd` node, sometimes at the expense of reliability.

| Option                          | Description
|---------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--db-sync-mode`                | Specify sync option, using format:<br />`[safe|fast|fastest]:[sync|async]:[<nblocks_per_sync>[blocks]|<nbytes_per_sync>[bytes]]`<br /><br />The default is `fast:async:250000000bytes`.<br /><br />The `fast:async:*` can corrupt blockchain database in case of a system crash. It should not corrupt if just `beldexd` crashes. If you are concerned with system crashes use `safe:sync`.
| `--max-concurrency`             | Max number of threads to use for a parallel jobs. The default value `0` uses the number of CPU threads.
| `--prep-blocks-threads`         | Max number of threads to use when computing block hashes (PoW) in groups. Defaults to 4. Decrease this if you don't want `beldexd` hog your computer when syncing.
| `--fast-block-sync`             | Sync up most of the way by using embedded, "known" block hashes. Pass `1` to turn on and `0` to turn off. This is on (`1`) by default. Normally, for every block the full node must calculate the block hash to verify miner's proof of work. Because the CryptoNight PoW used in Beldex is very expensive (even for verification), `beldexd` offers skipping these calculations for old blocks. In other words, it's a mechanism to trust `beldexd` binary regarding old blocks' PoW validity, to sync up faster.
| `--block-sync-size`             | How many blocks are processed in a single batch during chain synchronization. By default this is 20 blocks for newer history and 100 blocks for older history ("pre v4"). Default behavior is represented by value `0`. Intuitively, the more resources you have, the bigger batch size you may want to try out. Example:<br />`./beldexd --block-sync-size=500`
| `--bootstrap-daemon-address`    | The host:port of a "bootstrap" remote open node that the connected wallets can use while this node is still not fully synced. Example:<br/>`./beldexd --bootstrap-daemon-address=opennode.xmr-tw.org:18089`. The node will forward selected RPC calls to the bootstrap node. The wallet will handle this automatically and transparently. Obviously, such bootstraping phase has privacy implications similar to directly using a remote node.
| `--bootstrap-daemon-login`      | Specify username:password for the bootstrap daemon login (if required). This considers the RPC interface used by the wallet. Normally, open nodes do not require any credentials.

#### Mining

The following options configure **solo mining** using **CPU** with the standard software stack `beldexd`. This is mostly useful for:

* generating your stagenet or testnet coins
* experimentation and learning
* if you have super cheap access to vast CPU resources

Be advised though that real mining happens **in pools** and with high-end **GPU-s** instead of CPU-s.

| Option                             | Description
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--start-mining`                   | Specify wallet address to mining for. **This must be a [main address](../../Wallets/Addresses/MainAddress)!** It can be neither a subaddres nor integrated address.
| `--mining-threads`                 | Specify mining threads count. By default ony one thread will be used. For best results, set it to number of your physical cores.
| `--extra-messages-file`            | Specify file for extra messages to include into coinbase transactions.
| `--bg-mining-enable`               | Enable unobtrusive mining. In this mode mining will use a small percentage of your system resources to never noticeably slow down your computer. This is intended to encourage people to mine to improve decentralization. That being said chances of finding a block are diminishingly small with solo CPU mining, and even lesser with its unobtrusive version. You can tweak the unobtrusivness / power trade-offs with the further `--bg-*` options below.
| `--bg-mining-ignore-battery`       | If true, assumes plugged in when unable to query system power status.
| `--bg-mining-min-idle-interval`    | Specify min lookback interval in seconds for determining idle state.
| `--bg-mining-idle-threshold`       | Specify minimum avg idle percentage over lookback interval.
| `--bg-mining-miner-target`         | Specify maximum percentage cpu use by miner(s).

#### Testing Beldex itself

These options are useful for Beldex project developers and testers. Normal users shouldn't be concerned with these.

| Option                             | Description
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--test-drop-download`             | For net tests: in download, discard ALL blocks instead checking/saving them (very fast).
| `--test-drop-download-height`      | Like test-drop-download but discards only after around certain height. By default `0`.
| `--regtest`                        | Run in a regression testing mode.
| `--fixed-difficulty`               | Fixed difficulty used for testing. By default `0`.
| `--test-dbg-lock-sleep`            | Sleep time in ms, defaults to 0 (off), used to debug before/after locking mutex. Values 100 to 1000 are good for tests.
| `--save-graph`                     | Save data for dr Beldex.

#### Legacy

These options should no longer be necessary. They are still present in `beldexd` for backwards compatibility.

| Option                | Description
|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `--fluffy-blocks`     | Relay compact blocks. Default. Compact block is just a header and a list of transaction IDs.
| `--no-fluffy-blocks`  | Relay classic full blocks. Classic block contains all transactions.
| `--show-time-stats`   | Official docs say "Show time-stats when processing blocks/txs and disk synchronization" but it does not seem to produce any output during usual blockchain synchronization.
| `--zmq-rpc-bind-ip`   | IP for ZMQ RPC server to listen on. By default `127.0.0.1`. This is not yet widely used as ZMQ interface currently does not provide meaningful advantage over classic JSON-RPC interface. Unfortunately, currently there is no way to disable the ZMQ server. 
| `--zmq-rpc-bind-port` | Port for ZMQ RPC server to listen on. By default `22024` for mainnet, `38154` for stagenet, and `38158` for testnet. 
| `--db-type`           | Specify database type. The default and only available: `lmdb`.

## Commands

Commands give access to specific services provided by the daemon.
Commands are executed against the running daemon.
Their names follow the `command_name` pattern.

The following groups are only to make reference easier to follow.
The daemon itself does not group commands in any way.

See [running](#running) for example usage.
You can also type commands directly in the console of the running `beldexd` (if not detached). 

#### Help, version, status

| Option                             | Description
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `help [<command>]`                 | Show help for `<command>`.
| `version`                          | Show version information. Example output:<br />`Beldex 'Festive Freya' (v2.0.2-68397db6)`
| `status`                           | Show status. Example output:<br />`Height: 186754/186754 (100.0%) on stagenet, not mining, net hash 317 H/s, v9, up to date, 8(out)+0(in) connections, uptime 0d 3h 48m 47s`

#### P2P network

| Option                             | Description
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `print_pl`                         | Show the full peer list. 
| `print_pl_stats`                   | Show the full peer list statistics (white vs gray peers). White peers are online and reachable. Grey peers are offline but your `beldexd` remembers them from past sessions.
| `print_cn`                         | Show connected peers with connection initiative (incoming/outgoing) and other stats.
| `ban <IP> [<seconds>]`             | Ban a given `<IP>` for a given amount of `<seconds>`. By default the ban is for 24h. Example:<br />`./beldexd ban 187.63.135.161`.
| `unban <IP>`                       | Unban a given `<IP>`.
| `bans`                             | Show the currently banned IPs. Example output:<br />`187.63.135.161 banned for 86397 seconds`.
| `in_peers <max_number>`            | Set the <max_number> of incoming connections from other peers.
| `out_peers <max_number>`           | Set the <max_number> of outgoing connections to other peers.
| `limit [<kB/s>]`                   | Get or set the download and upload limit.
| `limit_down [<kB/s>]`              | Get or set the download limit.
| `limit_up [<kB/s>]`                | Get or set the upload limit.

#### Master Nodes

| Option                             | Description
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `print_sn`                         | Show Serivce Node registration state for all Master Nodes on the network, including data such as contribution amount, registration height, expiry data, last reward received, operator cut, operator address, and contributors.
| `print_sn`                         | Show Serivce Node registration state for only your Master Node, including data such as contribution amount, registration height, expiry data, last reward received, operator cut, operator address, and contributors.
| `print_sn_key`                     | Show your Master Node pubkey if `--service-node` flag is running.
| `print_sr <block-height>`          | Show staking requirement at specific block height.
| `print_quorum_state <height>`      | Show the quorum state(The Master Node's performing uptime proof checks) at specific block height.
| `prepare_registration`             | Prepare service Node for staking

#### Transaction pool

| Option                             | Description
|------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `flush_txpool [<txid>]`            | Flush specified transaction from transactions pool, or flush the whole transactions pool if <txid> was not provided.
| `print_pool`                       | Print the transaction pool using a verbose format.
| `print_pool_sh`                    | Print the transaction pool using a short format.
| `print_pool_stats`                 | Print the transaction pool's statistics (number of transactions, memory size, fees, double spend attempts etc).

#### Transactions

| Option                                                     | Description
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `print_coinbase_tx_sum <start_height> [<block_count>]`     | Show a sum of all emitted coins and paid fees within specified range. Example:<br />`./beldexd print_coinbase_tx_sum 0 1000000000000`
| `print_tx <transaction_hash> [+hex] [+json]`               | Show specified transaction as JSON and/or HEX.
| `relay_tx <txid>`                                          | Force relaying the transaction. Useful if you want to rebroadcast the transaction for any reason or if transaction was previously created with "do_not_relay":true.

#### Blockchain

| Option                                                     | Description
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `print_height`                                             | Show local blockchain height.
| `sync_info`                                                | Show blockchain sync progress and connected peers along with download / upload stats.
| `print_bc <begin_height> [<end_height>]`                   | Show blocks in range `<begin_height>`..`<end_height>`. The information will include block id, height, timestamp, version, size, weight, number of non-coinbase transactions, difficulty, nonce, and reward.  
| `print_block <block_hash> | <block_height>`                | Show detailed data of specified block.
| `hard_fork_info`                                           | Show current consensus version and future hard fork block height, if any.
| `is_key_image_spent <key_image>`                           | Check if specified key image is spent. Key image is a hash.

#### Manage daemon

| Option                                                     | Description
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `exit`, `stop_daemon`                                      | Ask daemon to exit gracefully. The `exit` and `stop_daemon` are identical (one is alias of the other).
| `set_log <level>|<{+,-,}categories>`                       | Set the current log level/categories where `<level>` is a number 0-4.
| `print_status`                                             | Show if daemon is running.
| `update (check|download)`                                  | Check if update is available and optionally download it. The hash is SHA-256. On linux use `sha256sum` to verify.


#### Mining

| Option                                                     | Description
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `show_hr`                                                  | Ask `beldexd` daemon to stop printing current hash rate. Relevant only if `beldexd` is mining. 
| `hide_hr`                                                  | Ask `beldexd` daemon to print current hash rate. Relevant only if `beldexd` is mining.
| `start_mining <addr> [<threads>] [do_background_mining] [ignore_battery]`   | Ask `beldexd` daemon to start mining. Block reward will go to `<addr>`.
| `stop_mining`                                              | Ask `beldexd` daemon to stop mining.

#### Testing Beldex itself

| Option                                                     | Description
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `start_save_graph`                                         | Start saving data for dr Beldex.
| `stop_save_graph`                                          | Stop saving data for dr Beldex.

#### Legacy

| Option                                                     | Description
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------
| `save`                                                     | Flush blockchain data to disk. This is normally no longer necessary as `beldexd` saves the blockchain automatically on exit. 


### Sources:
[monerodocs](https://monerodocs.org/interacting/download-monero-binaries/)