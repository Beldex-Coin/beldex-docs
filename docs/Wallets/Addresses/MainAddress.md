# Address

A Beldex public address is what you publish to get paid.

An address can be generated offline and for free. It boils down to generating a large random number representing your private spending key.

Publishing your Beldex address does __not__ endanger your privacy. That's because in Beldex transactions go to stealth addresses which are decoupled from your public address.

There are a few **types of public addresses** in Beldex:

* Main address - basic type of an address, also refered to as raw address
* Subaddress - what you should be using by default
* Integrated address - relevant for exchanges, merchants, and other businesses accepting Beldex in a fully automated way

## Main address

Historicaly, raw address was the only available option. For that reason it is the most widely adopted and supported address type.

Its strength is simplicity. However, these days users should prefer receiving to subaddresses instead.

Technically, raw address is also a basis for creating subaddresses and integrated addresses.

Raw address is **still useful for**:

* accepting block reward in a solo-mining scenario as other addresses are not supported
* accepting from senders who batch payouts (like mining pools); in this scenario the sender is paying multiple parties using a single transaction; such transaction has multiple outputs; subaddresses do not work in this scenario
* accepting from senders who use legacy wallets (can't send to subaddress)

Beldex raw address is composed of two public keys:

* public spend key
* public view key

It also contains a checksum and a "network byte" which actually identifies both the network and the address type.

## Data structure

Index       | Size in bytes    | Description
------------|------------------|-------------------------------------------------------------
0           | 1                | identifies the network and address type; [114](https://github.com/beldex-coin/beldex/blob/master/src/cryptonote_config.h#L181) - main chain; [156](https://github.com/beldex-coin/beldex/blob/master/src/cryptonote_config.h#L201) - test chain; [24](https://github.com/beldex-coin/beldex/blob/master/src/cryptonote_config.h#L224) - stagenet chain
1           | 32               | public spend key
33          | 32               | public view key
65          | 4                | checksum ([Keccak-f[1600] hash](https://github.com/beldex-coin/beldex/blob/master/src/common/base58.cpp#L261) of the previous 65 bytes, trimmed to first [4](https://github.com/beldex-coin/beldex/blob/master/src/common/base58.cpp#L53) bytes)

It totals to 69 bytes. The bytes are then encoded ([src](https://github.com/beldex-coin/beldex/blob/master/src/common/base58.cpp#L240)) in Beldex specific Base58 format, resulting in a 95 chars long string. Example main address:

`4AXk6eS3Ng98QxDTdC47eNdfCXttJycKraXxfsw9cMVngGUqP3kiSE6cwXoApU6gjzSXVX1ASAPAi1MSXA935XUs1MWEcv9`

See the [source code](https://github.com/beldex-coin/beldex/blob/master/src/cryptonote_basic/cryptonote_basic_impl.cpp#L172).

## Generating

Main address is derived from the root private key.

## Reference

* [StackExchenge answer](https://monero.stackexchange.com/questions/980/what-are-the-public-viewkeys-and-spendkeys)
* [https://xmr.llcoins.net/addresstests.html](https://xmr.llcoins.net/addresstests.html)